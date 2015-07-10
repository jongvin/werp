Create Or Replace Procedure SP_T_FL_GET_DAY_EXEC
(
	Ar_COMP_CODE				T_FL_DAY_EXEC_B.COMP_CODE%Type,
	Ar_CLSE_ACC_ID				T_FL_DAY_EXEC_B.CLSE_ACC_ID%Type,
	Ar_WORK_DT					Varchar2,
	Ar_CRTUSERNO				T_FL_DAY_EXEC_B.CRTUSERNO%Type
)
Is
	lnCnt						Number;
	lsClose						Varchar2(2);
	lddtWorkDt					Date;
Begin
	lddtWorkDt := F_T_STRINGTODATE(Ar_WORK_DT);
	Select
		Count(*)
	Into
		lnCnt
	From	T_FL_COMP_FLOW_MA_B
	Where	COMP_CODE = Ar_COMP_CODE
	And		CLSE_ACC_ID = Ar_CLSE_ACC_ID;
	If lnCnt < 1 Then
		Insert Into T_FL_COMP_FLOW_MA_B
		(
			COMP_CODE,
			CLSE_ACC_ID,
			CRTUSERNO,
			CRTDATE,
			PLAN_CONFIRM_TAG
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			Ar_CRTUSERNO,
			SysDate,
			'F'
		);
	End If;
	Select
		Count(*),
		Max(EXEC_CONFIRM_TAG)
	Into
		lnCnt,
		lsClose
	From	T_FL_COMP_EXEC_CLOSE a
	Where	a.COMP_CODE = Ar_COMP_CODE
	And		a.CLSE_ACC_ID = Ar_CLSE_ACC_ID
	And		a.WORK_YM = To_Char(lddtWorkDt,'YYYYMM');
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
			To_Char(lddtWorkDt,'YYYYMM'),
			Ar_CRTUSERNO,
			SysDate,
			'F'
		);
	ElsIf lsClose = 'T' Then
		Raise_Application_Error(-20009,'해당회기,해당분기의 자금수지 실적은 본사에서 마감되어 변경이 불가능합니다.');
	End If;
	PKG_FL_DAY_EXEC.ProcessBatch(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_WORK_DT,Ar_CRTUSERNO);
	SP_T_FL_DAY_EXEC_B_SUMUP(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_WORK_DT);
End;
/
