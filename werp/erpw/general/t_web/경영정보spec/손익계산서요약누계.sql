--인자 정보
--:CLSE_ACC_ID_NW : 당년도 회기
--:CLSE_ACC_ID_BF : 전년도 회기
--:MM : 월 ex) '01' ==> 1월
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
		Sum( Case When InStr(c.GB1,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_BF And b.WORK_YM <= :CLSE_ACC_ID_BF ||:MM Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_TOT_BF1,
		Sum( Case When InStr(c.GB1,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM <= :CLSE_ACC_ID_NW ||:MM  Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_TOT1,
		Sum( Case When InStr(c.GB1,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM <= :CLSE_ACC_ID_NW ||:MM  Then b.PLAN_AMT Else Null End ) / :BASE_AMT PLAN_AMT_TOT1,
		Sum( Case When InStr(c.GB1,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_BF And b.WORK_YM <= :CLSE_ACC_ID_BF ||:MM  And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_TOT_BF1,
		Sum( Case When InStr(c.GB1,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM <= :CLSE_ACC_ID_NW ||:MM  And a.MNG_CODE = '매출액' Then b.PLAN_AMT Else Null End ) / :BASE_AMT BASE_PLAN_AMT_TOT1,
		Sum( Case When InStr(c.GB1,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM <= :CLSE_ACC_ID_NW ||:MM  And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_TOT1,
		Sum( Case When InStr(c.GB2,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_BF And b.WORK_YM <= :CLSE_ACC_ID_BF ||:MM  Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_TOT_BF2,
		Sum( Case When InStr(c.GB2,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM <= :CLSE_ACC_ID_NW ||:MM  Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_TOT2,
		Sum( Case When InStr(c.GB2,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM <= :CLSE_ACC_ID_NW ||:MM  Then b.PLAN_AMT Else Null End ) / :BASE_AMT PLAN_AMT_TOT2,
		Sum( Case When InStr(c.GB2,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_BF And b.WORK_YM <= :CLSE_ACC_ID_BF ||:MM  And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_TOT_BF2,
		Sum( Case When InStr(c.GB2,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM <= :CLSE_ACC_ID_NW ||:MM  And a.MNG_CODE = '매출액' Then b.PLAN_AMT Else Null End ) / :BASE_AMT BASE_PLAN_AMT_TOT2,
		Sum( Case When InStr(c.GB2,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM <= :CLSE_ACC_ID_NW ||:MM  And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_TOT2,
		Sum( Case When InStr(c.GB3,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_BF And b.WORK_YM <= :CLSE_ACC_ID_BF ||:MM  Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_TOT_BF3,
		Sum( Case When InStr(c.GB3,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM <= :CLSE_ACC_ID_NW ||:MM  Then b.EXEC_AMT Else Null End ) / :BASE_AMT EXEC_AMT_TOT3,
		Sum( Case When InStr(c.GB3,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM <= :CLSE_ACC_ID_NW ||:MM  Then b.PLAN_AMT Else Null End ) / :BASE_AMT PLAN_AMT_TOT3,
		Sum( Case When InStr(c.GB3,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_BF And b.WORK_YM <= :CLSE_ACC_ID_BF ||:MM  And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_TOT_BF3,
		Sum( Case When InStr(c.GB3,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM <= :CLSE_ACC_ID_NW ||:MM  And a.MNG_CODE = '매출액' Then b.PLAN_AMT Else Null End ) / :BASE_AMT BASE_PLAN_AMT_TOT3,
		Sum( Case When InStr(c.GB3,b.COMP_CODE) > 0 And b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM <= :CLSE_ACC_ID_NW ||:MM  And a.MNG_CODE = '매출액' Then b.EXEC_AMT Else Null End ) / :BASE_AMT BASE_EXEC_AMT_TOT3
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
			Start With
				a.P_NO = 0
			Connect By
			Prior	a.BIZ_PLAN_ITEM_NO = a.P_NO
			Order Siblings By
				a.ITEM_LEVEL_SEQ
		) a,
		T_PL_COMP_PLAN_EXEC b,
		(
			Select
				Max(Decode(a.CODE_LIST_ID,'1',a.CODE_LIST_NAME)) GB1,
				Max(Decode(a.CODE_LIST_ID,'2',a.CODE_LIST_NAME)) GB2,
				Max(Decode(a.CODE_LIST_ID,'3',a.CODE_LIST_NAME)) GB3
			From	V_T_CODE_LIST a
			Where	a.CODE_GROUP_ID = '경영사업장구분'
		) c
	Where	a.BIZ_PLAN_ITEM_NO = b.BIZ_PLAN_ITEM_NO
	And		b.CLSE_ACC_ID In (:CLSE_ACC_ID_NW,:CLSE_ACC_ID_BF)
	And		b.COMP_CODE Like :COMP_CODE || '%'
	Group By
		a.RN,
		a.MNG_CODE,
		a.BIZ_PLAN_ITEM_NAME,
		c.GB1,
		c.GB2,
		c.GB3
)
Select
	1 MAIN_ORDER,
	'매출액' NAME,
	Sum(a.EXEC_AMT_TOT_BF1) EXEC_AMT_TOT_BF1,
	Sum(a.PLAN_AMT_TOT1) PLAN_AMT_TOT1,
	Sum(a.EXEC_AMT_TOT1) EXEC_AMT_TOT1,
	100 * Sum(a.EXEC_AMT_TOT1) / NullIf(Sum(a.PLAN_AMT_TOT1),0) PRG_1,
	Sum(a.EXEC_AMT_TOT_BF2) EXEC_AMT_TOT_BF2,
	Sum(a.EXEC_AMT_TOT_BF3) EXEC_AMT_TOT_BF3,
	Sum(a.PLAN_AMT_TOT3) PLAN_AMT_TOT3,
	Sum(a.EXEC_AMT_TOT3) EXEC_AMT_TOT3,
	100 * Sum(a.EXEC_AMT_TOT3) / NullIf(Sum(a.PLAN_AMT_TOT3),0) PRG_3,
	Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0) EXEC_AMT_TOT_BF_ALL,
	Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0) PLAN_AMT_TOT_ALL,
	Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0) EXEC_AMT_TOT_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)),0) PRG_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0))),0) UP_ALL
From	Base_Table a
Where	a.MNG_CODE = '매출액'
Union All
Select
	2 MAIN_ORDER,
	'매출이익' NAME,
	Sum(a.EXEC_AMT_TOT_BF1) EXEC_AMT_TOT_BF1,
	Sum(a.PLAN_AMT_TOT1) PLAN_AMT_TOT1,
	Sum(a.EXEC_AMT_TOT1) EXEC_AMT_TOT1,
	100 * Sum(a.EXEC_AMT_TOT1) / NullIf(Sum(a.PLAN_AMT_TOT1),0) PRG_1,
	Sum(a.EXEC_AMT_TOT_BF2) EXEC_AMT_TOT_BF2,
	Sum(a.EXEC_AMT_TOT_BF3) EXEC_AMT_TOT_BF3,
	Sum(a.PLAN_AMT_TOT3) PLAN_AMT_TOT3,
	Sum(a.EXEC_AMT_TOT3) EXEC_AMT_TOT3,
	100 * Sum(a.EXEC_AMT_TOT3) / NullIf(Sum(a.PLAN_AMT_TOT3),0) PRG_3,
	Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0) EXEC_AMT_TOT_BF_ALL,
	Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0) PLAN_AMT_TOT_ALL,
	Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0) EXEC_AMT_TOT_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)),0) PRG_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0))),0) UP_ALL
From	Base_Table a
Where	a.MNG_CODE = '매출이익'
Union All
Select
	3 MAIN_ORDER,
	'매출이익률' NAME,
	100 * (Sum(a.EXEC_AMT_TOT_BF1)) / NullIf((Sum(a.BASE_EXEC_AMT_TOT_BF1)),0) EXEC_AMT_TOT_BF1,
	100 * (Sum(a.PLAN_AMT_TOT1)) / NullIf((Sum(a.BASE_PLAN_AMT_TOT1) ),0)  PLAN_AMT_TOT1,
	100 * (Sum(a.EXEC_AMT_TOT1)) / NullIf((Sum(a.BASE_EXEC_AMT_TOT1) ),0)  EXEC_AMT_TOT1,
	100 * (100 * Sum(a.EXEC_AMT_TOT1) / NullIf(Sum(a.PLAN_AMT_TOT1),0)) / NullIf((100 * Sum(a.BASE_EXEC_AMT_TOT1) / NullIf(Sum(a.BASE_PLAN_AMT_TOT1),0) ),0)  PRG_1,
	100 * (Sum(a.EXEC_AMT_TOT_BF2)) / NullIf((Sum(a.BASE_EXEC_AMT_TOT_BF2) ),0)  EXEC_AMT_TOT_BF2,
	100 * (Sum(a.EXEC_AMT_TOT_BF3)) / NullIf((Sum(a.BASE_EXEC_AMT_TOT_BF3) ),0)  EXEC_AMT_TOT_BF3,
	100 * (Sum(a.PLAN_AMT_TOT3)) / NullIf((Sum(a.BASE_PLAN_AMT_TOT3) ),0)  PLAN_AMT_TOT3,
	100 * (Sum(a.EXEC_AMT_TOT3)) / NullIf((Sum(a.BASE_EXEC_AMT_TOT3) ),0)  EXEC_AMT_TOT3,
	100 * (100 * Sum(a.EXEC_AMT_TOT3) / NullIf(Sum(a.PLAN_AMT_TOT3),0)) / NullIf((100 * Sum(a.BASE_EXEC_AMT_TOT3) / NullIf(Sum(a.BASE_PLAN_AMT_TOT3),0) ),0)  PRG_3,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0)) / 
				NullIf((Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF3),0) ),0)  EXEC_AMT_TOT_BF_ALL,
	100 * (Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)) / 
				NullIf((Nvl(Sum(a.BASE_PLAN_AMT_TOT1),0) + Nvl(Sum(a.BASE_PLAN_AMT_TOT2),0) + Nvl(Sum(a.BASE_PLAN_AMT_TOT3),0) ),0)  PLAN_AMT_TOT_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / 
				NullIf((Nvl(Sum(a.BASE_EXEC_AMT_TOT1),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT2),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT3),0) ),0)  EXEC_AMT_TOT_ALL,
	100 * (100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)),0)) / 
				NullIf((100 * (Nvl(Sum(a.BASE_EXEC_AMT_TOT1),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT2),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.BASE_PLAN_AMT_TOT1),0) + Nvl(Sum(a.BASE_PLAN_AMT_TOT2),0) + Nvl(Sum(a.BASE_PLAN_AMT_TOT3),0)),0) ),0)  PRG_ALL,
	100 * (100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0))),0)) / 
				NullIf((100 * (Nvl(Sum(a.BASE_EXEC_AMT_TOT1),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT2),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF3),0))),0) ),0)  UP_ALL
