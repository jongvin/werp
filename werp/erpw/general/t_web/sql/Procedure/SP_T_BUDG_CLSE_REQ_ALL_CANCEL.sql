CREATE OR REPLACE Procedure SP_T_BUDG_CLSE_REQ_ALL_CANCEL
(
	Ar_COMP_CODE					Varchar2,
	Ar_CLSE_ACC_ID					Varchar2
)
Is

	liStart							Number;
	liEnd							Number;
	lsErrm							Varchar2(2000);
Begin
	
	delete
	from t_budg_close a
	Where   a.comp_code = AR_COMP_CODE
	And		a.CLSE_ACC_ID = AR_CLSE_ACC_ID; 
		
	
End;