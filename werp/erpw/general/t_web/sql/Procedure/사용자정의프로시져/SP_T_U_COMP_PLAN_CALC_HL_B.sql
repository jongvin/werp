Create Or Replace Procedure SP_T_U_COMP_PLAN_CALC_HL_B
Is
	ls_Comp_Code				T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type := PKG_FL_COM_PLAN.Get_COMP_CODE;
	ls_Clse_Acc_Id				T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type := PKG_FL_COM_PLAN.Get_CLSE_ACC_ID;
	ln_Flow_Code_B				T_FL_MONTH_PLAN_EXEC_B.FLOW_CODE_B%Type := PKG_FL_COM_PLAN.Get_FLOW_CODE_B;
	ls_CrtUserNo				T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type := PKG_FL_COM_PLAN.Get_CRTUSERNO;
	ls_FI_Mng_Code				T_FL_FLOW_CODE_B.MNG_CODE%Type := '기초시재';
	ls_IO_Mng_Code				T_FL_FLOW_CODE_B.MNG_CODE%Type := '수지차';
	ls_Out_Mng_Code				T_FL_FLOW_CODE_B.MNG_CODE%Type := '차입금상환';
Begin
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
				When ls_FI_Mng_Code Then b.SUM_PLAN_AMT
				When ls_IO_Mng_Code Then b.SUM_PLAN_AMT
				When ls_Out_Mng_Code Then - b.SUM_PLAN_AMT
				Else 0
			End) SUM_PLAN_AMT,
			Sum(Case a.MNG_CODE
				When ls_FI_Mng_Code Then b.MOD_PLAN_AMT
				When ls_IO_Mng_Code Then b.MOD_PLAN_AMT
				When ls_Out_Mng_Code Then - b.MOD_PLAN_AMT
				Else 0
			End) MOD_PLAN_AMT,
			Sum(Case a.MNG_CODE
				When ls_FI_Mng_Code Then b.B_MOD_PLAN_AMT
				When ls_IO_Mng_Code Then b.B_MOD_PLAN_AMT
				When ls_Out_Mng_Code Then - b.B_MOD_PLAN_AMT
				Else 0
			End) B_MOD_PLAN_AMT,
			Sum(Case a.MNG_CODE
				When ls_FI_Mng_Code Then b.PLAN_AMT
				When ls_IO_Mng_Code Then b.PLAN_AMT
				When ls_Out_Mng_Code Then - b.PLAN_AMT
				Else 0
			End) PLAN_AMT
		From	T_FL_MONTH_PLAN_EXEC_B b,
				T_FL_FLOW_CODE_B a
		Where	a.FLOW_CODE_B = b.FLOW_CODE_B
		And		a.MNG_CODE In (ls_IO_Mng_Code,ls_Out_Mng_Code,ls_FI_Mng_Code)
		And		b.COMP_CODE = ls_Comp_Code
		And		b.CLSE_ACC_ID = ls_Clse_Acc_Id
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
	Set		t.SUM_PLAN_AMT = Nvl(s.SUM_PLAN_AMT,0) + Nvl(s.MOD_PLAN_AMT,0) + Nvl(s.B_MOD_PLAN_AMT,0) ,
			t.MOD_PLAN_AMT = 0,
			t.PLAN_AMT = Nvl(s.SUM_PLAN_AMT,0) + Nvl(s.MOD_PLAN_AMT,0) + Nvl(s.B_MOD_PLAN_AMT,0) + Nvl(t.B_MOD_PLAN_AMT,0),
			t.MODDATE = s.CRTDATE,
			t.MODUSERNO = s.CRTUSERNO
	When Not Matched Then
	Insert 
	(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,SUM_PLAN_AMT,MOD_PLAN_AMT,B_MOD_PLAN_AMT,PLAN_AMT)
	Values
	(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_YM,s.FLOW_CODE_B,s.CRTUSERNO,s.CRTDATE,Nvl(s.SUM_PLAN_AMT,0) + Nvl(s.MOD_PLAN_AMT,0) + Nvl(s.B_MOD_PLAN_AMT,0),0,0,Nvl(s.SUM_PLAN_AMT,0) + Nvl(s.MOD_PLAN_AMT,0) + Nvl(s.B_MOD_PLAN_AMT,0));
End;
/
