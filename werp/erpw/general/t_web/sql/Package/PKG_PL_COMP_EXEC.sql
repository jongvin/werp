Create Or Replace Package PKG_PL_COMP_EXEC
Is
	Function	Get_COMP_CODE
	Return T_PL_COMP_PLAN_EXEC.COMP_CODE%Type;
	Function	Get_CLSE_ACC_ID
	Return T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type;
	Function	Get_CHG_SEQ
	Return T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type;
	Function	Get_BIZ_PLAN_ITEM_NO
	Return T_PL_COMP_PLAN_EXEC.BIZ_PLAN_ITEM_NO%Type;
	Function	Get_WORK_YM
	Return T_PL_COMP_PLAN_EXEC.WORK_YM%Type;
	Function	Get_CRTUSERNO
	Return T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type;
	Procedure	ProcessBatch
	(
		Ar_COMP_CODE				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_CHG_SEQ					T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type,
		Ar_WORK_YM					T_PL_COMP_PLAN_EXEC.WORK_YM%Type,
		Ar_CRTUSERNO				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type
	);
	Procedure	ProcessAutoRecal
	(
		Ar_COMP_CODE				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_CHG_SEQ					T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type,
		Ar_WORK_YM					T_PL_COMP_PLAN_EXEC.WORK_YM%Type,
		Ar_CRTUSERNO				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type
	);
	Procedure	SumChild;
	Procedure	SumSlip;
