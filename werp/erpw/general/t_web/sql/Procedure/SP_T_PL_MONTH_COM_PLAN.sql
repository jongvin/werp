Create Or Replace Procedure SP_T_PL_MONTH_COM_PLAN
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2,
	Ar_BIZ_PLAN_ITEM_NO			Number,
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
		Insert Into T_PL_COMP_PLAN_EXEC
		(
			COMP_CODE,
			CLSE_ACC_ID,
			CHG_SEQ,
			WORK_YM,
			BIZ_PLAN_ITEM_NO,
			CRTUSERNO,
			CRTDATE,
			B_MOD_PLAN_AMT,
			PLAN_AMT
		)
		Values
		(
			Ar_COMP_CODE,
			Ar_CLSE_ACC_ID,
			0,
			Ar_CLSE_ACC_ID||Ar_YM,
			Ar_BIZ_PLAN_ITEM_NO,
			Ar_CRTUSERNO,
			SysDate,
			Ar_Num,
			Ar_Num
		);
	Exception When Dup_Val_On_Index Then
		Update	T_PL_COMP_PLAN_EXEC
		Set		MODUSERNO = Ar_CRTUSERNO,
				MODDATE = Sysdate,
				B_MOD_PLAN_AMT = Ar_Num,
				PLAN_AMT = Nvl(SUM_PLAN_AMT,0) + Nvl(MOD_PLAN_AMT,0) + Nvl(Ar_Num,0)
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		WORK_YM = Ar_CLSE_ACC_ID||Ar_YM
		And		BIZ_PLAN_ITEM_NO = Ar_BIZ_PLAN_ITEM_NO
		And		CHG_SEQ = 0;
	End;
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
	ElsIf lsClose = 'T' Then
		Raise_Application_Error(-20009,'해당회기의 경영계획은 본사에서 마감되어 변경이 불가능합니다.');
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
