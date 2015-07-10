Create Or Replace Package PKG_FL_DEPT_EXEC_B
Is
	Function	Get_COMP_CODE
	Return T_FL_MONTH_PLAN_EXEC_PROJ_B.COMP_CODE%Type;
	Function	Get_CLSE_ACC_ID
	Return T_FL_MONTH_PLAN_EXEC_PROJ_B.CLSE_ACC_ID%Type;
	Function	Get_DEPT_CODE
	Return T_FL_MONTH_PLAN_EXEC_PROJ_B.DEPT_CODE%Type;
	Function	Get_FLOW_CODE_B
	Return T_FL_MONTH_PLAN_EXEC_PROJ_B.FLOW_CODE_B%Type;
	Function	Get_WORK_YM
	Return T_FL_MONTH_PLAN_EXEC_PROJ_B.WORK_YM%Type;
	Function	Get_CRTUSERNO
	Return T_FL_MONTH_PLAN_EXEC_PROJ_B.CRTUSERNO%Type;
	Procedure	ProcessBatch
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_PROJ_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_PROJ_B.CLSE_ACC_ID%Type,
		Ar_DEPT_CODE				T_FL_MONTH_PLAN_EXEC_PROJ_B.DEPT_CODE%Type,
		Ar_WORK_YM					T_FL_MONTH_PLAN_EXEC_PROJ_B.WORK_YM%Type,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_PROJ_B.CRTUSERNO%Type
	);
	Procedure	ProcessAutoRecal
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_PROJ_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_PROJ_B.CLSE_ACC_ID%Type,
		Ar_DEPT_CODE				T_FL_MONTH_PLAN_EXEC_PROJ_B.DEPT_CODE%Type,
		Ar_WORK_YM					T_FL_MONTH_PLAN_EXEC_PROJ_B.WORK_YM%Type,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_PROJ_B.CRTUSERNO%Type
	);
	Procedure	SumChild;
	Procedure	SumSlip;
	Procedure	CalcCurrentInOut;
	Procedure	CalcSpecialInOut;
	Procedure	CalcItrAmt;
