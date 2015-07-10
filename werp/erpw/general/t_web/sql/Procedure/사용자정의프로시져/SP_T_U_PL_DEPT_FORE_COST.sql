Create Or Replace Procedure SP_T_U_PL_DEPT_FORE_COST
--매출원가 가져오기
Is
	lsCompCode				T_PL_COMP_DEPT_PLAN_EXEC.COMP_CODE%Type := PKG_PL_DEPT_FORE.Get_COMP_CODE;
	lsClesAccId				T_PL_COMP_DEPT_PLAN_EXEC.CLSE_ACC_ID%Type := PKG_PL_DEPT_FORE.Get_CLSE_ACC_ID;
	lnChgSeq				T_PL_COMP_DEPT_PLAN_EXEC.CHG_SEQ%Type := PKG_PL_DEPT_FORE.Get_CHG_SEQ;
	lsDeptCode				T_PL_COMP_DEPT_PLAN_EXEC.DEPT_CODE%Type := PKG_PL_DEPT_FORE.Get_DEPT_CODE;
	lnItemNo				T_PL_COMP_DEPT_PLAN_EXEC.BIZ_PLAN_ITEM_NO%Type := PKG_PL_DEPT_FORE.Get_BIZ_PLAN_ITEM_NO;
	lsCrtUserNo				T_PL_COMP_DEPT_PLAN_EXEC.CRTUSERNO%Type := PKG_PL_DEPT_FORE.Get_CRTUSERNO;
	lnQuarterYear			Number := PKG_PL_DEPT_FORE.Get_QUARTER_YEAR;
	lsBegin					Varchar2(6);
	lsEnd					Varchar2(6);
Begin
	If lnQuarterYear = 1 Then
		lsBegin := lsClesAccId||'01';
		lsEnd := lsClesAccId||'03';
	End If;
	If lnQuarterYear = 2 Then
		lsBegin := lsClesAccId||'04';
		lsEnd := lsClesAccId||'06';
	End If;
	If lnQuarterYear = 3 Then
		lsBegin := lsClesAccId||'07';
		lsEnd := lsClesAccId||'09';
	End If;
	If lnQuarterYear = 4 Then
		lsBegin := lsClesAccId||'10';
		lsEnd := lsClesAccId||'12';
	End If;
	Merge Into T_PL_COMP_DEPT_PLAN_EXEC t
	Using
	(
		Select
			a.COMP_CODE,
			a.CLSE_ACC_ID,
			lnChgSeq CHG_SEQ,
			a.DEPT_CODE,
			a.WORK_YM,
			lnItemNo BIZ_PLAN_ITEM_NO,
			lsCrtUserNo CRTUSERNO,
			SysDate CRTDATE,
			a.NM_COST_AMT SUM_FORECAST_AMT
		From	T_PL_SALE_PLAN_YM a
		Where	a.COMP_CODE = lsCompCode
		And		a.CLSE_ACC_ID = lsClesAccId
		And		a.DEPT_CODE = lsDeptCode
		And		a.WORK_YM Between lsBegin And lsEnd
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
	Set		t.SUM_FORECAST_AMT = s.SUM_FORECAST_AMT,
			t.FORECAST_AMT = Nvl(s.SUM_FORECAST_AMT,0) + Nvl(t.MOD_FORECAST_AMT,0),
			t.MODDATE = s.CRTDATE,
			t.MODUSERNO = s.CRTUSERNO
	When Not Matched Then
	Insert
	(COMP_CODE,CLSE_ACC_ID,CHG_SEQ,DEPT_CODE,WORK_YM,BIZ_PLAN_ITEM_NO,CRTDATE,CRTUSERNO,SUM_FORECAST_AMT,MOD_FORECAST_AMT,FORECAST_AMT)
	Values
	(s.COMP_CODE,s.CLSE_ACC_ID,s.CHG_SEQ,s.DEPT_CODE,s.WORK_YM,s.BIZ_PLAN_ITEM_NO,s.CRTDATE,s.CRTUSERNO,s.SUM_FORECAST_AMT,0,s.SUM_FORECAST_AMT);
End;
/
