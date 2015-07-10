Create Or Replace Procedure SP_T_FL_REMOVE_FORE_B
(
	AR_COMP_CODE				VARCHAR2,
	AR_CLSE_ACC_ID				VARCHAR2,
	AR_DEPT_CODE				VARCHAR2,
	Ar_QUARTER_YEAR				Number
)
Is
	lsClose					Varchar2(2);
	lsBegin						Varchar2(6);
	lsEnd						Varchar2(6);
Begin
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
	--마감여부를 검증한다.
	lsClose := F_T_FL_Is_Close_Dept_F(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE,Ar_QUARTER_YEAR);
	If lsClose = 'T' Then
		Raise_Application_Error(-20009,'이미 마감되어 삭제가 불가능합니다.');
	End If;
	Update	T_FL_MONTH_PLAN_EXEC_PROJ_B
	Set		SUM_FORECAST_AMT = 0,
			MOD_FORECAST_AMT = 0,
			FORECAST_AMT = 0
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		DEPT_CODE = AR_DEPT_CODE
	And		WORK_YM Between lsBegin And lsEnd;
End;
/