From	Base_Table a
Where	a.MNG_CODE = '매출이익'
Union All
Select
	4 MAIN_ORDER,
	'판매관리비' NAME,
	Sum(a.EXEC_AMT_TOT_BF1) EXEC_AMT_TOT_BF1,
	Sum(a.PLAN_AMT_TOT1) PLAN_AMT_TOT1,
	Sum(a.EXEC_AMT_TOT1) EXEC_AMT_TOT1,
	100 * Sum(a.EXEC_AMT_TOT1) / NullIf(Sum(a.PLAN_AMT_TOT1),0) PRG_1,
	Sum(a.EXEC_AMT_TOT_BF2) EXEC_AMT_TOT_BF2,
	Sum(a.EXEC_AMT_TOT_BF3) EXEC_AMT_TOT_BF3,
	Sum(a.PLAN_AMT_TOT3) PLAN_AMT_TOT3,
	Sum(a.EXEC_AMT_TOT3) EXEC_AMT_TOT3,
	100 * Sum(a.EXEC_AMT_TOT3) / NullIf(Sum(a.PLAN_AMT_TOT3),0) PRG_3,
	Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0) EXEC_AMT_TOT_BF_ALL,
	Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0) PLAN_AMT_TOT_ALL,
	Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0) EXEC_AMT_TOT_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)),0) PRG_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0))),0) UP_ALL
