Create Or Replace Procedure SP_T_PL_PROJ_FORE
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2,
	Ar_DEPT_CODE				Varchar2,
	Ar_BIZ_PLAN_ITEM_NO			Number,
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
		Insert Into T_PL_COMP_DEPT_PLAN_EXEC
		(
			COMP_CODE,
			CLSE_ACC_ID,
			CHG_SEQ,
			DEPT_CODE,
			WORK_YM,
			BIZ_PLAN_ITEM_NO,
			CRTUSERNO,
			CRTDATE,
			MOD_FORECAST_AMT,
			FORECAST_AMT
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			0,
			Ar_DEPT_CODE,
			Ar_CLSE_ACC_ID||Ar_YM,
			Ar_BIZ_PLAN_ITEM_NO,
			Ar_CRTUSERNO,
			SysDate,
			Ar_Num,
			Ar_Num
		);
	Exception When Dup_Val_On_Index Then
		Update	T_PL_COMP_DEPT_PLAN_EXEC
		Set		MODUSERNO = Ar_CRTUSERNO,
				MODDATE = Sysdate,
				MOD_FORECAST_AMT = Ar_Num,
				FORECAST_AMT = Nvl(SUM_FORECAST_AMT,0) + Nvl(Ar_Num,0)
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		CHG_SEQ = 0
		And		DEPT_CODE = Ar_DEPT_CODE
		And		WORK_YM = Ar_CLSE_ACC_ID||Ar_YM
		And		BIZ_PLAN_ITEM_NO = Ar_BIZ_PLAN_ITEM_NO;
	End;
Begin
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
