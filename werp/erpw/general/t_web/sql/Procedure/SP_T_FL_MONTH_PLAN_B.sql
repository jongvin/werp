Create Or Replace Procedure SP_T_FL_MONTH_PLAN_B
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2,
	Ar_DEPT_CODE				Varchar2,
	Ar_FLOW_CODE_B				Number,
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
	Ar_PLAN_AMT_12				Number
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
			MOD_PLAN_AMT,
			PLAN_AMT
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			Ar_DEPT_CODE,
			Ar_CLSE_ACC_ID||Ar_YM,
			Ar_FLOW_CODE_B,
			Ar_CRTUSERNO,
			SysDate,
			Ar_Num,
			Ar_Num
		);
	Exception When Dup_Val_On_Index Then
		Update	T_FL_MONTH_PLAN_EXEC_PROJ_B
		Set		MODUSERNO = Ar_CRTUSERNO,
				MODDATE = Sysdate,
				MOD_PLAN_AMT = Ar_Num,
				PLAN_AMT = Nvl(SUM_PLAN_AMT,0) + Nvl(Ar_Num,0)
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		DEPT_CODE = Ar_DEPT_CODE
		And		WORK_YM = Ar_CLSE_ACC_ID||Ar_YM
		And		FLOW_CODE_B = Ar_FLOW_CODE_B;
	End;
Begin
	Select
		Count(*),
		Max(PLAN_CONFIRM_TAG)
	Into
		lnCnt,
		lsClose
	From	T_FL_COMP_FLOW_MA_B a
	Where	a.COMP_CODE = Ar_COMP_CODE
	And		a.CLSE_ACC_ID = Ar_CLSE_ACC_ID;
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
	ElsIf lsClose = 'T' Then
		Raise_Application_Error(-20009,'해당회기의 자금수지 계획은 본사에서 마감되어 변경이 불가능합니다.');
	End If;
	Select
		Count(*),
		Max(PLAN_CONFIRM_TAG)
	Into
		lnCnt,
		lsClose
	From	T_FL_DEPT_FLOW_MA a
	Where	a.COMP_CODE = Ar_COMP_CODE
	And		a.CLSE_ACC_ID = Ar_CLSE_ACC_ID
	And		a.DEPT_CODE = Ar_DEPT_CODE;
	If lnCnt < 1 Then
		Select
			Count(*)
		Into
			lnCnt
		From	T_PL_VIRTUAL_DEPT
		Where	V_DEPT_CODE = Ar_DEPT_CODE;
		If lnCnt > 0 Then		--만약 가상현장이라면
			Null;
		Else
			Insert Into T_FL_DEPT_FLOW_MA
			(
				COMP_CODE,
				CLSE_ACC_ID,
				DEPT_CODE,
				CRTUSERNO,
				CRTDATE,
				PLAN_CONFIRM_TAG
			)
			Values
			(
				Ar_COMP_CODE,
				Ar_CLSE_ACC_ID,
				Ar_DEPT_CODE,
				Ar_CRTUSERNO,
				SysDate,
				'F'
			);
		End If;
	ElsIf lsClose = 'T' Then
		Raise_Application_Error(-20009,'해당회기의 자금수지 계획은 본사에서 마감(현장별 마감)되어 변경이 불가능합니다.');
	End If;
	Select
		Count(*)
	Into
		lnCnt
	From	T_PL_PLAN_DEPT a
	Where	a.COMP_CODE = Ar_COMP_CODE
	And		a.CLSE_ACC_ID = Ar_CLSE_ACC_ID
	And		a.DEPT_CODE = Ar_DEPT_CODE;
	If lnCnt < 1 Then
		Insert Into T_PL_PLAN_DEPT
		(
			COMP_CODE,
			CLSE_ACC_ID,
			DEPT_CODE,
			CRTUSERNO,
			CRTDATE
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			Ar_DEPT_CODE,
			Ar_CRTUSERNO,
			SysDate
		);
	End If;
	IOU_Data('01',Ar_PLAN_AMT_01);
	IOU_Data('02',Ar_PLAN_AMT_02);
	IOU_Data('03',Ar_PLAN_AMT_03);
	IOU_Data('04',Ar_PLAN_AMT_04);
	IOU_Data('05',Ar_PLAN_AMT_05);
	IOU_Data('06',Ar_PLAN_AMT_06);
	IOU_Data('07',Ar_PLAN_AMT_07);
	IOU_Data('08',Ar_PLAN_AMT_08);
	IOU_Data('09',Ar_PLAN_AMT_09);
	IOU_Data('10',Ar_PLAN_AMT_10);
	IOU_Data('11',Ar_PLAN_AMT_11);
	IOU_Data('12',Ar_PLAN_AMT_12);
End;
/
