CREATE OR REPLACE Procedure
				sp_retrive_acct_remains( p_bank_code	   IN VARCHAR2 ,	   -- 은행코드
															   p_acct_number	 IN VARCHAR2 ,	   -- 계좌번호
															   p_remain_amt	   OUT NUMBER  ,	   -- 잔액		
															   p_enable_amt    OUT NUMBER  ,     -- 가용자금
															   p_resp_code	   OUT VARCHAR2,     -- 응답코드
															   p_resp_msg		   OUT VARCHAR2) IS  -- 응답코드명
		                									 	
		lrSend						  fbs_main_pkg.FB_VAN_SEND_RECORD;
		lrRecv						  fbs_main_pkg.FB_VAN_RECV_RECORD;
		ltVars						  fbs_main_pkg.T_Vars;
		ltNums						  fbs_main_pkg.T_Nums;

		lsRet						    Varchar2(4000);
		v_result_code				Varchar2(4000);
		v_result_msg				Varchar2(4000);		
		v_docu_num 					VARCHAR2(7);                -- 전문번호
    v_acct_number       Varchar2(4000);
   
    FB_DOCU_REMAIN_T    VARCHAR2(7) := '0600300'; /*  잔액조회        (업체=>은행)  */
    FB_DOCU_REMAIN_B    VARCHAR2(7) := '0610300'; /*  잔액조회        (은행=>업체)  */
    
		DEFAULT_TIMEOUT     NUMBER(10)   := 60;
		SUCCESS_CODE		Constant Varchar2(2) := 'OK';
		
	BEGIN
		-- >>>>>>>>>>>>>   처리로직	   <<<<<<<<<<<<<<<<<<
		
		--전문번호 
	  v_docu_num := FB_DOCU_REMAIN_T ;
		v_acct_number := replace(p_acct_number ,'-','');
		
		--.기본	초기화
		fbs_main_pkg.init_van_send_record(p_bank_code,v_acct_number,v_docu_num,lrSend);
		
		-- 개별부 설정
		lrSend.gaeb_area :=		fbs_util_pkg.sprintf('%-15.15s', v_acct_number) ||		  --1.계좌번호
													fbs_util_pkg.sprintf('%-1.1s'  , ''  ) ||		            --2.부호
													fbs_util_pkg.sprintf('%-13.13s', '0000000000000' ) ||		--3.현재잔액
													fbs_util_pkg.sprintf('%-13.13s', '0000000000000') ||		--4.지급가능액
													fbs_util_pkg.sprintf('%-158.158s', ''	);				        --5.예비

		lsRet := fbs_main_pkg.send_realtime_document(lrSend,DEFAULT_TIMEOUT,lrRecv,v_result_code,v_result_msg);

		If lsRet <>	SUCCESS_CODE Then
			 p_resp_msg := lsRet;
			 Return;
		End	If;
		
		ltNums(1) :=  15;	 --1.계좌번호            
		ltNums(2) :=   1;	 --2.부호                
		ltNums(3) :=  13;	 --3.현재잔액             
		ltNums(4) :=  13;	 --4.지급가능액
		ltNums(5) := 158;	 --5.예비                

		ltVars := fbs_main_pkg.SplitDocu(lrRecv.gaeb_area,ltNums);

		p_remain_amt	:= To_Number(ltVars(3)); --3.현재잔액  
	  p_enable_amt	:= To_Number(ltVars(4)); --4.지급가능액 
 		p_resp_code	  := v_result_code;
		p_resp_msg    := v_result_msg;
		
	END 	;
/
