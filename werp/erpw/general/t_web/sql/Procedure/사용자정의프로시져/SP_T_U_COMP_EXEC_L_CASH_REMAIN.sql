Create Or Replace Procedure SP_T_U_COMP_EXEC_L_CASH_REMAIN
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
				lsCompCode COMP_CODE ,
				lsClseAccId CLSE_ACC_ID ,
				ldWorkDt WORK_DT,
				lnFlowCodeB FLOW_CODE_B,
				lsCrtUserNo CRTUSERNO,
				SYSDATE CRTDATE,
				Nvl(Sum(a.DB_AMT),0) - Nvl(Sum(a.CR_AMT),0) SUM_EXEC_AMT
			From	T_ACC_SLIP_BODY1 a,
					(
						Select
							b.ACC_CODE,
							RowNum rn
						From
							(
								Select
									Distinct
									b.ACC_CODE
								From	T_FL_FLOW_ACC_CODE_B b
								Where	b.FLOW_CODE_B = lnFlowCodeB
							) b
					) b
			Where	a.TRANSFER_TAG = 'F'
			And		a.KEEP_DT Is Not Null
			And		a.COMP_CODE = lsCompCode
			And		a.ACC_CODE = b.ACC_CODE
			And		a.MAKE_DT <= ldWorkDt
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
		Set		t.EXEC_AMT = Nvl(s.SUM_EXEC_AMT,0) + Nvl(t.MOD_EXEC_AMT,0) ,
				t.SUM_EXEC_AMT = s.SUM_EXEC_AMT,
				t.MODDATE = s.CRTDATE,
				t.MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert
		(COMP_CODE,CLSE_ACC_ID,WORK_DT,FLOW_CODE_B,CRTDATE,CRTUSERNO,SUM_EXEC_AMT,MOD_EXEC_AMT,EXEC_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_DT,s.FLOW_CODE_B,s.CRTDATE,s.CRTUSERNO,s.SUM_EXEC_AMT,0,s.SUM_EXEC_AMT);
	Else
		ldWorkDt := Last_Day(To_Date(lsWorkYm||'01','YYYYMMDD'));
		Merge Into T_FL_MONTH_PLAN_EXEC_B t
		Using
		(
			Select
				lsCompCode COMP_CODE ,
				lsClseAccId CLSE_ACC_ID ,
				lsWorkYm WORK_YM,
				lnFlowCodeB FLOW_CODE_B,
				lsCrtUserNo CRTUSERNO,
				SYSDATE CRTDATE,
				Nvl(Sum(a.DB_AMT),0) - Nvl(Sum(a.CR_AMT),0) SUM_EXEC_AMT
			From	T_ACC_SLIP_BODY1 a,
					(
						Select
							b.ACC_CODE,
							RowNum rn
						From
							(
								Select
									Distinct
									b.ACC_CODE
								From	T_FL_FLOW_ACC_CODE_B b
								Where	b.FLOW_CODE_B = lnFlowCodeB
							) b
					) b
			Where	a.TRANSFER_TAG = 'F'
			And		a.KEEP_DT Is Not Null
			And		a.COMP_CODE = lsCompCode
			And		a.ACC_CODE = b.ACC_CODE
			And		a.MAKE_DT <= ldWorkDt
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
		Set		t.EXEC_AMT = Nvl(s.SUM_EXEC_AMT,0) + Nvl(t.B_MOD_EXEC_AMT,0) ,
				t.MOD_EXEC_AMT = 0,
				t.SUM_EXEC_AMT = s.SUM_EXEC_AMT,
				t.MODDATE = s.CRTDATE,
				t.MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert
		(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,CRTDATE,CRTUSERNO,SUM_EXEC_AMT,MOD_EXEC_AMT,B_MOD_EXEC_AMT,EXEC_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_YM,s.FLOW_CODE_B,s.CRTDATE,s.CRTUSERNO,s.SUM_EXEC_AMT,0,0,s.SUM_EXEC_AMT);
	End If;
End;
/
