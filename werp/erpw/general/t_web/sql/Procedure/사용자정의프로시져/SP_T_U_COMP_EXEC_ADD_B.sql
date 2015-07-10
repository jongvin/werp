Create Or Replace Procedure SP_T_U_COMP_EXEC_ADD_B
(
	Ar_In_Mng_Code				T_FL_FLOW_CODE_B.MNG_CODE%Type,
	Ar_Out_Mng_Code				T_FL_FLOW_CODE_B.MNG_CODE%Type
)
Is
	lsCompCode				T_FL_DAY_EXEC_B.COMP_CODE%Type := PKG_FL_DAY_EXEC.Get_COMP_CODE;
	lsClseAccId				T_FL_DAY_EXEC_B.CLSE_ACC_ID%Type := PKG_FL_DAY_EXEC.Get_CLSE_ACC_ID;
	lnFlowCodeB				T_FL_DAY_EXEC_B.FLOW_CODE_B%Type := PKG_FL_DAY_EXEC.Get_FLOW_CODE_B;
	ldWorkDt				T_FL_DAY_EXEC_B.WORK_DT%Type := PKG_FL_DAY_EXEC.Get_WORK_DT;
	lsCrtUserNo				T_FL_DAY_EXEC_B.CRTUSERNO%Type := PKG_FL_DAY_EXEC.Get_CRTUSERNO;
	lsWorkYm				T_FL_MONTH_PLAN_EXEC_B.WORK_YM%Type := PKG_FL_DAY_EXEC.Get_WORK_YM;
Begin
	If PKG_FL_DAY_EXEC.Is_DayExec Then
		Merge Into T_FL_DAY_EXEC_B t
		Using
		(
			Select
				b.COMP_CODE  COMP_CODE,
				b.CLSE_ACC_ID CLSE_ACC_ID,
				b.WORK_DT WORK_DT,
				lnFlowCodeB FLOW_CODE_B,
				lsCrtUserNo CRTUSERNO,
				SysDate CRTDATE,
				Sum(b.SUM_EXEC_AMT) SUM_EXEC_AMT,
				Sum(b.MOD_EXEC_AMT) MOD_EXEC_AMT,
				Sum(b.EXEC_AMT) EXEC_AMT
			From	T_FL_DAY_EXEC_B b,
					T_FL_FLOW_CODE_B a
			Where	a.FLOW_CODE_B = b.FLOW_CODE_B
			And		a.MNG_CODE In (Ar_In_Mng_Code,Ar_Out_Mng_Code)
			And		b.COMP_CODE = lsCompCode
			And		b.CLSE_ACC_ID = lsClseAccId
			And		b.WORK_DT = ldWorkDt
			Group By
				b.COMP_CODE ,
				b.CLSE_ACC_ID ,
				b.WORK_DT 
		) s
		On
		(
			s.COMP_CODE = t.COMP_CODE
		And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	s.WORK_DT = t.WORK_DT
		And	s.FLOW_CODE_B = t.FLOW_CODE_B
		)
		When Matched Then
		Update
		Set		t.SUM_EXEC_AMT = Nvl(s.SUM_EXEC_AMT,0) + Nvl(s.MOD_EXEC_AMT,0) ,
				t.MOD_EXEC_AMT = 0,
				t.EXEC_AMT = Nvl(s.SUM_EXEC_AMT,0) + Nvl(s.MOD_EXEC_AMT,0),
				t.MODDATE = s.CRTDATE,
				t.MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert 
		(COMP_CODE,CLSE_ACC_ID,WORK_DT,FLOW_CODE_B,CRTUSERNO,CRTDATE,SUM_EXEC_AMT,MOD_EXEC_AMT,EXEC_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_DT,s.FLOW_CODE_B,s.CRTUSERNO,s.CRTDATE,Nvl(s.SUM_EXEC_AMT,0) + Nvl(s.MOD_EXEC_AMT,0),0,Nvl(s.SUM_EXEC_AMT,0) + Nvl(s.MOD_EXEC_AMT,0));
	Else
		Merge Into T_FL_MONTH_PLAN_EXEC_B t
		Using
		(
			Select
				b.COMP_CODE  COMP_CODE,
				b.CLSE_ACC_ID CLSE_ACC_ID,
				b.WORK_YM WORK_YM,
				lnFlowCodeB FLOW_CODE_B,
				lsCrtUserNo CRTUSERNO,
				SysDate CRTDATE,
				Sum(b.SUM_EXEC_AMT) SUM_EXEC_AMT,
				Sum(b.MOD_EXEC_AMT) MOD_EXEC_AMT,
				Sum(b.B_MOD_EXEC_AMT) B_MOD_EXEC_AMT,
				Sum(b.EXEC_AMT) EXEC_AMT
			From	T_FL_MONTH_PLAN_EXEC_B b,
					T_FL_FLOW_CODE_B a
			Where	a.FLOW_CODE_B = b.FLOW_CODE_B
			And		a.MNG_CODE In (Ar_In_Mng_Code,Ar_Out_Mng_Code)
			And		b.COMP_CODE = lsCompCode
			And		b.CLSE_ACC_ID = lsClseAccId
			And		b.WORK_YM = lsWorkYm
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
		Set		t.SUM_EXEC_AMT = Nvl(s.SUM_EXEC_AMT,0) + Nvl(s.MOD_EXEC_AMT,0) + Nvl(s.B_MOD_EXEC_AMT,0) ,
				t.MOD_EXEC_AMT = 0,
				t.B_MOD_EXEC_AMT = 0,
				t.EXEC_AMT = Nvl(s.SUM_EXEC_AMT,0) + Nvl(s.MOD_EXEC_AMT,0) + Nvl(s.B_MOD_EXEC_AMT,0) + Nvl(t.B_MOD_EXEC_AMT,0),
				t.MODDATE = s.CRTDATE,
				t.MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert 
		(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,SUM_EXEC_AMT,MOD_EXEC_AMT,B_MOD_EXEC_AMT,EXEC_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_YM,s.FLOW_CODE_B,s.CRTUSERNO,s.CRTDATE,Nvl(s.SUM_EXEC_AMT,0) + Nvl(s.MOD_EXEC_AMT,0) + Nvl(s.B_MOD_EXEC_AMT,0),0,0,Nvl(s.SUM_EXEC_AMT,0) + Nvl(s.MOD_EXEC_AMT,0) + Nvl(s.B_MOD_EXEC_AMT,0));
	End If;
End;
/
