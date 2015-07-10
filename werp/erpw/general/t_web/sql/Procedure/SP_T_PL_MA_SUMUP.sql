Create Or Replace Procedure SP_T_PL_MA_SUMUP
(
	Ar_WORK_YM					T_PL_MA_DEPT_LIST.WORK_YM%Type
)
Is
Begin
	Merge Into T_PL_MA_DEPT_LIST t
	Using
	(
		Select
			a.DEPT_CODE,
			a.WORK_YM,
			a.ITEM_NO,
			Sum(b.AMT) AMT
		From
			(
				Select
					b.DEPT_CODE DEPT_CODE,
					Ar_WORK_YM WORK_YM,
					a.ITEM_NO,
					a.LEAF_ITEM_NO
				From
					(
						Select
							a.ITEM_NO,
							a.P_NO,
							a.IS_LEAF_TAG,
							RowNum RN,
							Level LV,
							First_Value(a.ITEM_NO) Over(Order By  rn Range Lv - 1 Preceding ) LEAF_ITEM_NO
						From
							(
								Select
									a.ITEM_NO,
									a.P_NO,
									a.IS_LEAF_TAG,
									RowNum RN,
									Level LV
								From	T_PL_MA_ITEM a
								Start With
									a.IS_LEAF_TAG = 'T'
								Connect By
									Prior	a.P_NO = a.ITEM_NO
							) a
						Order By
							a.RN
					) a,
					(
						Select
							Distinct
								x.DEPT_CODE
						From	T_PL_MA_DEPT_LIST x
						Where	x.WORK_YM = Ar_WORK_YM
					) b
				Where	a.IS_LEAF_TAG = 'F'
			) a,
			(
				Select
					b.DEPT_CODE ,
					b.WORK_YM ,
					b.ITEM_NO ,
					b.AMT
				From	T_PL_MA_DEPT_LIST b
				Where	b.WORK_YM = Ar_WORK_YM
			) b
		Where	a.DEPT_CODE = b.DEPT_CODE (+)
		And		a.WORK_YM = b.WORK_YM (+)
		And		a.LEAF_ITEM_NO = b.ITEM_NO (+)
		Group By
			a.DEPT_CODE,
			a.WORK_YM,
			a.ITEM_NO
	) s
	On
	(
		s.DEPT_CODE = t.DEPT_CODE
	And	s.WORK_YM = t.WORK_YM
	And	s.ITEM_NO = t.ITEM_NO
	)
	When Matched Then
	Update
	Set		AMT = s.AMT
	When Not Matched Then
	Insert
	(DEPT_CODE,WORK_YM,ITEM_NO,AMT)
	Values
	(s.DEPT_CODE,s.WORK_YM,s.ITEM_NO,s.AMT);
End;
/
