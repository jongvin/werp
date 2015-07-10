CREATE OR REPLACE Function F_T_FL_Is_Close_Dept_F
(
	AR_COMP_CODE				VARCHAR2,
	AR_CLSE_ACC_ID				VARCHAR2,
	AR_DEPT_CODE				VARCHAR2,
	Ar_QUARTER_YEAR				Number
)
Return Varchar2
Is
	lsClose1						Varchar2(2);
	lsClose2						Varchar2(2);
Begin
	Begin
		Select
			FORE_CONFIRM_TAG
		Into
			lsClose1
		From	T_FL_DEPT_FORECAST_CLOSE
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		DEPT_CODE = AR_DEPT_CODE
		And		QUARTER_YEAR = Ar_QUARTER_YEAR;
	Exception When No_Data_Found Then
		lsClose1 := 'F';
	End;
	If lsClose1 = 'T' Then
		Return 'T';
	End If;
	Begin
		Select
			FORE_CONFIRM_TAG
		Into
			lsClose2
		From	T_FL_COMP_FORECAST_CLOSE
		Where	COMP_CODE = AR_COMP_CODE
		And		CLSE_ACC_ID = AR_CLSE_ACC_ID
		And		QUARTER_YEAR = Ar_QUARTER_YEAR;
	Exception When No_Data_Found Then
		lsClose2 := 'F';
	End;
	If lsClose2 = 'T' Then
		Return 'T';
	End If;
	Return 'F';
End;
/
