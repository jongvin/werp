Create Or Replace Procedure SP_T_FL_MONTH_FORE_SUMUP_B
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2,
	Ar_DEPT_CODE				Varchar2,
	Ar_QUARTER_YEAR				Number
)
Is
	lsBegin						Varchar2(6);
	lsEnd						Varchar2(6);
	liStart						Number;
Begin
	If Ar_QUARTER_YEAR = 1 Then
		lsBegin := Ar_CLSE_ACC_ID||'01';
		lsEnd := Ar_CLSE_ACC_ID||'03';
		liStart := 0;
	End If;
	If Ar_QUARTER_YEAR = 2 Then
		lsBegin := Ar_CLSE_ACC_ID||'04';
		lsEnd := Ar_CLSE_ACC_ID||'06';
		liStart := 3;
	End If;
	If Ar_QUARTER_YEAR = 3 Then
		lsBegin := Ar_CLSE_ACC_ID||'07';
		lsEnd := Ar_CLSE_ACC_ID||'09';
		liStart := 6;
	End If;
	If Ar_QUARTER_YEAR = 4 Then
		lsBegin := Ar_CLSE_ACC_ID||'10';
		lsEnd := Ar_CLSE_ACC_ID||'12';
		liStart := 9;
	End If;
	Merge Into T_FL_MONTH_PLAN_EXEC_PROJ_B t
	Using
	(
		Select
			a.COMP_CODE,
			a.CLSE_ACC_ID,
			a.DEPT_CODE,
			a.WORK_YM,
			a.FLOW_CODE_B,
			Sum(b.SUM_FORECAST_AMT) SUM_FORECAST_AMT ,
			Sum(b.MOD_FORECAST_AMT) MOD_FORECAST_AMT ,
			Sum(b.FORECAST_AMT) FORECAST_AMT
		From
			(
				Select
					Ar_COMP_CODE COMP_CODE,
					Ar_CLSE_ACC_ID CLSE_ACC_ID,
					Ar_DEPT_CODE DEPT_CODE,
					Ar_CLSE_ACC_ID||b.YM WORK_YM,
					a.FLOW_CODE_B,
					a.LEAF_FLOW_CODE_B
				From
					(
						Select
							a.FLOW_CODE_B,
							a.P_NO,
							a.IS_LEAF_TAG,
							RowNum RN,
							Level LV,
							First_Value(a.FLOW_CODE_B) Over(Order By  rn Range Lv - 1 Preceding ) LEAF_FLOW_CODE_B
						From
							(
								Select
									a.FLOW_CODE_B,
									a.P_NO,
									a.IS_LEAF_TAG,
									RowNum RN,
									Level LV
								From	T_FL_FLOW_CODE_B a
								Start With
									a.IS_LEAF_TAG = 'T'
								Connect By
									Prior	a.P_NO = a.FLOW_CODE_B
							) a
						Order By
							a.RN
					) a,
					(
						Select
							To_Char(Level + liStart ,'fm00') YM
						From	Dual
						Connect By
							Level <= 3
					) b
				Where	a.IS_LEAF_TAG = 'F'
			) a,
			(
				Select
					b.COMP_CODE ,
					b.CLSE_ACC_ID ,
					b.DEPT_CODE ,
					b.WORK_YM ,
					b.FLOW_CODE_B ,
					b.SUM_FORECAST_AMT ,
					b.MOD_FORECAST_AMT ,
					b.FORECAST_AMT
				From	T_FL_MONTH_PLAN_EXEC_PROJ_B b
				Where	COMP_CODE = Ar_COMP_CODE
				And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
				And		DEPT_CODE = Ar_DEPT_CODE
				And		b.WORK_YM Between lsBegin And lsEnd
			) b
		Where	a.COMP_CODE = b.COMP_CODE (+)
		And		a.CLSE_ACC_ID = b.CLSE_ACC_ID (+)
		And		a.DEPT_CODE = b.DEPT_CODE (+)
		And		a.WORK_YM = b.WORK_YM (+)
		And		a.LEAF_FLOW_CODE_B = b.FLOW_CODE_B (+)
		Group By
			a.COMP_CODE,
			a.CLSE_ACC_ID,
			a.DEPT_CODE,
			a.WORK_YM,
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
	Set		SUM_FORECAST_AMT = s.SUM_FORECAST_AMT,
			MOD_FORECAST_AMT = s.MOD_FORECAST_AMT,
			FORECAST_AMT = s.FORECAST_AMT
	When Not Matched Then
	Insert
	(COMP_CODE,CLSE_ACC_ID,DEPT_CODE,WORK_YM,FLOW_CODE_B,SUM_FORECAST_AMT,MOD_FORECAST_AMT,FORECAST_AMT)
	Values
	(s.COMP_CODE,s.CLSE_ACC_ID,s.DEPT_CODE,s.WORK_YM,s.FLOW_CODE_B,s.SUM_FORECAST_AMT,s.MOD_FORECAST_AMT,s.FORECAST_AMT);
End;
/
