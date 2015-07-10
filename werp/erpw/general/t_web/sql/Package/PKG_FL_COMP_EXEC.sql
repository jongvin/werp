Create Or Replace Package PKG_FL_COMP_EXEC
Is
	Function	Get_COMP_CODE
	Return T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type;
	Function	Get_CLSE_ACC_ID
	Return T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type;
	Function	Get_FLOW_CODE_B
	Return T_FL_MONTH_PLAN_EXEC_B.FLOW_CODE_B%Type;
	Function	Get_WORK_YM
	Return T_FL_MONTH_PLAN_EXEC_B.WORK_YM%Type;
	Function	Get_CRTUSERNO
	Return T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type;
	Procedure	ProcessBatch
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type,
		Ar_WORK_YM					T_FL_MONTH_PLAN_EXEC_B.WORK_YM%Type,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type
	);
	Procedure	ProcessAutoRecal
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type,
		Ar_WORK_YM					T_FL_MONTH_PLAN_EXEC_B.WORK_YM%Type,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type
	);
	Procedure	SumChild;
	Procedure	SumSlip;
	Procedure	CalcCurrentInOut;
	Procedure	CalcSpecialInOut;
End;
/
Create Or Replace Package Body PKG_FL_COMP_EXEC
Is
	Type	T_FUNCTTIONS	Is Table Of T_FL_COMP_EXE_FUNCTIONS_B.FUNC_NAME%Type
		Index By Binary_Integer;
	Type	T_NUMS			Is Table Of Number
		Index By Binary_Integer;
	G_COMP_CODE				T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type;
	G_CLSE_ACC_ID			T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type;
	G_FLOW_CODE_B			T_FL_MONTH_PLAN_EXEC_B.FLOW_CODE_B%Type;
	G_WORK_YM				T_FL_MONTH_PLAN_EXEC_B.WORK_YM%Type;
	G_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type;

	G_FUNCTIONS				T_FUNCTTIONS;
	Procedure	LoadFunctions
	Is
	Begin
		G_FUNCTIONS.Delete;
		For lrA In (Select COMP_EXE_FUNC_NO_B,FUNC_NAME From T_FL_COMP_EXE_FUNCTIONS_B) Loop
			G_FUNCTIONS(lrA.COMP_EXE_FUNC_NO_B) := lrA.FUNC_NAME;
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
	Function	Get_WORK_YM
	Return T_FL_MONTH_PLAN_EXEC_B.WORK_YM%Type
	Is
	Begin
		Return G_WORK_YM ;
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
		Ar_WORK_YM					T_FL_MONTH_PLAN_EXEC_B.WORK_YM%Type,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type
	)
	Is
	Begin
		G_COMP_CODE := Ar_COMP_CODE;
		G_CLSE_ACC_ID := Ar_CLSE_ACC_ID;
		G_CRTUSERNO := Ar_CRTUSERNO;
		G_WORK_YM := Ar_WORK_YM;
	End;
	Procedure	ClearData
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type,
		Ar_WORK_YM					T_FL_MONTH_PLAN_EXEC_B.WORK_YM%Type
	)
	Is
	Begin
		Update	T_FL_MONTH_PLAN_EXEC_B
		Set		EXEC_AMT = 0
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		WORK_YM = Ar_WORK_YM;
		
		Delete	T_FL_MONTH_ACC_EXEC_SUM_C
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		WORK_YM = Ar_WORK_YM;
	End;
	Procedure	ProcessBatch
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_B.CLSE_ACC_ID%Type,
		Ar_WORK_YM					T_FL_MONTH_PLAN_EXEC_B.WORK_YM%Type,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type
	)
	Is
		ltFlowCode					T_NUMS;
		ltFuncNo					T_NUMS;
		liFirst						Number;
		liLast						Number;
		lsFuncName					T_FL_COMP_EXE_FUNCTIONS_B.FUNC_NAME%Type;
		lnFuncNo					Number;
	Begin
		LoadFunctions;
		SetCalcInfo(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_WORK_YM,Ar_CRTUSERNO);
		ClearData(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_WORK_YM);
		
		Select
			a.FLOW_CODE_B ,
			a.COMP_EXE_FUNC_NO_B
		Bulk Collect Into
			ltFlowCode,
			ltFuncNo
		From
			(
				Select
					a.FLOW_CODE_B ,
					a.COMP_EXE_FUNC_NO_B,
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
		Ar_WORK_YM					T_FL_MONTH_PLAN_EXEC_B.WORK_YM%Type,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_B.CRTUSERNO%Type
	)
	Is
		ltFlowCode					T_NUMS;
		ltFuncNo					T_NUMS;
		liFirst						Number;
		liLast						Number;
		lsFuncName					T_FL_COMP_EXE_FUNCTIONS_B.FUNC_NAME%Type;
		lnFuncNo					Number;
	Begin
		LoadFunctions;
		SetCalcInfo(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_WORK_YM,Ar_CRTUSERNO);
		
		Select
			a.FLOW_CODE_B ,
			a.COMP_EXE_FUNC_NO_B
		Bulk Collect Into
			ltFlowCode,
			ltFuncNo
		From
			(
				Select
					a.FLOW_CODE_B ,
					a.COMP_EXE_FUNC_NO_B,
					LEVEL LV,
					RowNum rn
				From	T_FL_FLOW_CODE_B a
				Where	a.COMP_EXE_FUNC_NO_B In
				(
					Select
						b.COMP_EXE_FUNC_NO_B
					From	T_FL_COMP_EXE_FUNCTIONS_B b
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
				Sum(a.EXEC_AMT) EXEC_AMT,
				SysDate CRTDATE,
				G_CRTUSERNO CRTUSERNO
			From	T_FL_MONTH_PLAN_EXEC_B a,
					T_FL_FLOW_CODE_B b
			Where	a.FLOW_CODE_B = b.FLOW_CODE_B
			And		b.P_NO = G_FLOW_CODE_B
			And		a.COMP_CODE = G_COMP_CODE
			And		a.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		a.WORK_YM = G_WORK_YM
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
		Set		t.EXEC_AMT = s.EXEC_AMT,
				t.MODDATE = s.CRTDATE,
				t.MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert
		(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,EXEC_AMT,CRTDATE,CRTUSERNO)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_YM,s.FLOW_CODE_B,s.EXEC_AMT,s.CRTDATE,s.CRTUSERNO);
	End;
	Procedure	SumSlip
	Is
		lddtf			Date := To_Date(G_WORK_YM||'01','YYYYMMDD');
		lddtt			Date := Last_Day(To_Date(G_WORK_YM||'01','YYYYMMDD'));
	Begin
		Insert Into T_FL_MONTH_ACC_EXEC_SUM_C
		(
			COMP_CODE,
			CLSE_ACC_ID,
			WORK_YM,
			FLOW_CODE_B,
			APPLY_SEQ,
			TRACE_SLIP_ID,
			TRACE_SLIP_IDSEQ,
			TRACE_NO,
			CASH_DT,
			EXEC_AMT
		)
		Select
			b.COMP_CODE COMP_CODE,
			G_CLSE_ACC_ID CLSE_ACC_ID,
			G_WORK_YM WORK_YM,
			a.FLOW_CODE_B FLOW_CODE_B,
			a.APPLY_SEQ APPLY_SEQ,
			b.TRACE_SLIP_ID TRACE_SLIP_ID,
			b.TRACE_SLIP_IDSEQ TRACE_SLIP_IDSEQ,
			b.TRACE_NO TRACE_NO,
			b.CASH_DT CASH_DT,
			(Case a.SLIP_SUM_MTHD_TAG
				When '1' Then b.DB_AMT
				When '2' Then b.CR_AMT
				When '3' Then Nvl(b.DB_AMT,0) - Nvl(b.CR_AMT,0)
				When '4' Then Nvl(b.CR_AMT,0) - Nvl(b.DB_AMT,0)
				Else 0
			End) * 
			(Case a.SIGN_TAG
				When 'N' Then -1
				Else 1
			End) EXEC_AMT
		From	T_FL_FLOW_ACC_CODE_B a,
				T_FL_TRACE_CASH_SLIP b
		Where	a.ACC_CODE = b.ACC_CODE
		And		b.COMP_CODE = G_COMP_CODE
		And		b.CASH_DT Between lddtf And lddtt
		And		a.FLOW_CODE_B = G_FLOW_CODE_B;
		
		Merge Into T_FL_MONTH_PLAN_EXEC_B t
		Using
		(
			Select
				a.COMP_CODE COMP_CODE,
				a.CLSE_ACC_ID CLSE_ACC_ID,
				a.WORK_YM WORK_YM,
				a.FLOW_CODE_B FLOW_CODE_B,
				G_CRTUSERNO CRTUSERNO,
				SysDate CRTDATE,
				Sum(a.EXEC_AMT) EXEC_AMT
			From	T_FL_MONTH_ACC_EXEC_SUM_C a
			Where	a.FLOW_CODE_B = G_FLOW_CODE_B
			And		a.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		a.WORK_YM = G_WORK_YM
			And		a.COMP_CODE = G_COMP_CODE
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
		Set		EXEC_AMT = s.EXEC_AMT,
				MODDATE = s.CRTDATE,
				MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert 
		(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,EXEC_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_YM,s.FLOW_CODE_B,s.CRTUSERNO,s.CRTDATE,s.EXEC_AMT);
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
					When '1' Then b.EXEC_AMT
					When '2' Then - b.EXEC_AMT
					Else 0
				End) EXEC_AMT
			From	T_FL_MONTH_PLAN_EXEC_B b,
					T_FL_FLOW_CODE_B a
			Where	a.FLOW_CODE_B = b.FLOW_CODE_B
			And		a.IS_LEAF_TAG = 'T'
			And		a.FLOW_ITEM_KIND In ('1','2')
			And		b.COMP_CODE = G_COMP_CODE
			And		b.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		b.WORK_YM = G_WORK_YM
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
		Set		EXEC_AMT = s.EXEC_AMT,
				MODDATE = s.CRTDATE,
				MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert 
		(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,EXEC_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_YM,s.FLOW_CODE_B,s.CRTUSERNO,s.CRTDATE,s.EXEC_AMT);
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
					When '1' Then b.EXEC_AMT
					When '4' Then b.EXEC_AMT
					When '2' Then - b.EXEC_AMT
					When '5' Then - b.EXEC_AMT
					Else 0
				End) EXEC_AMT
			From	T_FL_MONTH_PLAN_EXEC_B b,
					T_FL_FLOW_CODE_B a
			Where	a.FLOW_CODE_B = b.FLOW_CODE_B
			And		a.IS_LEAF_TAG = 'T'
			And		a.FLOW_ITEM_KIND In ('1','2','4','5')
			And		b.COMP_CODE = G_COMP_CODE
			And		b.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		b.WORK_YM = G_WORK_YM
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
		Set		EXEC_AMT = s.EXEC_AMT,
				MODDATE = s.CRTDATE,
				MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert 
		(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,EXEC_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_YM,s.FLOW_CODE_B,s.CRTUSERNO,s.CRTDATE,s.EXEC_AMT);
	End;
End;
/
