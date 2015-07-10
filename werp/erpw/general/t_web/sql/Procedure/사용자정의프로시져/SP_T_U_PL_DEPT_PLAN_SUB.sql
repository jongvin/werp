Create Or Replace Procedure SP_T_U_PL_DEPT_PLAN_SUB
(
	Ar_Mng_Code1			Varchar2,
	Ar_Mng_Code2			Varchar2
)
--항목 차감
Is
	lsCompCode				T_PL_COMP_DEPT_PLAN_EXEC.COMP_CODE%Type := PKG_PL_DEPT_PLAN.Get_COMP_CODE;
	lsClesAccId				T_PL_COMP_DEPT_PLAN_EXEC.CLSE_ACC_ID%Type := PKG_PL_DEPT_PLAN.Get_CLSE_ACC_ID;
	lnChgSeq				T_PL_COMP_DEPT_PLAN_EXEC.CHG_SEQ%Type := PKG_PL_DEPT_PLAN.Get_CHG_SEQ;
	lsDeptCode				T_PL_COMP_DEPT_PLAN_EXEC.DEPT_CODE%Type := PKG_PL_DEPT_PLAN.Get_DEPT_CODE;
	lnItemNo				T_PL_COMP_DEPT_PLAN_EXEC.BIZ_PLAN_ITEM_NO%Type := PKG_PL_DEPT_PLAN.Get_BIZ_PLAN_ITEM_NO;
	lsCrtUserNo				T_PL_COMP_DEPT_PLAN_EXEC.CRTUSERNO%Type := PKG_PL_DEPT_PLAN.Get_CRTUSERNO;
Begin
		Merge Into T_PL_COMP_DEPT_PLAN_EXEC t
		Using
		(
			Select
				a.COMP_CODE,
				a.CLSE_ACC_ID,
				a.CHG_SEQ,
				a.DEPT_CODE,
				a.WORK_YM,
				lnItemNo BIZ_PLAN_ITEM_NO,
				lsCrtUserNo CRTUSERNO,
				SysDate CRTDATE,
				Sum(
				Case b.MNG_CODE
				When Ar_Mng_Code1 Then a.SUM_PLAN_AMT
				When Ar_Mng_Code2 Then - a.SUM_PLAN_AMT
				Else 0
				End) SUM_PLAN_AMT,
				Sum(
				Case b.MNG_CODE
				When Ar_Mng_Code1 Then a.MOD_PLAN_AMT
				When Ar_Mng_Code2 Then - a.MOD_PLAN_AMT
				Else 0
				End) MOD_PLAN_AMT,
				Sum(
				Case b.MNG_CODE
				When Ar_Mng_Code1 Then a.PLAN_AMT
				When Ar_Mng_Code2 Then - a.PLAN_AMT
				Else 0
				End) PLAN_AMT
			From	T_PL_COMP_DEPT_PLAN_EXEC a,
					T_PL_ITEM b
			Where	a.COMP_CODE = lsCompCode
			And		a.CLSE_ACC_ID = lsClesAccId
			And		a.DEPT_CODE = lsDeptCode
			And		a.CHG_SEQ = lnChgSeq
			And		a.BIZ_PLAN_ITEM_NO = b.BIZ_PLAN_ITEM_NO
			And		b.MNG_CODE In (Ar_Mng_Code1,Ar_Mng_Code2)
			Group By
				a.COMP_CODE,
				a.CLSE_ACC_ID,
				a.CHG_SEQ,
				a.DEPT_CODE,
				a.WORK_YM
		) s
		On
		(
			s.COMP_CODE = t.COMP_CODE
		And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	s.CHG_SEQ = t.CHG_SEQ
		And	s.DEPT_CODE = t.DEPT_CODE
		And	s.WORK_YM = t.WORK_YM
		And	s.BIZ_PLAN_ITEM_NO = t.BIZ_PLAN_ITEM_NO
		)
		When Matched Then
		Update
		Set		t.SUM_PLAN_AMT = Nvl(s.SUM_PLAN_AMT,0) + Nvl(s.MOD_PLAN_AMT,0) ,
				t.MOD_PLAN_AMT = 0,
				t.PLAN_AMT = Nvl(s.SUM_PLAN_AMT,0) + Nvl(s.MOD_PLAN_AMT,0),
				t.MODDATE = s.CRTDATE,
				t.MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert
		(COMP_CODE,CLSE_ACC_ID,CHG_SEQ,DEPT_CODE,WORK_YM,BIZ_PLAN_ITEM_NO,CRTDATE,CRTUSERNO,SUM_PLAN_AMT,MOD_PLAN_AMT,PLAN_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.CHG_SEQ,s.DEPT_CODE,s.WORK_YM,s.BIZ_PLAN_ITEM_NO,s.CRTDATE,s.CRTUSERNO,Nvl(s.SUM_PLAN_AMT,0) + Nvl(s.MOD_PLAN_AMT,0),0,Nvl(s.SUM_PLAN_AMT,0) + Nvl(s.MOD_PLAN_AMT,0));
End;
/
