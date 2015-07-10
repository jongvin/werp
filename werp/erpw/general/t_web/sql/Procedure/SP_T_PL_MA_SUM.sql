Create Or Replace Procedure SP_T_PL_MA_SUM
(
	Ar_WORK_YM					T_PL_MA_DEPT_LIST.WORK_YM%Type,
	Ar_HIST_SEQ					Number,
	Ar_CRTUSERNO				T_PL_MA_DEPT_LIST.CRTUSERNO%Type
)
Is
Begin
	If Ar_HIST_SEQ Is Null Then
		Raise_Application_Error(-20009,'배부율 기준을 선택 후 작업하십시오.');
	End If;
	Begin
		Insert Into T_PL_MA_WORK_M
		(
			WORK_YM,
			CRTUSERNO,
			CRTDATE,
			HIST_SEQ
		)
		Values
		(
			Ar_WORK_YM,
			Ar_CRTUSERNO,
			SysDate,
			Ar_HIST_SEQ
		);
	Exception When Dup_Val_On_Index Then
		Update	T_PL_MA_WORK_M
		Set		HIST_SEQ = Ar_HIST_SEQ
		Where	WORK_YM = Ar_WORK_YM;
	End;
	PKG_PL_MA_DEPT_EXEC.ProcessBatch(Ar_WORK_YM,Ar_CRTUSERNO);
	SP_T_PL_MA_SUMUP(Ar_WORK_YM);
End;
/
