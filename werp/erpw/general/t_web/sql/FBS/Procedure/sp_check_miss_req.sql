CREATE OR REPLACE Procedure
				sp_check_miss_req( p_comp_code	 IN VARCHAR2 ,	   -- 사업장코드
				                   p_bank_code	 IN VARCHAR2 ,	   -- 은행코드
													 p_trade_ymd 	 IN VARCHAR2 ,	   -- 거래일자
													 p_miss_num	   IN VARCHAR2  ) IS -- 결번		
		                									 	
		lrSend						fbs_main_pkg.FB_VAN_SEND_RECORD;
		lrRecv						fbs_main_pkg.FB_VAN_RECV_RECORD;
		ltVars						fbs_main_pkg.T_Vars;
		ltNums						fbs_main_pkg.T_Nums;

		lsRet						  Varchar2(4000);
		v_result_code			Varchar2(4000);
		v_result_msg			Varchar2(4000);		
		v_docu_num 				VARCHAR2(7);                -- 전문번호
		v_docu_numc       NUMBER;
		v_max_docu_numc   NUMBER;
		v_cnt             NUMBER;

    FB_DOCU_BILL_TRX_B   VARCHAR2(7) := '0200400'; /*  어음거래명세     (은행=>업체) */  
    FB_DOCU_BILL_MISS_T  VARCHAR2(7) := '0200500'; /*  어음명세결번요청 (업체=>은행) */
    FB_DOCU_BILL_MISS_B  VARCHAR2(7) := '0210500'; /*  어음명세결번요청 (은행=>업체) */

		DEFAULT_TIMEOUT     NUMBER(10)   := 60;
		SUCCESS_CODE		Constant Varchar2(2) := 'OK';
		
	BEGIN
		-- >>>>>>>>>>>>>   처리로직	   <<<<<<<<<<<<<<<<<<
		--전문번호 
	  v_docu_num := FB_DOCU_BILL_MISS_T ;

		--.기본	초기화
    BEGIN
		Select
				a.TRAN_CODE,
				a.ENTE_CODE
			Into
				lrSend.tran_code,
				lrSend.ente_code
			From	T_FB_ORG_BANK a
			Where	a.COMP_CODE = p_comp_code
			And		a.BANK_MAIN_CODE = p_bank_code ;
		
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'은행거래정보가 설정되어	있지 않습니다.');
		End;
		
		lrSend.bank_code :=	p_bank_code;
		lrSend.send_date :=	To_Char(SysDate,'YYYYMMDD');
		lrSend.send_time :=	To_Char(SysDate,'HH24MISS');
		lrSend.send_cont :=	'1';
		-- 전문코드	및 업무코드	설정
		lrSend.docu_code :=	SubStrb(v_docu_num,1,4); 
		lrSend.upmu_code :=	SubStrb(v_docu_num,5,3);
		--전문 번호	채번
		lrSend.docu_numc :=	p_miss_num ;
		
    SELECT NVL(TO_NUMBER(MAX(DOCU_NUMC)),0) ,TO_NUMBER(p_miss_num)
    INTO v_max_docu_numc ,v_docu_numc
    FROM T_FB_VAN_RECV
    WHERE SEND_DATE = p_trade_ymd
    AND DOCU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,1,4) 
    AND UPMU_CODE = SUBSTRB(FB_DOCU_BILL_TRX_B,5,3) 
    AND ENTE_CODE = lrSend.ente_code
    AND BANK_CODE = lrSend.bank_code ;	
    
    IF v_max_docu_numc < v_docu_numc THEN
       Raise_Application_Error(-20009,'결번을 다시 확인하세요.');
    END IF; 
                
    -- 예금거래명세 혹은 결번요청을 하여, 이미 온것이 있으면 오류처리합니다. 
    SELECT COUNT(*) 
    INTO v_cnt
    FROM T_FB_VAN_RECV
    WHERE ENTE_CODE = lrSend.ente_code
    AND BANK_CODE = lrSend.bank_code
    AND SEND_DATE = p_trade_ymd
    AND ( (  DOCU_CODE = SUBSTRB( FB_DOCU_BILL_TRX_B , 1 , 4 )
             AND UPMU_CODE = SUBSTRB( FB_DOCU_BILL_TRX_B , 5 , 3 )
             AND DOCU_NUMC = p_miss_num )
         OR( DOCU_CODE = SUBSTRB( FB_DOCU_BILL_MISS_B , 1 , 4 )
             AND UPMU_CODE = SUBSTRB( FB_DOCU_BILL_MISS_B , 5 , 3 )   
             AND DOCU_NUMC = p_miss_num  )
    );
       
    IF v_cnt > 0 THEN
       Raise_Application_Error(-20009,'처리가 완료된 번호입니다.');
    END IF;
		
		-- 개별부 설정		
		lrSend.gaeb_area :=		fbs_util_pkg.sprintf( '%-2s'  , '' ) ||
		                      fbs_util_pkg.sprintf( '%-15s' , '' ) ||													
													fbs_util_pkg.sprintf( '%-8s'  , p_trade_ymd ) ||-- 셋팅되는 값(거래일자)
													fbs_util_pkg.sprintf( '%-6s'  , '' ) ||
													fbs_util_pkg.sprintf( '%-10s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-13s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-14s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-8s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-16s' , '' ) || 
                          fbs_util_pkg.sprintf( '%-16s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-3s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-13s' , '' ) ||
                          fbs_util_pkg.sprintf( '%-6s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-6s'  , p_miss_num ) ||  -- 셋팅되는 값
                          fbs_util_pkg.sprintf( '%-6s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-6s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-8s'  , '' ) ||
                          fbs_util_pkg.sprintf( '%-44s' , '' );  

		lsRet := fbs_main_pkg.send_realtime_document(lrSend,DEFAULT_TIMEOUT,lrRecv,v_result_code,v_result_msg);

		If lsRet <>	SUCCESS_CODE Then
				fbs_util_pkg.write_log('FBS', sqlerrm||'(결번:'||p_miss_num||')');
				RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(결번:'||p_miss_num||')');
		End	If;
		
		ltNums(1) :=   2;	 --1.거래구분
		ltNums(2) :=  15;	 --2.계좌번호
		ltNums(3) :=   8;	 --3.거래일자
		ltNums(4) :=   6;	 --4.거래시간
		ltNums(5) :=  10;	 --5.어음번호
		ltNums(6) :=  13;	 --6.금액
		ltNums(7) :=  14;	 --7.발행인
		ltNums(8) :=   8;	 --8.만기일
		ltNums(9) :=  16;	 --9.만기시지급은행
		ltNums(10):=  16;	 --10.CMS코드
		ltNums(11):=   3;	 --11.항목변경코드
		ltNums(12):=  13;	 --12.잔액
		ltNums(13):=   6;	 --13.지로코드
		ltNums(14):=   6;	 --14.원거래전문번호
		ltNums(15):=   6;	 --15.일련번호
		ltNums(16):=   6;	 --16.취소시일련번호
		ltNums(17):=   8;	 --17.취소시거래일자
		ltNums(18):=  44;	 --18.예비

		ltVars := fbs_main_pkg.SplitDocu(lrRecv.gaeb_area,ltNums);
		
		--예금거래명세 INSERT	
    INSERT INTO T_FB_BILL_TRX_DATA	
    ( BANK_CODE ,          --거래발생은행 
      ACCOUNT_NO,          --계좌번호
      TRADE_YMD,           --거래일자
      DOCU_NUMC,           --원거래전문번호
      TRX_GUBUN,           --거래구분
      TRADE_TIME,          --거래시간
      BILL_NO,             --어음번호
      ISSUE_NAME,          --발행인 
      FUTURE_PAY_DUE_YMD,  --만기일
      FUTURE_PAY_BANK_CODE,--만기시지급은행
      AMOUNT,              --금액 
      REMAIN_AMT,          --거래후잔액   
      CMS_CODE,            --CMS코드
      GIRO_CODE,           --지로코드
      COMP_CODE )          --사업장
    VALUES  
    ( p_bank_code ,
      ltVars(2) ,
			ltVars(3) ,
			ltVars(14),
			ltVars(1) ,
			ltVars(4) ,
			ltVars(5) ,
			ltVars(7) ,
			ltVars(8) ,
			ltVars(9) ,
			ltVars(6) ,
			ltVars(12),
			ltVars(10),
			ltVars(13),
			p_comp_code ) ;		

EXCEPTION
	WHEN OTHERS THEN		
			fbs_util_pkg.write_log('FBS', sqlerrm||'(결번:'||p_miss_num||')');
			RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(결번:'||p_miss_num||')');
END 	;
/
