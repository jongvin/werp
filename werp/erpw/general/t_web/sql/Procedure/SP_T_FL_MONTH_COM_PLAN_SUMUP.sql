Create Or Replace Procedure SP_T_FL_MONTH_COM_PLAN_SUMUP
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2
)
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
			Sum(b.SUM_PLAN_AMT) SUM_PLAN_AMT ,
			Sum(b.MOD_PLAN_AMT) MOD_PLAN_AMT ,
			Sum(b.B_MOD_PLAN_AMT) B_MOD_PLAN_AMT ,
			Sum(b.PLAN_AMT) PLAN_AMT
		From
			(
				Select
					Ar_COMP_CODE COMP_CODE,
					Ar_CLSE_ACC_ID CLSE_ACC_ID,
					Ar_CLSE_ACC_ID||b.YM WORK_YM,
					a.FLOW_CODE_B,
					a.LEAF_FLOW_CODE
				From
					(	
						Select
							a.FLOW_CODE_B,
							a.P_NO,
							a.IS_LEAF_TAG,
							RowNum RN,
							Level LV,
							First_Value(a.FLOW_CODE_B) Over(Order By  rn Range Lv - 1 Preceding ) LEAF_FLOW_CODE
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
							To_Char(Level ,'fm00') YM
						From	Dual
						Connect By
							Level <= 12
					) b
				Where	a.IS_LEAF_TAG = 'F'
			) a,
			(
				Select
					b.COMP_CODE ,
					b.CLSE_ACC_ID ,
					b.WORK_YM ,
					b.FLOW_CODE_B ,
					b.SUM_PLAN_AMT ,
					b.MOD_PLAN_AMT ,
					b.B_MOD_PLAN_AMT ,
					b.PLAN_AMT
				From	T_FL_MONTH_PLAN_EXEC_B b
				Where	b.COMP_CODE = Ar_COMP_CODE
				And		b.CLSE_ACC_ID = Ar_CLSE_ACC_ID
			) b
		Where	a.COMP_CODE = b.COMP_CODE (+)
		And		a.CLSE_ACC_ID = b.CLSE_ACC_ID (+)
		And		a.WORK_YM = b.WORK_YM (+)
		And		a.LEAF_FLOW_CODE = b.FLOW_CODE_B (+)
		Group By
			a.COMP_CODE,
			a.CLSE_ACC_ID,
			a.WORK_YM,
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
	Set		SUM_PLAN_AMT = s.SUM_PLAN_AMT,
			MOD_PLAN_AMT = s.MOD_PLAN_AMT,
			B_MOD_PLAN_AMT = s.B_MOD_PLAN_AMT,
			PLAN_AMT = s.PLAN_AMT
	When Not Matched Then
	Insert
	(COMP_CODE,CLSE_ACC_ID,WORK_YM,FLOW_CODE_B,SUM_PLAN_AMT,MOD_PLAN_AMT,B_MOD_PLAN_AMT,PLAN_AMT)
	Values
	(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_YM,s.FLOW_CODE_B,s.SUM_PLAN_AMT,s.MOD_PLAN_AMT,s.B_MOD_PLAN_AMT,s.PLAN_AMT);
End;
/
