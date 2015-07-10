Create Or Replace Package PKG_FL_DEPT_FORE
Is
	Function	Get_COMP_CODE
	Return T_FL_MONTH_PLAN_EXEC.COMP_CODE%Type;
	Function	Get_CLSE_ACC_ID
	Return T_FL_MONTH_PLAN_EXEC.CLSE_ACC_ID%Type;
	Function	Get_DEPT_CODE
	Return T_FL_MONTH_PLAN_EXEC.DEPT_CODE%Type;
	Function	Get_FLOW_CODE
	Return T_FL_MONTH_PLAN_EXEC.FLOW_CODE%Type;
	Function	Get_QUARTER_YEAR
	Return Number;
	Function	Get_CRTUSERNO
	Return T_FL_MONTH_PLAN_EXEC.CRTUSERNO%Type;
	Procedure	ProcessBatch
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_DEPT_CODE				T_FL_MONTH_PLAN_EXEC.DEPT_CODE%Type,
		Ar_QUARTER_YEAR				Number,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC.CRTUSERNO%Type
	);
	Procedure	ProcessAutoRecal
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_DEPT_CODE				T_FL_MONTH_PLAN_EXEC.DEPT_CODE%Type,
		Ar_QUARTER_YEAR				Number,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC.CRTUSERNO%Type
	);
	Procedure	SumChild;
	Procedure	CalcCurrentInOut;
	Procedure	CalcSpecialInOut;
	Procedure	CalcItrAmt;
