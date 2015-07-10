Create Or Replace Procedure SP_T_U_COMP_FORE_CALC_A_IO_B
(
	Ar_In_Mng_Code				T_FL_FLOW_CODE_B.MNG_CODE%Type,
	Ar_Out_Mng_Code				T_FL_FLOW_CODE_B.MNG_CODE%Type
)
Is
	ls_Comp_Code				T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type := PKG_FL_COM_FORE.Get_COMP_CODE;
	ls_Clse_Acc_Id				T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type := PKG_FL_COM_FORE.Get_CLSE_ACC_ID;
	ln_Flow_Code_B				T_FL_MONTH_PLAN_EXEC_B.FLOW_CODE_B%Type := PKG_FL_COM_FORE.Get_FLOW_CODE_B;
	ls_CrtUserNo				T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type := PKG_FL_COM_FORE.Get_CRTUSERNO;
	ln_Quarter_Year				Number := PKG_FL_COM_FORE.Get_QUARTER_YEAR;
	lsBegin						Varchar2(6);
	lsEnd						Varchar2(6);
Begin
	If ln_Quarter_Year = 1 Then
		lsBegin := ls_Clse_Acc_Id||'01';
		lsEnd := ls_Clse_Acc_Id||'03';
	End If;
	If ln_Quarter_Year = 2 Then
		lsBegin := ls_Clse_Acc_Id||'04';
		lsEnd := ls_Clse_Acc_Id||'06';
	End If;
	If ln_Quarter_Year = 3 Then
		lsBegin := ls_Clse_Acc_Id||'07';
		lsEnd := ls_Clse_Acc_Id||'09';
	End If;
	If ln_Quarter_Year = 4 Then
		lsBegin := ls_Clse_Acc_Id||'10';
		lsEnd := ls_Clse_Acc_Id||'12';
	End If;
	Merge Into T_FL_MONTH_PLAN_EXEC_B t
	Using
	(
		Select
			b.COMP_CODE  COMP_CODE,
			b.CLSE_ACC_ID CLSE_ACC_ID,
			b.WORK_YM WORK_YM,
			ln_Flow_Code_B FLOW_CODE_B,
			ls_CrtUserNo CRTUSERNO,
			SysDate CRTDATE,
			Sum(Case a.MNG_CODE
				When Ar_In_Mng_Code Then b.SUM_FORECAST_AMT
				When Ar_Out_Mng_Code Then - b.SUM_FORECAST_AMT
				Else 0
			End) SUM_FORECAST_AMT,
			Sum(Case a.MNG_CODE
				When Ar_In_Mng_Code Then b.MOD_FORECAST_AMT
				When Ar_Out_Mng_Code Then - b.MOD_FORECAST_AMT
				Else 0
			End) MOD_FORECAST_AMT,
			Sum(Case a.MNG_CODE
				When Ar_In_Mng_Code Then b.B_MOD_FORECAST_AMT
				When Ar_Out_Mng_Code Then - b.B_MOD_FORECAST_AMT
				Else 0
			End) B_MOD_FORECAST_AMT,
			Sum(Case a.MNG_CODE
				When Ar_In_Mng_Code Then b.FORECAST_AMT
				When Ar_Out_Mng_Code Then - b.FORECAST_AMT
				Else 0
			End) FORECAST_AMT
		From	T_FL_MONTH_PLAN_EXEC_B b,
				T_FL_FLOW_CODE_B a
		Where	a.FLOW_CODE_B = b.FLOW_CODE_B
		And		a.MNG_CODE In (Ar_In_Mng_Code,Ar_Out_Mng_Code)
		And		b.COMP_CODE = ls_Comp_Code
		And		b.CLSE_ACC_ID = ls_Clse_Acc_Id
		And		b.WORK_YM Between lsBegin And lsEnd
		Group By
			b.COMP_CODE ,
			b.CLSE_ACC_ID ,
			b.WORK_YM 
	) s
	On
	(
		s.COMP_CODE = t.COMP_CODE
	And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
	And	s.WORK_YM = t.WORK_YM
	And	s.FLOW_CODE_B = t.FLOW_CODE_B
	)
	When Matched Then
	Update
	Set		t.SUM_FORECAST_AMT = Nvl(s.SUM_FORECAST_AMT,0) + Nvl(s.MOD_FORECAST_AMT,0) + Nvl(s.B_MOD_FORECAST_AMT,0) ,
			t.MOD_FORECAST_AMT = 0,
			t.FORECAST_AMT = Nvl(s.SUM_FORECAST_AMT,0) + Nvl(s.MOD_FORECAST_AMT,0) + Nvl(s.B_MOD_FORECAST_AMT,0) + Nvl(t.B_MOD_FORECAST_AMT,0),
			t.MODDATE = s.CRTDATE,
			t.MODUSERNO = s.CRTUSERNO
	When Not Matched Then
	Insert 
	(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,SUM_FORECAST_AMT,MOD_FORECAST_AMT,B_MOD_FORECAST_AMT,FORECAST_AMT)
	Values
	(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_YM,s.FLOW_CODE_B,s.CRTUSERNO,s.CRTDATE,Nvl(s.SUM_FORECAST_AMT,0) + Nvl(s.MOD_FORECAST_AMT,0) + Nvl(s.B_MOD_FORECAST_AMT,0),0,0,Nvl(s.SUM_FORECAST_AMT,0) + Nvl(s.MOD_FORECAST_AMT,0) + Nvl(s.B_MOD_FORECAST_AMT,0));
End;
/
