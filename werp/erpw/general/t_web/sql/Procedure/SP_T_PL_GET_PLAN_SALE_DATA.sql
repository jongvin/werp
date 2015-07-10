Create Or Replace Procedure SP_T_PL_GET_PLAN_SALE_DATA
(
	Ar_COMP_CODE				T_PL_COMP_DEPT_PLAN_EXEC.COMP_CODE%Type,
	Ar_CLSE_ACC_ID				T_PL_COMP_DEPT_PLAN_EXEC.CLSE_ACC_ID%Type,
	Ar_DEPT_CODE				T_PL_COMP_DEPT_PLAN_EXEC.DEPT_CODE%Type,
	Ar_CRTUSERNO				T_PL_COMP_DEPT_PLAN_EXEC.CRTUSERNO%Type
)
Is
	lnCnt						Number;
	lsClose						Varchar2(2);
	lrBase						T_PL_SALE_PLAN%RowType;
	lddtBase					Date;
Begin
	lddtBase := To_Date(Ar_CLSE_ACC_ID||'0101','YYYYMMDD');
	lrBase.COMP_CODE := Ar_COMP_CODE;
	lrBase.CLSE_ACC_ID := Ar_CLSE_ACC_ID;
	lrBase.DEPT_CODE := Ar_DEPT_CODE;
	lrBase.CRTUSERNO := Ar_CRTUSERNO;
	lrBase.CRTDATE := SysDate;
	Begin
		Select
			CONS_AMT,
			Nvl(BUDG_AMT,0) + Nvl(AS_AMT,0)
		Into
			lrBase.CONS_AMT,
			lrBase.BUDG_AMT
		From	T_DEPT_CODE_ORG
		Where	DEPT_CODE = Ar_DEPT_CODE;
	Exception When No_Data_Found Then
		lrBase.CONS_AMT := 0;
		lrBase.BUDG_AMT := 0;
	End;
	--매출원가
	Begin
		Select
			Nvl(Sum(DB_AMT),0) - Nvl(Sum(CR_AMT),0)
		Into
			lrBase.PY_COST_SUM
		From	T_ACC_SLIP_BODY1
		Where	DEPT_CODE = Ar_DEPT_CODE
		And		KEEP_DT Is Not Null
		And		TRANSFER_TAG = 'F'
		And		ACC_CODE Like '52%'
		And		MAKE_DT < lddtBase;
	Exception When No_Data_Found Then
		lrBase.PY_COST_SUM := 0;
	End;
	--매출액
	Begin
		Select
			Nvl(Sum(CR_AMT),0) - Nvl(Sum(DB_AMT),0)
		Into
			lrBase.PY_SALE_SUM
		From	T_ACC_SLIP_BODY1
		Where	DEPT_CODE = Ar_DEPT_CODE
		And		KEEP_DT Is Not Null
		And		TRANSFER_TAG = 'F'
		And		ACC_CODE Like '51%'
		And		MAKE_DT < lddtBase;
	Exception When No_Data_Found Then
		lrBase.PY_SALE_SUM := 0;
	End;
	Begin
		Insert Into T_PL_SALE_PLAN Values lrBase;
	Exception When Dup_Val_On_Index Then
		Update	T_PL_SALE_PLAN
		Set		CONS_AMT = lrBase.CONS_AMT,
				BUDG_AMT = lrBase.BUDG_AMT,
				PY_COST_SUM = lrBase.PY_COST_SUM,
				PY_SALE_SUM = lrBase.PY_SALE_SUM,
				MODUSERNO = Ar_CRTUSERNO,
				MODDATE = Sysdate
		Where	COMP_CODE = lrBase.COMP_CODE
		And		CLSE_ACC_ID = lrBase.CLSE_ACC_ID
		And		DEPT_CODE = lrBase.DEPT_CODE;
	End;
	Merge Into T_PL_SALE_PLAN_YM t
	Using
	(
		Select
			Ar_COMP_CODE COMP_CODE,
			Ar_CLSE_ACC_ID CLSE_ACC_ID,
			Ar_CRTUSERNO CRTUSERNO,
			SysDate CRTDATE,
			a.DEPT_CODE,
			a.WORK_YM,
			a.NM_COST_AMT,
			0 CONS_INC_AMT,
			0 BUDG_INC_AMT,
			Nvl(Round(a.CONS_AMT * ((Nvl(a.PRE_COST,0) + Nvl(a.NM_COST_AMT_SUM,0)) / NullIf(a.BUDG_AMT,0))),0) 
				- Nvl(Nvl(Lag(Round(a.CONS_AMT * ((Nvl(a.PRE_COST,0) + Nvl(a.NM_COST_AMT_SUM,0)) / NullIf(a.BUDG_AMT,0)))) Over (Order By a.WORK_YM ),a.PRE_SALE),0) NM_SALE_AMT
			From
				(
					Select
						a.DEPT_CODE,
						a.WORK_YM,
						Nvl(a.M_AMT ,0) +
						Nvl(a.L_AMT ,0) +
						Nvl(a.X_AMT ,0) +
						Nvl(a.S_AMT,0) NM_COST_AMT,
						lrBase.PY_COST_SUM PRE_COST,
						lrBase.PY_SALE_SUM PRE_SALE,
						lrBase.CONS_AMT CONS_AMT,
						lrBase.BUDG_AMT BUDG_AMT,
						Sum(Nvl(a.M_AMT ,0) +
							Nvl(a.L_AMT ,0) +
							Nvl(a.X_AMT ,0) +
							Nvl(a.S_AMT,0)) Over (Order By a.WORK_YM) NM_COST_AMT_SUM
					From	C_FL_INV_PLAN_INTERFACE a
					Where	a.DEPT_CODE = Ar_DEPT_CODE
					And		a.WORK_YM Like Ar_CLSE_ACC_ID || '%'
					Order By
						a.WORK_YM
				) a
			Order By
				a.WORK_YM
	) s
	On
	(
		s.COMP_CODE = t.COMP_CODE
	And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
	And	s.DEPT_CODE = t.DEPT_CODE
	And	s.WORK_YM = t.WORK_YM
	)
	When Matched Then
	Update
	Set		t.NM_COST_AMT = s.NM_COST_AMT,
			t.CONS_INC_AMT = s.CONS_INC_AMT,
			t.BUDG_INC_AMT = s.BUDG_INC_AMT,
			t.NM_SALE_AMT = s.NM_SALE_AMT,
			t.MODUSERNO = s.CRTUSERNO,
			t.MODDATE = s.CRTDATE
	When Not Matched Then
	Insert
	(
		COMP_CODE,
		CLSE_ACC_ID,
		DEPT_CODE,
		WORK_YM,
		CRTUSERNO,
		CRTDATE,
		CONS_INC_AMT,
		BUDG_INC_AMT,
		NM_COST_AMT,
		NM_SALE_AMT
	)
	Values
	(
		s.COMP_CODE,
		s.CLSE_ACC_ID,
		s.DEPT_CODE,
		s.WORK_YM,
		s.CRTUSERNO,
		s.CRTDATE,
		s.CONS_INC_AMT,
		s.BUDG_INC_AMT,
		s.NM_COST_AMT,
		s.NM_SALE_AMT
	);
End;
/
