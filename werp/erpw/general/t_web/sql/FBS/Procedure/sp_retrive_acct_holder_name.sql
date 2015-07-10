CREATE OR REPLACE PROCEDURE
		 sp_retrive_acct_holder_name( p_comp_code	   IN VARCHAR2 ,	   -- 사업장코드
		                              p_bank_code	   IN VARCHAR2 ,	   -- 은행코드
															    p_acct_number	 IN VARCHAR2 ,	   -- 계좌번호
															    p_biz_number	 IN VARCHAR2 ,     -- 주민(사업자)번호
															    p_holder_name	 OUT VARCHAR2,     -- 예금주명
															    p_result_msg	 OUT VARCHAR2)IS   -- 응답결과
			
		lrSend						fbs_main_pkg.FB_VAN_SEND_RECORD;
		lrRecv						fbs_main_pkg.FB_VAN_RECV_RECORD;
		ltVars						fbs_main_pkg.T_Vars;
		ltNums						fbs_main_pkg.T_Nums;

		lsRet						  Varchar2(4000);
		v_result_code			Varchar2(4000);
		v_result_msg			Varchar2(4000);
		v_acct_number     Varchar2(4000);
		v_holder_name     Varchar2(15);

		v_docu_num 				VARCHAR2(7);                -- 전문번호
   
    FB_DOCU_NAME_CHECK_T    VARCHAR2(7) := '0400400'; /*  수취인 성명조회 (업체=>은행)  */
    FB_DOCU_NAME_CHECK_B    VARCHAR2(7) := '0410400'; /*  수취인 성명조회 (은행=>업체)  */
    
		DEFAULT_TIMEOUT     NUMBER(10)   := 60;
		SUCCESS_CODE		Constant Varchar2(2) := 'OK';
		
	BEGIN
		-- >>>>>>>>>>>>>   처리로직	   <<<<<<<<<<<<<<<<<<
		--전문번호 
	  v_docu_num := FB_DOCU_NAME_CHECK_T ;
    v_acct_number := replace(p_acct_number ,'-','');		
		
		--.기본	초기화
		Begin
			Select
				a.TRAN_CODE,
				a.ENTE_CODE
			Into
				lrSend.tran_code,
				lrSend.ente_code
			From	T_FB_ORG_BANK a
			Where	a.COMP_CODE      = p_comp_code
			And		a.BANK_MAIN_CODE = p_bank_code;
			
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'은행거래정보가 설정되어	있지 않습니다.');
		End;
		
		lrSend.bank_code :=	p_bank_code;
		lrSend.send_date :=	To_Char(SysDate,'YYYYMMDD');
		lrSend.send_time :=	To_Char(SysDate,'HH24MISS');
		lrSend.send_cont :=	'1';
		-- 전문코드	및 업무코드	설정
		lrSend.docu_code :=	substrb(v_docu_num ,1,4);
		lrSend.upmu_code :=	substrb(v_docu_num ,5,3);
		--전문 번호	채번
		lrSend.docu_numc :=	F_T_Gen_docu_numc(lrSend.bank_code,lrSend.docu_code,lrSend.upmu_code,lrSend.send_date);		

		-- 개별부 설정
		lrSend.gaeb_area :=		fbs_util_pkg.sprintf('%-2.2s'    , p_bank_code) ||		  --1.은행
													fbs_util_pkg.sprintf('%-15.15s'  , v_acct_number  ) ||	--2.계좌번호
													fbs_util_pkg.sprintf('%-14.14s'  , p_biz_number ) ||		--3.주민(사업자)번호
													fbs_util_pkg.sprintf('%-14.14s'  , '') ||		            --4.예금주명
													fbs_util_pkg.sprintf('%-155.155s', ''	);				        --5.예비

		lsRet := fbs_main_pkg.send_realtime_document(lrSend,DEFAULT_TIMEOUT,lrRecv,v_result_code,v_result_msg);

		If lsRet <>	SUCCESS_CODE Then
			 fbs_util_pkg.write_log('FBS', lsRet||'(계좌번호:'||p_acct_number||')');
			 RAISE_APPLICATION_ERROR(-20010 ,lsRet||'(계좌번호:'||p_acct_number||')');	
			 Return ;
		End	If;
		
		ltNums(1) :=   2;	 --1.은행       
		ltNums(2) :=  15;	 --2.계좌번호                
		ltNums(3) :=  14;	 --3.주민(사업자)번호  
		ltNums(4) :=  14;	 --4.예금주명
		ltNums(5) := 155;	 --5.예비                

		ltVars := fbs_main_pkg.SplitDocu(lrRecv.gaeb_area,ltNums);

	  v_holder_name	:= To_Number(ltVars(4)); --4.예금주명
	  
	  p_holder_name	:= v_holder_name;
	  p_result_msg	:= v_result_msg; 
		
	END 	;
/
