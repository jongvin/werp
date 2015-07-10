Create Or Replace Procedure SP_T_U_PL_COM_FORE_BUDG
--예산 집계
Is
	lsCompCode				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type := PKG_PL_COM_FORE.Get_COMP_CODE;
	lsClesAccId				T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type := PKG_PL_COM_FORE.Get_CLSE_ACC_ID;
	lnChgSeq				T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type := PKG_PL_COM_FORE.Get_CHG_SEQ;
	lnItemNo				T_PL_COMP_PLAN_EXEC.BIZ_PLAN_ITEM_NO%Type := PKG_PL_COM_FORE.Get_BIZ_PLAN_ITEM_NO;
	lsCrtUserNo				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type := PKG_PL_COM_FORE.Get_CRTUSERNO;
	lnQuarterYear			Number := PKG_PL_COM_FORE.Get_QUARTER_YEAR;
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
	Merge Into T_PL_COMP_PLAN_EXEC t
	Using
	(
		Select
			a.COMP_CODE,
			a.CLSE_ACC_ID,
			lnChgSeq CHG_SEQ,
			To_Char(a.BUDG_YM,'YYYYMM') WORK_YM,
			lnItemNo BIZ_PLAN_ITEM_NO,
			lsCrtUserNo CRTUSERNO,
			SysDate CRTDATE,
			Sum(a.BUDG_MONTH_ASSIGN_AMT) SUM_FORECAST_AMT
		From	T_BUDG_MONTH_AMT a,
				T_BUDG_CODE b
		Where	a.COMP_CODE = lsCompCode
		And		a.CLSE_ACC_ID = lsClesAccId
		And		a.BUDG_CODE_NO = b.BUDG_CODE_NO
		And		To_Char(a.BUDG_YM,'YYYYMM') Between lsBegin And lsEnd
		And		b.ACC_CODE In
		(
			Select
				x.ACC_CODE
			From	T_PL_FLOW_ACC_CODE x
			Where	x.BIZ_PLAN_ITEM_NO = lnItemNo
		)
		Group By
			a.COMP_CODE,
			a.CLSE_ACC_ID,
			To_Char(a.BUDG_YM,'YYYYMM')
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
	Set		t.SUM_FORECAST_AMT = Nvl(s.SUM_FORECAST_AMT,0) ,
			t.MOD_FORECAST_AMT = 0,
			t.FORECAST_AMT = Nvl(s.SUM_FORECAST_AMT,0) + Nvl(t.B_MOD_FORECAST_AMT,0),
			t.MODDATE = s.CRTDATE,
			t.MODUSERNO = s.CRTUSERNO
	When Not Matched Then
	Insert
	(COMP_CODE,CLSE_ACC_ID,CHG_SEQ,WORK_YM,BIZ_PLAN_ITEM_NO,CRTDATE,CRTUSERNO,SUM_FORECAST_AMT,MOD_FORECAST_AMT,B_MOD_FORECAST_AMT,FORECAST_AMT)
	Values
	(s.COMP_CODE,s.CLSE_ACC_ID,s.CHG_SEQ,s.WORK_YM,s.BIZ_PLAN_ITEM_NO,s.CRTDATE,s.CRTUSERNO,Nvl(s.SUM_FORECAST_AMT,0) ,0,0,Nvl(s.SUM_FORECAST_AMT,0));
End;
/
