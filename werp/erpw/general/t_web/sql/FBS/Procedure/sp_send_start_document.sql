CREATE OR REPLACE Procedure
		sp_send_start_document( p_comp_code	 IN VARCHAR2 ,	   -- 사업장코드
		                 				p_bank_code	 IN VARCHAR2 ) IS  -- 은행코드
		                									 	
		lrSend						fbs_main_pkg.FB_VAN_SEND_RECORD;
		lrRecv						fbs_main_pkg.FB_VAN_RECV_RECORD;

		lsRet						  Varchar2(4000);
		v_result_code			Varchar2(4000);
		v_result_msg			Varchar2(4000);		
		v_docu_num 				VARCHAR2(7);                -- 전문번호

    FB_DOCU_OPEN_T    VARCHAR2(7) := '0800100'; /*  개시전문        (업체=>은행)  */
    FB_DOCU_OPEN_B    VARCHAR2(7) := '0810100'; /*  개시전문        (은행=>업체)  */

		DEFAULT_TIMEOUT   NUMBER(10)   := 60;
		SUCCESS_CODE		  Constant Varchar2(2) := 'OK';
		
	BEGIN
		-- >>>>>>>>>>>>>   처리로직	   <<<<<<<<<<<<<<<<<<
		--전문번호 
	  v_docu_num := FB_DOCU_OPEN_T ;

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
		lrSend.docu_numc :=	F_T_Gen_docu_numc(lrSend.bank_code,lrSend.docu_code,lrSend.upmu_code,lrSend.send_date);
		
		-- 개별부 설정		
		lrSend.gaeb_area :=		fbs_util_pkg.sprintf( '%-200s'  , '' );

		lsRet := fbs_main_pkg.send_realtime_document(lrSend,DEFAULT_TIMEOUT,lrRecv,v_result_code,v_result_msg);

		If lsRet <>	SUCCESS_CODE Then
				fbs_util_pkg.write_log('FBS', sqlerrm||'(은행:'||p_bank_code||')');
				RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(은행:'||p_bank_code||')');
		End	If;

EXCEPTION
	WHEN OTHERS THEN		
			fbs_util_pkg.write_log('FBS', sqlerrm||'(은행:'||p_bank_code||')');
			RAISE_APPLICATION_ERROR(-20010 ,sqlerrm||'(은행:'||p_bank_code||')');
END 	;
/
