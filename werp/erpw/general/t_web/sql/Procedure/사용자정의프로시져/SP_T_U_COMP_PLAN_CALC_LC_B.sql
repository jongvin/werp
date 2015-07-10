Create Or Replace Procedure SP_T_U_COMP_PLAN_CALC_LC_B
Is
	ls_Comp_Code				T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type := PKG_FL_COM_PLAN.Get_COMP_CODE;
	ls_Clse_Acc_Id				T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type := PKG_FL_COM_PLAN.Get_CLSE_ACC_ID;
	ln_Flow_Code_B				T_FL_MONTH_PLAN_EXEC_B.FLOW_CODE_B%Type := PKG_FL_COM_PLAN.Get_FLOW_CODE_B;
	ls_CrtUserNo				T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type := PKG_FL_COM_PLAN.Get_CRTUSERNO;
	ls_FI_Mng_Code				T_FL_FLOW_CODE_B.MNG_CODE%Type := '기초시재';
	ls_HL_Mng_Code				T_FL_FLOW_CODE_B.MNG_CODE%Type := '과부족금';
	ls_ME_Mng_Code				T_FL_FLOW_CODE_B.MNG_CODE%Type := '대책';
	ls_IO_Mng_Code				T_FL_FLOW_CODE_B.MNG_CODE%Type := '수지차';
	ls_Out_Mng_Code				T_FL_FLOW_CODE_B.MNG_CODE%Type := '차입금상환';
	ls_Work_Ym					Varchar2(6);
	ln_First_Cash				Number;
	ln_HL_Amt					Number;
	ln_ME_Amt					Number;
	ln_IO_Amt					Number;
	ln_Out_Amt					Number;
	ln_Last_Cash				Number;
	ln_Item_No					Number;
	ln_Item_No_HL				Number;
