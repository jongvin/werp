Create Or Replace Package PKG_PL_MA_DEPT_EXEC
Is
	Function	Get_ITEM_NO
	Return T_PL_MA_DEPT_LIST.ITEM_NO%Type;
	Function	Get_WORK_YM
	Return T_PL_MA_DEPT_LIST.WORK_YM%Type;
	Function	Get_CRTUSERNO
	Return T_PL_MA_DEPT_LIST.CRTUSERNO%Type;
	Function	Get_ITEM_NO_W_MNG_CODE
	(
		Ar_MNG_CODE					Varchar2
	)Return Number;
	Procedure	ProcessBatch
	(
		Ar_WORK_YM					T_PL_MA_DEPT_LIST.WORK_YM%Type,
		Ar_CRTUSERNO				T_PL_MA_DEPT_LIST.CRTUSERNO%Type
	);
	Procedure	ProcessAutoRecal
	(
		Ar_WORK_YM					T_PL_MA_DEPT_LIST.WORK_YM%Type,
		Ar_CRTUSERNO				T_PL_MA_DEPT_LIST.CRTUSERNO%Type
	);
	Procedure	SumChild;
	Procedure	SumSlip;
End;
/
Create Or Replace Package Body PKG_PL_MA_DEPT_EXEC
Is
	Type	T_FUNCTTIONS	Is Table Of T_PL_MA_USER_FUNCTIONS.FUNC_NAME%Type
		Index By Binary_Integer;
	Type	T_NUMS			Is Table Of Number
		Index By Binary_Integer;
	Type	T_NAMES			Is Table Of Varchar2(100)
		Index By Binary_Integer;
	G_ITEM_NO				T_PL_MA_DEPT_LIST.ITEM_NO%Type;
	G_WORK_YM				T_PL_MA_DEPT_LIST.WORK_YM%Type;
	G_CRTUSERNO				T_PL_MA_DEPT_LIST.CRTUSERNO%Type;

	G_FUNCTIONS				T_FUNCTTIONS;
	G_CALCITRAMT			Boolean := False;
	Procedure	LoadFunctions
	Is
	Begin
		G_FUNCTIONS.Delete;
		For lrA In (Select FUNC_NO,FUNC_NAME From T_PL_MA_USER_FUNCTIONS) Loop
			G_FUNCTIONS(lrA.FUNC_NO) := lrA.FUNC_NAME;
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
	Function	Get_ITEM_NO
	Return T_PL_MA_DEPT_LIST.ITEM_NO%Type
	Is
	Begin
		Return G_ITEM_NO ;
	End;
	Function	Get_WORK_YM
	Return T_PL_MA_DEPT_LIST.WORK_YM%Type
	Is
	Begin
		Return G_WORK_YM ;
	End;
	Function	Get_CRTUSERNO
	Return T_PL_MA_DEPT_LIST.CRTUSERNO%Type
	Is
	Begin
		Return G_CRTUSERNO ;
	End;
	Function	Get_ITEM_NO_W_MNG_CODE
	(
		Ar_MNG_CODE					Varchar2
	)Return Number
	Is
		ln_Item_No					Number;
	Begin
		Select
			ITEM_NO
		Into
			ln_Item_No
		From	T_PL_MA_ITEM
		Where	MNG_CODE = Ar_MNG_CODE
		And		RowNum < 2;
		Return ln_Item_No;
	Exception When No_Data_Found Then
		Return Null;
	End;
	Procedure	SetCalcInfo
	(
		Ar_WORK_YM					T_PL_MA_DEPT_LIST.WORK_YM%Type,
		Ar_CRTUSERNO				T_PL_MA_DEPT_LIST.CRTUSERNO%Type
	)
	Is
	Begin
		G_CRTUSERNO := Ar_CRTUSERNO;
		G_WORK_YM := Ar_WORK_YM;
	End;
	Procedure	ClearData
	(
		Ar_WORK_YM					T_PL_MA_DEPT_LIST.WORK_YM%Type
	)
	Is
	Begin
		Delete	T_PL_MA_DEPT_LIST
		Where	WORK_YM = Ar_WORK_YM;

		Delete	T_PL_MA_MONTH_DVD
		Where	WORK_YM = Ar_WORK_YM;

		Delete	T_PL_MA_MONTH_SUM
		Where	WORK_YM = Ar_WORK_YM;
	End;
	Procedure	ProcessBatch
	(
		Ar_WORK_YM					T_PL_MA_DEPT_LIST.WORK_YM%Type,
		Ar_CRTUSERNO				T_PL_MA_DEPT_LIST.CRTUSERNO%Type
	)
	Is
		ltItemNo					T_NUMS;
		ltFuncNo					T_NUMS;
		ltNames						T_NAMES;
		liFirst						Number;
		liLast						Number;
		lsFuncName					T_PL_MA_USER_FUNCTIONS.FUNC_NAME%Type;
		lnFuncNo					Number;
		lddtF						Date := To_Date(Ar_WORK_YM||'01','YYYYMMDD');
		lddtT						Date := Last_Day(lddtF);
	Begin
		--Pkg_T_Debug.PrintMessages('PKG_PL_MA_DEPT_EXEC','TimeTrace Start');
		--Pkg_T_Debug.PrintMessages('PKG_PL_MA_DEPT_EXEC',To_Char(SysDate,'HH24:MI:SS'));
		LoadFunctions;
		--Pkg_T_Debug.PrintMessages('PKG_PL_MA_DEPT_EXEC','TimeTrace End Load Function');
		--Pkg_T_Debug.PrintMessages('PKG_PL_MA_DEPT_EXEC',To_Char(SysDate,'HH24:MI:SS'));
		SetCalcInfo(Ar_WORK_YM,Ar_CRTUSERNO);
		--Pkg_T_Debug.PrintMessages('PKG_PL_MA_DEPT_EXEC','TimeTrace End SetCalcInfo');
		--Pkg_T_Debug.PrintMessages('PKG_PL_MA_DEPT_EXEC',To_Char(SysDate,'HH24:MI:SS'));
		ClearData(Ar_WORK_YM);

		--Pkg_T_Debug.PrintMessages('PKG_PL_MA_DEPT_EXEC','TimeTrace 2');
		--Pkg_T_Debug.PrintMessages('PKG_PL_MA_DEPT_EXEC',To_Char(SysDate,'HH24:MI:SS'));
		Select
			a.ITEM_NO ,
			a.FUNC_NO,
			a.BIZ_PLAN_ITEM_NAME
		Bulk Collect Into
			ltItemNo,
			ltFuncNo,
			ltNames
		From
			(
				Select
					a.ITEM_NO ,
					a.FUNC_NO,
					a.BIZ_PLAN_ITEM_NAME,
					LEVEL LV,
					RowNum rn
				From	T_PL_MA_ITEM a
				Start With	a.P_NO = 0
				Connect By
					Prior	a.ITEM_NO = a.P_NO
				Order Siblings By
					a.ITEM_LEVEL_SEQ
			) a
		order by
			a.lv desc,
			a.rn asc;
		If ltItemNo.Count > 0 Then
			liFirst := ltItemNo.First;
			liLast := ltItemNo.Last;
			For liI In liFirst..liLast Loop
				lnFuncNo := ltFuncNo(liI);
				If lnFuncNo Is Not Null Then
					G_ITEM_NO := ltItemNo(liI);
					lsFuncName := GetFunction(lnFuncNo);
		--Pkg_T_Debug.PrintMessages('PKG_PL_MA_DEPT_EXEC',ltNames(liI));
		--Pkg_T_Debug.PrintMessages('PKG_PL_MA_DEPT_EXEC',lsFuncName);
		--Pkg_T_Debug.PrintMessages('PKG_PL_MA_DEPT_EXEC',To_Char(SysDate,'HH24:MI:SS'));
					Execute Immediate lsFuncName;
		--Pkg_T_Debug.PrintMessages('PKG_PL_MA_DEPT_EXEC',lsFuncName||' End');
		--Pkg_T_Debug.PrintMessages('PKG_PL_MA_DEPT_EXEC',To_Char(SysDate,'HH24:MI:SS'));
				End If;
			End Loop;
		End If;
	End;
	Procedure	ProcessAutoRecal
	(
		Ar_WORK_YM					T_PL_MA_DEPT_LIST.WORK_YM%Type,
		Ar_CRTUSERNO				T_PL_MA_DEPT_LIST.CRTUSERNO%Type
	)
	Is
		ltItemNo					T_NUMS;
		ltFuncNo					T_NUMS;
		liFirst						Number;
		liLast						Number;
		lsFuncName					T_PL_MA_USER_FUNCTIONS.FUNC_NAME%Type;
		lnFuncNo					Number;
	Begin
		LoadFunctions;
		SetCalcInfo(Ar_WORK_YM,Ar_CRTUSERNO);

		Select
			a.ITEM_NO ,
			a.FUNC_NO
		Bulk Collect Into
			ltItemNo,
			ltFuncNo
		From
			(
				Select
					a.ITEM_NO ,
					a.FUNC_NO,
					LEVEL LV,
					RowNum rn
				From	T_PL_MA_ITEM a
				Where	a.FUNC_NO In
				(
					Select
						b.FUNC_NO
					From	T_PL_MA_USER_FUNCTIONS b
					Where	b.AUTO_RECALCC_TAG = 'T'
				)
				Start With	a.P_NO = 0
				Connect By
					Prior	a.ITEM_NO = a.P_NO
				Order Siblings By
					a.ITEM_LEVEL_SEQ
			) a
		order by
			a.lv desc,
			a.rn asc;
		If ltItemNo.Count > 0 Then
			liFirst := ltItemNo.First;
			liLast := ltItemNo.Last;
			For liI In liFirst..liLast Loop
				lnFuncNo := ltFuncNo(liI);
				If lnFuncNo Is Not Null Then
					G_ITEM_NO := ltItemNo(liI);
					lsFuncName := GetFunction(lnFuncNo);
					Execute Immediate lsFuncName;
				End If;
			End Loop;
		End If;
	End;
	Procedure	SumChild
	Is
	Begin
		Merge Into T_PL_MA_DEPT_LIST t
		Using
		(
			Select
				a.DEPT_CODE ,
				a.WORK_YM,
				G_ITEM_NO ITEM_NO,
				Sum(a.AMT) AMT,
				SysDate CRTDATE,
				G_CRTUSERNO CRTUSERNO
			From	T_PL_MA_DEPT_LIST a,
					T_PL_MA_ITEM b
			Where	a.ITEM_NO = b.ITEM_NO
			And		b.P_NO = G_ITEM_NO
			And		a.WORK_YM = G_WORK_YM
			Group By
				a.DEPT_CODE ,
				a.WORK_YM
		) s
		On
		(
			s.DEPT_CODE = t.DEPT_CODE
		And	s.WORK_YM = t.WORK_YM
		And	s.ITEM_NO = t.ITEM_NO
		)
		When Matched Then
		Update
		Set		t.AMT = s.AMT,
				t.MODDATE = s.CRTDATE,
				t.MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert
		(DEPT_CODE,WORK_YM,ITEM_NO,CRTDATE,CRTUSERNO,AMT)
		Values
		(s.DEPT_CODE,s.WORK_YM,s.ITEM_NO,s.CRTDATE,s.CRTUSERNO,s.AMT);
	End;
	Procedure	SumSlip
	Is
		lddtf			Date := To_Date(G_WORK_YM||'01','YYYYMMDD');
		lddtt			Date := Last_Day(To_Date(G_WORK_YM||'01','YYYYMMDD'));
		lnHistSeq		Number;
	Begin
		Begin
			Select
				HIST_SEQ
			Into
				lnHistSeq
			From	T_PL_MA_WORK_M
			Where	WORK_YM = G_WORK_YM;
		Exception When No_Data_Found Then
			Raise_Application_Error(-20009,'작업정보를 찾을 수 없습니다.');
		End;
		If lnHistSeq Is Null Then
			Raise_Application_Error(-20009,'작업정보에 적용 배부율 차수를 등록하십시오.');
		End If;
		--1. 먼저 원가집적 대상으로 원가를 집적한다.
		Insert Into T_PL_MA_MONTH_SUM
		(
			WORK_YM,
			ITEM_NO,
			APPLY_SEQ,
			SLIP_ID,
			SLIP_IDSEQ,
			CRTUSERNO,
			CRTDATE,
			DEPT_CODE,
			SUM_TAR_CODE,
			DB_AMT,
			CR_AMT,
			APPL_AMT
		)
		Select
			G_WORK_YM WORK_YM,
			a.ITEM_NO,
			a.APPLY_SEQ,
			b.SLIP_ID,
			b.SLIP_IDSEQ,
			G_CRTUSERNO,
			SysDate,
			b.DEPT_CODE,
			a.SUM_TAR_CODE,
			b.DB_AMT ,
			b.CR_AMT,
			Case
				When a.SLIP_SUM_MTHD_TAG = '1' Then		--차변합
					b.DB_AMT
				When a.SLIP_SUM_MTHD_TAG = '2' Then		--대변합
					b.CR_AMT
				When a.SLIP_SUM_MTHD_TAG = '3' Then		--차변 - 대변
					Nvl(b.DB_AMT,0) - Nvl(b.CR_AMT,0)
				When a.SLIP_SUM_MTHD_TAG = '4' Then		--대변 - 차변
					Nvl(b.CR_AMT,0) - Nvl(b.DB_AMT,0)
				Else
					0
			End * Decode(a.SIGN_TAG,'P',1,-1) APPL_AMT
		From	T_PL_MA_ITEM_ACC_CODE a,
				T_ACC_SLIP_BODY1 b
		Where	b.MAKE_DT Between lddtf And lddtt
		And		b.ACC_CODE = a.ACC_CODE
		And		a.ITEM_NO = G_ITEM_NO
		And		Exists
		(
			Select
				Null
			From	T_PL_MA_SUM_TAR_DEPT ex
			Where	ex.SUM_TAR_CODE = a.SUM_TAR_CODE
			And		ex.DEPT_CODE = b.DEPT_CODE
		);
		Insert Into T_PL_MA_MONTH_DVD
		(
			DEPT_CODE,
			WORK_YM,
			ITEM_NO,
			APPLY_SEQ,
			CRTUSERNO,
			CRTDATE,
			DVD_AMT,
			DVD_RAT_POSITION,
			DVD_RAT_BASE,
			SUM_AMT,
			SUM_TAR_CODE
		)
		--배부하지않는 직접원가는 바로 집계한다.
		Select
			b.DEPT_CODE,
			b.WORK_YM,
			b.ITEM_NO,
			b.APPLY_SEQ,
			G_CRTUSERNO,
			SysDate,
			Sum(b.APPL_AMT) DVD_AMT,
			100 DVD_RAT_POSITION,
			100 DVD_RAT_BASE,
			Sum(b.APPL_AMT) SUM_AMT,
			a.SUM_TAR_CODE
		From	T_PL_MA_ITEM_ACC_CODE a,
				T_PL_MA_MONTH_SUM b
		Where	a.DVD_TAG = 'F'
		And		b.WORK_YM = G_WORK_YM
		And		a.ITEM_NO = G_ITEM_NO
		And		a.ITEM_NO = b.ITEM_NO
		And		a.APPLY_SEQ = b.APPLY_SEQ
		Group By
			b.DEPT_CODE,
			b.WORK_YM,
			b.ITEM_NO,
			b.APPLY_SEQ,
			a.SUM_TAR_CODE
		Union All
		--배부율에 따라서 배부한다.
		Select
			a.DEPT_CODE,
			b.WORK_YM,
			b.ITEM_NO,
			b.APPLY_SEQ,
			G_CRTUSERNO,
			SysDate,
			Nvl(a.DVD_RAT_POSITION,0) * Nvl(b.SUM_AMT,0) / nullif(a.DVD_RAT_BASE,0) DVD_AMT,
			a.DVD_RAT_POSITION,
			a.DVD_RAT_BASE,
			b.SUM_AMT,
			b.SUM_TAR_CODE
		From
			(
				Select
					b.DVD_TAR_CODE,
					a.DVD_CODE,
					a.DEPT_CODE,
					a.DVD_RAT_POSITION,
					Sum(a.DVD_RAT_POSITION) Over (Partition By b.DVD_TAR_CODE) DVD_RAT_BASE
				From	T_PL_MA_DVD_RAT_LIST a,
						T_PL_MA_DVD_TAR_DEPT b
				Where	a.HIST_SEQ = lnHistSeq
				And		a.DEPT_CODE = b.DEPT_CODE
			) a,
			(
				Select
					sa.WORK_YM ,
					sa.ITEM_NO ,
					sa.APPLY_SEQ,
					sb.SUM_TAR_CODE ,
					sb.DVD_TAR_CODE,
					sb.DVD_CODE,
					Sum(sa.APPL_AMT) SUM_AMT
				From	T_PL_MA_MONTH_SUM sa,
						T_PL_MA_ITEM_ACC_CODE sb
				Where	sa.WORK_YM = G_WORK_YM
				And		sa.ITEM_NO = G_ITEM_NO
				And		sa.ITEM_NO = sb.ITEM_NO
				And		sa.APPLY_SEQ = sb.APPLY_SEQ
				Group by
					sa.WORK_YM ,
					sa.ITEM_NO ,
					sb.SUM_TAR_CODE ,
					sb.DVD_CODE,
					sb.DVD_TAR_CODE,
					sa.APPLY_SEQ
			) b
		Where	b.DVD_TAR_CODE = a.DVD_TAR_CODE
		And		b.DVD_CODE = a.DVD_CODE
		And		Nvl(Nvl(a.DVD_RAT_POSITION,0) * Nvl(b.SUM_AMT,0) / nullif(a.DVD_RAT_BASE,0),0) <> 0;
		Insert Into T_PL_MA_DEPT_LIST
		(
			DEPT_CODE,
			WORK_YM,
			ITEM_NO,
			CRTUSERNO,
			CRTDATE,
			AMT
		)
		Select
			DEPT_CODE,
			WORK_YM,
			ITEM_NO,
			G_CRTUSERNO,
			SysDate,
			Sum(DVD_AMT) AMT
		From	T_PL_MA_MONTH_DVD
		Where	WORK_YM = G_WORK_YM
		And		ITEM_NO = G_ITEM_NO
		Group By
			DEPT_CODE,
			WORK_YM,
			ITEM_NO;
	End;
End;
/
