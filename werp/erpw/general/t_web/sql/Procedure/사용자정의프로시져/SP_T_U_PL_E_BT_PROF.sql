Create Or Replace Procedure SP_T_U_PL_E_BT_PROF
--경영계획 세전순이익 실적 산출
Is
	lsCompCode				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type;
	lsClseAccId				T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type;
	lnChgSeq				T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type;
	lnItemNo				T_PL_COMP_PLAN_EXEC.BIZ_PLAN_ITEM_NO%Type;
	lsWorkYm				T_PL_COMP_PLAN_EXEC.WORK_YM%Type;
	lsCrtUserNo				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type;
Begin
	lsCompCode := PKG_PL_COMP_EXEC.Get_COMP_CODE;
	lsClseAccId := PKG_PL_COMP_EXEC.Get_CLSE_ACC_ID;
	lnChgSeq := PKG_PL_COMP_EXEC.Get_CHG_SEQ;
	lnItemNo := PKG_PL_COMP_EXEC.Get_BIZ_PLAN_ITEM_NO;
	lsWorkYm := PKG_PL_COMP_EXEC.Get_WORK_YM;
	lsCrtUserNo := PKG_PL_COMP_EXEC.Get_CRTUSERNO;
	Merge Into T_PL_COMP_PLAN_EXEC t
	Using
	(
		Select
			a.COMP_CODE ,
			a.CLSE_ACC_ID ,
			a.CHG_SEQ ,
			a.WORK_YM ,
			lnItemNo BIZ_PLAN_ITEM_NO,
			lsCrtUserNo CRTUSERNO,
			SysDate CRTDATE,
			Sum(Decode(b.ITEM_TAG,'B',-1,1) * Nvl(a.SUM_EXEC_AMT,0)) SUM_EXEC_AMT,
			Sum(Decode(b.ITEM_TAG,'B',-1,1) * Nvl(a.MOD_EXEC_AMT,0)) MOD_EXEC_AMT,
			Sum(Decode(b.ITEM_TAG,'B',-1,1) * Nvl(a.B_MOD_EXEC_AMT,0)) B_MOD_EXEC_AMT,
			Sum(Decode(b.ITEM_TAG,'B',-1,1) * Nvl(a.EXEC_AMT,0)) EXEC_AMT
		From	T_PL_COMP_PLAN_EXEC a,
				T_PL_ITEM b
		Where	a.BIZ_PLAN_ITEM_NO = b.BIZ_PLAN_ITEM_NO
		And		b.ITEM_TAG In ('8','A','B')		--경상이익,특별이익,특별손실을 가져온다.
		And		b.IS_LEAF_TAG = 'T'
		And		a.COMP_CODE = lsCompCode
		And		a.CLSE_ACC_ID = lsClseAccId
		And		a.CHG_SEQ = lnChgSeq
		And		a.WORK_YM = lsWorkYm
		Group By
			a.COMP_CODE ,
			a.CLSE_ACC_ID ,
			a.CHG_SEQ ,
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
	Set	SUM_EXEC_AMT = s.SUM_EXEC_AMT,
		MOD_EXEC_AMT = s.MOD_EXEC_AMT,
		B_MOD_EXEC_AMT = s.B_MOD_EXEC_AMT,
		EXEC_AMT = s.EXEC_AMT
	When Not Matched Then
	Insert
	(COMP_CODE,CLSE_ACC_ID,CHG_SEQ,WORK_YM,BIZ_PLAN_ITEM_NO,CRTUSERNO,CRTDATE,SUM_EXEC_AMT,MOD_EXEC_AMT,B_MOD_EXEC_AMT,EXEC_AMT)
	Values
	(s.COMP_CODE,s.CLSE_ACC_ID,s.CHG_SEQ,s.WORK_YM,s.BIZ_PLAN_ITEM_NO,s.CRTUSERNO,s.CRTDATE,s.SUM_EXEC_AMT,s.MOD_EXEC_AMT,s.B_MOD_EXEC_AMT,s.EXEC_AMT);
End;
/

