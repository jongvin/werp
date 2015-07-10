--인자 정보
--:CLSE_ACC_ID_NW : 당년도 회기
--:BASE_AMT : 금액 단위 기본은 억단위이므로 1000000000을 넘김
Select
	*
From
(
With Base_Table As
(
	Select
		a.RN,
		a.BIZ_PLAN_ITEM_NAME,
		a.MNG_CODE,
		a.EXEC_AMT_01,
		a.EXEC_AMT_02,
		a.EXEC_AMT_03,
		a.EXEC_AMT_04,
		a.EXEC_AMT_05,
		a.EXEC_AMT_06,
		a.EXEC_AMT_07,
		a.EXEC_AMT_08,
		a.EXEC_AMT_09,
		a.EXEC_AMT_10,
		a.EXEC_AMT_11,
		a.EXEC_AMT_12,
		a.EXEC_AMT_TOT,
		a.PLAN_AMT_01,
		a.PLAN_AMT_02,
		a.PLAN_AMT_03,
		a.PLAN_AMT_04,
		a.PLAN_AMT_05,
		a.PLAN_AMT_06,
		a.PLAN_AMT_07,
		a.PLAN_AMT_08,
		a.PLAN_AMT_09,
		a.PLAN_AMT_10,
		a.PLAN_AMT_11,
		a.PLAN_AMT_12,
		a.PLAN_AMT_TOT,
		100 * a.EXEC_AMT_01 / NullIf(Sum(a.BASE_EXEC_AMT_01) Over (),0) RAT_01,
		100 * a.EXEC_AMT_02 / NullIf(Sum(a.BASE_EXEC_AMT_02) Over (),0) RAT_02,
		100 * a.EXEC_AMT_03 / NullIf(Sum(a.BASE_EXEC_AMT_03) Over (),0) RAT_03,
		100 * a.EXEC_AMT_04 / NullIf(Sum(a.BASE_EXEC_AMT_04) Over (),0) RAT_04,
		100 * a.EXEC_AMT_05 / NullIf(Sum(a.BASE_EXEC_AMT_05) Over (),0) RAT_05,
		100 * a.EXEC_AMT_06 / NullIf(Sum(a.BASE_EXEC_AMT_06) Over (),0) RAT_06,
		100 * a.EXEC_AMT_07 / NullIf(Sum(a.BASE_EXEC_AMT_07) Over (),0) RAT_07,
		100 * a.EXEC_AMT_08 / NullIf(Sum(a.BASE_EXEC_AMT_08) Over (),0) RAT_08,
		100 * a.EXEC_AMT_09 / NullIf(Sum(a.BASE_EXEC_AMT_09) Over (),0) RAT_09,
		100 * a.EXEC_AMT_10 / NullIf(Sum(a.BASE_EXEC_AMT_10) Over (),0) RAT_10,
		100 * a.EXEC_AMT_11 / NullIf(Sum(a.BASE_EXEC_AMT_11) Over (),0) RAT_11,
		100 * a.EXEC_AMT_12 / NullIf(Sum(a.BASE_EXEC_AMT_12) Over (),0) RAT_12,
		100 * a.EXEC_AMT_TOT / NullIf(Sum(a.BASE_EXEC_AMT_TOT) Over (),0) RAT_TOT
	From
		(
			Select
				a.RN,
				a.BIZ_PLAN_ITEM_NAME,
				a.MNG_CODE,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '01' Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_01,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '02' Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_02,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '03' Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_03,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '04' Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_04,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '05' Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_05,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '06' Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_06,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '07' Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_07,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '08' Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_08,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '09' Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_09,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '10' Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_10,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '11' Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_11,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '12' Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_12,
				Sum(b.EXEC_AMT) / :BASE_AMT EXEC_AMT_TOT,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '01' Then b.PLAN_AMT Else Null End ) / :BASE_AMT PLAN_AMT_01,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '02' Then b.PLAN_AMT Else Null End ) / :BASE_AMT PLAN_AMT_02,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '03' Then b.PLAN_AMT Else Null End ) / :BASE_AMT PLAN_AMT_03,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '04' Then b.PLAN_AMT Else Null End ) / :BASE_AMT PLAN_AMT_04,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '05' Then b.PLAN_AMT Else Null End ) / :BASE_AMT PLAN_AMT_05,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '06' Then b.PLAN_AMT Else Null End ) / :BASE_AMT PLAN_AMT_06,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '07' Then b.PLAN_AMT Else Null End ) / :BASE_AMT PLAN_AMT_07,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '08' Then b.PLAN_AMT Else Null End ) / :BASE_AMT PLAN_AMT_08,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '09' Then b.PLAN_AMT Else Null End ) / :BASE_AMT PLAN_AMT_09,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '10' Then b.PLAN_AMT Else Null End ) / :BASE_AMT PLAN_AMT_10,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '11' Then b.PLAN_AMT Else Null End ) / :BASE_AMT PLAN_AMT_11,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '12' Then b.PLAN_AMT Else Null End ) / :BASE_AMT PLAN_AMT_12,
				Sum(b.PLAN_AMT) / :BASE_AMT PLAN_AMT_TOT,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '01' And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_01,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '02' And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_02,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '03' And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_03,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '04' And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_04,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '05' And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_05,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '06' And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_06,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '07' And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_07,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '08' And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_08,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '09' And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_09,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '10' And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_10,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '11' And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_11,
				Sum( Case When b.WORK_YM = :CLSE_ACC_ID_NW || '12' And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_12,
				Sum( Case When a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_TOT
			From
				(
					Select
						a.BIZ_PLAN_ITEM_NO,
						a.BIZ_PLAN_ITEM_NAME,
						a.ITEM_TAG,
						a.LEVEL_TAG,
						a.MNG_CODE,
						RowNum Rn
					From	T_PL_ITEM a
					Where	a.LEVEL_TAG In ('1')
					Start With
						a.P_NO = 0
					Connect By
					Prior	a.BIZ_PLAN_ITEM_NO = a.P_NO
					Order Siblings By
						a.ITEM_LEVEL_SEQ
				) a,
				T_PL_COMP_PLAN_EXEC b
			Where	a.BIZ_PLAN_ITEM_NO = b.BIZ_PLAN_ITEM_NO
			And		b.CLSE_ACC_ID In (:CLSE_ACC_ID_NW)
			And		b.COMP_CODE Like :COMP_CODE || '%'
			Group By
				a.RN,
				a.MNG_CODE,
				a.BIZ_PLAN_ITEM_NAME
		) a
)
Select
	1 MAIN_ORDER,
	'매 출 액' NAME,
	a.EXEC_AMT_01 C_01,
	a.EXEC_AMT_02 C_02,
	a.EXEC_AMT_03 C_03,
	a.EXEC_AMT_04 C_04,
	a.EXEC_AMT_05 C_05,
	a.EXEC_AMT_06 C_06,
	a.EXEC_AMT_07 C_07,
	a.EXEC_AMT_08 C_08,
	a.EXEC_AMT_09 C_09,
	a.EXEC_AMT_10 C_10,
	a.EXEC_AMT_11 C_11,
	a.EXEC_AMT_12 C_12,
	a.EXEC_AMT_TOT C_TOT
