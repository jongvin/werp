CREATE OR REPLACE Function F_T_FL_Is_Close_Dept
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
		From	T_FL_DEPT_FLOW_MA
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE;
	Exception When No_Data_Found Then
		lsClose1 := 'F';
	End;
	If lsClose1 = 'T' Then
		Return 'T';
	End If;
	Begin
		Select
			PLAN_CONFIRM_TAG
		Into
			lsClose2
		From	T_FL_COMP_FLOW_MA_B
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID;
	Exception When No_Data_Found Then
		lsClose2 := 'F';
	End;
	If lsClose2 = 'T' Then
		Return 'T';
	End If;
	Return 'F';
End;
/