From	Base_Table a
Where	a.MNG_CODE = '관리판매비'
Union All
Select
	5 MAIN_ORDER,
	'인건비' NAME,
	Sum(a.EXEC_AMT_TOT_BF1) EXEC_AMT_TOT_BF1,
	Sum(a.PLAN_AMT_TOT1) PLAN_AMT_TOT1,
	Sum(a.EXEC_AMT_TOT1) EXEC_AMT_TOT1,
	100 * Sum(a.EXEC_AMT_TOT1) / NullIf(Sum(a.PLAN_AMT_TOT1),0) PRG_1,
	Sum(a.EXEC_AMT_TOT_BF2) EXEC_AMT_TOT_BF2,
	Sum(a.EXEC_AMT_TOT_BF3) EXEC_AMT_TOT_BF3,
	Sum(a.PLAN_AMT_TOT3) PLAN_AMT_TOT3,
	Sum(a.EXEC_AMT_TOT3) EXEC_AMT_TOT3,
	100 * Sum(a.EXEC_AMT_TOT3) / NullIf(Sum(a.PLAN_AMT_TOT3),0) PRG_3,
	Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0) EXEC_AMT_TOT_BF_ALL,
	Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0) PLAN_AMT_TOT_ALL,
	Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0) EXEC_AMT_TOT_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)),0) PRG_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0))),0) UP_ALL
