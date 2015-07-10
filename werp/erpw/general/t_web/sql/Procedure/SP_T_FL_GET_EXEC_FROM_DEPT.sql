Create Or Replace Procedure SP_T_FL_GET_EXEC_FROM_DEPT
(
	Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC.COMP_CODE%Type,
	Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC.CLSE_ACC_ID%Type,
	Ar_WORK_YM					T_FL_MONTH_PLAN_EXEC.WORK_YM%Type,
	Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC.CRTUSERNO%Type
)
Is
	lnCnt						Number;
	lsClose						Varchar2(2);
Begin
	Select
		Count(*),
		Max(EXEC_CONFIRM_TAG)
	Into
		lnCnt,
		lsClose
	From	T_FL_COMP_EXEC_CLOSE a
	Where	a.COMP_CODE = Ar_COMP_CODE
	And		a.CLSE_ACC_ID = Ar_CLSE_ACC_ID
	And		a.WORK_YM = Ar_WORK_YM;
	If lnCnt < 1 Then
		Insert Into T_FL_COMP_EXEC_CLOSE
		(
			COMP_CODE,
			CLSE_ACC_ID,
			WORK_YM,
			CRTUSERNO,
			CRTDATE,
			EXEC_CONFIRM_TAG
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			Ar_WORK_YM,
			Ar_CRTUSERNO,
			SysDate,
			'F'
		);
	ElsIf lsClose = 'T' Then
		Raise_Application_Error(-20009,'�ش�ȸ��,�ش�б��� �ڱݼ��� ������ ���翡�� �����Ǿ� ������ �Ұ����մϴ�.');
	End If;
	PKG_FL_COMP_EXEC.ProcessBatch(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_WORK_YM,Ar_CRTUSERNO);
	SP_T_FL_MONTH_COM_EXEC_SUMUP(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_WORK_YM);
End;
/
