CREATE OR REPLACE Function F_T_PL_Is_Close_Dept
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
Return Varchar2
Is
	lsClose1						Varchar2(2);
	lsClose2						Varchar2(2);
Begin
	Begin
		Select
			PLAN_CONFIRM_TAG
		Into
			lsClose1
		From	T_PL_COMP_PLAN_CHG
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		CHG_SEQ = 0;
	Exception When No_Data_Found Then
		lsClose1 := 'F';
	End;
	If lsClose1 = 'T' Then
		Return 'T';
	End If;
	Return 'F';
End;
/