End;
/
Create Or Replace Package Body PKG_FL_DEPT_EXEC_B
Is
	Type	T_FUNCTTIONS	Is Table Of T_FL_COMP_EXE_FUNCTIONS.FUNC_NAME%Type
		Index By Binary_Integer;
	Type	T_NUMS			Is Table Of Number
		Index By Binary_Integer;
	G_COMP_CODE				T_FL_MONTH_PLAN_EXEC_PROJ_B.COMP_CODE%Type;
	G_CLSE_ACC_ID			T_FL_MONTH_PLAN_EXEC_PROJ_B.CLSE_ACC_ID%Type;
	G_DEPT_CODE				T_FL_MONTH_PLAN_EXEC_PROJ_B.DEPT_CODE%Type;
	G_FLOW_CODE_B			T_FL_MONTH_PLAN_EXEC_PROJ_B.FLOW_CODE_B%Type;
	G_WORK_YM				T_FL_MONTH_PLAN_EXEC_PROJ_B.WORK_YM%Type;
	G_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_PROJ_B.CRTUSERNO%Type;

	G_FUNCTIONS				T_FUNCTTIONS;
	Procedure	LoadFunctions
	Is
	Begin
		G_FUNCTIONS.Delete;
		For lrA In (Select COMP_EXE_FUNC_NO,FUNC_NAME From T_FL_COMP_EXE_FUNCTIONS) Loop
			G_FUNCTIONS(lrA.COMP_EXE_FUNC_NO) := lrA.FUNC_NAME;
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
	Return T_FL_MONTH_PLAN_EXEC_PROJ_B.COMP_CODE%Type
	Is
	Begin
		Return G_COMP_CODE ;
	End;
	Function	Get_CLSE_ACC_ID
	Return T_FL_MONTH_PLAN_EXEC_PROJ_B.CLSE_ACC_ID%Type
	Is
	Begin
		Return G_CLSE_ACC_ID ;
	End;
	Function	Get_DEPT_CODE
	Return T_FL_MONTH_PLAN_EXEC_PROJ_B.DEPT_CODE%Type
	Is
	Begin
		Return G_DEPT_CODE ;
	End;
	Function	Get_FLOW_CODE_B
	Return T_FL_MONTH_PLAN_EXEC_PROJ_B.FLOW_CODE_B%Type
	Is
	Begin
		Return G_FLOW_CODE_B ;
	End;
	Function	Get_WORK_YM
	Return T_FL_MONTH_PLAN_EXEC_PROJ_B.WORK_YM%Type
	Is
	Begin
		Return G_WORK_YM ;
	End;
	Function	Get_CRTUSERNO
	Return T_FL_MONTH_PLAN_EXEC_PROJ_B.CRTUSERNO%Type
	Is
	Begin
		Return G_CRTUSERNO ;
	End;
	Procedure	SetCalcInfo
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_PROJ_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_PROJ_B.CLSE_ACC_ID%Type,
		Ar_DEPT_CODE				T_FL_MONTH_PLAN_EXEC_PROJ_B.DEPT_CODE%Type,
		Ar_WORK_YM					T_FL_MONTH_PLAN_EXEC_PROJ_B.WORK_YM%Type,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_PROJ_B.CRTUSERNO%Type
	)
	Is
	Begin
		G_COMP_CODE := Ar_COMP_CODE;
		G_CLSE_ACC_ID := Ar_CLSE_ACC_ID;
		G_DEPT_CODE := Ar_DEPT_CODE;
		G_CRTUSERNO := Ar_CRTUSERNO;
		G_WORK_YM := Ar_WORK_YM;
	End;
	Procedure	ClearData
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_PROJ_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_PROJ_B.CLSE_ACC_ID%Type,
		Ar_DEPT_CODE				T_FL_MONTH_PLAN_EXEC_PROJ_B.DEPT_CODE%Type,
		Ar_WORK_YM					T_FL_MONTH_PLAN_EXEC_PROJ_B.WORK_YM%Type
	)
	Is
	Begin
		Update	T_FL_MONTH_PLAN_EXEC_PROJ_B
		Set		EXEC_AMT = 0,
				SUM_EXEC_AMT = 0
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		DEPT_CODE = Ar_DEPT_CODE
		And		WORK_YM = Ar_WORK_YM;
		
		Delete	T_FL_MONTH_ACC_EXEC_SUM_B
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		DEPT_CODE = Ar_DEPT_CODE
		And		WORK_YM = Ar_WORK_YM;
	End;
	Procedure	ProcessBatch
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_PROJ_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_PROJ_B.CLSE_ACC_ID%Type,
		Ar_DEPT_CODE				T_FL_MONTH_PLAN_EXEC_PROJ_B.DEPT_CODE%Type,
		Ar_WORK_YM					T_FL_MONTH_PLAN_EXEC_PROJ_B.WORK_YM%Type,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_PROJ_B.CRTUSERNO%Type
	)
	Is
		ltFlowCode					T_NUMS;
		ltFuncNo					T_NUMS;
		liFirst						Number;
		liLast						Number;
		lsFuncName					T_FL_COMP_EXE_FUNCTIONS.FUNC_NAME%Type;
		lnFuncNo					Number;
	Begin
		LoadFunctions;
		SetCalcInfo(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_WORK_YM,Ar_CRTUSERNO);
		ClearData(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_WORK_YM);
		
		Select
			a.FLOW_CODE_B ,
			a.COMP_EXE_FUNC_NO
		Bulk Collect Into
			ltFlowCode,
			ltFuncNo
		From
			(
				Select
					a.FLOW_CODE_B ,
					a.COMP_EXE_FUNC_NO,
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
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC_PROJ_B.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC_PROJ_B.CLSE_ACC_ID%Type,
		Ar_DEPT_CODE				T_FL_MONTH_PLAN_EXEC_PROJ_B.DEPT_CODE%Type,
		Ar_WORK_YM					T_FL_MONTH_PLAN_EXEC_PROJ_B.WORK_YM%Type,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC_PROJ_B.CRTUSERNO%Type
	)
	Is
		ltFlowCode					T_NUMS;
		ltFuncNo					T_NUMS;
		liFirst						Number;
		liLast						Number;
		lsFuncName					T_FL_COMP_EXE_FUNCTIONS.FUNC_NAME%Type;
		lnFuncNo					Number;
	Begin
		LoadFunctions;
		SetCalcInfo(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_WORK_YM,Ar_CRTUSERNO);
		
		Select
			a.FLOW_CODE_B ,
			a.COMP_EXE_FUNC_NO
		Bulk Collect Into
			ltFlowCode,
			ltFuncNo
		From
			(
				Select
					a.FLOW_CODE_B ,
					a.COMP_EXE_FUNC_NO,
					LEVEL LV,
					RowNum rn
				From	T_FL_FLOW_CODE_B a
				Where	a.COMP_EXE_FUNC_NO In
				(
					Select
						b.COMP_EXE_FUNC_NO
					From	T_FL_COMP_EXE_FUNCTIONS b
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
		Merge Into T_FL_MONTH_PLAN_EXEC_PROJ_B t
		Using
		(
			Select
				a.COMP_CODE ,
				a.CLSE_ACC_ID ,
				a.DEPT_CODE ,
				a.WORK_YM,
				G_FLOW_CODE_B FLOW_CODE_B,
				Sum(a.SUM_EXEC_AMT) SUM_EXEC_AMT,
				Sum(a.MOD_EXEC_AMT) MOD_EXEC_AMT,
				Sum(a.EXEC_AMT) EXEC_AMT,
				SysDate CRTDATE,
				G_CRTUSERNO CRTUSERNO
			From	T_FL_MONTH_PLAN_EXEC_PROJ_B a,
					T_FL_FLOW_CODE_B b
			Where	a.FLOW_CODE_B = b.FLOW_CODE_B
			And		b.P_NO = G_FLOW_CODE_B
			And		a.COMP_CODE = G_COMP_CODE
			And		a.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		a.DEPT_CODE = G_DEPT_CODE
			And		a.WORK_YM = G_WORK_YM
			Group By
				a.COMP_CODE ,
				a.CLSE_ACC_ID ,
				a.DEPT_CODE ,
				a.WORK_YM
		) s
		On
		(
			s.COMP_CODE = t.COMP_CODE
		And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	s.DEPT_CODE = t.DEPT_CODE
		And	s.WORK_YM = t.WORK_YM
		And	s.FLOW_CODE_B = t.FLOW_CODE_B
		)
		When Matched Then
		Update
		Set		t.SUM_EXEC_AMT = s.SUM_EXEC_AMT,
				t.MOD_EXEC_AMT = s.MOD_EXEC_AMT,
				t.EXEC_AMT = s.EXEC_AMT,
				t.MODDATE = s.CRTDATE,
				t.MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert
		(COMP_CODE,CLSE_ACC_ID,DEPT_CODE,WORK_YM,FLOW_CODE_B,CRTDATE,CRTUSERNO,SUM_EXEC_AMT,MOD_EXEC_AMT,EXEC_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.DEPT_CODE,s.WORK_YM,s.FLOW_CODE_B,s.CRTDATE,s.CRTUSERNO,s.SUM_EXEC_AMT,s.MOD_EXEC_AMT,s.EXEC_AMT);
	End;
	Procedure	SumSlip
	Is
		lddtf			Date := To_Date(G_WORK_YM||'01','YYYYMMDD');
		lddtt			Date := Last_Day(To_Date(G_WORK_YM||'01','YYYYMMDD'));
	Begin
		Insert Into T_FL_MONTH_ACC_EXEC_SUM_B
		(
			COMP_CODE,
			CLSE_ACC_ID,
			DEPT_CODE,
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
			b.DEPT_CODE DEPT_CODE,
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
		And		b.DEPT_CODE = G_DEPT_CODE
		And		b.CASH_DT Between lddtf And lddtt
		And		a.SUM_MTHD_TAG = '1'			--현금추적
		And		a.FLOW_CODE_B = G_FLOW_CODE_B
		Union All
		Select
			b.COMP_CODE COMP_CODE,
			G_CLSE_ACC_ID CLSE_ACC_ID,
			b.DEPT_CODE DEPT_CODE,
			G_WORK_YM WORK_YM,
			a.FLOW_CODE_B FLOW_CODE_B,
			a.APPLY_SEQ APPLY_SEQ,
			b.SLIP_ID TRACE_SLIP_ID,
			b.SLIP_IDSEQ TRACE_SLIP_IDSEQ,
			RowNum TRACE_NO,
			b.MAKE_DT CASH_DT,
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
				T_ACC_SLIP_BODY1 b
		Where	a.ACC_CODE = b.ACC_CODE
		And		b.COMP_CODE = G_COMP_CODE
		And		b.DEPT_CODE = G_DEPT_CODE
		And		b.MAKE_DT Between lddtf And lddtt
		And		a.SUM_MTHD_TAG = '2'			--전표추적
		And		a.FLOW_CODE_B = G_FLOW_CODE_B
		And		b.KEEP_DT Is Not Null
		Union All
		Select
			c.COMP_CODE COMP_CODE,
			G_CLSE_ACC_ID CLSE_ACC_ID,
			c.DEPT_CODE DEPT_CODE,
			G_WORK_YM WORK_YM,
			a.FLOW_CODE_B FLOW_CODE_B,
			a.APPLY_SEQ APPLY_SEQ,
			c.SLIP_ID TRACE_SLIP_ID,
			c.SLIP_IDSEQ TRACE_SLIP_IDSEQ,
			RowNum TRACE_NO,
			c.MAKE_DT CASH_DT,
			(Case a.SLIP_SUM_MTHD_TAG
				When '1' Then Sign(c.DB_AMT) * Nvl(b.RESET_AMT,0)
				When '2' Then Sign(c.CR_AMT) * Nvl(b.RESET_AMT,0)
				When '3' Then Nvl(Sign(c.DB_AMT) * Nvl(b.RESET_AMT,0),0) - Nvl(Sign(c.CR_AMT) * Nvl(b.RESET_AMT,0),0)
				When '4' Then Nvl(Sign(c.CR_AMT) * Nvl(b.RESET_AMT,0),0) - Nvl(Sign(c.DB_AMT) * Nvl(b.RESET_AMT,0),0)
				Else 0
			End) * 
			(Case a.SIGN_TAG
				When 'N' Then -1
				Else 1
			End) EXEC_AMT
		From	T_FL_FLOW_ACC_CODE_B a,
				T_ACC_SLIP_REMAIN_KEEP b,
				T_ACC_SLIP_BODY1 c,
				T_ACC_SLIP_BODY1 d
		Where	a.ACC_CODE = c.ACC_CODE
		And		a.SETOFF_ACC_CODE = d.ACC_CODE
		And		b.SLIP_ID = c.SLIP_ID
		And		b.SLIP_IDSEQ = c.SLIP_IDSEQ
		And		b.SLIP_ID = d.SLIP_ID
		And		b.RESET_SLIP_IDSEQ = d.SLIP_IDSEQ
		And		c.COMP_CODE = G_COMP_CODE
		And		c.DEPT_CODE = G_DEPT_CODE
		And		c.MAKE_DT Between lddtf And lddtt
		And		a.SUM_MTHD_TAG = '3'			--상계전표추적
		And		a.FLOW_CODE_B = G_FLOW_CODE_B
		And		c.KEEP_DT Is Not Null;
		
		Merge Into T_FL_MONTH_PLAN_EXEC_PROJ_B t
		Using
		(
			Select
				a.COMP_CODE COMP_CODE,
				a.CLSE_ACC_ID CLSE_ACC_ID,
				a.DEPT_CODE DEPT_CODE,
				a.WORK_YM WORK_YM,
				a.FLOW_CODE_B FLOW_CODE_B,
				G_CRTUSERNO CRTUSERNO,
				SysDate CRTDATE,
				Sum(a.EXEC_AMT) SUM_EXEC_AMT
			From	T_FL_MONTH_ACC_EXEC_SUM_B a
			Where	a.FLOW_CODE_B = G_FLOW_CODE_B
			And		a.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		a.DEPT_CODE = G_DEPT_CODE
			And		a.WORK_YM = G_WORK_YM
			And		a.COMP_CODE = G_COMP_CODE
			Group By
				a.COMP_CODE ,
				a.CLSE_ACC_ID ,
				a.DEPT_CODE ,
				a.WORK_YM ,
				a.FLOW_CODE_B
		) s
		On
		(
			s.COMP_CODE = t.COMP_CODE
		And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	s.DEPT_CODE = t.DEPT_CODE
		And	s.WORK_YM = t.WORK_YM
		And	s.FLOW_CODE_B = t.FLOW_CODE_B
		)
		When Matched Then
		Update
		Set		SUM_EXEC_AMT = s.SUM_EXEC_AMT,
				EXEC_AMT = Nvl(s.SUM_EXEC_AMT,0) + Nvl(t.MOD_EXEC_AMT,0),
				MODDATE = s.CRTDATE,
				MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert 
		(COMP_CODE,CLSE_ACC_ID,DEPT_CODE,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,SUM_EXEC_AMT,EXEC_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.DEPT_CODE,s.WORK_YM,s.FLOW_CODE_B,s.CRTUSERNO,s.CRTDATE,s.SUM_EXEC_AMT,s.SUM_EXEC_AMT);
	End;
	Procedure	CalcCurrentInOut
	Is
	Begin
		Merge Into T_FL_MONTH_PLAN_EXEC_PROJ_B t
		Using
		(
			Select
				b.COMP_CODE  COMP_CODE,
				b.CLSE_ACC_ID CLSE_ACC_ID,
				b.DEPT_CODE DEPT_CODE,
				b.WORK_YM WORK_YM,
				G_FLOW_CODE_B FLOW_CODE_B,
				G_CRTUSERNO CRTUSERNO,
				SysDate CRTDATE,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.SUM_EXEC_AMT
					When '2' Then - b.SUM_EXEC_AMT
					Else 0
				End) SUM_EXEC_AMT,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.MOD_EXEC_AMT
					When '2' Then - b.MOD_EXEC_AMT
					Else 0
				End) MOD_EXEC_AMT,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.EXEC_AMT
					When '2' Then - b.EXEC_AMT
					Else 0
				End) EXEC_AMT
			From	T_FL_MONTH_PLAN_EXEC_PROJ_B b,
					T_FL_FLOW_CODE_B a
			Where	a.FLOW_CODE_B = b.FLOW_CODE_B
			And		a.IS_LEAF_TAG = 'T'
			And		a.FLOW_ITEM_KIND In ('1','2')
			And		b.COMP_CODE = G_COMP_CODE
			And		b.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		b.DEPT_CODE = G_DEPT_CODE
			And		b.WORK_YM = G_WORK_YM
			Group By
				b.COMP_CODE ,
				b.CLSE_ACC_ID ,
				b.DEPT_CODE ,
				b.WORK_YM 
		) s
		On
		(
			s.COMP_CODE = t.COMP_CODE
		And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	s.DEPT_CODE = t.DEPT_CODE
		And	s.WORK_YM = t.WORK_YM
		And	s.FLOW_CODE_B = t.FLOW_CODE_B
		)
		When Matched Then
		Update
		Set		SUM_EXEC_AMT = s.SUM_EXEC_AMT,
				MOD_EXEC_AMT = s.MOD_EXEC_AMT,
				EXEC_AMT = s.EXEC_AMT,
				MODDATE = s.CRTDATE,
				MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert 
		(COMP_CODE,CLSE_ACC_ID,DEPT_CODE,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,SUM_EXEC_AMT,MOD_EXEC_AMT,EXEC_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.DEPT_CODE,s.WORK_YM,s.FLOW_CODE_B,s.CRTUSERNO,s.CRTDATE,s.SUM_EXEC_AMT,s.MOD_EXEC_AMT,s.EXEC_AMT);
		Delete	T_FL_MONTH_ACC_EXEC_SUM_B
		Where	COMP_CODE = G_COMP_CODE
		And		CLSE_ACC_ID = G_CLSE_ACC_ID
		And		DEPT_CODE = G_DEPT_CODE
		And		FLOW_CODE_B = G_FLOW_CODE_B;
		Insert Into T_FL_MONTH_ACC_EXEC_SUM_B
		(
			COMP_CODE ,
			CLSE_ACC_ID ,
			DEPT_CODE ,
			WORK_YM ,
			FLOW_CODE_B ,
			APPLY_SEQ ,
			TRACE_SLIP_ID ,
			TRACE_SLIP_IDSEQ ,
			TRACE_NO ,
			CASH_DT ,
			EXEC_AMT
		)
		Select
			a.COMP_CODE ,
			a.CLSE_ACC_ID ,
			a.DEPT_CODE ,
			a.WORK_YM ,
			G_FLOW_CODE_B FLOW_CODE_B ,
			a.APPLY_SEQ ,
			a.TRACE_SLIP_ID ,
			a.TRACE_SLIP_IDSEQ ,
			RowNum TRACE_NO ,
			a.CASH_DT ,
			Decode(b.FLOW_ITEM_KIND,'1', a.EXEC_AMT , - a.EXEC_AMT) EXEC_AMT
		From	T_FL_MONTH_ACC_EXEC_SUM_B a,
				T_FL_FLOW_CODE_B b
		Where	a.FLOW_CODE_B = b.FLOW_CODE_B
		And		b.FLOW_ITEM_KIND In ('1','2')
		And		a.COMP_CODE = G_COMP_CODE
		And		a.CLSE_ACC_ID = G_CLSE_ACC_ID
		And		a.DEPT_CODE = G_DEPT_CODE
		And		a.WORK_YM = G_WORK_YM;
	End;
	Procedure	CalcSpecialInOut
	Is
	Begin
		Merge Into T_FL_MONTH_PLAN_EXEC_PROJ_B t
		Using
		(
			Select
				b.COMP_CODE  COMP_CODE,
				b.CLSE_ACC_ID CLSE_ACC_ID,
				b.DEPT_CODE DEPT_CODE,
				b.WORK_YM WORK_YM,
				G_FLOW_CODE_B FLOW_CODE_B,
				G_CRTUSERNO CRTUSERNO,
				SysDate CRTDATE,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.SUM_EXEC_AMT
					When '4' Then b.SUM_EXEC_AMT
					When '2' Then - b.SUM_EXEC_AMT
					When '5' Then - b.SUM_EXEC_AMT
					Else 0
				End) SUM_EXEC_AMT,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.MOD_EXEC_AMT
					When '4' Then b.MOD_EXEC_AMT
					When '2' Then - b.MOD_EXEC_AMT
					When '5' Then - b.MOD_EXEC_AMT
					Else 0
				End) MOD_EXEC_AMT,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.EXEC_AMT
					When '4' Then b.EXEC_AMT
					When '2' Then - b.EXEC_AMT
					When '5' Then - b.EXEC_AMT
					Else 0
				End) EXEC_AMT
			From	T_FL_MONTH_PLAN_EXEC_PROJ_B b,
					T_FL_FLOW_CODE_B a
			Where	a.FLOW_CODE_B = b.FLOW_CODE_B
			And		a.IS_LEAF_TAG = 'T'
			And		a.FLOW_ITEM_KIND In ('1','2','4','5')
			And		b.COMP_CODE = G_COMP_CODE
			And		b.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		b.DEPT_CODE = G_DEPT_CODE
			And		b.WORK_YM = G_WORK_YM
			Group By
				b.COMP_CODE ,
				b.CLSE_ACC_ID ,
				b.DEPT_CODE ,
				b.WORK_YM 
		) s
		On
		(
			s.COMP_CODE = t.COMP_CODE
		And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	s.DEPT_CODE = t.DEPT_CODE
		And	s.WORK_YM = t.WORK_YM
		And	s.FLOW_CODE_B = t.FLOW_CODE_B
		)
		When Matched Then
		Update
		Set		SUM_EXEC_AMT = s.SUM_EXEC_AMT,
				MOD_EXEC_AMT = s.MOD_EXEC_AMT,
				EXEC_AMT = s.EXEC_AMT,
				MODDATE = s.CRTDATE,
				MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert 
		(COMP_CODE,CLSE_ACC_ID,DEPT_CODE,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,SUM_EXEC_AMT,MOD_EXEC_AMT,EXEC_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.DEPT_CODE,s.WORK_YM,s.FLOW_CODE_B,s.CRTUSERNO,s.CRTDATE,s.SUM_EXEC_AMT,s.MOD_EXEC_AMT,s.EXEC_AMT);
		Delete	T_FL_MONTH_ACC_EXEC_SUM_B
		Where	COMP_CODE = G_COMP_CODE
		And		CLSE_ACC_ID = G_CLSE_ACC_ID
		And		DEPT_CODE = G_DEPT_CODE
		And		FLOW_CODE_B = G_FLOW_CODE_B;
		Insert Into T_FL_MONTH_ACC_EXEC_SUM_B
		(
			COMP_CODE ,
			CLSE_ACC_ID ,
			DEPT_CODE ,
			WORK_YM ,
			FLOW_CODE_B ,
			APPLY_SEQ ,
			TRACE_SLIP_ID ,
			TRACE_SLIP_IDSEQ ,
			TRACE_NO ,
			CASH_DT ,
			EXEC_AMT
		)
		Select
			a.COMP_CODE ,
			a.CLSE_ACC_ID ,
			a.DEPT_CODE ,
			a.WORK_YM ,
			G_FLOW_CODE_B FLOW_CODE_B ,
			a.APPLY_SEQ ,
			a.TRACE_SLIP_ID ,
			a.TRACE_SLIP_IDSEQ ,
			RowNum TRACE_NO ,
			a.CASH_DT ,
			Decode(b.FLOW_ITEM_KIND,'1', a.EXEC_AMT,'4', a.EXEC_AMT , - a.EXEC_AMT) EXEC_AMT
		From	T_FL_MONTH_ACC_EXEC_SUM_B a,
				T_FL_FLOW_CODE_B b
		Where	a.FLOW_CODE_B = b.FLOW_CODE_B
		And		b.FLOW_ITEM_KIND In ('1','2','4','5')
		And		a.COMP_CODE = G_COMP_CODE
		And		a.CLSE_ACC_ID = G_CLSE_ACC_ID
		And		a.DEPT_CODE = G_DEPT_CODE
		And		a.WORK_YM = G_WORK_YM;
	End;
	Procedure	CalcItrAmt
	Is
	Begin
		Merge Into T_FL_MONTH_PLAN_EXEC_PROJ_B t
		Using
		(
			Select
				G_COMP_CODE  COMP_CODE,
				G_CLSE_ACC_ID CLSE_ACC_ID,
				G_DEPT_CODE DEPT_CODE,
				To_Char(a.WORK_DT,'YYYYMM') WORK_YM ,
				G_FLOW_CODE_B FLOW_CODE_B,
				G_CRTUSERNO CRTUSERNO,
				SysDate CRTDATE,
				Round(Sum(a.ITR_AMT)) SUM_EXEC_AMT,
				0 MOD_EXEC_AMT,
				Round(Sum(a.ITR_AMT)) EXEC_AMT
			From
				(
					Select
						a.WORK_DT ,
						a.EXEC_AMT_SUM * 
						((Decode(Sign(a.EXEC_AMT_SUM),-1,a.ITR_RATIO_OUT_SUM,a.ITR_RATIO_IN_SUM))  / 100 ) * 
						(a.WORK_DT_TO - a.WORK_DT) / (to_date(G_CLSE_ACC_ID ||'1231','YYYYMMDD') - to_date(G_CLSE_ACC_ID ||'0101','YYYYMMDD') + 1) ITR_AMT
					From
						(
							Select
								a.WORK_DT ,
								a.SEQ,
								Nvl(Lead(a.WORK_DT) Over (Order By a.WORK_DT,a.SEQ),to_date(To_Char(To_Number(G_CLSE_ACC_ID) + 1,'FM0000') ||'0101','YYYYMMDD')) WORK_DT_TO ,
								Nvl(Sum(a.ITR_RATIO_IN) Over (Order By a.WORK_DT,a.SEQ),0) - Nvl(Sum(a.L_ITR_RATIO_IN) Over (Order By a.WORK_DT,a.SEQ),0) ITR_RATIO_IN_SUM ,
								Nvl(Sum(a.ITR_RATIO_OUT) Over (Order By a.WORK_DT,a.SEQ),0) - Nvl(Sum(a.L_ITR_RATIO_OUT) Over (Order By a.WORK_DT,a.SEQ),0) ITR_RATIO_OUT_SUM ,
								Sum(a.EXEC_AMT) Over (Order By a.WORK_DT,a.SEQ) EXEC_AMT_SUM
							From
								(
									Select
										a.WORK_DT ,
										0 ITR_RATIO_IN ,
										0 ITR_RATIO_OUT,
										0 L_ITR_RATIO_IN,
										0 L_ITR_RATIO_OUT,
										a.EXEC_AMT,
										2 SEQ
									From
										(
											Select
												To_Date(b.WORK_YM||'01','YYYYMMDD') WORK_DT ,
												Sum(b.EXEC_AMT) EXEC_AMT
											From	T_FL_MONTH_PLAN_EXEC_PROJ_B b,
													T_FL_FLOW_CODE_B a
											Where	a.FLOW_CODE_B = b.FLOW_CODE_B
											And		a.IS_LEAF_TAG = 'T'
											And		a.FLOW_ITEM_KIND = '6'
											And		b.COMP_CODE = G_COMP_CODE
											And		b.DEPT_CODE = G_DEPT_CODE
											And		b.WORK_YM <= G_WORK_YM
											Group By
												b.COMP_CODE ,
												b.CLSE_ACC_ID ,
												b.DEPT_CODE ,
												b.WORK_YM 
										) a
									Union All
									Select
										a.ITR_DATE_F,
										a.ITR_RATIO_IN ,
										a.ITR_RATIO_OUT,
										a.L_ITR_RATIO_IN,
										a.L_ITR_RATIO_OUT,
										0,
										1
									From
										(
											Select
												a.ITR_DATE_F,
												a.ITR_RATIO_IN ,
												a.ITR_RATIO_OUT,
												Lag(a.ITR_RATIO_IN) Over ( Order By a.ITR_DATE_F) L_ITR_RATIO_IN,
												Lag(a.ITR_RATIO_OUT) Over ( Order By a.ITR_DATE_F) L_ITR_RATIO_OUT
											From	T_FL_ITR_INFO a
											Where	a.COMP_CODE = G_COMP_CODE
											And		a.ITR_DATE_F <= Last_Day(to_date(G_WORK_YM ||'01','YYYYMMDD'))
											And		a.ITR_DATE_TO >= to_date(G_WORK_YM ||'01','YYYYMMDD')
											Order By
												a.ITR_DATE_F
										) a
								) a
							Order By
								a.WORK_DT,
								a.SEQ
						) a
				) a
			Where	To_Char(a.WORK_DT,'YYYY') = G_CLSE_ACC_ID
			Group by
				To_Char(a.WORK_DT,'YYYYMM')
		) s
		On
		(
			s.COMP_CODE = t.COMP_CODE
		And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	s.DEPT_CODE = t.DEPT_CODE
		And	s.WORK_YM = t.WORK_YM
		And	s.FLOW_CODE_B = t.FLOW_CODE_B
		)
		When Matched Then
		Update
		Set		SUM_EXEC_AMT = s.SUM_EXEC_AMT,
				EXEC_AMT = Nvl(s.SUM_EXEC_AMT,0) + Nvl(t.MOD_EXEC_AMT,0) ,
				MODDATE = s.CRTDATE,
				MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert 
		(COMP_CODE,CLSE_ACC_ID,DEPT_CODE,WORK_YM,FLOW_CODE_B,CRTUSERNO,CRTDATE,SUM_EXEC_AMT,EXEC_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.DEPT_CODE,s.WORK_YM,s.FLOW_CODE_B,s.CRTUSERNO,s.CRTDATE,s.SUM_EXEC_AMT,s.EXEC_AMT);
	End;
End;
/
