Create Or Replace Procedure SP_T_PL_REMOVE_PROJ_PLAN
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
Is
	lsClose					Varchar2(2);
	lnAmt					Number;
Begin
	--�������θ� �����Ѵ�.
	lsClose := F_T_PL_Is_Close_Dept(AR_COMP_CODE,AR_CLSE_ACC_ID,AR_DEPT_CODE);
	If lsClose = 'T' Then
		Raise_Application_Error(-20009,'�̹� �����Ǿ� ������ �Ұ����մϴ�.');
	End If;
	--���� �����̳� ���� �ݾ��� �ִ� �� Ȯ���Ѵ�.
	Select
		Nvl(Sum(Abs(SUM_FORECAST_AMT)),0) + 
		Nvl(Sum(Abs(MOD_FORECAST_AMT)),0) + 
		Nvl(Sum(Abs(FORECAST_AMT)),0) + 
		Nvl(Sum(Abs(EXEC_AMT)),0)
	Into
		lnAmt
	From	T_PL_COMP_DEPT_PLAN_EXEC
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		CHG_SEQ = 0
	And		DEPT_CODE = AR_DEPT_CODE;
	If lnAmt > 0 Then
		Raise_Application_Error(-20009,'�̹� �����۾��̳� ���������� �����Ƿ� ��ü ������ �Ұ����մϴ�.');
	End If;
	Delete	T_PL_COMP_DEPT_PLAN_EXEC
	Where	COMP_CODE = AR_COMP_CODE
	And		CLSE_ACC_ID = AR_CLSE_ACC_ID
	And		CHG_SEQ = 0
	And		DEPT_CODE = AR_DEPT_CODE;
End;
/
