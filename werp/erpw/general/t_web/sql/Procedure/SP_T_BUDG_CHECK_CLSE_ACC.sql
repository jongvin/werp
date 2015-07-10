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
		Raise_Application_Error(-20009,'예산월을 입력하십시오.');
	End If;
	If Not ( lrRec.ACCOUNT_FDT <= AR_BUDG_YM And lrRec.ACCOUNT_EDT >= AR_BUDG_YM) Then
		Raise_Application_Error(-20009,'예산월이 회기 범위를 벗어났습니다.');
	End If;
Exception When No_Data_Found Then
	Raise_Application_Error(-20009,'회기 정보를 찾을 수 없습니다.');
End;
/

