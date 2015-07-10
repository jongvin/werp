Create Or Replace Procedure SP_T_PL_DEPT_SALE_PLAN
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2,
	Ar_DEPT_CODE				Varchar2,
	Ar_LV						Number,
	Ar_CRTUSERNO				Varchar2,
	Ar_AMT_00					Number,
	Ar_AMT_01					Number,
	Ar_AMT_02					Number,
	Ar_AMT_03					Number,
	Ar_AMT_04					Number,
	Ar_AMT_05					Number,
	Ar_AMT_06					Number,
	Ar_AMT_07					Number,
	Ar_AMT_08					Number,
	Ar_AMT_09					Number,
	Ar_AMT_10					Number,
	Ar_AMT_11					Number,
	Ar_AMT_12					Number
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
		If Ar_LV = 1 Then	--도급증감액
			Begin
				Insert Into T_PL_SALE_PLAN_YM
				(
					COMP_CODE,
					CLSE_ACC_ID,
					DEPT_CODE,
					WORK_YM,
					CRTUSERNO,
					CRTDATE,
					MODUSERNO,
					MODDATE,
					CONS_INC_AMT,
					BUDG_INC_AMT,
					NM_COST_AMT,
					NM_SALE_AMT
				)
				Values
				(
					Ar_COMP_CODE,
					Ar_CLSE_ACC_ID,
					Ar_DEPT_CODE,
					Ar_CLSE_ACC_ID||Ar_YM,
					Ar_CRTUSERNO,
					SysDate,
					Null,
					Null,
					Ar_Num,
					0,
					0,
					0
				);
			Exception When Dup_Val_On_Index Then
				Update	T_PL_SALE_PLAN_YM
				Set		MODUSERNO = Ar_CRTUSERNO,
						MODDATE = Sysdate,
						CONS_INC_AMT = Ar_Num
				Where	COMP_CODE = Ar_COMP_CODE
				And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
				And		DEPT_CODE = Ar_DEPT_CODE
				And		WORK_YM = Ar_CLSE_ACC_ID||Ar_YM;
			End;
		ElsIf Ar_LV = 2 Then	--실행증감액
			Begin
				Insert Into T_PL_SALE_PLAN_YM
				(
					COMP_CODE,
					CLSE_ACC_ID,
					DEPT_CODE,
					WORK_YM,
					CRTUSERNO,
					CRTDATE,
					MODUSERNO,
					MODDATE,
					CONS_INC_AMT,
					BUDG_INC_AMT,
					NM_COST_AMT,
					NM_SALE_AMT
				)
				Values
				(
					Ar_COMP_CODE,
					Ar_CLSE_ACC_ID,
					Ar_DEPT_CODE,
					Ar_CLSE_ACC_ID||Ar_YM,
					Ar_CRTUSERNO,
					SysDate,
					Null,
					Null,
					0,
					Ar_Num,
					0,
					0
				);
			Exception When Dup_Val_On_Index Then
				Update	T_PL_SALE_PLAN_YM
				Set		MODUSERNO = Ar_CRTUSERNO,
						MODDATE = Sysdate,
						BUDG_INC_AMT = Ar_Num
				Where	COMP_CODE = Ar_COMP_CODE
				And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
				And		DEPT_CODE = Ar_DEPT_CODE
				And		WORK_YM = Ar_CLSE_ACC_ID||Ar_YM;
			End;
		ElsIf Ar_LV = 3 Then	--당월원가발생액(계획)
			Begin
				Insert Into T_PL_SALE_PLAN_YM
				(
					COMP_CODE,
					CLSE_ACC_ID,
					DEPT_CODE,
					WORK_YM,
					CRTUSERNO,
					CRTDATE,
					MODUSERNO,
					MODDATE,
					CONS_INC_AMT,
					BUDG_INC_AMT,
					NM_COST_AMT,
					NM_SALE_AMT
				)
				Values
				(
					Ar_COMP_CODE,
					Ar_CLSE_ACC_ID,
					Ar_DEPT_CODE,
					Ar_CLSE_ACC_ID||Ar_YM,
					Ar_CRTUSERNO,
					SysDate,
					Null,
					Null,
					0,
					0,
					Ar_Num,
					0
				);
			Exception When Dup_Val_On_Index Then
				Update	T_PL_SALE_PLAN_YM
				Set		MODUSERNO = Ar_CRTUSERNO,
						MODDATE = Sysdate,
						NM_COST_AMT = Ar_Num
				Where	COMP_CODE = Ar_COMP_CODE
				And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
				And		DEPT_CODE = Ar_DEPT_CODE
				And		WORK_YM = Ar_CLSE_ACC_ID||Ar_YM;
			End;
		ElsIf Ar_LV = 4 Then	--당월매출발생액(계획)
			Begin
				Insert Into T_PL_SALE_PLAN_YM
				(
					COMP_CODE,
					CLSE_ACC_ID,
					DEPT_CODE,
					WORK_YM,
					CRTUSERNO,
					CRTDATE,
					MODUSERNO,
					MODDATE,
					CONS_INC_AMT,
					BUDG_INC_AMT,
					NM_COST_AMT,
					NM_SALE_AMT
				)
				Values
				(
					Ar_COMP_CODE,
					Ar_CLSE_ACC_ID,
					Ar_DEPT_CODE,
					Ar_CLSE_ACC_ID||Ar_YM,
					Ar_CRTUSERNO,
					SysDate,
					Null,
					Null,
					0,
					0,
					0,
					Ar_Num
				);
			Exception When Dup_Val_On_Index Then
				Update	T_PL_SALE_PLAN_YM
				Set		MODUSERNO = Ar_CRTUSERNO,
						MODDATE = Sysdate,
						NM_SALE_AMT = Ar_Num
				Where	COMP_CODE = Ar_COMP_CODE
				And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
				And		DEPT_CODE = Ar_DEPT_CODE
				And		WORK_YM = Ar_CLSE_ACC_ID||Ar_YM;
			End;
		End If;
	End;
