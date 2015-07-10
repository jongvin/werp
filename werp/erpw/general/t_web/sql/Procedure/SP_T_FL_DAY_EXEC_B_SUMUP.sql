Create Or Replace Procedure SP_T_FL_DAY_EXEC_B_SUMUP
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2,
	Ar_WORK_DT					Varchar2
)
Is
Begin
	Merge Into T_FL_DAY_EXEC_B t
	Using
	(
		Select
			a.COMP_CODE,
			a.CLSE_ACC_ID,
			a.WORK_DT,
			a.FLOW_CODE_B,
			Sum(b.SUM_EXEC_AMT) SUM_EXEC_AMT,
			Sum(b.MOD_EXEC_AMT) MOD_EXEC_AMT,
			Sum(b.EXEC_AMT) EXEC_AMT
		From
			(
				Select
					Ar_COMP_CODE COMP_CODE,
					Ar_CLSE_ACC_ID CLSE_ACC_ID,
					F_T_STRINGTODATE(Ar_WORK_DT) WORK_DT,
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
					) a
				Where	a.IS_LEAF_TAG = 'F'
			) a,
			(
				Select
					b.COMP_CODE ,
					b.CLSE_ACC_ID ,
					b.WORK_DT ,
					b.FLOW_CODE_B ,
					b.SUM_EXEC_AMT,
					b.MOD_EXEC_AMT,
					b.EXEC_AMT
				From	T_FL_DAY_EXEC_B b
				Where	b.COMP_CODE = Ar_COMP_CODE
				And		b.CLSE_ACC_ID = Ar_CLSE_ACC_ID
				And		b.WORK_DT = F_T_STRINGTODATE(Ar_WORK_DT)
			) b
		Where	a.COMP_CODE = b.COMP_CODE (+)
		And		a.CLSE_ACC_ID = b.CLSE_ACC_ID (+)
		And		a.WORK_DT = b.WORK_DT (+)
		And		a.LEAF_FLOW_CODE = b.FLOW_CODE_B (+)
		Group By
			a.COMP_CODE,
			a.CLSE_ACC_ID,
			a.WORK_DT,
			a.FLOW_CODE_B
	) s
	On
	(
		s.COMP_CODE = t.COMP_CODE
	And	s.CLSE_ACC_ID = t.CLSE_ACC_ID
	And	s.WORK_DT = t.WORK_DT
	And	s.FLOW_CODE_B = t.FLOW_CODE_B
	)
	When Matched Then
	Update
	Set		EXEC_AMT = s.EXEC_AMT,
			MOD_EXEC_AMT = s.MOD_EXEC_AMT,
			SUM_EXEC_AMT = s.SUM_EXEC_AMT
	When Not Matched Then
	Insert
	(COMP_CODE,CLSE_ACC_ID,WORK_DT,FLOW_CODE_B,SUM_EXEC_AMT,MOD_EXEC_AMT,EXEC_AMT)
	Values
	(s.COMP_CODE,s.CLSE_ACC_ID,s.WORK_DT,s.FLOW_CODE_B,s.SUM_EXEC_AMT,s.MOD_EXEC_AMT,s.EXEC_AMT);
End;
/
