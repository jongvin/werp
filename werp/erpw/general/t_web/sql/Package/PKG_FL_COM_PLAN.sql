Create Or Replace Package PKG_FL_COM_PLAN
Is
	Function	Get_COMP_CODE
	Return T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type;
	Function	Get_CLSE_ACC_ID
	Return T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type;
	Function	Get_FLOW_CODE_B
	Return T_FL_MONTH_PLAN_EXEC_B.FLOW_CODE_B%Type;
	Function	Get_CRTUSERNO
	Return T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type;
	Procedure	ProcessBatch
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type
	);
	Procedure	ProcessAutoRecal
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type
	);
	Procedure	SumChild;
	Procedure	CalcCurrentInOut;
	Procedure	CalcSpecialInOut;
	Procedure	SumFromDept;
End;
/
Create Or Replace Package Body PKG_FL_COM_PLAN
Is
	Type	T_FUNCTTIONS	Is Table Of T_FL_COMP_PLN_FUNCTIONS_B.FUNC_NAME%Type
		Index By Binary_Integer;
	Type	T_NUMS			Is Table Of Number
		Index By Binary_Integer;
	G_COMP_CODE				T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type;
	G_CLSE_ACC_ID			T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type;
	G_FLOW_CODE_B			T_FL_MONTH_PLAN_EXEC_B.FLOW_CODE_B%Type;
	G_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type;

	G_FUNCTIONS				T_FUNCTTIONS;
	Procedure	LoadFunctions
	Is
	Begin
		G_FUNCTIONS.Delete;
		For lrA In (Select COMP_PLN_FUNC_NO_B,FUNC_NAME From T_FL_COMP_PLN_FUNCTIONS_B) Loop
			G_FUNCTIONS(lrA.COMP_PLN_FUNC_NO_B) := lrA.FUNC_NAME;
		End Loop;
	End;
	Function	GetFunction
	(
		Ar_Index			Number
	)
	Return Varchar2
	Is
	Begin
		Return 'Begin '||G_FUNCTIONS(Ar_Index)||'; End;';
	End;
	Function	Get_COMP_CODE
	Return T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type
	Is
	Begin
		Return G_COMP_CODE ;
	End;
	Function	Get_CLSE_ACC_ID
	Return T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type
	Is
	Begin
		Return G_CLSE_ACC_ID ;
	End;
	Function	Get_FLOW_CODE_B
	Return T_FL_MONTH_PLAN_EXEC_B.FLOW_CODE_B%Type
	Is
	Begin
		Return G_FLOW_CODE_B ;
	End;
	Function	Get_CRTUSERNO
	Return T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type
	Is
	Begin
		Return G_CRTUSERNO ;
	End;
	Procedure	SetCalcInfo
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type
	)
	Is
	Begin
		G_COMP_CODE := Ar_COMP_CODE;
		G_CLSE_ACC_ID := Ar_CLSE_ACC_ID;
		G_CRTUSERNO := Ar_CRTUSERNO;
	End;
	Procedure	ClearData
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type
	)
	Is
	Begin
		Update	T_FL_MONTH_PLAN_EXEC_B
		Set		SUM_PLAN_AMT = 0,
				MOD_PLAN_AMT = 0,
				PLAN_AMT = Nvl(B_MOD_PLAN_AMT,0)
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID;
	End;
	Procedure	ProcessBatch
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type
	)
	Is
		ltFlowCode					T_NUMS;
		ltFuncNo					T_NUMS;
		liFirst						Number;
		liLast						Number;
		lsFuncName					T_FL_COMP_PLN_FUNCTIONS_B.FUNC_NAME%Type;
		lnFuncNo					Number;
	Begin
		LoadFunctions;
		SetCalcInfo(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_CRTUSERNO);
		ClearData(Ar_COMP_CODE,Ar_CLSE_ACC_ID);
		
		Select
			a.FLOW_CODE_B ,
			a.COMP_PLN_FUNC_NO_B
		Bulk Collect Into
			ltFlowCode,
			ltFuncNo
		From
			(
				Select
					a.FLOW_CODE_B ,
					a.COMP_PLN_FUNC_NO_B,
					LEVEL LV,
					RowNum rn
				From	T_FL_FLOW_CODE_B a
				Start With	a.P_NO = 0
				Connect By
					Prior	a.FLOW_CODE_B = a.P_NO
				Order Siblings By
					a.LEVEL_SEQ
			) a
		order by 
			a.lv desc,
			a.rn asc;
		If ltFlowCode.Count > 0 Then
			liFirst := ltFlowCode.First;
			liLast := ltFlowCode.Last;
			For liI In liFirst..liLast Loop
				lnFuncNo := ltFuncNo(liI);
				If lnFuncNo Is Not Null Then
					G_FLOW_CODE_B := ltFlowCode(liI);
					lsFuncName := GetFunction(lnFuncNo);
					Execute Immediate lsFuncName;
				End If;
			End Loop;
		End If;
	End;
	Procedure	ProcessAutoRecal
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type
	)
	Is
		ltFlowCode					T_NUMS;
		ltFuncNo					T_NUMS;
		liFirst						Number;
		liLast						Number;
		lsFuncName					T_FL_COMP_PLN_FUNCTIONS_B.FUNC_NAME%Type;
		lnFuncNo					Number;
	Begin
		LoadFunctions;
		SetCalcInfo(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_CRTUSERNO);
		
		Select
			a.FLOW_CODE_B ,
			a.COMP_PLN_FUNC_NO_B
		Bulk Collect Into
			ltFlowCode,
			ltFuncNo
		From
			(
				Select
					a.FLOW_CODE_B ,
					a.COMP_PLN_FUNC_NO_B,
					LEVEL LV,
					RowNum rn
				From	T_FL_FLOW_CODE_B a
				Where	a.COMP_PLN_FUNC_NO_B In
				(
					Select
						b.COMP_PLN_FUNC_NO_B
					From	T_FL_COMP_PLN_FUNCTIONS_B b
					Where	b.AUTO_RECALCC_TAG = 'T'
				)
				Start With	a.P_NO = 0
				Connect By
					Prior	a.FLOW_CODE_B = a.P_NO
				Order Siblings By
					a.LEVEL_SEQ
			) a
		order by 
			a.lv desc,
			a.rn asc;
		If ltFlowCode.Count > 0 Then
			liFirst := ltFlowCode.First;
			liLast := ltFlowCode.Last;
			For liI In liFirst..liLast Loop
				lnFuncNo := ltFuncNo(liI);
				If lnFuncNo Is Not Null Then
					G_FLOW_CODE_B := ltFlowCode(liI);
					lsFuncName := GetFunction(lnFuncNo);
					Execute Immediate lsFuncName;
				End If;
			End Loop;
		End If;
	End;
	Procedure	SumChild
	Is
	Begin
		Merge Into T_FL_MONTH_PLAN_EXEC_B t
		Using
		(
			Select
				a.COMP_CODE ,
				a.CLSE_ACC_ID ,
				a.WORK_YM,
				G_FLOW_CODE_B FLOW_CODE_B,
				Sum(a.SUM_PLAN_AMT) SUM_PLAN_AMT,
				Sum(a.MOD_PLAN_AMT) MOD_PLAN_AMT,
				Sum(a.B_MOD_PLAN_AMT) B_MOD_PLAN_AMT,
				Sum(a.PLAN_AMT) PLAN_AMT,
				SysDate CRTDATE,
				G_CRTUSERNO CRTUSERNO
			From	T_FL_MONTH_PLAN_EXEC_B a,
					T_FL_FLOW_CODE_B b
			Where	a.FLOW_CODE_B = b.FLOW_CODE_B
			And		b.P_NO = G_FLOW_CODE_B
			And		a.COMP_CODE = G_COMP_CODE
			And		a.CLSE_ACC_ID = G_CLSE_ACC_ID
			Group By
				a.COMP_CODE ,
				a.CLSE_ACC_ID ,
				a.WORK_YM
		) s
		On
		(
			s.COMP_CODE = t.COMP_CODE
		And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	s.WORK_YM = t.WORK_YM
		And	s.FLOW_CODE_B = t.FLOW_CODE_B
		)
		When Matched Then
		Update
		Set		t.SUM_PLAN_AMT = s.SUM_PLAN_AMT,
				t.MOD_PLAN_AMT = s.MOD_PLAN_AMT,
				t.B_MOD_PLAN_AMT = s.B_MOD_PLAN_AMT,
				t.PLAN_AMT = s.PLAN_AMT,
				t.MODDATE = s.CRTDATE,
				t.MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert
		(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,SUM_PLAN_AMT,PLAN_AMT,MOD_PLAN_AMT,B_MOD_PLAN_AMT,CRTDATE,CRTUSERNO)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_YM,s.FLOW_CODE_B,s.SUM_PLAN_AMT,s.PLAN_AMT,s.MOD_PLAN_AMT,s.B_MOD_PLAN_AMT,s.CRTDATE,s.CRTUSERNO);
	End;
	Procedure	CalcCurrentInOut
	Is
	Begin
		Merge Into T_FL_MONTH_PLAN_EXEC_B t
		Using
		(
			Select
				b.COMP_CODE  COMP_CODE,
				b.CLSE_ACC_ID CLSE_ACC_ID,
				b.WORK_YM WORK_YM,
				G_FLOW_CODE_B FLOW_CODE_B,
				G_CRTUSERNO CRTUSERNO,
				SysDate CRTDATE,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.SUM_PLAN_AMT
					When '2' Then - b.SUM_PLAN_AMT
					Else 0
				End) SUM_PLAN_AMT,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.MOD_PLAN_AMT
					When '2' Then - b.MOD_PLAN_AMT
					Else 0
				End) MOD_PLAN_AMT,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.B_MOD_PLAN_AMT
					When '2' Then - b.B_MOD_PLAN_AMT
					Else 0
				End) B_MOD_PLAN_AMT,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.PLAN_AMT
					When '2' Then - b.PLAN_AMT
					Else 0
				End) PLAN_AMT
			From	T_FL_MONTH_PLAN_EXEC_B b,
					T_FL_FLOW_CODE_B a
			Where	a.FLOW_CODE_B = b.FLOW_CODE_B
			And		a.IS_LEAF_TAG = 'T'
			And		a.FLOW_ITEM_KIND In ('1','2')
			And		b.COMP_CODE = G_COMP_CODE
			And		b.CLSE_ACC_ID = G_CLSE_ACC_ID
			Group By
				b.COMP_CODE ,
				b.CLSE_ACC_ID ,
				b.WORK_YM 
		) s
		On
		(
			s.COMP_CODE = t.COMP_CODE
		And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	s.WORK_YM = t.WORK_YM
		And	s.FLOW_CODE_B = t.FLOW_CODE_B
		)
		When Matched Then
		Update
		Set		SUM_PLAN_AMT = s.SUM_PLAN_AMT,
				MOD_PLAN_AMT = s.MOD_PLAN_AMT,
				B_MOD_PLAN_AMT = s.B_MOD_PLAN_AMT,
				PLAN_AMT = s.PLAN_AMT,
				MODDATE = s.CRTDATE,
				MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert 
		(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,SUM_PLAN_AMT,MOD_PLAN_AMT,B_MOD_PLAN_AMT,PLAN_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_YM,s.FLOW_CODE_B,s.CRTUSERNO,s.CRTDATE,s.SUM_PLAN_AMT,s.MOD_PLAN_AMT,s.B_MOD_PLAN_AMT,s.PLAN_AMT);
	End;
	Procedure	CalcSpecialInOut
	Is
	Begin
		Merge Into T_FL_MONTH_PLAN_EXEC_B t
		Using
		(
			Select
				b.COMP_CODE  COMP_CODE,
				b.CLSE_ACC_ID CLSE_ACC_ID,
				b.WORK_YM WORK_YM,
				G_FLOW_CODE_B FLOW_CODE_B,
				G_CRTUSERNO CRTUSERNO,
				SysDate CRTDATE,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.SUM_PLAN_AMT
					When '4' Then b.SUM_PLAN_AMT
					When '2' Then - b.SUM_PLAN_AMT
					When '5' Then - b.SUM_PLAN_AMT
					Else 0
				End) SUM_PLAN_AMT,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.MOD_PLAN_AMT
					When '4' Then b.MOD_PLAN_AMT
					When '2' Then - b.MOD_PLAN_AMT
					When '5' Then - b.MOD_PLAN_AMT
					Else 0
				End) MOD_PLAN_AMT,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.B_MOD_PLAN_AMT
					When '4' Then b.B_MOD_PLAN_AMT
					When '2' Then - b.B_MOD_PLAN_AMT
					When '5' Then - b.B_MOD_PLAN_AMT
					Else 0
				End) B_MOD_PLAN_AMT,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.PLAN_AMT
					When '4' Then b.PLAN_AMT
					When '2' Then - b.PLAN_AMT
					When '5' Then - b.PLAN_AMT
					Else 0
				End) PLAN_AMT
			From	T_FL_MONTH_PLAN_EXEC_B b,
					T_FL_FLOW_CODE_B a
			Where	a.FLOW_CODE_B = b.FLOW_CODE_B
			And		a.IS_LEAF_TAG = 'T'
			And		a.FLOW_ITEM_KIND In ('1','2','4','5')
			And		b.COMP_CODE = G_COMP_CODE
			And		b.CLSE_ACC_ID = G_CLSE_ACC_ID
			Group By
				b.COMP_CODE ,
				b.CLSE_ACC_ID ,
				b.WORK_YM 
		) s
		On
		(
			s.COMP_CODE = t.COMP_CODE
		And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	s.WORK_YM = t.WORK_YM
		And	s.FLOW_CODE_B = t.FLOW_CODE_B
		)
		When Matched Then
		Update
		Set		SUM_PLAN_AMT = s.SUM_PLAN_AMT,
				MOD_PLAN_AMT = s.MOD_PLAN_AMT,
				B_MOD_PLAN_AMT = s.B_MOD_PLAN_AMT,
				PLAN_AMT = s.PLAN_AMT,
				MODDATE = s.CRTDATE,
				MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert 
		(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,SUM_PLAN_AMT,MOD_PLAN_AMT,B_MOD_PLAN_AMT,PLAN_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_YM,s.FLOW_CODE_B,s.CRTUSERNO,s.CRTDATE,s.SUM_PLAN_AMT,s.MOD_PLAN_AMT,s.B_MOD_PLAN_AMT,s.PLAN_AMT);
	End;
	Procedure	SumFromDept
	Is
	Begin
		Merge Into T_FL_MONTH_PLAN_EXEC_B t
		Using
		(
			Select
				a.COMP_CODE,
				a.CLSE_ACC_ID,
				a.WORK_YM,
				a.FLOW_CODE_B,
				G_CRTUSERNO CRTUSERNO,
				Sysdate CRTDATE,
				Sum(a.SUM_PLAN_AMT) SUM_PLAN_AMT,
				Sum(a.MOD_PLAN_AMT) MOD_PLAN_AMT,
				Sum(a.PLAN_AMT) PLAN_AMT
			From	T_FL_MONTH_PLAN_EXEC_PROJ_B a
			Where	a.COMP_CODE = G_COMP_CODE
			And		a.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		a.FLOW_CODE_B = G_FLOW_CODE_B
			Group By
				a.COMP_CODE ,
				a.CLSE_ACC_ID ,
				a.WORK_YM ,
				a.FLOW_CODE_B
		) s
		On
		(
			s.COMP_CODE = t.COMP_CODE
		And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	s.WORK_YM = t.WORK_YM
		And	s.FLOW_CODE_B = t.FLOW_CODE_B
		)
		When Matched Then
		Update
		Set
			t.SUM_PLAN_AMT = Nvl(s.SUM_PLAN_AMT,0) + Nvl(s.MOD_PLAN_AMT,0),
			t.MOD_PLAN_AMT = 0,
			t.PLAN_AMT = Nvl(s.SUM_PLAN_AMT,0) + Nvl(s.MOD_PLAN_AMT,0) + Nvl(t.B_MOD_PLAN_AMT,0),
			t.MODDATE = s.CRTDATE,
			t.MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert 
		(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,SUM_PLAN_AMT,MOD_PLAN_AMT,B_MOD_PLAN_AMT,PLAN_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_YM,s.FLOW_CODE_B,s.CRTUSERNO,s.CRTDATE,Nvl(s.SUM_PLAN_AMT,0) + Nvl(s.MOD_PLAN_AMT,0),0,0,s.PLAN_AMT);
	End;
End;
/