Begin
	Select
		Count(*)
	Into
		lnCnt
	From	T_PL_PLAN_DEPT
	Where	COMP_CODE = Ar_COMP_CODE
	And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
	And		DEPT_CODE = Ar_DEPT_CODE;
	If lnCnt < 1 Then
		Raise_Application_Error(-20009,'해당 현장 또는 가상 현장은 당회기에 관리되어야 하는 회기별 현장설정에서 등록되어 있는 현장이 아닙니다..');
	End If;
	If Ar_LV = 1 Then	--도급금액
		Begin
			Insert Into T_PL_SALE_PLAN
			(
				COMP_CODE,
				CLSE_ACC_ID,
				DEPT_CODE,
				CRTUSERNO,
				CRTDATE,
				MODUSERNO,
				MODDATE,
				CONS_AMT,
				BUDG_AMT,
				PY_COST_SUM,
				PY_SALE_SUM
			)
			Values
			(
				Ar_COMP_CODE,
				Ar_CLSE_ACC_ID,
				Ar_DEPT_CODE,
				Ar_CRTUSERNO,
				SysDate,
				Null,
				Null,
				Ar_AMT_00,
				0,
				0,
				0
			);
		Exception When Dup_Val_On_Index Then
			Update	T_PL_SALE_PLAN
			Set		MODUSERNO = Ar_CRTUSERNO,
					MODDATE = SysDate,
					CONS_AMT = Ar_AMT_00
			Where	COMP_CODE = Ar_COMP_CODE
			And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
			And		DEPT_CODE = Ar_DEPT_CODE;
		End;
	ElsIf Ar_LV = 2 Then	--실행금액
		Begin
			Insert Into T_PL_SALE_PLAN
			(
				COMP_CODE,
				CLSE_ACC_ID,
				DEPT_CODE,
				CRTUSERNO,
				CRTDATE,
				MODUSERNO,
				MODDATE,
				CONS_AMT,
				BUDG_AMT,
				PY_COST_SUM,
				PY_SALE_SUM
			)
			Values
			(
				Ar_COMP_CODE,
				Ar_CLSE_ACC_ID,
				Ar_DEPT_CODE,
				Ar_CRTUSERNO,
				SysDate,
				Null,
				Null,
				0,
				Ar_AMT_00,
				0,
				0
			);
		Exception When Dup_Val_On_Index Then
			Update	T_PL_SALE_PLAN
			Set		MODUSERNO = Ar_CRTUSERNO,
					MODDATE = SysDate,
					BUDG_AMT = Ar_AMT_00
			Where	COMP_CODE = Ar_COMP_CODE
			And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
			And		DEPT_CODE = Ar_DEPT_CODE;
		End;
	ElsIf Ar_LV = 3 Then	--전년누적원가
		Begin
			Insert Into T_PL_SALE_PLAN
			(
				COMP_CODE,
				CLSE_ACC_ID,
				DEPT_CODE,
				CRTUSERNO,
				CRTDATE,
				MODUSERNO,
				MODDATE,
				CONS_AMT,
				BUDG_AMT,
				PY_COST_SUM,
				PY_SALE_SUM
			)
			Values
			(
				Ar_COMP_CODE,
				Ar_CLSE_ACC_ID,
				Ar_DEPT_CODE,
				Ar_CRTUSERNO,
				SysDate,
				Null,
				Null,
				0,
				0,
				Ar_AMT_00,
				0
			);
		Exception When Dup_Val_On_Index Then
			Update	T_PL_SALE_PLAN
			Set		MODUSERNO = Ar_CRTUSERNO,
					MODDATE = SysDate,
					PY_COST_SUM = Ar_AMT_00
			Where	COMP_CODE = Ar_COMP_CODE
			And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
			And		DEPT_CODE = Ar_DEPT_CODE;
		End;
	ElsIf Ar_LV = 4 Then	--누적매출
		Begin
			Insert Into T_PL_SALE_PLAN
			(
				COMP_CODE,
				CLSE_ACC_ID,
				DEPT_CODE,
				CRTUSERNO,
				CRTDATE,
				MODUSERNO,
				MODDATE,
				CONS_AMT,
				BUDG_AMT,
				PY_COST_SUM,
				PY_SALE_SUM
			)
			Values
			(
				Ar_COMP_CODE,
				Ar_CLSE_ACC_ID,
				Ar_DEPT_CODE,
				Ar_CRTUSERNO,
				SysDate,
				Null,
				Null,
				0,
				0,
				0,
				Ar_AMT_00
			);
		Exception When Dup_Val_On_Index Then
			Update	T_PL_SALE_PLAN
			Set		MODUSERNO = Ar_CRTUSERNO,
					MODDATE = SysDate,
					PY_SALE_SUM = Ar_AMT_00
			Where	COMP_CODE = Ar_COMP_CODE
			And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
			And		DEPT_CODE = Ar_DEPT_CODE;
		End;
	End If;
	IOU_Data('01',Ar_AMT_01);
	IOU_Data('02',Ar_AMT_02);
	IOU_Data('03',Ar_AMT_03);
	IOU_Data('04',Ar_AMT_04);
	IOU_Data('05',Ar_AMT_05);
	IOU_Data('06',Ar_AMT_06);
	IOU_Data('07',Ar_AMT_07);
	IOU_Data('08',Ar_AMT_08);
	IOU_Data('09',Ar_AMT_09);
	IOU_Data('10',Ar_AMT_10);
	IOU_Data('11',Ar_AMT_11);
	IOU_Data('12',Ar_AMT_12);
End;
/