From	Base_Table a
Where	a.MNG_CODE = '인건비'
Union All
Select
	6 MAIN_ORDER,
	'경  비' NAME,
	Sum(a.EXEC_AMT_TOT_BF1) EXEC_AMT_TOT_BF1,
	Sum(a.PLAN_AMT_TOT1) PLAN_AMT_TOT1,
	Sum(a.EXEC_AMT_TOT1) EXEC_AMT_TOT1,
	100 * Sum(a.EXEC_AMT_TOT1) / NullIf(Sum(a.PLAN_AMT_TOT1),0) PRG_1,
	Sum(a.EXEC_AMT_TOT_BF2) EXEC_AMT_TOT_BF2,
	Sum(a.EXEC_AMT_TOT_BF3) EXEC_AMT_TOT_BF3,
	Sum(a.PLAN_AMT_TOT3) PLAN_AMT_TOT3,
	Sum(a.EXEC_AMT_TOT3) EXEC_AMT_TOT3,
	100 * Sum(a.EXEC_AMT_TOT3) / NullIf(Sum(a.PLAN_AMT_TOT3),0) PRG_3,
	Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0) EXEC_AMT_TOT_BF_ALL,
	Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0) PLAN_AMT_TOT_ALL,
	Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0) EXEC_AMT_TOT_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)),0) PRG_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0))),0) UP_ALL
From	Base_Table a
Where	a.MNG_CODE In ( '광고선전비','감가상각비','지급수수료','기타판관비')
Union All
Select
	6 MAIN_ORDER,
	'(대손상각비)' NAME,
	Sum(a.EXEC_AMT_TOT_BF1) EXEC_AMT_TOT_BF1,
	Sum(a.PLAN_AMT_TOT1) PLAN_AMT_TOT1,
	Sum(a.EXEC_AMT_TOT1) EXEC_AMT_TOT1,
	100 * Sum(a.EXEC_AMT_TOT1) / NullIf(Sum(a.PLAN_AMT_TOT1),0) PRG_1,
	Sum(a.EXEC_AMT_TOT_BF2) EXEC_AMT_TOT_BF2,
	Sum(a.EXEC_AMT_TOT_BF3) EXEC_AMT_TOT_BF3,
	Sum(a.PLAN_AMT_TOT3) PLAN_AMT_TOT3,
	Sum(a.EXEC_AMT_TOT3) EXEC_AMT_TOT3,
	100 * Sum(a.EXEC_AMT_TOT3) / NullIf(Sum(a.PLAN_AMT_TOT3),0) PRG_3,
	Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0) EXEC_AMT_TOT_BF_ALL,
	Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0) PLAN_AMT_TOT_ALL,
	Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0) EXEC_AMT_TOT_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)),0) PRG_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0))),0) UP_ALL