Begin
	Select
		FLOW_CODE_B
	Into
		ln_Item_No
	From	T_FL_FLOW_CODE_B
	Where	MNG_CODE = ls_FI_Mng_Code
	And		RowNum < 2;
	Select
		FLOW_CODE_B
	Into
		ln_Item_No_HL
	From	T_FL_FLOW_CODE_B
	Where	MNG_CODE = ls_HL_Mng_Code
	And		RowNum < 2;
	For liI In 0..11 Loop
		ls_Work_Ym := F_T_AddMonths(ls_Clse_Acc_Id||'01',liI);
		--기초시재
		If liI = 0 Then
			Select
				Sum(b.PLAN_AMT)
			Into
				ln_First_Cash
			From	T_FL_MONTH_PLAN_EXEC_B b,
					T_FL_FLOW_CODE_B a
			Where	a.FLOW_CODE_B = b.FLOW_CODE_B
			And		a.MNG_CODE = ls_FI_Mng_Code
			And		b.COMP_CODE = ls_Comp_Code
			And		b.CLSE_ACC_ID = ls_Clse_Acc_Id
			And		b.WORK_YM = ls_Work_Ym;
		Else
			ln_First_Cash := ln_Last_Cash;
			Begin
				Insert Into T_FL_MONTH_PLAN_EXEC_B
				(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,SUM_PLAN_AMT,MOD_PLAN_AMT,B_MOD_PLAN_AMT,PLAN_AMT)
				Values
				(ls_Comp_Code,ls_Clse_Acc_Id,ls_Work_Ym,ln_Item_No,ls_CrtUserNo,SysDate,ln_Last_Cash,0,0,ln_Last_Cash);
			Exception When Dup_Val_On_Index Then
				Update	T_FL_MONTH_PLAN_EXEC_B
				Set		SUM_PLAN_AMT = ln_Last_Cash,
						MOD_PLAN_AMT = 0,
						PLAN_AMT = Nvl(B_MOD_PLAN_AMT,0) + Nvl(ln_Last_Cash,0)
				Where	COMP_CODE = ls_Comp_Code
				And		CLSE_ACC_ID = ls_Clse_Acc_Id
				And		WORK_YM = ls_Work_Ym
				And		FLOW_CODE_B = ln_Item_No;
			End;
		End If;
		--수지차
		Select
			Sum(b.PLAN_AMT)
		Into
			ln_IO_Amt
		From	T_FL_MONTH_PLAN_EXEC_B b,
				T_FL_FLOW_CODE_B a
		Where	a.FLOW_CODE_B = b.FLOW_CODE_B
		And		a.MNG_CODE = ls_IO_Mng_Code
		And		b.COMP_CODE = ls_Comp_Code
		And		b.CLSE_ACC_ID = ls_Clse_Acc_Id
		And		b.WORK_YM = ls_Work_Ym;
		--차입금상환
		Select
			Sum(b.PLAN_AMT)
		Into
			ln_Out_Amt
		From	T_FL_MONTH_PLAN_EXEC_B b,
				T_FL_FLOW_CODE_B a
		Where	a.FLOW_CODE_B = b.FLOW_CODE_B
		And		a.MNG_CODE = ls_Out_Mng_Code
		And		b.COMP_CODE = ls_Comp_Code
		And		b.CLSE_ACC_ID = ls_Clse_Acc_Id
		And		b.WORK_YM = ls_Work_Ym;
		ln_HL_Amt := Nvl(ln_First_Cash,0) + Nvl(ln_IO_Amt,0) - Nvl(ln_Out_Amt,0);
		Begin
			Insert Into T_FL_MONTH_PLAN_EXEC_B
			(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,SUM_PLAN_AMT,MOD_PLAN_AMT,B_MOD_PLAN_AMT,PLAN_AMT)
			Values
			(ls_Comp_Code,ls_Clse_Acc_Id,ls_Work_Ym,ln_Item_No_HL,ls_CrtUserNo,SysDate,ln_HL_Amt,0,0,ln_HL_Amt);
		Exception When Dup_Val_On_Index Then
			Update	T_FL_MONTH_PLAN_EXEC_B
			Set		SUM_PLAN_AMT = ln_HL_Amt,
					MOD_PLAN_AMT = 0,
					PLAN_AMT = Nvl(B_MOD_PLAN_AMT,0) + Nvl(ln_HL_Amt,0)
			Where	COMP_CODE = ls_Comp_Code
			And		CLSE_ACC_ID = ls_Clse_Acc_Id
			And		WORK_YM = ls_Work_Ym
			And		FLOW_CODE_B = ln_Item_No_HL;
		End;
		--과부족
		Select
			Sum(b.PLAN_AMT)
		Into
			ln_HL_Amt
		From	T_FL_MONTH_PLAN_EXEC_B b,
				T_FL_FLOW_CODE_B a
		Where	a.FLOW_CODE_B = b.FLOW_CODE_B
		And		a.MNG_CODE = ls_HL_Mng_Code
		And		b.COMP_CODE = ls_Comp_Code
		And		b.CLSE_ACC_ID = ls_Clse_Acc_Id
		And		b.WORK_YM = ls_Work_Ym;

		--대책
		Select
			Sum(b.PLAN_AMT)
		Into
			ln_ME_Amt
		From	T_FL_MONTH_PLAN_EXEC_B b,
				T_FL_FLOW_CODE_B a
		Where	a.FLOW_CODE_B = b.FLOW_CODE_B
		And		a.MNG_CODE = ls_ME_Mng_Code
		And		b.COMP_CODE = ls_Comp_Code
		And		b.CLSE_ACC_ID = ls_Clse_Acc_Id
		And		b.WORK_YM = ls_Work_Ym;
		ln_Last_Cash := Nvl(ln_HL_Amt,0) + Nvl(ln_ME_Amt,0);
		Begin
			Insert Into T_FL_MONTH_PLAN_EXEC_B
			(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,SUM_PLAN_AMT,MOD_PLAN_AMT,B_MOD_PLAN_AMT,PLAN_AMT)
			Values
			(ls_Comp_Code,ls_Clse_Acc_Id,ls_Work_Ym,ln_Flow_Code_B,ls_CrtUserNo,SysDate,ln_Last_Cash,0,0,ln_Last_Cash);
		Exception When Dup_Val_On_Index Then
			Update	T_FL_MONTH_PLAN_EXEC_B
			Set		SUM_PLAN_AMT = ln_Last_Cash,
					MOD_PLAN_AMT = 0,
					PLAN_AMT = Nvl(B_MOD_PLAN_AMT,0) + Nvl(ln_Last_Cash,0)
			Where	COMP_CODE = ls_Comp_Code
			And		CLSE_ACC_ID = ls_Clse_Acc_Id
			And		WORK_YM = ls_Work_Ym
			And		FLOW_CODE_B = ln_Flow_Code_B;
		End;
	End Loop;
End;
/
