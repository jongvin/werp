Create Or Replace Procedure SP_T_PL_MONTH_COM_PLAN_SUMUP
(
	Ar_COMP_CODE				Varchar2,
	Ar_CLSE_ACC_ID				Varchar2,
	Ar_CHG_SEQ					Number
)
Is
Begin
	Merge Into T_PL_COMP_PLAN_EXEC t
	Using
	(
		Select
			a.COMP_CODE,
			a.CLSE_ACC_ID,
			a.CHG_SEQ,
			a.WORK_YM,
			a.BIZ_PLAN_ITEM_NO,
			Sum(b.SUM_PLAN_AMT) SUM_PLAN_AMT ,
			Sum(b.MOD_PLAN_AMT) MOD_PLAN_AMT ,
			Sum(b.B_MOD_PLAN_AMT) B_MOD_PLAN_AMT ,
			Sum(b.PLAN_AMT) PLAN_AMT
		From
			(
				Select
					Ar_COMP_CODE COMP_CODE,
					Ar_CLSE_ACC_ID CLSE_ACC_ID,
					Ar_CHG_SEQ CHG_SEQ,
					Ar_CLSE_ACC_ID||b.YM WORK_YM,
					a.BIZ_PLAN_ITEM_NO,
					a.LEAF_FLOW_CODE
				From
					(	
						Select
							a.BIZ_PLAN_ITEM_NO,
							a.P_NO,
							a.IS_LEAF_TAG,
							RowNum RN,
							Level LV,
							First_Value(a.BIZ_PLAN_ITEM_NO) Over(Order By  rn Range Lv - 1 Preceding ) LEAF_FLOW_CODE
						From
							(	
								Select
									a.BIZ_PLAN_ITEM_NO,
									a.P_NO,
									a.IS_LEAF_TAG,
									RowNum RN,
									Level LV
								From	T_PL_ITEM a
								Start With 
									a.IS_LEAF_TAG = 'T'
								Connect By
									Prior	a.P_NO = a.BIZ_PLAN_ITEM_NO
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
					b.CHG_SEQ,
					b.WORK_YM ,
					b.BIZ_PLAN_ITEM_NO ,
					b.SUM_PLAN_AMT ,
					b.MOD_PLAN_AMT ,
					b.B_MOD_PLAN_AMT ,
					b.PLAN_AMT
				From	T_PL_COMP_PLAN_EXEC b
				Where	b.COMP_CODE = Ar_COMP_CODE
				And		b.CLSE_ACC_ID = Ar_CLSE_ACC_ID
				And		b.CHG_SEQ = Ar_CHG_SEQ
			) b
		Where	a.COMP_CODE = b.COMP_CODE (+)
		And		a.CLSE_ACC_ID = b.CLSE_ACC_ID (+)
		And		a.CHG_SEQ = b.CHG_SEQ (+)
		And		a.WORK_YM = b.WORK_YM (+)
		And		a.LEAF_FLOW_CODE = b.BIZ_PLAN_ITEM_NO (+)
		Group By
			a.COMP_CODE,
			a.CHG_SEQ,
			a.CLSE_ACC_ID,
			a.WORK_YM,
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
	Set		SUM_PLAN_AMT = s.SUM_PLAN_AMT,
			MOD_PLAN_AMT = s.MOD_PLAN_AMT,
			B_MOD_PLAN_AMT = s.B_MOD_PLAN_AMT,
			PLAN_AMT = s.PLAN_AMT
	When Not Matched Then
	Insert
	(COMP_CODE,CLSE_ACC_ID,CHG_SEQ,WORK_YM,BIZ_PLAN_ITEM_NO,SUM_PLAN_AMT,MOD_PLAN_AMT,B_MOD_PLAN_AMT,PLAN_AMT)
	Values
	(s.COMP_CODE,s.CLSE_ACC_ID,s.CHG_SEQ,s.WORK_YM,s.BIZ_PLAN_ITEM_NO,s.SUM_PLAN_AMT,s.MOD_PLAN_AMT,s.B_MOD_PLAN_AMT,s.PLAN_AMT);
End;
/