From	Base_Table a
Where	a.MNG_CODE In ( '대손상각비')
Union All
Select
	7 MAIN_ORDER,
	'영업이익' NAME,
	Sum(a.EXEC_AMT_TOT_BF1) EXEC_AMT_TOT_BF1,
	Sum(a.PLAN_AMT_TOT1) PLAN_AMT_TOT1,
	Sum(a.EXEC_AMT_TOT1) EXEC_AMT_TOT1,
	100 * Sum(a.EXEC_AMT_TOT1) / NullIf(Sum(a.PLAN_AMT_TOT1),0) PRG_1,
	Sum(a.EXEC_AMT_TOT_BF2) EXEC_AMT_TOT_BF2,
	Sum(a.EXEC_AMT_TOT_BF3) EXEC_AMT_TOT_BF3,
	Sum(a.PLAN_AMT_TOT3) PLAN_AMT_TOT3,
	Sum(a.EXEC_AMT_TOT3) EXEC_AMT_TOT3,
	100 * Sum(a.EXEC_AMT_TOT3) / NullIf(Sum(a.PLAN_AMT_TOT3),0) PRG_3,
	Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0) EXEC_AMT_TOT_BF_ALL,
	Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0) PLAN_AMT_TOT_ALL,
	Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0) EXEC_AMT_TOT_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)),0) PRG_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0))),0) UP_ALL
From	Base_Table a
Where	a.MNG_CODE In ( '영업이익')
Union All
Select
	8 MAIN_ORDER,
	'영업이익률' NAME,
	100 * (Sum(a.EXEC_AMT_TOT_BF1)) / NullIf((Sum(a.BASE_EXEC_AMT_TOT_BF1)),0) EXEC_AMT_TOT_BF1,
	100 * (Sum(a.PLAN_AMT_TOT1)) / NullIf((Sum(a.BASE_PLAN_AMT_TOT1) ),0)  PLAN_AMT_TOT1,
	100 * (Sum(a.EXEC_AMT_TOT1)) / NullIf((Sum(a.BASE_EXEC_AMT_TOT1) ),0)  EXEC_AMT_TOT1,
	100 * (100 * Sum(a.EXEC_AMT_TOT1) / NullIf(Sum(a.PLAN_AMT_TOT1),0)) / NullIf((100 * Sum(a.BASE_EXEC_AMT_TOT1) / NullIf(Sum(a.BASE_PLAN_AMT_TOT1),0) ),0)  PRG_1,
	100 * (Sum(a.EXEC_AMT_TOT_BF2)) / NullIf((Sum(a.BASE_EXEC_AMT_TOT_BF2) ),0)  EXEC_AMT_TOT_BF2,
	100 * (Sum(a.EXEC_AMT_TOT_BF3)) / NullIf((Sum(a.BASE_EXEC_AMT_TOT_BF3) ),0)  EXEC_AMT_TOT_BF3,
	100 * (Sum(a.PLAN_AMT_TOT3)) / NullIf((Sum(a.BASE_PLAN_AMT_TOT3) ),0)  PLAN_AMT_TOT3,
	100 * (Sum(a.EXEC_AMT_TOT3)) / NullIf((Sum(a.BASE_EXEC_AMT_TOT3) ),0)  EXEC_AMT_TOT3,
	100 * (100 * Sum(a.EXEC_AMT_TOT3) / NullIf(Sum(a.PLAN_AMT_TOT3),0)) / NullIf((100 * Sum(a.BASE_EXEC_AMT_TOT3) / NullIf(Sum(a.BASE_PLAN_AMT_TOT3),0) ),0)  PRG_3,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0)) / 
				NullIf((Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF3),0) ),0)  EXEC_AMT_TOT_BF_ALL,
	100 * (Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)) / 
				NullIf((Nvl(Sum(a.BASE_PLAN_AMT_TOT1),0) + Nvl(Sum(a.BASE_PLAN_AMT_TOT2),0) + Nvl(Sum(a.BASE_PLAN_AMT_TOT3),0) ),0)  PLAN_AMT_TOT_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / 
				NullIf((Nvl(Sum(a.BASE_EXEC_AMT_TOT1),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT2),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT3),0) ),0)  EXEC_AMT_TOT_ALL,
	100 * (100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)),0)) / 
				NullIf((100 * (Nvl(Sum(a.BASE_EXEC_AMT_TOT1),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT2),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.BASE_PLAN_AMT_TOT1),0) + Nvl(Sum(a.BASE_PLAN_AMT_TOT2),0) + Nvl(Sum(a.BASE_PLAN_AMT_TOT3),0)),0) ),0)  PRG_ALL,
	100 * (100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0))),0)) / 
				NullIf((100 * (Nvl(Sum(a.BASE_EXEC_AMT_TOT1),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT2),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF3),0))),0) ),0)  UP_ALL