End;
/
Create Or Replace Package Body PKG_PL_COMP_EXEC
Is
	Type	T_FUNCTTIONS	Is Table Of T_PL_COMP_EXE_FUNCTIONS_B.FUNC_NAME%Type
		Index By Binary_Integer;
	Type	T_NUMS			Is Table Of Number
		Index By Binary_Integer;
	G_COMP_CODE				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type;
	G_CLSE_ACC_ID			T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type;
	G_CHG_SEQ				T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type;
	G_BIZ_PLAN_ITEM_NO		T_PL_COMP_PLAN_EXEC.BIZ_PLAN_ITEM_NO%Type;
	G_WORK_YM				T_PL_COMP_PLAN_EXEC.WORK_YM%Type;
	G_CRTUSERNO				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type;

	G_FUNCTIONS				T_FUNCTTIONS;
	Procedure	LoadFunctions
	Is
	Begin
		G_FUNCTIONS.Delete;
		For lrA In (Select COMP_EXE_FUNC_NO_B,FUNC_NAME From T_PL_COMP_EXE_FUNCTIONS_B) Loop
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
	Function	Get_WORK_YM
	Return T_PL_COMP_PLAN_EXEC.WORK_YM%Type
	Is
	Begin
		Return G_WORK_YM ;
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
		Ar_WORK_YM					T_PL_COMP_PLAN_EXEC.WORK_YM%Type,
		Ar_CRTUSERNO				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type
	)
	Is
	Begin
		G_COMP_CODE := Ar_COMP_CODE;
		G_CLSE_ACC_ID := Ar_CLSE_ACC_ID;
		G_CHG_SEQ := Ar_CHG_SEQ;
		G_CRTUSERNO := Ar_CRTUSERNO;
		G_WORK_YM := Ar_WORK_YM;
	End;
	Procedure	ClearData
	(
		Ar_COMP_CODE				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_CHG_SEQ					T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type,
		Ar_WORK_YM					T_PL_COMP_PLAN_EXEC.WORK_YM%Type
	)
	Is
	Begin
		Update	T_PL_COMP_PLAN_EXEC
		Set		MOD_EXEC_AMT = 0,
				SUM_EXEC_AMT = 0,
				EXEC_AMT = B_MOD_EXEC_AMT
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		CHG_SEQ = Ar_CHG_SEQ
		And		WORK_YM = Ar_WORK_YM;

		Update	T_PL_COMP_DEPT_PLAN_EXEC
		Set		MOD_EXEC_AMT = 0,
				SUM_EXEC_AMT = 0,
				EXEC_AMT = 0
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		CHG_SEQ = Ar_CHG_SEQ
		And		WORK_YM = Ar_WORK_YM;

		Delete	T_PL_MONTH_DEPT_ACC_EXEC_SUM
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		WORK_YM = Ar_WORK_YM;

		Delete	T_PL_MONTH_ACC_EXEC_SUM
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		WORK_YM = Ar_WORK_YM;
	End;
	Procedure	ProcessBatch
	(
		Ar_COMP_CODE				T_PL_COMP_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_PL_COMP_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_CHG_SEQ					T_PL_COMP_PLAN_EXEC.CHG_SEQ%Type,
		Ar_WORK_YM					T_PL_COMP_PLAN_EXEC.WORK_YM%Type,
		Ar_CRTUSERNO				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type
	)
	Is
		ltFlowCode					T_NUMS;
		ltFuncNo					T_NUMS;
		liFirst						Number;
		liLast						Number;
		lsFuncName					T_PL_COMP_EXE_FUNCTIONS_B.FUNC_NAME%Type;
		lnFuncNo					Number;
	Begin
		LoadFunctions;
		SetCalcInfo(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_CHG_SEQ,Ar_WORK_YM,Ar_CRTUSERNO);
		ClearData(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_CHG_SEQ,Ar_WORK_YM);

		Select
			a.BIZ_PLAN_ITEM_NO ,
			a.COMP_EXE_FUNC_NO_B
		Bulk Collect Into
			ltFlowCode,
			ltFuncNo
		From
			(
				Select
					a.BIZ_PLAN_ITEM_NO ,
					a.COMP_EXE_FUNC_NO_B,
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
		Ar_WORK_YM					T_PL_COMP_PLAN_EXEC.WORK_YM%Type,
		Ar_CRTUSERNO				T_PL_COMP_PLAN_EXEC.CRTUSERNO%Type
	)
	Is
		ltFlowCode					T_NUMS;
		ltFuncNo					T_NUMS;
		liFirst						Number;
		liLast						Number;
		lsFuncName					T_PL_COMP_EXE_FUNCTIONS_B.FUNC_NAME%Type;
		lnFuncNo					Number;
	Begin
		LoadFunctions;
		SetCalcInfo(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_CHG_SEQ,Ar_WORK_YM,Ar_CRTUSERNO);

		Select
			a.BIZ_PLAN_ITEM_NO ,
			a.COMP_EXE_FUNC_NO_B
		Bulk Collect Into
			ltFlowCode,
			ltFuncNo
		From
			(
				Select
					a.BIZ_PLAN_ITEM_NO ,
					a.COMP_EXE_FUNC_NO_B,
					LEVEL LV,
					RowNum rn
				From	T_PL_ITEM a
				Where	a.COMP_EXE_FUNC_NO_B In
				(
					Select
						b.COMP_EXE_FUNC_NO_B
					From	T_PL_COMP_EXE_FUNCTIONS_B b
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
	Begin
		Merge Into T_PL_COMP_PLAN_EXEC t
		Using
		(
			Select
				a.COMP_CODE ,
				a.CLSE_ACC_ID ,
				a.CHG_SEQ,
				a.WORK_YM,
				G_BIZ_PLAN_ITEM_NO BIZ_PLAN_ITEM_NO,
				Sum(a.SUM_EXEC_AMT) SUM_EXEC_AMT,
				Sum(a.MOD_EXEC_AMT) MOD_EXEC_AMT,
				Sum(a.B_MOD_EXEC_AMT) B_MOD_EXEC_AMT,
				Sum(a.EXEC_AMT) EXEC_AMT,
				SysDate CRTDATE,
				G_CRTUSERNO CRTUSERNO
			From	T_PL_COMP_PLAN_EXEC a,
					T_PL_ITEM b
			Where	a.BIZ_PLAN_ITEM_NO = b.BIZ_PLAN_ITEM_NO
			And		b.P_NO = G_BIZ_PLAN_ITEM_NO
			And		a.COMP_CODE = G_COMP_CODE
			And		a.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		a.CHG_SEQ = G_CHG_SEQ
			And		a.WORK_YM = G_WORK_YM
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
		Set		t.SUM_EXEC_AMT = s.SUM_EXEC_AMT,
				t.MOD_EXEC_AMT = s.MOD_EXEC_AMT,
				t.B_MOD_EXEC_AMT = s.B_MOD_EXEC_AMT,
				t.EXEC_AMT = s.EXEC_AMT,
				t.MODDATE = s.CRTDATE,
				t.MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert
		(COMP_CODE,CLSE_ACC_ID,CHG_SEQ,WORK_YM,BIZ_PLAN_ITEM_NO,SUM_EXEC_AMT,EXEC_AMT,MOD_EXEC_AMT,B_MOD_EXEC_AMT,CRTDATE,CRTUSERNO)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.CHG_SEQ,s.WORK_YM,s.BIZ_PLAN_ITEM_NO,s.SUM_EXEC_AMT,s.EXEC_AMT,s.MOD_EXEC_AMT,s.B_MOD_EXEC_AMT,s.CRTDATE,s.CRTUSERNO);
	End;
	Procedure	SumSlip
	Is
		lddtf			Date := To_Date(G_WORK_YM||'01','YYYYMMDD');
		lddtt			Date := Last_Day(To_Date(G_WORK_YM||'01','YYYYMMDD'));
		lrPlItem					T_PL_ITEM%RowType;
	Begin
		Begin
			Select
				*
			Into
				lrPlItem
			From	T_PL_ITEM
			Where	BIZ_PLAN_ITEM_NO = G_BIZ_PLAN_ITEM_NO;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'해당 항목을 찾을 수 없습니다.');
		End;
		If lrPlItem.DEPT_TAG = 'T' Then		--만약 현장별로 계획이 편성된 것이라면 실적도 현장별 실적을 집계해야 합니다.
			Insert Into T_PL_MONTH_DEPT_ACC_EXEC_SUM
			(
				COMP_CODE,
				CLSE_ACC_ID,
				DEPT_CODE,
				WORK_YM,
				BIZ_PLAN_ITEM_NO,
				APPLY_SEQ,
				SLIP_ID,
				SLIP_IDSEQ,
				EXEC_AMT
			)
			Select
				G_COMP_CODE COMP_CODE,
				G_CLSE_ACC_ID CLSE_ACC_ID,
				b.DEPT_CODE DEPT_CODE,
				G_WORK_YM WORK_YM,
				G_BIZ_PLAN_ITEM_NO BIZ_PLAN_ITEM_NO,
				a.APPLY_SEQ APPLY_SEQ,
				b.SLIP_ID SLIP_ID,
				b.SLIP_IDSEQ SLIP_IDSEQ,
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
			From	T_PL_FLOW_ACC_CODE a,
					T_ACC_SLIP_BODY1 b
			Where	a.ACC_CODE = b.ACC_CODE
			And		b.COMP_CODE = G_COMP_CODE
			And		b.MAKE_DT Between lddtf And lddtt
			And		a.SUM_MTHD_TAG = '2'		--전표추적
			And		a.BIZ_PLAN_ITEM_NO = G_BIZ_PLAN_ITEM_NO
			And		b.KEEP_DT Is Not Null
			And		b.TRANSFER_TAG = 'F'
			Union All
			Select
				c.COMP_CODE COMP_CODE,
				G_CLSE_ACC_ID CLSE_ACC_ID,
				c.DEPT_CODE DEPT_CODE,
				G_WORK_YM WORK_YM,
				G_BIZ_PLAN_ITEM_NO BIZ_PLAN_ITEM_NO,
				a.APPLY_SEQ APPLY_SEQ,
				b.SLIP_ID SLIP_ID,
				b.SLIP_IDSEQ SLIP_IDSEQ,
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
			From	T_PL_FLOW_ACC_CODE  a,
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
			And		c.MAKE_DT Between lddtf And lddtt
			And		a.SUM_MTHD_TAG = '3'			--상계전표추적
			And		a.BIZ_PLAN_ITEM_NO = G_BIZ_PLAN_ITEM_NO
			And		c.KEEP_DT Is Not Null
			And		c.TRANSFER_TAG = 'F'
			And		d.TRANSFER_TAG = 'F';
			--만약 년초 계획에 없던 현장이어도 실제 실적이 발생했다면 경영계획 회기별 현장목록에 추가 되어야 합니다.
			Insert Into T_PL_PLAN_DEPT
			(
				COMP_CODE,
				CLSE_ACC_ID,
				DEPT_CODE
			)
			Select
				Distinct
				COMP_CODE,
				CLSE_ACC_ID,
				DEPT_CODE
			From	T_PL_MONTH_DEPT_ACC_EXEC_SUM b
			Where	b.COMP_CODE = G_COMP_CODE
			And		b.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		b.WORK_YM = G_WORK_YM
			And		b.BIZ_PLAN_ITEM_NO = G_BIZ_PLAN_ITEM_NO
			And		Not Exists
			(
				Select
					Null
				From	T_PL_PLAN_DEPT x
				Where	x.COMP_CODE = b.COMP_CODE
				And		x.CLSE_ACC_ID = b.CLSE_ACC_ID
				And		x.DEPT_CODE = b.DEPT_CODE
			);
			
			--현장별 실적의 경우는 그 금액이 관련 가상현장 및 해당 가상현장의 실 현장 모두로 집계 됩니다.
			--그러므로 현장별 계금액 과 사업장 금액은 일치하지 않습니다.
			Merge Into T_PL_COMP_DEPT_PLAN_EXEC t
			Using
			(
				Select
					G_CRTUSERNO CRTUSERNO,
					SysDate CRTDATE,
					b.COMP_CODE COMP_CODE,
					b.CLSE_ACC_ID CLSE_ACC_ID,
					G_CHG_SEQ CHG_SEQ,
					b.DEPT_CODE DEPT_CODE,
					b.WORK_YM WORK_YM,
					b.BIZ_PLAN_ITEM_NO BIZ_PLAN_ITEM_NO,
					Sum(b.EXEC_AMT) EXEC_AMT
				From	T_PL_PLAN_DEPT a,
						T_PL_MONTH_DEPT_ACC_EXEC_SUM b
				Where	b.COMP_CODE = G_COMP_CODE
				And		b.CLSE_ACC_ID = G_CLSE_ACC_ID
				And		b.WORK_YM = G_WORK_YM
				And		b.BIZ_PLAN_ITEM_NO = G_BIZ_PLAN_ITEM_NO
				And		a.COMP_CODE = b.COMP_CODE
				And		a.CLSE_ACC_ID = b.CLSE_ACC_ID
				And		a.DEPT_CODE = b.DEPT_CODE
				/*
				And		a.DEPT_CODE Not In 
				(
					Select
						bb.V_DEPT_CODE
					From	T_PL_VIRTUAL_DEPT bb
				)
				*/
				Group By
					b.COMP_CODE,
					b.CLSE_ACC_ID,
					b.DEPT_CODE,
					b.WORK_YM,
					b.BIZ_PLAN_ITEM_NO
				Union All
				Select
					G_CRTUSERNO CRTUSERNO,
					SysDate CRTDATE,
					c.COMP_CODE COMP_CODE,
					c.CLSE_ACC_ID CLSE_ACC_ID,
					G_CHG_SEQ CHG_SEQ,
					b.V_DEPT_CODE DEPT_CODE,
					c.WORK_YM WORK_YM,
					c.BIZ_PLAN_ITEM_NO BIZ_PLAN_ITEM_NO,
					Sum(c.EXEC_AMT) EXEC_AMT
				From	T_PL_PLAN_DEPT a,
						T_PL_VIRTUAL_REAL_DEPT b,
						T_PL_MONTH_DEPT_ACC_EXEC_SUM c
				Where	a.COMP_CODE = b.COMP_CODE
				And		a.CLSE_ACC_ID = b.CLSE_ACC_ID
				And		a.DEPT_CODE = b.V_DEPT_CODE
				And		b.COMP_CODE = c.COMP_CODE
				And		b.CLSE_ACC_ID = c.CLSE_ACC_ID
				And		b.R_DEPT_CODE = c.DEPT_CODE
				And		c.COMP_CODE = G_COMP_CODE
				And		c.CLSE_ACC_ID = G_CLSE_ACC_ID
				And		c.WORK_YM = G_WORK_YM
				And		c.BIZ_PLAN_ITEM_NO = G_BIZ_PLAN_ITEM_NO
				Group By
					c.COMP_CODE,
					c.CLSE_ACC_ID ,
					b.V_DEPT_CODE,
					c.WORK_YM,
					c.BIZ_PLAN_ITEM_NO
			) s
			On
			(
				s.COMP_CODE = t.COMP_CODE
			And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
			And	s.CHG_SEQ = t.CHG_SEQ
			And	s.DEPT_CODE = t.DEPT_CODE
			And	s.WORK_YM = t.WORK_YM
			And	s.BIZ_PLAN_ITEM_NO = t.BIZ_PLAN_ITEM_NO
			)
			When Matched Then
			Update
			Set	SUM_EXEC_AMT = s.EXEC_AMT,
				EXEC_AMT = s.EXEC_AMT,
				MODDATE = s.CRTDATE,
				MODUSERNO = s.CRTUSERNO
			When Not Matched Then
			Insert
			(COMP_CODE,CLSE_ACC_ID,CHG_SEQ,DEPT_CODE,WORK_YM,BIZ_PLAN_ITEM_NO,CRTUSERNO,CRTDATE,EXEC_AMT,SUM_EXEC_AMT)
			Values
			(s.COMP_CODE,s.CLSE_ACC_ID,s.CHG_SEQ,s.DEPT_CODE,s.WORK_YM,s.BIZ_PLAN_ITEM_NO,s.CRTUSERNO,s.CRTDATE,s.EXEC_AMT,s.EXEC_AMT);
		End If;
		Insert Into T_PL_MONTH_ACC_EXEC_SUM
		(
			COMP_CODE,
			CLSE_ACC_ID,
			WORK_YM,
			BIZ_PLAN_ITEM_NO,
			APPLY_SEQ,
			SLIP_ID,
			SLIP_IDSEQ,
			EXEC_AMT
		)
		Select
			G_COMP_CODE COMP_CODE,
			G_CLSE_ACC_ID CLSE_ACC_ID,
			G_WORK_YM WORK_YM,
			G_BIZ_PLAN_ITEM_NO BIZ_PLAN_ITEM_NO,
			a.APPLY_SEQ APPLY_SEQ,
			b.SLIP_ID SLIP_ID,
			b.SLIP_IDSEQ SLIP_IDSEQ,
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
		From	T_PL_FLOW_ACC_CODE a,
				T_ACC_SLIP_BODY1 b
		Where	a.ACC_CODE = b.ACC_CODE
		And		b.COMP_CODE = G_COMP_CODE
		And		b.MAKE_DT Between lddtf And lddtt
		And		a.SUM_MTHD_TAG = '2'		--전표추적
		And		a.BIZ_PLAN_ITEM_NO = G_BIZ_PLAN_ITEM_NO
		And		b.KEEP_DT Is Not Null
		And		b.TRANSFER_TAG = 'F'
		Union All
		Select
			c.COMP_CODE COMP_CODE,
			G_CLSE_ACC_ID CLSE_ACC_ID,
			G_WORK_YM WORK_YM,
			G_BIZ_PLAN_ITEM_NO BIZ_PLAN_ITEM_NO,
			a.APPLY_SEQ APPLY_SEQ,
			b.SLIP_ID SLIP_ID,
			b.SLIP_IDSEQ SLIP_IDSEQ,
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
		From	T_PL_FLOW_ACC_CODE  a,
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
		And		c.MAKE_DT Between lddtf And lddtt
		And		a.SUM_MTHD_TAG = '3'			--상계전표추적
		And		a.BIZ_PLAN_ITEM_NO = G_BIZ_PLAN_ITEM_NO
		And		c.KEEP_DT Is Not Null
		And		c.TRANSFER_TAG = 'F'
		And		d.TRANSFER_TAG = 'F';
		
		Merge Into T_PL_COMP_PLAN_EXEC t
		Using
		(
			Select
				G_CRTUSERNO CRTUSERNO,
				SysDate CRTDATE,
				b.COMP_CODE COMP_CODE,
				b.CLSE_ACC_ID CLSE_ACC_ID,
				G_CHG_SEQ CHG_SEQ,
				b.WORK_YM WORK_YM,
				b.BIZ_PLAN_ITEM_NO BIZ_PLAN_ITEM_NO,
				Sum(b.EXEC_AMT) EXEC_AMT
			From	T_PL_MONTH_ACC_EXEC_SUM b
			Where	b.COMP_CODE = G_COMP_CODE
			And		b.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		b.WORK_YM = G_WORK_YM
			And		b.BIZ_PLAN_ITEM_NO = G_BIZ_PLAN_ITEM_NO
			Group By
				b.COMP_CODE,
				b.CLSE_ACC_ID,
				b.WORK_YM,
				b.BIZ_PLAN_ITEM_NO
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
		Set	SUM_EXEC_AMT = s.EXEC_AMT,
			EXEC_AMT = s.EXEC_AMT,
			MODDATE = s.CRTDATE,
			MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert
		(COMP_CODE,CLSE_ACC_ID,CHG_SEQ,WORK_YM,BIZ_PLAN_ITEM_NO,CRTUSERNO,CRTDATE,EXEC_AMT,SUM_EXEC_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.CHG_SEQ,s.WORK_YM,s.BIZ_PLAN_ITEM_NO,s.CRTUSERNO,s.CRTDATE,s.EXEC_AMT,s.EXEC_AMT);
	End;
End;
/