End;
/
Create Or Replace Package Body PKG_FL_DEPT_FORE
Is
	Type	T_FUNCTTIONS	Is Table Of T_FL_DEPT_FORE_FUNCTIONS.FUNC_NAME%Type
		Index By Binary_Integer;
	Type	T_NUMS			Is Table Of Number
		Index By Binary_Integer;
	G_COMP_CODE				T_FL_MONTH_PLAN_EXEC.COMP_CODE%Type;
	G_CLSE_ACC_ID			T_FL_MONTH_PLAN_EXEC.CLSE_ACC_ID%Type;
	G_DEPT_CODE				T_FL_MONTH_PLAN_EXEC.DEPT_CODE%Type;
	G_FLOW_CODE				T_FL_MONTH_PLAN_EXEC.FLOW_CODE%Type;
	G_QUARTER_YEAR			Number;
	G_CRTUSERNO				T_FL_MONTH_PLAN_EXEC.CRTUSERNO%Type;

	G_FUNCTIONS				T_FUNCTTIONS;
	G_CALCITRAMT			Boolean := False;
	Procedure	LoadFunctions
	Is
	Begin
		G_FUNCTIONS.Delete;
		For lrA In (Select DEPT_FOR_FUNC_NO,FUNC_NAME From T_FL_DEPT_FORE_FUNCTIONS) Loop
			G_FUNCTIONS(lrA.DEPT_FOR_FUNC_NO) := lrA.FUNC_NAME;
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
	Return T_FL_MONTH_PLAN_EXEC.COMP_CODE%Type
	Is
	Begin
		Return G_COMP_CODE ;
	End;
	Function	Get_CLSE_ACC_ID
	Return T_FL_MONTH_PLAN_EXEC.CLSE_ACC_ID%Type
	Is
	Begin
		Return G_CLSE_ACC_ID ;
	End;
	Function	Get_DEPT_CODE
	Return T_FL_MONTH_PLAN_EXEC.DEPT_CODE%Type
	Is
	Begin
		Return G_DEPT_CODE ;
	End;
	Function	Get_FLOW_CODE
	Return T_FL_MONTH_PLAN_EXEC.FLOW_CODE%Type
	Is
	Begin
		Return G_FLOW_CODE ;
	End;
	Function	Get_QUARTER_YEAR
	Return Number
	Is
	Begin
		Return G_QUARTER_YEAR ;
	End;
	Function	Get_CRTUSERNO
	Return T_FL_MONTH_PLAN_EXEC.CRTUSERNO%Type
	Is
	Begin
		Return G_CRTUSERNO ;
	End;
	Procedure	SetCalcInfo
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_DEPT_CODE				T_FL_MONTH_PLAN_EXEC.DEPT_CODE%Type,
		Ar_QUARTER_YEAR				Number,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC.CRTUSERNO%Type
	)
	Is
	Begin
		G_COMP_CODE := Ar_COMP_CODE;
		G_CLSE_ACC_ID := Ar_CLSE_ACC_ID;
		G_DEPT_CODE := Ar_DEPT_CODE;
		G_QUARTER_YEAR := Ar_QUARTER_YEAR;
		G_CRTUSERNO := Ar_CRTUSERNO;
	End;
	Procedure	ClearData
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_DEPT_CODE				T_FL_MONTH_PLAN_EXEC.DEPT_CODE%Type,
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
		Update	T_FL_MONTH_PLAN_EXEC
		Set		SUM_FORECAST_AMT = 0,
				FORECAST_AMT = MOD_FORECAST_AMT
		Where	COMP_CODE = Ar_COMP_CODE
		And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
		And		DEPT_CODE = Ar_DEPT_CODE
		And		WORK_YM Between lsBegin And lsEnd;
	End;
	Procedure	ProcessBatch
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_DEPT_CODE				T_FL_MONTH_PLAN_EXEC.DEPT_CODE%Type,
		Ar_QUARTER_YEAR				Number,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC.CRTUSERNO%Type
	)
	Is
		ltFlowCode					T_NUMS;
		ltFuncNo					T_NUMS;
		liFirst						Number;
		liLast						Number;
		lsFuncName					T_FL_DEPT_FORE_FUNCTIONS.FUNC_NAME%Type;
		lnFuncNo					Number;
	Begin
		LoadFunctions;
		SetCalcInfo(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_QUARTER_YEAR,Ar_CRTUSERNO);
		ClearData(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_QUARTER_YEAR);
		
		Select
			a.FLOW_CODE ,
			a.DEPT_FOR_FUNC_NO
		Bulk Collect Into
			ltFlowCode,
			ltFuncNo
		From
			(
				Select
					a.FLOW_CODE ,
					a.DEPT_FOR_FUNC_NO,
					LEVEL LV,
					RowNum rn
				From	T_FL_FLOW_CODE a
				Start With	a.P_NO = 0
				Connect By
					Prior	a.FLOW_CODE = a.P_NO
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
					G_FLOW_CODE := ltFlowCode(liI);
					lsFuncName := GetFunction(lnFuncNo);
					Execute Immediate lsFuncName;
				End If;
			End Loop;
		End If;
	End;
	Procedure	ProcessAutoRecal
	(
		Ar_COMP_CODE				T_FL_MONTH_PLAN_EXEC.COMP_CODE%Type,
		Ar_CLSE_ACC_ID				T_FL_MONTH_PLAN_EXEC.CLSE_ACC_ID%Type,
		Ar_DEPT_CODE				T_FL_MONTH_PLAN_EXEC.DEPT_CODE%Type,
		Ar_QUARTER_YEAR				Number,
		Ar_CRTUSERNO				T_FL_MONTH_PLAN_EXEC.CRTUSERNO%Type
	)
	Is
		ltFlowCode					T_NUMS;
		ltFuncNo					T_NUMS;
		liFirst						Number;
		liLast						Number;
		lsFuncName					T_FL_DEPT_FORE_FUNCTIONS.FUNC_NAME%Type;
		lnFuncNo					Number;
	Begin
		LoadFunctions;
		SetCalcInfo(Ar_COMP_CODE,Ar_CLSE_ACC_ID,Ar_DEPT_CODE,Ar_QUARTER_YEAR,Ar_CRTUSERNO);
		
		Select
			a.FLOW_CODE ,
			a.DEPT_FOR_FUNC_NO
		Bulk Collect Into
			ltFlowCode,
			ltFuncNo
		From
			(
				Select
					a.FLOW_CODE ,
					a.DEPT_FOR_FUNC_NO,
					LEVEL LV,
					RowNum rn
				From	T_FL_FLOW_CODE a
				Where	a.DEPT_FOR_FUNC_NO In
				(
					Select
						b.DEPT_FOR_FUNC_NO
					From	T_FL_DEPT_FORE_FUNCTIONS b
					Where	b.AUTO_RECALCC_TAG = 'T'
				)
				Start With	a.P_NO = 0
				Connect By
					Prior	a.FLOW_CODE = a.P_NO
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
					G_FLOW_CODE := ltFlowCode(liI);
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
		Merge Into T_FL_MONTH_PLAN_EXEC t
		Using
		(
			Select
				a.COMP_CODE ,
				a.CLSE_ACC_ID ,
				a.DEPT_CODE ,
				a.WORK_YM,
				G_FLOW_CODE FLOW_CODE,
				Sum(a.SUM_FORECAST_AMT) SUM_FORECAST_AMT,
				Sum(a.MOD_FORECAST_AMT) MOD_FORECAST_AMT,
				Sum(a.FORECAST_AMT) FORECAST_AMT,
				SysDate CRTDATE,
				G_CRTUSERNO CRTUSERNO
			From	T_FL_MONTH_PLAN_EXEC a,
					T_FL_FLOW_CODE b
			Where	a.FLOW_CODE = b.FLOW_CODE
			And		b.P_NO = G_FLOW_CODE
			And		a.COMP_CODE = G_COMP_CODE
			And		a.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		a.DEPT_CODE = G_DEPT_CODE
			And		a.WORK_YM Between lsBegin And lsEnd
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
		And	s.FLOW_CODE = t.FLOW_CODE
		)
		When Matched Then
		Update
		Set		t.SUM_FORECAST_AMT = s.SUM_FORECAST_AMT,
				t.MOD_FORECAST_AMT = s.MOD_FORECAST_AMT,
				t.FORECAST_AMT = s.FORECAST_AMT,
				t.MODDATE = s.CRTDATE,
				t.MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert
		(COMP_CODE,CLSE_ACC_ID,DEPT_CODE,WORK_YM,FLOW_CODE,CRTDATE,CRTUSERNO,SUM_FORECAST_AMT,MOD_FORECAST_AMT,FORECAST_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.DEPT_CODE,s.WORK_YM,s.FLOW_CODE,s.CRTDATE,s.CRTUSERNO,s.SUM_FORECAST_AMT,s.MOD_FORECAST_AMT,s.FORECAST_AMT);
	End;
	Procedure	CalcCurrentInOut
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
		Merge Into T_FL_MONTH_PLAN_EXEC t
		Using
		(
			Select
				b.COMP_CODE  COMP_CODE,
				b.CLSE_ACC_ID CLSE_ACC_ID,
				b.DEPT_CODE DEPT_CODE,
				b.WORK_YM WORK_YM,
				G_FLOW_CODE FLOW_CODE,
				G_CRTUSERNO CRTUSERNO,
				SysDate CRTDATE,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.SUM_FORECAST_AMT
					When '2' Then - b.SUM_FORECAST_AMT
					Else 0
				End) SUM_FORECAST_AMT,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.MOD_FORECAST_AMT
					When '2' Then - b.MOD_FORECAST_AMT
					Else 0
				End) MOD_FORECAST_AMT,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.FORECAST_AMT
					When '2' Then - b.FORECAST_AMT
					Else 0
				End) FORECAST_AMT
			From	T_FL_MONTH_PLAN_EXEC b,
					T_FL_FLOW_CODE a
			Where	a.FLOW_CODE = b.FLOW_CODE
			And		a.IS_LEAF_TAG = 'T'
			And		a.FLOW_ITEM_KIND In ('1','2')
			And		b.COMP_CODE = G_COMP_CODE
			And		b.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		b.DEPT_CODE = G_DEPT_CODE
			And		b.WORK_YM Between lsBegin And lsEnd
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
		And	s.FLOW_CODE = t.FLOW_CODE
		)
		When Matched Then
		Update
		Set		SUM_FORECAST_AMT = s.SUM_FORECAST_AMT,
				MOD_FORECAST_AMT = s.MOD_FORECAST_AMT,
				FORECAST_AMT = s.FORECAST_AMT,
				MODDATE = s.CRTDATE,
				MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert 
		(COMP_CODE,CLSE_ACC_ID,DEPT_CODE,WORK_YM,FLOW_CODE,CRTUSERNO,CRTDATE,SUM_FORECAST_AMT,MOD_FORECAST_AMT,FORECAST_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.DEPT_CODE,s.WORK_YM,s.FLOW_CODE,s.CRTUSERNO,s.CRTDATE,s.SUM_FORECAST_AMT,s.MOD_FORECAST_AMT,s.FORECAST_AMT);
	End;
	Procedure	CalcSpecialInOut
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
		Merge Into T_FL_MONTH_PLAN_EXEC t
		Using
		(
			Select
				b.COMP_CODE  COMP_CODE,
				b.CLSE_ACC_ID CLSE_ACC_ID,
				b.DEPT_CODE DEPT_CODE,
				b.WORK_YM WORK_YM,
				G_FLOW_CODE FLOW_CODE,
				G_CRTUSERNO CRTUSERNO,
				SysDate CRTDATE,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.SUM_FORECAST_AMT
					When '4' Then b.SUM_FORECAST_AMT
					When '2' Then - b.SUM_FORECAST_AMT
					When '5' Then - b.SUM_FORECAST_AMT
					Else 0
				End) SUM_FORECAST_AMT,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.MOD_FORECAST_AMT
					When '4' Then b.MOD_FORECAST_AMT
					When '2' Then - b.MOD_FORECAST_AMT
					When '5' Then - b.MOD_FORECAST_AMT
					Else 0
				End) MOD_FORECAST_AMT,
				Sum(Case a.FLOW_ITEM_KIND
					When '1' Then b.FORECAST_AMT
					When '4' Then b.FORECAST_AMT
					When '2' Then - b.FORECAST_AMT
					When '5' Then - b.FORECAST_AMT
					Else 0
				End) FORECAST_AMT
			From	T_FL_MONTH_PLAN_EXEC b,
					T_FL_FLOW_CODE a
			Where	a.FLOW_CODE = b.FLOW_CODE
			And		a.IS_LEAF_TAG = 'T'
			And		a.FLOW_ITEM_KIND In ('1','2','4','5')
			And		b.COMP_CODE = G_COMP_CODE
			And		b.CLSE_ACC_ID = G_CLSE_ACC_ID
			And		b.DEPT_CODE = G_DEPT_CODE
			And		b.WORK_YM Between lsBegin And lsEnd
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
		And	s.FLOW_CODE = t.FLOW_CODE
		)
		When Matched Then
		Update
		Set		SUM_FORECAST_AMT = s.SUM_FORECAST_AMT,
				MOD_FORECAST_AMT = s.MOD_FORECAST_AMT,
				FORECAST_AMT = s.FORECAST_AMT,
				MODDATE = s.CRTDATE,
				MODUSERNO = s.CRTUSERNO
		When Not Matched Then
		Insert 
		(COMP_CODE,CLSE_ACC_ID,DEPT_CODE,WORK_YM,FLOW_CODE,CRTUSERNO,CRTDATE,SUM_FORECAST_AMT,MOD_FORECAST_AMT,FORECAST_AMT)
		Values
		(s.COMP_CODE,s.CLSE_ACC_ID,s.DEPT_CODE,s.WORK_YM,s.FLOW_CODE,s.CRTUSERNO,s.CRTDATE,s.SUM_FORECAST_AMT,s.MOD_FORECAST_AMT,s.FORECAST_AMT);
	End;
	Procedure	CalcItrAmt
	Is
		lsWorkYm				Varchar2(10);
		lsWorkStart				Varchar2(10);
		lnPreInOutAmt			Number;
		lnNowInOutAmt			Number;
		lnR1In					Number;
		lnR1Out					Number;
		lnR2In					Number;
		lnR2Out					Number;
		lnInItrAmt				Number;
		lnOutItrAmt				Number;
	Begin
		If G_CALCITRAMT Then
			Return;
		End If;
		lsWorkStart := G_CLSE_ACC_ID || To_Char(G_QUARTER_YEAR * 4 - 3 ,'FM00');
		For liI In 1..3 Loop
			lsWorkYm := G_CLSE_ACC_ID || To_Char(G_QUARTER_YEAR * 4 - 4 + liI,'FM00');
			Select
				Nvl(Sum(Case
					When a.WORK_YM < lsWorkStart And b.FLOW_ITEM_KIND In ('1','4') Then
						a.EXEC_AMT
					When a.WORK_YM >= lsWorkStart And a.WORK_YM < lsWorkYm And b.FLOW_ITEM_KIND In ('1','4') Then
						a.FORECAST_AMT
					When a.WORK_YM < lsWorkStart And b.FLOW_ITEM_KIND In ('2','5') Then
						- a.EXEC_AMT
					When a.WORK_YM >= lsWorkStart And a.WORK_YM < lsWorkYm And b.FLOW_ITEM_KIND In ('2','5') Then
						- a.FORECAST_AMT
					Else
						0
				End),0) PRE_IN_OUT_AMT,
				Nvl(Sum(Case
					When a.WORK_YM = lsWorkYm And b.FLOW_ITEM_KIND In ('1','4') And Nvl(b.MNG_CODE,'X') Not In ('수입이자복사','지급이자복사') Then
						a.FORECAST_AMT
					When a.WORK_YM = lsWorkYm And b.FLOW_ITEM_KIND In ('2','5') And Nvl(b.MNG_CODE,'X') Not In ('수입이자복사','지급이자복사') Then
						- a.FORECAST_AMT
					Else
						0
				End),0) IN_OUT_AMT
			Into
				lnPreInOutAmt,
				lnNowInOutAmt
			from	T_FL_MONTH_PLAN_EXEC a,
					T_FL_FLOW_CODE b
			Where	a.DEPT_CODE = G_DEPT_CODE
			And		a.COMP_CODE = G_COMP_CODE
			And		a.FLOW_CODE = b.FLOW_CODE
			And		b.FLOW_ITEM_KIND In ('1','2','4','5')
			And		a.WORK_YM <= lsWorkYm
			And		b.IS_LEAF_TAG = 'T';
			Begin
				Select
					ITR_RATIO_IN,
					ITR_RATIO_OUT
				Into
					lnR1In,
					lnR1Out
				From	T_FL_ITR_INFO
				Where	To_Date(lsWorkYm||'01','YYYYMMDD') - 1 Between ITR_DATE_F And ITR_DATE_TO;
			Exception When No_Data_Found Then
				Raise_Application_Error(-20009,'이자율 정보가 설정되어 있지 않습니다.');
			End;
			Begin
				Select
					ITR_RATIO_IN,
					ITR_RATIO_OUT
				Into
					lnR2In,
					lnR2Out
				From	T_FL_ITR_INFO
				Where	Last_Day(To_Date(lsWorkYm||'01','YYYYMMDD')) Between ITR_DATE_F And ITR_DATE_TO;
			Exception When No_Data_Found Then
				Raise_Application_Error(-20009,'이자율 정보가 설정되어 있지 않습니다.');
			End;
			If lnPreInOutAmt >= 0 Then	--월초 잔액이 양수이면
				lnR1In := lnR1In / 100 /12;
				lnR1Out := 0;
			Else
				lnR1In := 0;
				lnR1Out := lnR1Out / 100 /12;
			End If;
			If lnNowInOutAmt >= 0 Then	--당월 수지가 양수이면
				lnR2In := lnR2In / 100 /12 / 2;		--/2가 붙는 이유는 당월은 평잔이므로...
				lnR2Out := 0;
			Else
				lnR2In := 0;
				lnR2Out := lnR2Out / 100 /12 / 2;
			End If;
			/*
			수입금의 반복계산 산식
			r1 := 수입이자 / 100 / 12 ; --> 월 이자율
			r2 := 수입이자 / 100 / 2 /12 ;-->월 평균잔액에 대한 이자율
			k := 월초 수지 잔액
			a1 := 당월 순수 자금수지차
			n번 순환한 결과를 다음과 같다고 하면
			an := kr1 + (am - k)r2 + a1     단 am = an-1(즉 이전에 계산된 순환결과
			가 되고 이를 연속 전개하면
			an = (kr1 - kr2 + ar2)(1+r+r^2+r^3....r^(n-1)) + a1 이 되고
			이는 등비수열의 합 공식에 의해
			an = (kr1 - kr2 + ar2) / (1-r2) + a1 이 되며
			이중에서 이자부분은 최초 원금 a1을 뺀 부분이므로
			(kr1 - kr2 + ar2) / (1-r2) 이 된다.
			*/
			lnInItrAmt := (lnPreInOutAmt * lnR1In - lnPreInOutAmt * lnR2In + (lnPreInOutAmt + lnNowInOutAmt) * lnR2In ) / (1-lnR2In);	--등비수열의 합을 이용함
			lnOutItrAmt := - (lnPreInOutAmt * lnR1Out - lnPreInOutAmt * lnR2Out + (lnPreInOutAmt + lnNowInOutAmt) * lnR2Out + lnInItrAmt ) / (1-lnR2Out) + lnInItrAmt ;	--등비수열의 합을 이용함
