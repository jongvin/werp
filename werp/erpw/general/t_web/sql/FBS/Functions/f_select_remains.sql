CREATE OR REPLACE Function
		 f_select_remains( p_bank_code	   IN VARCHAR2 ,	   -- �����ڵ�
											 p_acct_number	 IN VARCHAR2 ) 	   -- ���¹�ȣ
		RETURN VARCHAR2 IS

		v_result      			Varchar2(4000);
		v_result_msg				Varchar2(4000);
		v_result_code				Varchar2(4000);
		v_remain_amt				number;
		v_enable_amt				number;
    
		SUCCESS_CODE		Constant Varchar2(2) := 'OK';
		Pragma autonomous_transaction;
		
	BEGIN
		-- >>>>>>>>>>>>>   ó������	   <<<<<<<<<<<<<<<<<<
		
		sp_retrive_acct_remains( p_bank_code, p_acct_number,v_remain_amt,v_enable_amt,v_result_code,v_result_msg );
		
		v_result := fbs_util_pkg.sprintf('%-13.13s' , v_remain_amt) ||
								fbs_util_pkg.sprintf('%-13.13s' , v_enable_amt) || v_result_msg ;
		
		Commit;
		Return v_result;

	Exception When Others Then
		Rollback;
		Raise;
	End;		