From	Base_Table a
Where	a.MNG_CODE = '영업이익'
Union All
Select
	9 MAIN_ORDER,
	'영업외수익' NAME,
	Sum(a.EXEC_AMT_TOT_BF1) EXEC_AMT_TOT_BF1,
	Sum(a.PLAN_AMT_TOT1) PLAN_AMT_TOT1,
	Sum(a.EXEC_AMT_TOT1) EXEC_AMT_TOT1,
	100 * Sum(a.EXEC_AMT_TOT1) / NullIf(Sum(a.PLAN_AMT_TOT1),0) PRG_1,
	Sum(a.EXEC_AMT_TOT_BF2) EXEC_AMT_TOT_BF2,
	Sum(a.EXEC_AMT_TOT_BF3) EXEC_AMT_TOT_BF3,
	Sum(a.PLAN_AMT_TOT3) PLAN_AMT_TOT3,
	Sum(a.EXEC_AMT_TOT3) EXEC_AMT_TOT3,
	100 * Sum(a.EXEC_AMT_TOT3) / NullIf(Sum(a.PLAN_AMT_TOT3),0) PRG_3,
	Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0) EXEC_AMT_TOT_BF_ALL,
	Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0) PLAN_AMT_TOT_ALL,
	Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0) EXEC_AMT_TOT_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)),0) PRG_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0))),0) UP_ALL
From	Base_Table a
Where	a.MNG_CODE In ( '영업외수익')
Union All
Select
	10 MAIN_ORDER,
	'이자수익' NAME,
	Sum(a.EXEC_AMT_TOT_BF1) EXEC_AMT_TOT_BF1,
	Sum(a.PLAN_AMT_TOT1) PLAN_AMT_TOT1,
	Sum(a.EXEC_AMT_TOT1) EXEC_AMT_TOT1,
	100 * Sum(a.EXEC_AMT_TOT1) / NullIf(Sum(a.PLAN_AMT_TOT1),0) PRG_1,
	Sum(a.EXEC_AMT_TOT_BF2) EXEC_AMT_TOT_BF2,
	Sum(a.EXEC_AMT_TOT_BF3) EXEC_AMT_TOT_BF3,
	Sum(a.PLAN_AMT_TOT3) PLAN_AMT_TOT3,
	Sum(a.EXEC_AMT_TOT3) EXEC_AMT_TOT3,
	100 * Sum(a.EXEC_AMT_TOT3) / NullIf(Sum(a.PLAN_AMT_TOT3),0) PRG_3,
	Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0) EXEC_AMT_TOT_BF_ALL,
	Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0) PLAN_AMT_TOT_ALL,
	Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0) EXEC_AMT_TOT_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)),0) PRG_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0))),0) UP_ALL
