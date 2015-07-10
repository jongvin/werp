Create Or Replace Procedure SP_T_BUDG_CHECK_CLSE_ACC
(
	AR_COMP_CODE					VARCHAR2,
	AR_CLSE_ACC_ID					VARCHAR2,
	AR_BUDG_YM						Date
)
Is
	lrRec					T_YEAR_CLOSE%RowType;
Begin
	Select
		*
	Into
		lrRec
	From	T_YEAR_CLOSE
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID;
	If AR_BUDG_YM Is Null Then
		Raise_Application_Error(-20009,'������� �Է��Ͻʽÿ�.');
	End If;
	If Not ( lrRec.ACCOUNT_FDT <= AR_BUDG_YM And lrRec.ACCOUNT_EDT >= AR_BUDG_YM) Then
		Raise_Application_Error(-20009,'������� ȸ�� ������ ������ϴ�.');
	End If;
Exception When No_Data_Found Then
	Raise_Application_Error(-20009,'ȸ�� ������ ã�� �� �����ϴ�.');
End;
/

