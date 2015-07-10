Create Or Replace Procedure SP_T_FL_REMOVE_FOREC
(
	AR_COMP_CODE				VARCHAR2,
	AR_CLSE_ACC_ID				VARCHAR2,
	Ar_QUARTER_YEAR				Number
)
Is
	lsClose					Varchar2(2);
	lsBegin						Varchar2(6);
	lsEnd						Varchar2(6);
Begin
	--�������θ� �����Ѵ�.
	lsClose := F_T_FL_Is_Close_Comp_F(AR_COMP_CODE,AR_CLSE_ACC_ID,Ar_QUARTER_YEAR);
	If lsClose = 'T' Then
		Raise_Application_Error(-20009,'�̹� �����Ǿ� ������ �Ұ����մϴ�.');
	End If;
	If Ar_QUARTER_YEAR = 1 Then
		lsBegin := Ar_CLSE_ACC_ID||'01';
		lsEnd := Ar_CLSE_ACC_ID||'03';
	End If;
	If Ar_QUARTER_YEAR = 2 Then
		lsBegin := Ar_CLSE_ACC_ID||'04';
		lsEnd := Ar_CLSE_ACC_ID||'06';
	End If;
	If Ar_QUARTER_YEAR = 3 Then
		lsBegin := Ar_CLSE_ACC_ID||'07';
		lsEnd := Ar_CLSE_ACC_ID||'09';
	End If;
	If Ar_QUARTER_YEAR = 4 Then
		lsBegin := Ar_CLSE_ACC_ID||'10';
		lsEnd := Ar_CLSE_ACC_ID||'12';
	End If;
	Update	T_FL_MONTH_PLAN_EXEC_B
	Set		SUM_FORECAST_AMT = 0,
			MOD_FORECAST_AMT = 0,
			B_MOD_FORECAST_AMT = 0,
			FORECAST_AMT = 0
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		WORK_YM Between lsBegin And lsEnd;
End;
/
