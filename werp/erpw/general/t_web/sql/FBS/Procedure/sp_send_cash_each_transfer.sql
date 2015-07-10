CREATE OR REPLACE Procedure
				sp_send_cash_each_transfer( p_out_bank_code	   IN VARCHAR2 ,	   -- 출금은행코드
																	  p_out_acct_number	 IN VARCHAR2 ,	   -- 출금계좌번호
								 									  p_in_bank_code	   IN VARCHAR2 ,	   -- 입금은행코드
																	  p_in_acct_number	 IN VARCHAR2 ,	   -- 입금계좌번호
																	  p_pay_amt	         IN NUMBER   ,	   -- 이체금액									 
																	  p_commission       OUT NUMBER  ,     -- 수수료
																	  p_resp_code	       OUT VARCHAR2,     -- 응답코드
																	  p_resp_msg		     OUT VARCHAR2,     -- 응답코드명
																	  p_docu_numc		     OUT VARCHAR2,     -- 전문번호
																	  p_send_date		     OUT VARCHAR2,     -- 전송시간
																	  p_recv_date		     OUT VARCHAR2 ) IS -- 응답시간
		                									 	
		lrSend						fbs_main_pkg.FB_VAN_SEND_RECORD;
		lrRecv						fbs_main_pkg.FB_VAN_RECV_RECORD;
		ltVars						fbs_main_pkg.T_Vars;
		ltNums						fbs_main_pkg.T_Nums;

		lsRet						    Varchar2(4000);
		v_result_code				Varchar2(4000);
		v_result_msg				Varchar2(4000);		
		v_account_pass			VARCHAR2(8);                -- 비밀번호
		v_docu_num 					VARCHAR2(7);                -- 전문번호
		v_real_sign_no 			VARCHAR2(6);                -- 복기부호
   
    FB_DOCU_DATR_T      VARCHAR2(7) := '0100100'; /*  당행이체        (업체=>은행)  */
    FB_DOCU_DATR_B      VARCHAR2(7) := '0110100'; /*  당행이체        (은행=>업체)  */
    FB_DOCU_TATR_T      VARCHAR2(7) := '0100200'; /*  타행이체        (업체=>은행)  */
    FB_DOCU_TATR_B      VARCHAR2(7) := '0110200'; /*  타행이체        (은행=>업체)  */
    
		DEFAULT_TIMEOUT     NUMBER(10)   := 60;
		SUCCESS_CODE		Constant Varchar2(2) := 'OK';
		
	BEGIN
		-- >>>>>>>>>>>>>   처리로직	   <<<<<<<<<<<<<<<<<<
							
    -- 출금은행정보를 가져옵니다.(통장비밀번호,이체비밀번호)
    SELECT fbs_util_pkg.pw_decode( NEW_PASSWORD , 4 )||
    			 fbs_util_pkg.pw_decode( NEW_PASSWORD , 4 )
    INTO   v_account_pass 
    FROM   T_FB_ACCOUNTS_PWD
    WHERE  ACCOUNT_NO = p_out_acct_number ;

		--전문번호 
		IF p_out_bank_code = p_in_bank_code  THEN
			 v_docu_num := FB_DOCU_DATR_T ;
		ELSE	
			 v_docu_num := FB_DOCU_TATR_T ;
		END IF;			 

    -- 복기부호
    SELECT fbs_util_pkg.get_real_sign_no (p_out_bank_code ,p_out_acct_number ,
                             p_in_bank_code  ,p_in_acct_number  ,p_pay_amt,v_docu_num )
    INTO   v_real_sign_no
    FROM   dual ;    

		--.기본	초기화
		fbs_main_pkg.init_van_send_record(p_out_bank_code,p_out_acct_number,v_docu_num,lrSend);
		
		-- 개별부 설정
		lrSend.gaeb_area :=		fbs_util_pkg.sprintf('%-15.15s', p_in_acct_number) ||		--1.출금계좌번호
													fbs_util_pkg.sprintf('%-8.8s'  , v_account_pass  ) ||		--2.비밀번호(8)
													fbs_util_pkg.sprintf('%-6.6s'  , v_real_sign_no  ) ||		--3.복기부호
													fbs_util_pkg.sprintf('%-13.13s', LPAD(TO_CHAR(p_pay_amt),13,'0')) ||		--4.출금금액
													fbs_util_pkg.sprintf('%-1.1s'  , ''	) ||				        --5.출금후잔액부호
													fbs_util_pkg.sprintf('%-13.13s', '' )	||					      --6.출금후잔액
													fbs_util_pkg.sprintf('%-2.2s'  , p_in_bank_code	 ) ||		--7.입금은행코드
													fbs_util_pkg.sprintf('%-15.15s', p_in_acct_number) ||		--8.입금계좌번호
													fbs_util_pkg.sprintf('%-13.13s', ''	) ||				        --9.수수료
													fbs_util_pkg.sprintf('%-6.6s'  , '' )	||					      --10.CMS코드
													fbs_util_pkg.sprintf('%-22.22s', ''	) ||				        --11.입금인 성명(사용안함)
													fbs_util_pkg.sprintf('%-14.14s', '' )	||					      --12.입금인통장적요
													fbs_util_pkg.sprintf('%-72.72s', ''	) ;				          --13.예비

		lsRet := fbs_main_pkg.send_realtime_document(lrSend,DEFAULT_TIMEOUT,lrRecv,v_result_code,v_result_msg);

		If lsRet <>	SUCCESS_CODE Then
			 p_resp_msg := lsRet;
       fbs_util_pkg.write_log('FBS' , p_resp_msg);
	     RAISE_APPLICATION_ERROR(-20030,p_resp_msg);
			 Return;
		End	If;
		
		ltNums(1) :=  15;	--1.출금계좌번호           
		ltNums(2) :=   8;	--2.비밀번호(8)            
		ltNums(3) :=   6;	--3.복기부호               
		ltNums(4) :=  13;	--4.출금금액               
		ltNums(5) :=   1;	--5.출금후잔액부호         
		ltNums(6) :=  13;	--6.출금후잔액             
		ltNums(7) :=   2;	--7.8            
		ltNums(8) :=  15;	--8.입금계좌번호           
		ltNums(9) :=  13;	--9.수수료                 
		ltNums(10) :=  6;	--10.CMS코드               
		ltNums(11) := 22;	--11.입금인 성명(사용안함) 
		ltNums(12) := 14;	--12.입금인통장적요        
		ltNums(13) :=  7;	--13.예비                  


		ltVars := fbs_main_pkg.SplitDocu(lrRecv.gaeb_area,ltNums);

		p_commission	:= To_Number(ltVars(9)); --9.수수료  
 		p_resp_code	:= v_result_code;
		p_resp_msg := v_result_msg;
		p_send_date := lrSend.send_date||lrSend.send_time;
		p_recv_date := lrRecv.send_date||lrRecv.send_time;
		p_docu_numc := lrSend.docu_numc;
		
	END 	;
