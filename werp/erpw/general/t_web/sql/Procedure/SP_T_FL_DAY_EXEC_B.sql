Create Or Replace Procedure SP_T_FL_DAY_EXEC_B
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2,
	Ar_FLOW_CODE				Number,
	Ar_WORK_DT					Varchar2,
	Ar_CRTUSERNO				Varchar2,
	Ar_MOD_EXEC_AMT				Number
)
Is
	lnCnt						Number;
	lsClose						Varchar2(2);
	lddtWorkDt					Date;
	lsWorkYm					Varchar2(6);
Begin
	lddtWorkDt := F_T_STRINGTODATE(Ar_WORK_DT);
	lsWorkYm := To_Char(lddtWorkDt,'YYYYMM');
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
	And		a.WORK_YM = lsWorkYm;
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
			lsWorkYm,
			Ar_CRTUSERNO,
			SysDate,
			'F'
		);
	ElsIf lsClose = 'T' Then
		Raise_Application_Error(-20009,'해당월의 본사자금수지는 마감되어 변경이 불가능합니다.');
	End If;

	Begin
		Insert Into T_FL_DAY_EXEC_B
		(
			COMP_CODE,
			CLSE_ACC_ID,
			FLOW_CODE_B,
			WORK_DT,
			CRTUSERNO,
			CRTDATE,
			SUM_EXEC_AMT,
			MOD_EXEC_AMT,
			EXEC_AMT
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			Ar_FLOW_CODE,
			lddtWorkDt,
			Ar_CRTUSERNO,
			SysDate,
			0,
			Ar_MOD_EXEC_AMT,
			Ar_MOD_EXEC_AMT
		);
	Exception When Dup_Val_On_Index Then
		Update	T_FL_DAY_EXEC_B
		Set		MOD_EXEC_AMT = Ar_MOD_EXEC_AMT,
				EXEC_AMT = Nvl(SUM_EXEC_AMT,0) + Nvl(Ar_MOD_EXEC_AMT,0),
				MODUSERNO = Ar_CRTUSERNO,
				MODDATE = Sysdate
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		WORK_DT = lddtWorkDt
		And		FLOW_CODE_B = Ar_FLOW_CODE;
	End;
End;
/