From	Base_Table a
Where	a.MNG_CODE = '매출액'
Union All
Select
	2 MAIN_ORDER,
	'원가율(%)' NAME,
	a.RAT_01 C_01,
	a.RAT_02 C_02,
	a.RAT_03 C_03,
	a.RAT_04 C_04,
	a.RAT_05 C_05,
	a.RAT_06 C_06,
	a.RAT_07 C_07,
	a.RAT_08 C_08,
	a.RAT_09 C_09,
	a.RAT_10 C_10,
	a.RAT_11 C_11,
	a.RAT_12 C_12,
	a.RAT_TOT C_TOT
From	Base_Table a
Where	a.MNG_CODE = '매출원가'
Union All
Select
	3 MAIN_ORDER,
	'매출이익' NAME,
	a.EXEC_AMT_01 C_01,
	a.EXEC_AMT_02 C_02,
	a.EXEC_AMT_03 C_03,
	a.EXEC_AMT_04 C_04,
	a.EXEC_AMT_05 C_05,
	a.EXEC_AMT_06 C_06,
	a.EXEC_AMT_07 C_07,
	a.EXEC_AMT_08 C_08,
	a.EXEC_AMT_09 C_09,
	a.EXEC_AMT_10 C_10,
	a.EXEC_AMT_11 C_11,
	a.EXEC_AMT_12 C_12,
	a.EXEC_AMT_TOT C_TOT
