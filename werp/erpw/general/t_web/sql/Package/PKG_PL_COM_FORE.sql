Create Or Replace Package PKG_PL_COM_FORE
Is
	Function	Get_COMP_CODE
	Return T_PL_COMP_PLAN_EXEC.COMP_CODE%Type;
	Function	Get_CLSE_ACC_ID
	Return T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type;
	Function	Get_CHG_SEQ
	Return T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type;
	Function	Get_BIZ_PLAN_ITEM_NO
	Return T_PL_COMP_PLAN_EXEC.BIZ_PLAN_ITEM_NO%Type;
	Function	Get_QUARTER_YEAR
	Return Number;
	Function	Get_CRTUSERNO
	Return T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type;
	Procedure	ProcessBatch
	(
		Ar_COMP_CODE				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_CHG_SEQ					T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type,
		Ar_QUARTER_YEAR				Number,
		Ar_CRTUSERNO				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type
	);
	Procedure	ProcessAutoRecal
	(
		Ar_COMP_CODE				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_CHG_SEQ					T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type,
		Ar_QUARTER_YEAR				Number,
		Ar_CRTUSERNO				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type
	);
	Procedure	SumChild;
	Procedure	SumFromDept;
End;
/
Create Or Replace Package Body PKG_PL_COM_FORE
Is
	Type	T_FUNCTTIONS	Is Table Of T_PL_COMP_FORE_FUNCTIONS_B.FUNC_NAME%Type
		Index By Binary_Integer;
	Type	T_NUMS			Is Table Of Number
		Index By Binary_Integer;
	G_COMP_CODE				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type;
	G_CLSE_ACC_ID			T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type;
	G_CHG_SEQ				T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type;
	G_BIZ_PLAN_ITEM_NO			T_PL_COMP_PLAN_EXEC.BIZ_PLAN_ITEM_NO%Type;
	G_QUARTER_YEAR			Number;
	G_CRTUSERNO				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type;

	G_FUNCTIONS				T_FUNCTTIONS;
	Procedure	LoadFunctions
	Is
	Begin
		G_FUNCTIONS.Delete;
		For lrA In (Select COMP_FOR_FUNC_NO_B,FUNC_NAME From T_PL_COMP_FORE_FUNCTIONS_B) Loop
			G_FUNCTIONS(lrA.COMP_FOR_FUNC_NO_B) := lrA.FUNC_NAME;
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
	Return T_PL_COMP_PLAN_EXEC.COMP_CODE%Type
	Is
	Begin
		Return G_COMP_CODE ;
	End;
	Function	Get_CLSE_ACC_ID
	Return T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type
	Is
	Begin
		Return G_CLSE_ACC_ID ;
	End;
	Function	Get_CHG_SEQ
	Return T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type
	Is
	Begin
		Return G_CHG_SEQ;
	End;
	Function	Get_BIZ_PLAN_ITEM_NO
	Return T_PL_COMP_PLAN_EXEC.BIZ_PLAN_ITEM_NO%Type
	Is
	Begin
		Return G_BIZ_PLAN_ITEM_NO ;
	End;
	Function	Get_QUARTER_YEAR
	Return Number
	Is
	Begin
		Return G_QUARTER_YEAR ;
	End;
	Function	Get_CRTUSERNO
	Return T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type
	Is
	Begin
		Return G_CRTUSERNO ;
	End;
	Procedure	SetCalcInfo
	(
		Ar_COMP_CODE				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_CHG_SEQ					T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type,
		Ar_QUARTER_YEAR				Number,
		Ar_CRTUSERNO				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type
	)
	Is
	Begin
		G_COMP_CODE := Ar_COMP_CODE;
		G_CLSE_ACC_ID := Ar_CLSE_ACC_ID;
		G_CHG_SEQ := Ar_CHG_SEQ;
		G_QUARTER_YEAR := Ar_QUARTER_YEAR;
		G_CRTUSERNO := Ar_CRTUSERNO;
	End;
	Procedure	ClearData
	(
		Ar_COMP_CODE				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_CHG_SEQ					T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type,
		Ar_QUARTER_YEAR				Number
	)
	Is
		lsBegin						Varchar2(6);
		lsEnd						Varchar2(6);
	Begin
		If Ar_QUARTER_YEAR = 1 Then
			lsBegin := Ar_CLSE_ACC_ID||'01';
			lsEnd := Ar_CLSE_ACC_ID||'03';
		End If;
		If Ar_QUARTER_YEAR = 2 Then
			lsBegin := Ar_CLSE_ACC_ID||'04';
			lsEnd := Ar_CLSE_ACC_ID||'06';
		End If;
		If Ar_QUARTER_YEAR = 3 Then
			lsBegin := Ar_CLSE_ACC_ID||'07';
			lsEnd := Ar_CLSE_ACC_ID||'09';
		End If;
		If Ar_QUARTER_YEAR = 4 Then
			lsBegin := Ar_CLSE_ACC_ID||'10';
			lsEnd := Ar_CLSE_ACC_ID||'12';
		End If;
		Update	T_PL_COMP_PLAN_EXEC
		Set		SUM_FORECAST_AMT = 0,
				MOD_FORECAST_AMT = 0,
				FORECAST_AMT = Nvl(B_MOD_FORECAST_AMT,0)
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		WORK_YM Between lsBegin And lsEnd
		And		CHG_SEQ = Ar_CHG_SEQ;
	End;
	Procedure	ProcessBatch
	(
		Ar_COMP_CODE				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_CHG_SEQ					T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type,
		Ar_QUARTER_YEAR				Number,
		Ar_CRTUSERNO				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type
	)
	Is
		ltFlowCode					T_NUMS;
		ltFuncNo					T_NUMS;
		liFirst						Number;
		liLast						Number;
		lsFuncName					T_PL_COMP_FORE_FUNCTIONS_B.FUNC_NAME%Type;
		lnFuncNo					Number;
	Begin
		LoadFunctions;
		SetCalcInfo(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_CHG_SEQ,Ar_QUARTER_YEAR,Ar_CRTUSERNO);
		ClearData(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_CHG_SEQ,Ar_QUARTER_YEAR);
		
		Select
			a.BIZ_PLAN_ITEM_NO ,
			a.COMP_FOR_FUNC_NO_B
		Bulk Collect Into
			ltFlowCode,
			ltFuncNo
		From
			(
				Select
					a.BIZ_PLAN_ITEM_NO ,
					a.COMP_FOR_FUNC_NO_B,
					LEVEL LV,
					RowNum rn
				From	T_PL_ITEM a
				Start With	a.P_NO = 0
				Connect By
					Prior	a.BIZ_PLAN_ITEM_NO = a.P_NO
				Order Siblings By
					a.ITEM_LEVEL_SEQ
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
					G_BIZ_PLAN_ITEM_NO := ltFlowCode(liI);
					lsFuncName := GetFunction(lnFuncNo);
					Execute Immediate lsFuncName;
				End If;
			End Loop;
		End If;
	End;
	Procedure	ProcessAutoRecal
	(
		Ar_COMP_CODE				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_CHG_SEQ					T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type,
		Ar_QUARTER_YEAR				Number,
		Ar_CRTUSERNO				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type
	)
	Is
		ltFlowCode					T_NUMS;
		ltFuncNo					T_NUMS;
		liFirst						Number;
		liLast						Number;
		lsFuncName					T_PL_COMP_FORE_FUNCTIONS_B.FUNC_NAME%Type;
		lnFuncNo					Number;
	Begin
		LoadFunctions;
		SetCalcInfo(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_CHG_SEQ,Ar_QUARTER_YEAR,Ar_CRTUSERNO);
		
		Select
			a.BIZ_PLAN_ITEM_NO ,
			a.COMP_FOR_FUNC_NO_B
		Bulk Collect Into
			ltFlowCode,
			ltFuncNo
		From
			(
				Select
					a.BIZ_PLAN_ITEM_NO ,
					a.COMP_FOR_FUNC_NO_B,
					LEVEL LV,
					RowNum rn
				From	T_PL_ITEM a
				Where	a.COMP_FOR_FUNC_NO_B In
				(
					Select
						b.COMP_FOR_FUNC_NO_B
					From	T_PL_COMP_FORE_FUNCTIONS_B b
					Where	b.AUTO_RECALCC_TAG = 'T'
				)
				Start With	a.P_NO = 0
				Connect By
					Prior	a.BIZ_PLAN_ITEM_NO = a.P_NO
				Order Siblings By
					a.ITEM_LEVEL_SEQ
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
					G_BIZ_PLAN_ITEM_NO := ltFlowCode(liI);
					lsFuncName := GetFunction(lnFuncNo);
					Execute Immediate lsFuncName;
				End If;
			End Loop;
		End If;
	End;
	Procedure	SumChild
	Is
		lsBegin						Varchar2(6);
		lsEnd						Varchar2(6);
	Begin
		If G_QUARTER_YEAR = 1 Then
			lsBegin := G_CLSE_ACC_ID||'01';
			lsEnd := G_CLSE_ACC_ID||'03';
		End If;
		If G_QUARTER_YEAR = 2 Then
			lsBegin := G_CLSE_ACC_ID||'04';
			lsEnd := G_CLSE_ACC_ID||'06';
		End If;
		If G_QUARTER_YEAR = 3 Then
			lsBegin := G_CLSE_ACC_ID||'07';
			lsEnd := G_CLSE_ACC_ID||'09';
		End If;
		If G_QUARTER_YEAR = 4 Then
			lsBegin := G_CLSE_ACC_ID||'10';
			lsEnd := G_CLSE_ACC_ID||'12';
		End If;
		Merge Into T_PL_COMP_PLAN_EXEC t
		Using
		(
			Select
				a.COMP_CODE ,
				a.CLSE_ACC_ID ,
				a.CHG_SEQ,
				a.WORK_YM,
				G_BIZ_PLAN_ITEM_NO BIZ_PLAN_ITEM_NO,
				Sum(a.SUM_FORECAST_AMT) SUM_FORECAST_AMT,
				Sum(a.MOD_FORECAST_AMT) MOD_FORECAST_AMT,
				Sum(a.B_MOD_FORECAST_AMT) B_MOD_FORECAST_AMT,
				Sum(a.FORECAST_AMT) FORECAST_AMT,
				SysDate CRTDATE,
				G_CRTUSERNO CRTUSERNO
			From	T_PL_COMP_PLAN_EXEC a,
					T_PL_ITEM b
			Where	a.BIZ_PLAN_ITEM_NO = b.BIZ_PLAN_ITEM_NO
			And		b.P_NO = G_BIZ_PLAN_ITEM_NO
			And		a.COMP_CODE = G_COMP_CODE
			And		a.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		a.CHG_SEQ = G_CHG_SEQ
			And		a.WORK_YM Between lsBegin And lsEnd
			Group By
				a.COMP_CODE ,
				a.CLSE_ACC_ID ,
				a.CHG_SEQ,
				a.WORK_YM
		) s
		On
		(
			s.COMP_CODE = t.COMP_CODE
		And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	s.CHG_SEQ = t.CHG_SEQ
		And	s.WORK_YM = t.WORK_YM
		And	s.BIZ_PLAN_ITEM_NO = t.BIZ_PLAN_ITEM_NO
		)
		When Matched Then
		Update
		Set		t.SUM_FORECAST_AMT = s.SUM_FORECAST_AMT,
				t.MOD_FORECAST_AMT = s.MOD_FORECAST_AMT,
				t.B_MOD_FORECAST_AMT = s.B_MOD_FORECAST_AMT,
				t.FORECAST_AMT = s.FORECAST_AMT,
				t.MODDATE = s.CRTDATE,
				t.MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert
		(COMP_CODE,CLSE_ACC_ID,CHG_SEQ,WORK_YM,BIZ_PLAN_ITEM_NO,SUM_FORECAST_AMT,FORECAST_AMT,MOD_FORECAST_AMT,B_MOD_FORECAST_AMT,CRTDATE,CRTUSERNO)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.CHG_SEQ,s.WORK_YM,s.BIZ_PLAN_ITEM_NO,s.SUM_FORECAST_AMT,s.FORECAST_AMT,s.MOD_FORECAST_AMT,s.B_MOD_FORECAST_AMT,s.CRTDATE,s.CRTUSERNO);
	End;
	Procedure	SumFromDept
	Is
		lsBegin						Varchar2(6);
		lsEnd						Varchar2(6);
	Begin
		If G_QUARTER_YEAR = 1 Then
			lsBegin := G_CLSE_ACC_ID||'01';
			lsEnd := G_CLSE_ACC_ID||'03';
		End If;
		If G_QUARTER_YEAR = 2 Then
			lsBegin := G_CLSE_ACC_ID||'04';
			lsEnd := G_CLSE_ACC_ID||'06';
		End If;
		If G_QUARTER_YEAR = 3 Then
			lsBegin := G_CLSE_ACC_ID||'07';
			lsEnd := G_CLSE_ACC_ID||'09';
		End If;
		If G_QUARTER_YEAR = 4 Then
			lsBegin := G_CLSE_ACC_ID||'10';
			lsEnd := G_CLSE_ACC_ID||'12';
		End If;
		Merge Into T_PL_COMP_PLAN_EXEC t
		Using
		(
			Select
				a.COMP_CODE,
				a.CLSE_ACC_ID,
				a.CHG_SEQ,
				a.WORK_YM,
				a.BIZ_PLAN_ITEM_NO,
				G_CRTUSERNO CRTUSERNO,
				Sysdate CRTDATE,
				Sum(a.SUM_FORECAST_AMT) SUM_FORECAST_AMT,
				Sum(a.MOD_FORECAST_AMT) MOD_FORECAST_AMT,
				Sum(a.FORECAST_AMT) FORECAST_AMT
			From	T_PL_COMP_DEPT_PLAN_EXEC a
			Where	a.COMP_CODE = G_COMP_CODE
			And		a.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		a.BIZ_PLAN_ITEM_NO = G_BIZ_PLAN_ITEM_NO
			And		a.CHG_SEQ = G_CHG_SEQ
			And		a.WORK_YM Between lsBegin And lsEnd
			Group By
				a.COMP_CODE ,
				a.CLSE_ACC_ID ,
				a.CHG_SEQ,
				a.WORK_YM ,
				a.BIZ_PLAN_ITEM_NO
		) s
		On
		(
			s.COMP_CODE = t.COMP_CODE
		And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
		And	s.CHG_SEQ = t.CHG_SEQ
		And	s.WORK_YM = t.WORK_YM
		And	s.BIZ_PLAN_ITEM_NO = t.BIZ_PLAN_ITEM_NO
		)
		When Matched Then
		Update
		Set
			t.SUM_FORECAST_AMT = Nvl(s.SUM_FORECAST_AMT,0) + Nvl(s.MOD_FORECAST_AMT,0),
			t.MOD_FORECAST_AMT = 0,
			t.FORECAST_AMT = Nvl(s.SUM_FORECAST_AMT,0) + Nvl(s.MOD_FORECAST_AMT,0) + Nvl(t.B_MOD_FORECAST_AMT,0),
			t.MODDATE = s.CRTDATE,
			t.MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert 
		(COMP_CODE,CLSE_ACC_ID,CHG_SEQ,WORK_YM,BIZ_PLAN_ITEM_NO,CRTUSERNO,CRTDATE,SUM_FORECAST_AMT,MOD_FORECAST_AMT,B_MOD_FORECAST_AMT,FORECAST_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.CHG_SEQ,s.WORK_YM,s.BIZ_PLAN_ITEM_NO,s.CRTUSERNO,s.CRTDATE,Nvl(s.SUM_FORECAST_AMT,0) + Nvl(s.MOD_FORECAST_AMT,0),0,0,Nvl(s.SUM_FORECAST_AMT,0) + Nvl(s.MOD_FORECAST_AMT,0));
	End;
End;
/