From	Base_Table a
Where	a.MNG_CODE In ( '수입이자')
Union All
Select
	11 MAIN_ORDER,
	'영업외비용' NAME,
	Sum(a.EXEC_AMT_TOT_BF1) EXEC_AMT_TOT_BF1,
	Sum(a.PLAN_AMT_TOT1) PLAN_AMT_TOT1,
	Sum(a.EXEC_AMT_TOT1) EXEC_AMT_TOT1,
	100 * Sum(a.EXEC_AMT_TOT1) / NullIf(Sum(a.PLAN_AMT_TOT1),0) PRG_1,
	Sum(a.EXEC_AMT_TOT_BF2) EXEC_AMT_TOT_BF2,
	Sum(a.EXEC_AMT_TOT_BF3) EXEC_AMT_TOT_BF3,
	Sum(a.PLAN_AMT_TOT3) PLAN_AMT_TOT3,
	Sum(a.EXEC_AMT_TOT3) EXEC_AMT_TOT3,
	100 * Sum(a.EXEC_AMT_TOT3) / NullIf(Sum(a.PLAN_AMT_TOT3),0) PRG_3,
	Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0) EXEC_AMT_TOT_BF_ALL,
	Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0) PLAN_AMT_TOT_ALL,
	Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0) EXEC_AMT_TOT_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)),0) PRG_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0))),0) UP_ALL
From	Base_Table a
Where	a.MNG_CODE In ( '영업외비용')
Union All
Select
	12 MAIN_ORDER,
	'이자비용' NAME,
	Sum(a.EXEC_AMT_TOT_BF1) EXEC_AMT_TOT_BF1,
	Sum(a.PLAN_AMT_TOT1) PLAN_AMT_TOT1,
	Sum(a.EXEC_AMT_TOT1) EXEC_AMT_TOT1,
	100 * Sum(a.EXEC_AMT_TOT1) / NullIf(Sum(a.PLAN_AMT_TOT1),0) PRG_1,
	Sum(a.EXEC_AMT_TOT_BF2) EXEC_AMT_TOT_BF2,
	Sum(a.EXEC_AMT_TOT_BF3) EXEC_AMT_TOT_BF3,
	Sum(a.PLAN_AMT_TOT3) PLAN_AMT_TOT3,
	Sum(a.EXEC_AMT_TOT3) EXEC_AMT_TOT3,
	100 * Sum(a.EXEC_AMT_TOT3) / NullIf(Sum(a.PLAN_AMT_TOT3),0) PRG_3,
	Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0) EXEC_AMT_TOT_BF_ALL,
	Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0) PLAN_AMT_TOT_ALL,
	Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0) EXEC_AMT_TOT_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)),0) PRG_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0))),0) UP_ALL
From	Base_Table a
Where	a.MNG_CODE In ( '지급이자')
Union All
Select
	13 MAIN_ORDER,
	'경상이익' NAME,
	Sum(a.EXEC_AMT_TOT_BF1) EXEC_AMT_TOT_BF1,
	Sum(a.PLAN_AMT_TOT1) PLAN_AMT_TOT1,
	Sum(a.EXEC_AMT_TOT1) EXEC_AMT_TOT1,
	100 * Sum(a.EXEC_AMT_TOT1) / NullIf(Sum(a.PLAN_AMT_TOT1),0) PRG_1,
	Sum(a.EXEC_AMT_TOT_BF2) EXEC_AMT_TOT_BF2,
	Sum(a.EXEC_AMT_TOT_BF3) EXEC_AMT_TOT_BF3,
	Sum(a.PLAN_AMT_TOT3) PLAN_AMT_TOT3,
	Sum(a.EXEC_AMT_TOT3) EXEC_AMT_TOT3,
	100 * Sum(a.EXEC_AMT_TOT3) / NullIf(Sum(a.PLAN_AMT_TOT3),0) PRG_3,
	Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0) EXEC_AMT_TOT_BF_ALL,
	Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0) PLAN_AMT_TOT_ALL,
	Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0) EXEC_AMT_TOT_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)),0) PRG_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0))),0) UP_ALL