/*
			pkg_t_debug.PrintMessages('CalcItrAmt','lsWorkYm');
			pkg_t_debug.PrintMessages('CalcItrAmt',lsWorkYm);
			pkg_t_debug.PrintMessages('CalcItrAmt','lnPreInOutAmt');
			pkg_t_debug.PrintMessages('CalcItrAmt',lnPreInOutAmt);
			pkg_t_debug.PrintMessages('CalcItrAmt','lnNowInOutAmt');
			pkg_t_debug.PrintMessages('CalcItrAmt',lnNowInOutAmt);
			pkg_t_debug.PrintMessages('CalcItrAmt','lnR1In');
			pkg_t_debug.PrintMessages('CalcItrAmt',lnR1In);
			pkg_t_debug.PrintMessages('CalcItrAmt','lnR2In');
			pkg_t_debug.PrintMessages('CalcItrAmt',lnR2In);
			pkg_t_debug.PrintMessages('CalcItrAmt','lnInItrAmt');
			pkg_t_debug.PrintMessages('CalcItrAmt',lnInItrAmt);
			pkg_t_debug.PrintMessages('CalcItrAmt','lnR1Out');
			pkg_t_debug.PrintMessages('CalcItrAmt',lnR1Out);
			pkg_t_debug.PrintMessages('CalcItrAmt','lnR2Out');
			pkg_t_debug.PrintMessages('CalcItrAmt',lnR2Out);
			pkg_t_debug.PrintMessages('CalcItrAmt','lnOutItrAmt');
			pkg_t_debug.PrintMessages('CalcItrAmt',lnOutItrAmt);
*/
			Begin
				Insert Into T_FL_MONTH_PLAN_EXEC
				(
					COMP_CODE,CLSE_ACC_ID,DEPT_CODE,WORK_YM,FLOW_CODE,CRTUSERNO,CRTDATE,SUM_FORECAST_AMT,MOD_FORECAST_AMT,FORECAST_AMT
				)
				Values
				(
					G_COMP_CODE,G_CLSE_ACC_ID,G_DEPT_CODE,lsWorkYm,G_FLOW_CODE,G_CRTUSERNO,SysDate,lnInItrAmt - lnOutItrAmt,0,lnInItrAmt - lnOutItrAmt
				);
			Exception When Dup_Val_On_Index Then
				Update	T_FL_MONTH_PLAN_EXEC
					Set	SUM_FORECAST_AMT = lnInItrAmt - lnOutItrAmt,
						FORECAST_AMT = Nvl(MOD_FORECAST_AMT,0) + lnInItrAmt - lnOutItrAmt,
						MODUSERNO = G_CRTUSERNO,
						MODDATE = SysDate
				Where	COMP_CODE = G_COMP_CODE
				And		CLSE_ACC_ID = G_CLSE_ACC_ID
				And		DEPT_CODE = G_DEPT_CODE
				And		WORK_YM = lsWorkYm
				And		FLOW_CODE = G_FLOW_CODE;
			End;
			Merge Into T_FL_MONTH_PLAN_EXEC t
			Using
			(
				Select
					G_COMP_CODE  COMP_CODE,
					G_CLSE_ACC_ID CLSE_ACC_ID,
					G_DEPT_CODE DEPT_CODE,
					lsWorkYm WORK_YM ,
					a.FLOW_CODE FLOW_CODE,
					G_CRTUSERNO CRTUSERNO,
					SysDate CRTDATE,
					lnInItrAmt SUM_FORECAST_AMT,
					0 MOD_FORECAST_AMT,
					lnInItrAmt FORECAST_AMT
				From	T_FL_FLOW_CODE a
				Where	MNG_CODE = '수입이자복사'
			) s
			On
			(
				s.COMP_CODE = t.COMP_CODE
			And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
			And	s.DEPT_CODE = t.DEPT_CODE
			And	s.WORK_YM = t.WORK_YM
			And	s.FLOW_CODE = t.FLOW_CODE
			)
			When Matched Then
			Update
			Set		SUM_FORECAST_AMT = s.SUM_FORECAST_AMT,
					FORECAST_AMT = Nvl(s.SUM_FORECAST_AMT,0) + Nvl(t.MOD_FORECAST_AMT,0) ,
					MODDATE = s.CRTDATE,
					MODUSERNO = s.CRTUSERNO
			When Not Matched Then
			Insert 
			(COMP_CODE,CLSE_ACC_ID,DEPT_CODE,WORK_YM,FLOW_CODE,CRTUSERNO,CRTDATE,SUM_FORECAST_AMT,MOD_FORECAST_AMT,FORECAST_AMT)
			Values
			(s.COMP_CODE,s.CLSE_ACC_ID,s.DEPT_CODE,s.WORK_YM,s.FLOW_CODE,s.CRTUSERNO,s.CRTDATE,s.SUM_FORECAST_AMT,s.MOD_FORECAST_AMT,s.FORECAST_AMT);
			Merge Into T_FL_MONTH_PLAN_EXEC t
			Using
			(
				Select
					G_COMP_CODE  COMP_CODE,
					G_CLSE_ACC_ID CLSE_ACC_ID,
					G_DEPT_CODE DEPT_CODE,
					lsWorkYm WORK_YM ,
					a.FLOW_CODE FLOW_CODE,
					G_CRTUSERNO CRTUSERNO,
					SysDate CRTDATE,
					lnOutItrAmt SUM_FORECAST_AMT,
					0 MOD_FORECAST_AMT,
					lnOutItrAmt FORECAST_AMT
				From	T_FL_FLOW_CODE a
				Where	MNG_CODE = '지급이자복사'
			) s
			On
			(
				s.COMP_CODE = t.COMP_CODE
			And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
			And	s.DEPT_CODE = t.DEPT_CODE
			And	s.WORK_YM = t.WORK_YM
			And	s.FLOW_CODE = t.FLOW_CODE
			)
			When Matched Then
			Update
			Set		SUM_FORECAST_AMT = s.SUM_FORECAST_AMT,
					FORECAST_AMT = Nvl(s.SUM_FORECAST_AMT,0) + Nvl(t.MOD_FORECAST_AMT,0) ,
					MODDATE = s.CRTDATE,
					MODUSERNO = s.CRTUSERNO
			When Not Matched Then
			Insert 
			(COMP_CODE,CLSE_ACC_ID,DEPT_CODE,WORK_YM,FLOW_CODE,CRTUSERNO,CRTDATE,SUM_FORECAST_AMT,MOD_FORECAST_AMT,FORECAST_AMT)
			Values
			(s.COMP_CODE,s.CLSE_ACC_ID,s.DEPT_CODE,s.WORK_YM,s.FLOW_CODE,s.CRTUSERNO,s.CRTDATE,s.SUM_FORECAST_AMT,s.MOD_FORECAST_AMT,s.FORECAST_AMT);
		End Loop;
		Begin
			G_CALCITRAMT := True;
			SP_T_FL_MONTH_FORE_SUM(G_COMP_CODE,G_CLSE_ACC_ID,G_DEPT_CODE,G_QUARTER_YEAR);
		Exception When Others Then
			G_CALCITRAMT := False;
			Raise;
		End;
	End;
End;
/
