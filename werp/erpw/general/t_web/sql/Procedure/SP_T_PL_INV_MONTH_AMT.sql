Create Or Replace Procedure SP_T_PL_INV_MONTH_AMT
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2,
	Ar_KIND_CODE				Varchar2,
	Ar_LV						Number,
	Ar_CRTUSERNO				Varchar2,
	Ar_PLAN_AMT_01				Number,
	Ar_PLAN_AMT_02				Number,
	Ar_PLAN_AMT_03				Number,
	Ar_PLAN_AMT_04				Number,
	Ar_PLAN_AMT_05				Number,
	Ar_PLAN_AMT_06				Number,
	Ar_PLAN_AMT_07				Number,
	Ar_PLAN_AMT_08				Number,
	Ar_PLAN_AMT_09				Number,
	Ar_PLAN_AMT_10				Number,
	Ar_PLAN_AMT_11				Number,
	Ar_PLAN_AMT_12				Number,
	Ar_FORE_AMT_01				Number,
	Ar_FORE_AMT_02				Number,
	Ar_FORE_AMT_03				Number,
	Ar_FORE_AMT_04				Number,
	Ar_FORE_AMT_05				Number,
	Ar_FORE_AMT_06				Number,
	Ar_FORE_AMT_07				Number,
	Ar_FORE_AMT_08				Number,
	Ar_FORE_AMT_09				Number,
	Ar_FORE_AMT_10				Number,
	Ar_FORE_AMT_11				Number,
	Ar_FORE_AMT_12				Number,
	Ar_EXEC_AMT_01				Number,
	Ar_EXEC_AMT_02				Number,
	Ar_EXEC_AMT_03				Number,
	Ar_EXEC_AMT_04				Number,
	Ar_EXEC_AMT_05				Number,
	Ar_EXEC_AMT_06				Number,
	Ar_EXEC_AMT_07				Number,
	Ar_EXEC_AMT_08				Number,
	Ar_EXEC_AMT_09				Number,
	Ar_EXEC_AMT_10				Number,
	Ar_EXEC_AMT_11				Number,
	Ar_EXEC_AMT_12				Number
)
Is
	Procedure	IOU_Data1
	(
		Ar_YM					Varchar2,
		Ar_PlanAmt				Number,
		Ar_ForeAmt				Number,
		Ar_ExecAmt				Number
	)
	Is
	Begin
		Insert Into T_PL_INV_EXEC_MONTH
		(
			COMP_CODE,
			CLSE_ACC_ID,
			WORK_YM,
			KIND_CODE,
			CRTUSERNO,
			CRTDATE,
			CONS_PLAN_AMT,
			CONS_FORECAST_AMT,
			CONS_EXEC_AMT
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			Ar_CLSE_ACC_ID||Ar_YM,
			Ar_KIND_CODE,
			Ar_CRTUSERNO,
			SysDate,
			Ar_PlanAmt,
			Ar_ForeAmt,
			Ar_ExecAmt
		);
	Exception When Dup_Val_On_Index Then
		Update	T_PL_INV_EXEC_MONTH
		Set		MODUSERNO = Ar_CRTUSERNO,
				MODDATE = Sysdate,
				CONS_PLAN_AMT = Ar_PlanAmt,
				CONS_FORECAST_AMT = Ar_ForeAmt,
				CONS_EXEC_AMT = Ar_ExecAmt
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		WORK_YM = Ar_CLSE_ACC_ID||Ar_YM
		And		KIND_CODE = Ar_KIND_CODE;
	End;
	Procedure	IOU_Data2
	(
		Ar_YM					Varchar2,
		Ar_PlanAmt				Number,
		Ar_ForeAmt				Number,
		Ar_ExecAmt				Number
	)
	Is
	Begin
		Insert Into T_PL_INV_EXEC_MONTH
		(
			COMP_CODE,
			CLSE_ACC_ID,
			WORK_YM,
			KIND_CODE,
			CRTUSERNO,
			CRTDATE,
			FIN_PLAN_AMT,
			FIN_FORECAST_AMT,
			FIN_EXEC_AMT
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			Ar_CLSE_ACC_ID||Ar_YM,
			Ar_KIND_CODE,
			Ar_CRTUSERNO,
			SysDate,
			Ar_PlanAmt,
			Ar_ForeAmt,
			Ar_ExecAmt
		);
	Exception When Dup_Val_On_Index Then
		Update	T_PL_INV_EXEC_MONTH
		Set		MODUSERNO = Ar_CRTUSERNO,
				MODDATE = Sysdate,
				FIN_PLAN_AMT = Ar_PlanAmt,
				FIN_FORECAST_AMT = Ar_ForeAmt,
				FIN_EXEC_AMT = Ar_ExecAmt
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		WORK_YM = Ar_CLSE_ACC_ID||Ar_YM
		And		KIND_CODE = Ar_KIND_CODE;
	End;
