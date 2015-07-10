Create Or Replace Procedure SP_T_FL_GET_EXEC_SIMPLE
(
	Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC.COMP_CODE%Type,
	Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC.CLSE_ACC_ID%Type,
	Ar_WORK_YM					T_FL_MONTH_PLAN_EXEC.WORK_YM%Type,
	Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC.CRTUSERNO%Type
)
Is
	lnCnt						Number;
	lsClose						Varchar2(2);
	lddtFrom					Date;
	lddtEnd						Date;
Begin
	lddtFrom := To_Date(Ar_WORK_YM||'01','YYYYMMDD');
	lddtEnd := Last_Day(lddtFrom);
	Select
		Count(*),
		Max(EXEC_CONFIRM_TAG)
	Into
		lnCnt,
		lsClose
	From	T_FL_COMP_EXEC_CLOSE a
	Where	a.COMP_CODE = Ar_COMP_CODE
	And		a.CLSE_ACC_ID = Ar_CLSE_ACC_ID
	And		a.WORK_YM = Ar_WORK_YM;
	If lnCnt < 1 Then
		Insert Into T_FL_COMP_EXEC_CLOSE
		(
			COMP_CODE,
			CLSE_ACC_ID,
			WORK_YM,
			CRTUSERNO,
			CRTDATE,
			EXEC_CONFIRM_TAG
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			Ar_WORK_YM,
			Ar_CRTUSERNO,
			SysDate,
			'F'
		);
	ElsIf lsClose = 'T' Then
		Raise_Application_Error(-20009,'해당회기,해당분기의 자금수지 전망은 본사에서 마감되어 변경이 불가능합니다.');
	End If;

	Merge Into T_FL_MONTH_PLAN_EXEC_B t
	Using
	(
		Select
			a.COMP_CODE,
			a.CLSE_ACC_ID,
			a.FLOW_CODE_B,
			Ar_CRTUSERNO CRTUSERNO,
			SysDate CRTDATE,
			To_Char(a.WORK_DT,'YYYYMM') WORK_YM,
			Sum(a.SUM_EXEC_AMT) SUM_EXEC_AMT,
			Sum(a.MOD_EXEC_AMT) MOD_EXEC_AMT,
			Sum(a.EXEC_AMT) EXEC_AMT,
			0 B_MOD_EXEC_AMT
		From	T_FL_DAY_EXEC_B a
		Where	a.COMP_CODE = Ar_COMP_CODE
		And		a.CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		a.WORK_DT Between lddtFrom And lddtEnd
		Group By
			a.COMP_CODE,
			a.CLSE_ACC_ID,
			a.FLOW_CODE_B,
			To_Char(a.WORK_DT,'YYYYMM')
	) f
	On
	(
		f.COMP_CODE = t.COMP_CODE
	And	f.CLSE_ACC_ID = t.CLSE_ACC_ID
	And	f.WORK_YM = t.WORK_YM
	And	f.FLOW_CODE_B = t.FLOW_CODE_B
	)
	When Matched Then
	Update
	Set		SUM_EXEC_AMT = f.SUM_EXEC_AMT,
			MOD_EXEC_AMT = f.MOD_EXEC_AMT,
			B_MOD_EXEC_AMT = f.B_MOD_EXEC_AMT,
			EXEC_AMT = f.EXEC_AMT,
			MODUSERNO = f.CRTUSERNO,
			MODDATE = f.CRTDATE
	When Not Matched Then
	Insert
	(
		COMP_CODE,
		CLSE_ACC_ID,
		WORK_YM,
		FLOW_CODE_B,
		CRTUSERNO,
		CRTDATE,
		EXEC_AMT,
		SUM_EXEC_AMT,
		MOD_EXEC_AMT,
		B_MOD_EXEC_AMT
	)
	Values
	(
		f.COMP_CODE,
		f.CLSE_ACC_ID,
		f.WORK_YM,
		f.FLOW_CODE_B,
		f.CRTUSERNO,
		f.CRTDATE,
		f.EXEC_AMT,
		f.SUM_EXEC_AMT,
		f.MOD_EXEC_AMT,
		f.B_MOD_EXEC_AMT
	);

	PKG_FL_DAY_EXEC.ProcessBatchMonth(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_WORK_YM,Ar_CRTUSERNO);

End;
/
