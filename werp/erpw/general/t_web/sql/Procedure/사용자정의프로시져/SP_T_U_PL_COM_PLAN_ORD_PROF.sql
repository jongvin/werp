Create Or Replace Procedure SP_T_U_PL_COM_PLAN_ORD_PROF
--경상이익
Is
	lsCompCode				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type := PKG_PL_COM_PLAN.Get_COMP_CODE;
	lsClesAccId				T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type := PKG_PL_COM_PLAN.Get_CLSE_ACC_ID;
	lnChgSeq				T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type := PKG_PL_COM_PLAN.Get_CHG_SEQ;
	lnItemNo				T_PL_COMP_PLAN_EXEC.BIZ_PLAN_ITEM_NO%Type := PKG_PL_COM_PLAN.Get_BIZ_PLAN_ITEM_NO;
	lsCrtUserNo				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type := PKG_PL_COM_PLAN.Get_CRTUSERNO;
	ls_Mng_Code1			T_PL_ITEM.MNG_CODE%Type := '영업이익';
	ls_Mng_Code2			T_PL_ITEM.MNG_CODE%Type := '영업외수익';
	ls_Mng_Code3			T_PL_ITEM.MNG_CODE%Type := '영업외비용';
Begin
	Merge Into T_PL_COMP_PLAN_EXEC t
	Using
	(
		Select
			a.COMP_CODE,
			a.CLSE_ACC_ID,
			a.CHG_SEQ,
			a.WORK_YM,
			lnItemNo BIZ_PLAN_ITEM_NO,
			lsCrtUserNo CRTUSERNO,
			SysDate CRTDATE,
			Sum(
			Case b.MNG_CODE
			When ls_Mng_Code1 Then a.SUM_PLAN_AMT
			When ls_Mng_Code2 Then a.SUM_PLAN_AMT
			When ls_Mng_Code3 Then - a.SUM_PLAN_AMT
			Else 0
			End) SUM_PLAN_AMT,
			Sum(
			Case b.MNG_CODE
			When ls_Mng_Code1 Then a.MOD_PLAN_AMT
			When ls_Mng_Code2 Then a.MOD_PLAN_AMT
			When ls_Mng_Code3 Then - a.MOD_PLAN_AMT
			Else 0
			End) MOD_PLAN_AMT,
			Sum(
			Case b.MNG_CODE
			When ls_Mng_Code1 Then a.B_MOD_PLAN_AMT
			When ls_Mng_Code2 Then a.B_MOD_PLAN_AMT
			When ls_Mng_Code3 Then - a.B_MOD_PLAN_AMT
			Else 0
			End) B_MOD_PLAN_AMT,
			Sum(
			Case b.MNG_CODE
			When ls_Mng_Code1 Then a.PLAN_AMT
			When ls_Mng_Code2 Then a.PLAN_AMT
			When ls_Mng_Code3 Then - a.PLAN_AMT
			Else 0
			End) PLAN_AMT
		From	T_PL_COMP_PLAN_EXEC a,
				T_PL_ITEM b
		Where	a.COMP_CODE = lsCompCode
		And		a.CLSE_ACC_ID = lsClesAccId
		And		a.CHG_SEQ = lnChgSeq
		And		a.BIZ_PLAN_ITEM_NO = b.BIZ_PLAN_ITEM_NO
		And		b.MNG_CODE In (ls_Mng_Code1,ls_Mng_Code2,ls_Mng_Code3)
		Group By
			a.COMP_CODE,
			a.CLSE_ACC_ID,
			a.CHG_SEQ,
			a.WORK_YM
	) s
	On
	(
		s.COMP_CODE = t.COMP_CODE
	And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
	And	s.CHG_SEQ = t.CHG_SEQ
	And	s.WORK_YM = t.WORK_YM
	And	s.BIZ_PLAN_ITEM_NO = t.BIZ_PLAN_ITEM_NO
	)
	When Matched Then
	Update
	Set		t.SUM_PLAN_AMT = Nvl(s.SUM_PLAN_AMT,0) + Nvl(s.MOD_PLAN_AMT,0) + Nvl(s.B_MOD_PLAN_AMT,0) ,
			t.MOD_PLAN_AMT = 0,
			t.B_MOD_PLAN_AMT = 0,
			t.PLAN_AMT = Nvl(s.SUM_PLAN_AMT,0) + Nvl(s.MOD_PLAN_AMT,0) + Nvl(s.B_MOD_PLAN_AMT,0),
			t.MODDATE = s.CRTDATE,
			t.MODUSERNO = s.CRTUSERNO
	When Not Matched Then
	Insert
	(COMP_CODE,CLSE_ACC_ID,CHG_SEQ,WORK_YM,BIZ_PLAN_ITEM_NO,CRTDATE,CRTUSERNO,SUM_PLAN_AMT,MOD_PLAN_AMT,B_MOD_PLAN_AMT,PLAN_AMT)
	Values
	(s.COMP_CODE,s.CLSE_ACC_ID,s.CHG_SEQ,s.WORK_YM,s.BIZ_PLAN_ITEM_NO,s.CRTDATE,s.CRTUSERNO,Nvl(s.SUM_PLAN_AMT,0) + Nvl(s.MOD_PLAN_AMT,0) + Nvl(s.B_MOD_PLAN_AMT,0),0,0,Nvl(s.SUM_PLAN_AMT,0) + Nvl(s.MOD_PLAN_AMT,0) + Nvl(s.B_MOD_PLAN_AMT,0));
End;
/