From	Base_Table a
Where	a.MNG_CODE In ( '경상이익')
Union All
Select
	14 MAIN_ORDER,
	'세전이익률' NAME,
	100 * (Sum(a.EXEC_AMT_TOT_BF1)) / NullIf((Sum(a.BASE_EXEC_AMT_TOT_BF1)),0) EXEC_AMT_TOT_BF1,
	100 * (Sum(a.PLAN_AMT_TOT1)) / NullIf((Sum(a.BASE_PLAN_AMT_TOT1) ),0)  PLAN_AMT_TOT1,
	100 * (Sum(a.EXEC_AMT_TOT1)) / NullIf((Sum(a.BASE_EXEC_AMT_TOT1) ),0)  EXEC_AMT_TOT1,
	100 * (100 * Sum(a.EXEC_AMT_TOT1) / NullIf(Sum(a.PLAN_AMT_TOT1),0)) / NullIf((100 * Sum(a.BASE_EXEC_AMT_TOT1) / NullIf(Sum(a.BASE_PLAN_AMT_TOT1),0) ),0)  PRG_1,
	100 * (Sum(a.EXEC_AMT_TOT_BF2)) / NullIf((Sum(a.BASE_EXEC_AMT_TOT_BF2) ),0)  EXEC_AMT_TOT_BF2,
	100 * (Sum(a.EXEC_AMT_TOT_BF3)) / NullIf((Sum(a.BASE_EXEC_AMT_TOT_BF3) ),0)  EXEC_AMT_TOT_BF3,
	100 * (Sum(a.PLAN_AMT_TOT3)) / NullIf((Sum(a.BASE_PLAN_AMT_TOT3) ),0)  PLAN_AMT_TOT3,
	100 * (Sum(a.EXEC_AMT_TOT3)) / NullIf((Sum(a.BASE_EXEC_AMT_TOT3) ),0)  EXEC_AMT_TOT3,
	100 * (100 * Sum(a.EXEC_AMT_TOT3) / NullIf(Sum(a.PLAN_AMT_TOT3),0)) / NullIf((100 * Sum(a.BASE_EXEC_AMT_TOT3) / NullIf(Sum(a.BASE_PLAN_AMT_TOT3),0) ),0)  PRG_3,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0)) / 
				NullIf((Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF3),0) ),0)  EXEC_AMT_TOT_BF_ALL,
	100 * (Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)) / 
				NullIf((Nvl(Sum(a.BASE_PLAN_AMT_TOT1),0) + Nvl(Sum(a.BASE_PLAN_AMT_TOT2),0) + Nvl(Sum(a.BASE_PLAN_AMT_TOT3),0) ),0)  PLAN_AMT_TOT_ALL,
	100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / 
				NullIf((Nvl(Sum(a.BASE_EXEC_AMT_TOT1),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT2),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT3),0) ),0)  EXEC_AMT_TOT_ALL,
	100 * (100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.PLAN_AMT_TOT1),0) + Nvl(Sum(a.PLAN_AMT_TOT2),0) + Nvl(Sum(a.PLAN_AMT_TOT3),0)),0)) / 
				NullIf((100 * (Nvl(Sum(a.BASE_EXEC_AMT_TOT1),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT2),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT3),0)) / NullIf((Nvl(Sum(a.BASE_PLAN_AMT_TOT1),0) + Nvl(Sum(a.BASE_PLAN_AMT_TOT2),0) + Nvl(Sum(a.BASE_PLAN_AMT_TOT3),0)),0) ),0)  PRG_ALL,
	100 * (100 * (Nvl(Sum(a.EXEC_AMT_TOT1),0) + Nvl(Sum(a.EXEC_AMT_TOT2),0) + Nvl(Sum(a.EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.EXEC_AMT_TOT_BF3),0))),0)) / 
				NullIf((100 * (Nvl(Sum(a.BASE_EXEC_AMT_TOT1),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT2),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT3),0)) / NullIf((100 * (Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF1),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF2),0) + Nvl(Sum(a.BASE_EXEC_AMT_TOT_BF3),0))),0) ),0)  UP_ALL
From	Base_Table a
Where	a.MNG_CODE = '세전이익'
)
Order By
	MAIN_ORDER
/
