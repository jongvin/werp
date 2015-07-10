CREATE OR REPLACE Procedure
		 sp_reselect_remains( p_bank_code	   IN VARCHAR2 ,	   -- �����ڵ�
											    p_acct_number	 IN VARCHAR2 )IS   -- ���¹�ȣ

		v_result      			Varchar2(4000);
		v_result_msg				Varchar2(4000);	
		v_result_code				Varchar2(4000);		
		v_remain_amt				number;
		v_enable_amt				number;
    
		SUCCESS_CODE		Constant Varchar2(2) := 'OK';
		
	BEGIN
		-- >>>>>>>>>>>>>   ó������	   <<<<<<<<<<<<<<<<<<
		
		sp_retrive_acct_remains( p_bank_code, 
		                         p_acct_number,
		                         v_remain_amt,
		                         v_enable_amt,
		                         v_result_code,
		                         v_result_msg );

	Exception When Others Then
		Raise;
	End;		