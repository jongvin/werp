CREATE OR REPLACE Function F_T_FL_Is_Close_Comp
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2
)
Return Varchar2
Is
	lsClose2						Varchar2(2);
Begin
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
