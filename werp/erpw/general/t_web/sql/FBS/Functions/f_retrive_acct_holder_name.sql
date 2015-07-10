CREATE OR REPLACE Function
		 f_retrive_acct_holder_name( p_comp_code	   IN VARCHAR2 ,	   -- 사업장코드
		                             p_bank_code	   IN VARCHAR2 ,	   -- 은행코드
															   p_acct_number	 IN VARCHAR2 ,	   -- 계좌번호
															   p_biz_number	   IN VARCHAR2 )	   -- 주민(사업자)번호
		RETURN VARCHAR2 IS

		v_result      			Varchar2(4000);
		v_result_msg				Varchar2(4000);
		v_acct_number       Varchar2(4000);
		v_holder_name       Varchar2(15);
    
		DEFAULT_TIMEOUT     NUMBER(10)   := 60;
		SUCCESS_CODE		Constant Varchar2(2) := 'OK';
		Pragma autonomous_transaction;
		
	BEGIN
		-- >>>>>>>>>>>>>   처리로직	   <<<<<<<<<<<<<<<<<<
		 sp_retrive_acct_holder_name( p_comp_code	 , 
		                              p_bank_code	 ,
															    p_acct_number,
															    p_biz_number ,
															    v_holder_name,
															    v_result_msg	); 
	
		v_result := fbs_util_pkg.sprintf('%-14.14s' , v_holder_name) ||v_result_msg ;
		
		Commit;
		Return v_result;

	Exception When Others Then
		Rollback;
		Raise;
	End;		

