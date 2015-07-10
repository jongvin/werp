CREATE OR REPLACE Function F_T_FL_Is_Close_Dept_E
(
	AR_COMP_CODE				VARCHAR2,
	AR_CLSE_ACC_ID				VARCHAR2,
	AR_DEPT_CODE				VARCHAR2,
	Ar_WORK_YM					VARCHAR2
)
Return Varchar2
Is
	lsClose1						Varchar2(2);
	lsClose2						Varchar2(2);
Begin
	Begin
		Select
			EXEC_CONFIRM_TAG
		Into
			lsClose1
		From	T_FL_DEPT_EXEC_CLOSE
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE
		And		WORK_YM = Ar_WORK_YM;
	Exception When No_Data_Found Then
		lsClose1 := 'F';
	End;
	If lsClose1 = 'T' Then
		Return 'T';
	End If;
	Begin
		Select
			EXEC_CONFIRM_TAG
		Into
			lsClose2
		From	T_FL_COMP_EXEC_CLOSE
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		WORK_YM = Ar_WORK_YM;
	Exception When No_Data_Found Then
		lsClose2 := 'F';
	End;
	If lsClose2 = 'T' Then
		Return 'T';
	End If;
	Return 'F';
End;
/
