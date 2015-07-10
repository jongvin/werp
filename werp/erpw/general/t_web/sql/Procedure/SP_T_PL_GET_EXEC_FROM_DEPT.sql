Create Or Replace Procedure SP_T_PL_GET_EXEC_FROM_DEPT
(
	Ar_COMP_CODE				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type,
	Ar_CLSE_ACC_ID				T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type,
	Ar_WORK_YM					T_PL_COMP_PLAN_EXEC.WORK_YM%Type,
	Ar_CRTUSERNO				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type
)
Is
	lnCnt						Number;
	lsClose						Varchar2(2);
Begin
	Select
		Count(*),
		Max(PLAN_CONFIRM_TAG)
	Into
		lnCnt,
		lsClose
	From	T_PL_COMP_PLAN_CHG a
	Where	a.COMP_CODE = Ar_COMP_CODE
	And		a.CLSE_ACC_ID = Ar_CLSE_ACC_ID
	And		a.CHG_SEQ = 0;
	If lnCnt < 1 Then
		Insert Into	T_PL_COMP_PLAN_MA
		(
			COMP_CODE,
			CLSE_ACC_ID,
			CRTUSERNO,
			CRTDATE,
			LAST_CHG_SEQ,
			LAST_CON_CHG_SEQ
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			Ar_CRTUSERNO,
			SysDate,
			0,
			0
		);
		Insert Into T_PL_COMP_PLAN_CHG
		(
			COMP_CODE,
			CLSE_ACC_ID,
			CHG_SEQ,
			CRTUSERNO,
			CRTDATE,
			PLAN_CONFIRM_TAG
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			0,
			Ar_CRTUSERNO,
			SysDate,
			'F'
		);
	End If;
	PKG_PL_COMP_EXEC.ProcessBatch(Ar_COMP_CODE,Ar_CLSE_ACC_ID,0,Ar_WORK_YM,Ar_CRTUSERNO);
	SP_T_PL_MONTH_COM_EXEC_SUMUP(Ar_COMP_CODE,Ar_CLSE_ACC_ID,0,Ar_WORK_YM);
End;
/