From	Base_Table a
Where	a.MNG_CODE = '매출이익'
Union All
Select
	4 MAIN_ORDER,
	'일반관리비율(%)' NAME,
	a.RAT_01 C_01,
	a.RAT_02 C_02,
	a.RAT_03 C_03,
	a.RAT_04 C_04,
	a.RAT_05 C_05,
	a.RAT_06 C_06,
	a.RAT_07 C_07,
	a.RAT_08 C_08,
	a.RAT_09 C_09,
	a.RAT_10 C_10,
	a.RAT_11 C_11,
	a.RAT_12 C_12,
	a.RAT_TOT C_TOT
From	Base_Table a
Where	a.MNG_CODE = '관리판매비'
Union All
Select
	4 MAIN_ORDER,
	'영업외손익(%)' NAME,
	Sum(a.RAT_01) C_01,
	Sum(a.RAT_02) C_02,
	Sum(a.RAT_03) C_03,
	Sum(a.RAT_04) C_04,
	Sum(a.RAT_05) C_05,
	Sum(a.RAT_06) C_06,
	Sum(a.RAT_07) C_07,
	Sum(a.RAT_08) C_08,
	Sum(a.RAT_09) C_09,
	Sum(a.RAT_10) C_10,
	Sum(a.RAT_11) C_11,
	Sum(a.RAT_12) C_12,
	Sum(a.RAT_TOT) C_TOT
From	Base_Table a
Where	a.MNG_CODE in( '영업외수익','영업외비용')
Union All
Select
	5 MAIN_ORDER,
	'경상이익(%)' NAME,
	a.RAT_01 C_01,
	a.RAT_02 C_02,
	a.RAT_03 C_03,
	a.RAT_04 C_04,
	a.RAT_05 C_05,
	a.RAT_06 C_06,
	a.RAT_07 C_07,
	a.RAT_08 C_08,
	a.RAT_09 C_09,
	a.RAT_10 C_10,
	a.RAT_11 C_11,
	a.RAT_12 C_12,
	a.RAT_TOT C_TOT
From	Base_Table a
Where	a.MNG_CODE = '경상이익'
Union All
Select
	6 MAIN_ORDER,
	'세전이익' NAME,
	a.EXEC_AMT_01 C_01,
	a.EXEC_AMT_02 C_02,
	a.EXEC_AMT_03 C_03,
	a.EXEC_AMT_04 C_04,
	a.EXEC_AMT_05 C_05,
	a.EXEC_AMT_06 C_06,
	a.EXEC_AMT_07 C_07,
	a.EXEC_AMT_08 C_08,
	a.EXEC_AMT_09 C_09,
	a.EXEC_AMT_10 C_10,
	a.EXEC_AMT_11 C_11,
	a.EXEC_AMT_12 C_12,
	a.EXEC_AMT_TOT C_TOT
From	Base_Table a
Where	a.MNG_CODE = '세전이익'
)
Order By
	MAIN_ORDER