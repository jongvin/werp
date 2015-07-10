Create Or Replace Procedure SP_T_FL_GET_PLAN_FROM_DEPT
(
	Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC.COMP_CODE%Type,
	Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC.CLSE_ACC_ID%Type,
	Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC.CRTUSERNO%Type
)
Is
	lnCnt						Number;
	lsClose						Varchar2(2);
Begin
	Select
		Count(*),
		Max(PLAN_CONFIRM_TAG)
	Into
		lnCnt,
		lsClose
	From	T_FL_COMP_FLOW_MA_B a
	Where	a.COMP_CODE = Ar_COMP_CODE
	And		a.CLSE_ACC_ID = Ar_CLSE_ACC_ID;
	If lnCnt < 1 Then
		Insert Into T_FL_COMP_FLOW_MA_B
		(
			COMP_CODE,
			CLSE_ACC_ID,
			CRTUSERNO,
			CRTDATE,
			PLAN_CONFIRM_TAG
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			Ar_CRTUSERNO,
			SysDate,
			'F'
		);
	ElsIf lsClose = 'T' Then
		Raise_Application_Error(-20009,'�ش�ȸ���� �ڱݼ��� ��ȹ�� ���翡�� �����Ǿ� ������ �Ұ����մϴ�.');
	End If;
	PKG_FL_COM_PLAN.ProcessBatch(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_CRTUSERNO);
	SP_T_FL_MONTH_COM_PLAN_SUMUP(Ar_COMP_CODE,Ar_CLSE_ACC_ID);
End;
/
