Create Or Replace Procedure SP_T_U_Dept_Plan_Get_M_AMT
Is
	lsCompCode				T_FL_MONTH_PLAN_EXEC.COMP_CODE%Type;
	lsClseAccId				T_FL_MONTH_PLAN_EXEC.CLSE_ACC_ID%Type;
	lsDeptCode				T_FL_MONTH_PLAN_EXEC.DEPT_CODE%Type;
	lnFlowCode				T_FL_MONTH_PLAN_EXEC.FLOW_CODE%Type;
	lsCrtUserNo				T_FL_MONTH_PLAN_EXEC.CRTUSERNO%Type;
Begin
	lsCompCode := PKG_FL_DEPT_PLAN.Get_COMP_CODE;
	lsClseAccId := PKG_FL_DEPT_PLAN.Get_CLSE_ACC_ID;
	lsDeptCode := PKG_FL_DEPT_PLAN.Get_DEPT_CODE;
	lnFlowCode := PKG_FL_DEPT_PLAN.Get_FLOW_CODE;
	lsCrtUserNo := PKG_FL_DEPT_PLAN.Get_CRTUSERNO;
	-- 기존 자료는 이미 초기화 되어 있다고 봅니다.
	Merge Into T_FL_MONTH_PLAN_EXEC t
	Using
	(
		Select
			lsCompCode COMP_CODE,
			lsClseAccId CLSE_ACC_ID,
			a.DEPT_CODE ,
			a.WORK_YM ,
			lnFlowCode FLOW_CODE,
			lsCrtUserNo CRTUSERNO,
			SysDate CRTDATE,
			a.M_AMT SUM_PLAN_AMT
		From	C_FL_INV_PLAN_INTERFACE a
		Where	a.DEPT_CODE = lsDeptCode
		And		a.WORK_YM Like lsClseAccId || '%'
	) s
	On
	(
		s.COMP_CODE = t.COMP_CODE
	And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
	And	s.DEPT_CODE = t.DEPT_CODE
	And	s.WORK_YM = t.WORK_YM
	And	s.FLOW_CODE = t.FLOW_CODE
	)
	When Matched Then
	Update
	Set		t.SUM_PLAN_AMT = s.SUM_PLAN_AMT,
			t.MODUSERNO = s.CRTUSERNO,
			t.MODDATE = s.CRTDATE,
			t.PLAN_AMT = Nvl(s.SUM_PLAN_AMT,0) + Nvl(t.MOD_PLAN_AMT,0)
	When Not Matched Then
	Insert
	(COMP_CODE,CLSE_ACC_ID,DEPT_CODE,FLOW_CODE,WORK_YM,CRTUSERNO,CRTDATE,SUM_PLAN_AMT,PLAN_AMT)
	Values
	(s.COMP_CODE,s.CLSE_ACC_ID,s.DEPT_CODE,s.FLOW_CODE,s.WORK_YM,s.CRTUSERNO,s.CRTDATE,s.SUM_PLAN_AMT,s.SUM_PLAN_AMT);
End;
/