Begin
	If Ar_LV = 1 Then			--ฐ๘ป็
		IOU_Data1('01',Ar_PLAN_AMT_01,Ar_FORE_AMT_01,Ar_EXEC_AMT_01);
		IOU_Data1('02',Ar_PLAN_AMT_02,Ar_FORE_AMT_02,Ar_EXEC_AMT_02);
		IOU_Data1('03',Ar_PLAN_AMT_03,Ar_FORE_AMT_03,Ar_EXEC_AMT_03);
		IOU_Data1('04',Ar_PLAN_AMT_04,Ar_FORE_AMT_04,Ar_EXEC_AMT_04);
		IOU_Data1('05',Ar_PLAN_AMT_05,Ar_FORE_AMT_05,Ar_EXEC_AMT_05);
		IOU_Data1('06',Ar_PLAN_AMT_06,Ar_FORE_AMT_06,Ar_EXEC_AMT_06);
		IOU_Data1('07',Ar_PLAN_AMT_07,Ar_FORE_AMT_07,Ar_EXEC_AMT_07);
		IOU_Data1('08',Ar_PLAN_AMT_08,Ar_FORE_AMT_08,Ar_EXEC_AMT_08);
		IOU_Data1('09',Ar_PLAN_AMT_09,Ar_FORE_AMT_09,Ar_EXEC_AMT_09);
		IOU_Data1('10',Ar_PLAN_AMT_10,Ar_FORE_AMT_10,Ar_EXEC_AMT_10);
		IOU_Data1('11',Ar_PLAN_AMT_11,Ar_FORE_AMT_11,Ar_EXEC_AMT_11);
		IOU_Data1('12',Ar_PLAN_AMT_12,Ar_FORE_AMT_12,Ar_EXEC_AMT_12);
	ElsIf Ar_LV = 2 Then
		IOU_Data2('01',Ar_PLAN_AMT_01,Ar_FORE_AMT_01,Ar_EXEC_AMT_01);
		IOU_Data2('02',Ar_PLAN_AMT_02,Ar_FORE_AMT_02,Ar_EXEC_AMT_02);
		IOU_Data2('03',Ar_PLAN_AMT_03,Ar_FORE_AMT_03,Ar_EXEC_AMT_03);
		IOU_Data2('04',Ar_PLAN_AMT_04,Ar_FORE_AMT_04,Ar_EXEC_AMT_04);
		IOU_Data2('05',Ar_PLAN_AMT_05,Ar_FORE_AMT_05,Ar_EXEC_AMT_05);
		IOU_Data2('06',Ar_PLAN_AMT_06,Ar_FORE_AMT_06,Ar_EXEC_AMT_06);
		IOU_Data2('07',Ar_PLAN_AMT_07,Ar_FORE_AMT_07,Ar_EXEC_AMT_07);
		IOU_Data2('08',Ar_PLAN_AMT_08,Ar_FORE_AMT_08,Ar_EXEC_AMT_08);
		IOU_Data2('09',Ar_PLAN_AMT_09,Ar_FORE_AMT_09,Ar_EXEC_AMT_09);
		IOU_Data2('10',Ar_PLAN_AMT_10,Ar_FORE_AMT_10,Ar_EXEC_AMT_10);
		IOU_Data2('11',Ar_PLAN_AMT_11,Ar_FORE_AMT_11,Ar_EXEC_AMT_11);
		IOU_Data2('12',Ar_PLAN_AMT_12,Ar_FORE_AMT_12,Ar_EXEC_AMT_12);
	End If;
End;
/
