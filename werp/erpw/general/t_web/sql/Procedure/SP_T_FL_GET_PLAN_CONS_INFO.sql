Create Or Replace Procedure SP_T_FL_GET_PLAN_CONS_INFO
(
	Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC.COMP_CODE%Type,
	Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC.CLSE_ACC_ID%Type,
	Ar_DEPT_CODE				T_FL_MONTH_PLAN_EXEC.DEPT_CODE%Type,
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
	From	T_FL_DEPT_FLOW_MA a
	Where	a.COMP_CODE = Ar_COMP_CODE
	And		a.CLSE_ACC_ID = Ar_CLSE_ACC_ID
	And		a.DEPT_CODE = Ar_DEPT_CODE;
	If lnCnt < 1 Then
		Insert Into T_FL_DEPT_FLOW_MA
		(
			COMP_CODE,
			CLSE_ACC_ID,
			DEPT_CODE,
			CRTUSERNO,
			CRTDATE,
			PLAN_CONFIRM_TAG
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			Ar_DEPT_CODE,
			Ar_CRTUSERNO,
			SysDate,
			'F'
		);
	ElsIf lsClose = 'T' Then
		Raise_Application_Error(-20009,'해당회기의 자금수지 계획은 본사에서 마감(현장별 마감)되어 변경이 불가능합니다.');
	End If;
	PKG_FL_DEPT_PLAN.ProcessBatch(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_CRTUSERNO);
	SP_T_FL_MONTH_PLAN_SUMUP(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE);
End;
/
