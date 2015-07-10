Create Or Replace Procedure SP_T_FL_MONTH_EXEC_SUMUP
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2,
	Ar_DEPT_CODE				Varchar2,
	Ar_WORK_YM					T_FL_MONTH_PLAN_EXEC.WORK_YM%Type
)
Is
Begin
	Merge Into T_FL_MONTH_PLAN_EXEC t
	Using
	(
		Select
			a.COMP_CODE,
			a.CLSE_ACC_ID,
			a.DEPT_CODE,
			a.WORK_YM,
			a.FLOW_CODE,
			Sum(b.SUM_EXEC_AMT) SUM_EXEC_AMT,
			Sum(b.MOD_EXEC_AMT) MOD_EXEC_AMT,
			Sum(b.EXEC_AMT) EXEC_AMT
		From
			(
				Select
					Ar_COMP_CODE COMP_CODE,
					Ar_CLSE_ACC_ID CLSE_ACC_ID,
					Ar_DEPT_CODE DEPT_CODE,
					Ar_WORK_YM WORK_YM,
					a.FLOW_CODE,
					a.LEAF_FLOW_CODE
				From
					(
						Select
							a.FLOW_CODE,
							a.P_NO,
							a.IS_LEAF_TAG,
							RowNum RN,
							Level LV,
							First_Value(a.FLOW_CODE) Over(Order By  rn Range Lv - 1 Preceding ) LEAF_FLOW_CODE
						From
							(
								Select
									a.FLOW_CODE,
									a.P_NO,
									a.IS_LEAF_TAG,
									RowNum RN,
									Level LV
								From	T_FL_FLOW_CODE a
								Start With
									a.IS_LEAF_TAG = 'T'
								Connect By
									Prior	a.P_NO = a.FLOW_CODE
							) a
						Order By
							a.RN
					) a
				Where	a.IS_LEAF_TAG = 'F'
			) a,
			(
				Select
					b.COMP_CODE ,
					b.CLSE_ACC_ID ,
					b.DEPT_CODE ,
					b.WORK_YM ,
					b.FLOW_CODE ,
					b.SUM_EXEC_AMT ,
					b.MOD_EXEC_AMT ,
					b.EXEC_AMT 
				From	T_FL_MONTH_PLAN_EXEC b
				Where	COMP_CODE = Ar_COMP_CODE
				And		CLSE_ACC_ID = Ar_CLSE_ACC_ID
				And		DEPT_CODE = Ar_DEPT_CODE
				And		b.WORK_YM = Ar_WORK_YM
			) b
		Where	a.COMP_CODE = b.COMP_CODE (+)
		And		a.CLSE_ACC_ID = b.CLSE_ACC_ID (+)
		And		a.DEPT_CODE = b.DEPT_CODE (+)
		And		a.WORK_YM = b.WORK_YM (+)
		And		a.LEAF_FLOW_CODE = b.FLOW_CODE (+)
		Group By
			a.COMP_CODE,
			a.CLSE_ACC_ID,
			a.DEPT_CODE,
			a.WORK_YM,
			a.FLOW_CODE
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
	Set		SUM_EXEC_AMT = s.SUM_EXEC_AMT,
			MOD_EXEC_AMT = s.MOD_EXEC_AMT,
			EXEC_AMT = s.EXEC_AMT
	When Not Matched Then
	Insert
	(COMP_CODE,CLSE_ACC_ID,DEPT_CODE,WORK_YM,FLOW_CODE,SUM_EXEC_AMT,MOD_EXEC_AMT,EXEC_AMT)
	Values
	(s.COMP_CODE,s.CLSE_ACC_ID,s.DEPT_CODE,s.WORK_YM,s.FLOW_CODE,s.SUM_EXEC_AMT,s.MOD_EXEC_AMT,s.EXEC_AMT);
End;
/
