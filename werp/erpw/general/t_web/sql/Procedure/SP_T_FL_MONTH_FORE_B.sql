Create Or Replace Procedure SP_T_FL_MONTH_FORE_B
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2,
	Ar_DEPT_CODE				Varchar2,
	Ar_FLOW_CODE				Number,
	Ar_QUARTER_YEAR				Number,
	Ar_CRTUSERNO				Varchar2,
	Ar_FORE_AMT_01				Number,
	Ar_FORE_AMT_02				Number,
	Ar_FORE_AMT_03				Number
)
Is
	lnCnt						Number;
	lsClose						Varchar2(2);
	Procedure	IOU_Data
	(
		Ar_YM					Varchar2,
		Ar_Num					Number
	)
	Is
	Begin
		Insert Into T_FL_MONTH_PLAN_EXEC_PROJ_B
		(
			COMP_CODE,
			CLSE_ACC_ID,
			DEPT_CODE,
			WORK_YM,
			FLOW_CODE_B,
			CRTUSERNO,
			CRTDATE,
			MOD_FORECAST_AMT,
			FORECAST_AMT
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			Ar_DEPT_CODE,
			Ar_CLSE_ACC_ID||Ar_YM,
			Ar_FLOW_CODE,
			Ar_CRTUSERNO,
			SysDate,
			Ar_Num,
			Ar_Num
		);
	Exception When Dup_Val_On_Index Then
		Update	T_FL_MONTH_PLAN_EXEC_PROJ_B
		Set		MODUSERNO = Ar_CRTUSERNO,
				MODDATE = Sysdate,
				MOD_FORECAST_AMT = Ar_Num,
				FORECAST_AMT = Nvl(SUM_FORECAST_AMT,0) + Nvl(Ar_Num,0)
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		DEPT_CODE = Ar_DEPT_CODE
		And		WORK_YM = Ar_CLSE_ACC_ID||Ar_YM
		And		FLOW_CODE_B = Ar_FLOW_CODE;
	End;
Begin
	Select
		Count(*),
		Max(FORE_CONFIRM_TAG)
	Into
		lnCnt,
		lsClose
	From	T_FL_DEPT_FORECAST_CLOSE a
	Where	a.COMP_CODE = Ar_COMP_CODE
	And		a.CLSE_ACC_ID = Ar_CLSE_ACC_ID
	And		a.DEPT_CODE = Ar_DEPT_CODE
	And		a.QUARTER_YEAR = Ar_QUARTER_YEAR;
	If lnCnt < 1 Then
		Insert Into T_FL_DEPT_FORECAST_CLOSE
		(
			COMP_CODE,
			CLSE_ACC_ID,
			DEPT_CODE,
			QUARTER_YEAR,
			CRTUSERNO,
			CRTDATE,
			FORE_CONFIRM_TAG
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			Ar_DEPT_CODE,
			Ar_QUARTER_YEAR,
			Ar_CRTUSERNO,
			SysDate,
			'F'
		);
	ElsIf lsClose = 'T' Then
		Raise_Application_Error(-20009,'해당회기,해당분기의 자금수지 전망은 본사에서 마감(현장별 마감)되어 변경이 불가능합니다.');
	End If;
	Select
		Count(*),
		Max(FORE_CONFIRM_TAG)
	Into
		lnCnt,
		lsClose
	From	T_FL_COMP_FORECAST_CLOSE a
	Where	a.COMP_CODE = Ar_COMP_CODE
	And		a.CLSE_ACC_ID = Ar_CLSE_ACC_ID
	And		a.QUARTER_YEAR = Ar_QUARTER_YEAR;
	If lnCnt < 1 Then
		Insert Into T_FL_COMP_FORECAST_CLOSE
		(
			COMP_CODE,
			CLSE_ACC_ID,
			QUARTER_YEAR,
			CRTUSERNO,
			CRTDATE,
			FORE_CONFIRM_TAG
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			Ar_QUARTER_YEAR,
			Ar_CRTUSERNO,
			SysDate,
			'F'
		);
	ElsIf lsClose = 'T' Then
		Raise_Application_Error(-20009,'해당회기,해당분기의 자금수지 전망은 본사에서 마감되어 변경이 불가능합니다.');
	End If;
	If Ar_QUARTER_YEAR = 1 Then
		IOU_Data('01',Ar_FORE_AMT_01);
		IOU_Data('02',Ar_FORE_AMT_02);
		IOU_Data('03',Ar_FORE_AMT_03);
	End If;
	If Ar_QUARTER_YEAR = 2 Then
		IOU_Data('04',Ar_FORE_AMT_01);
		IOU_Data('05',Ar_FORE_AMT_02);
		IOU_Data('06',Ar_FORE_AMT_03);
	End If;
	If Ar_QUARTER_YEAR = 3 Then
		IOU_Data('07',Ar_FORE_AMT_01);
		IOU_Data('08',Ar_FORE_AMT_02);
		IOU_Data('09',Ar_FORE_AMT_03);
	End If;
	If Ar_QUARTER_YEAR = 4 Then
		IOU_Data('10',Ar_FORE_AMT_01);
		IOU_Data('11',Ar_FORE_AMT_02);
		IOU_Data('12',Ar_FORE_AMT_03);
	End If;
End;
/
