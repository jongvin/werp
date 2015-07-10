--인자 정보
--:CLSE_ACC_ID_BF : 전년도 회기 ==> 당년 회기가 2005이면 2004를 넘김
--:CLSE_ACC_ID_NW : 당년도 회기
--:CLSE_ACC_ID_AF : 후년도 회기 ==> 당년 회기가 2005이면 2006을 넘김
--:START_MM_MIN : 분기시작월 ==>만약 1분기이면 '01' 2분기이면 '04' 3분기이면 '07' 4분기이면 '10'
--:START_MM_MID : 분기시작월 ==>만약 1분기이면 '02' 2분기이면 '05' 3분기이면 '08' 4분기이면 '11'
--:START_MM_MAX : 분기시작월 ==>만약 1분기이면 '03' 2분기이면 '06' 3분기이면 '09' 4분기이면 '12'
--:BASE_AMT : 금액 단위 기본은 백만단위이므로 1000000을 넘김
Select
	a.RN,
	a.SUBRN,
	a.BIZ_PLAN_ITEM_NAME,		--항목명
	a.BF_Y_EXEC_AMT,				--전년실적
	a.BF_Y_BM_EXEC_AMT,			--전년분기전실적
	a.NW_Y_BM_PLAN_AMT,			--당년분기전계획
	a.NW_Y_BM_EXEC_AMT,			--당년분기전실적
	Decode(a.MNG_CODE,'매출액',100 * Nvl(a.NW_Y_BM_EXEC_AMT,0) / NullIf(a.NW_Y_BM_PLAN_AMT,0) ,Nvl(a.NW_Y_BM_EXEC_AMT,0) - Nvl(a.NW_Y_BM_PLAN_AMT,0) ) NW_BM_P_E_SUB ,	--계획비(분기전)
	Decode(a.MNG_CODE,'매출액',100 * Nvl(a.NW_Y_BM_EXEC_AMT,0) / NullIf(a.BF_Y_BM_EXEC_AMT,0) ,Nvl(a.NW_Y_BM_EXEC_AMT,0) - Nvl(a.BF_Y_BM_EXEC_AMT,0) ) NW_BM_B_E_SUM ,	--전년비(분기전)
	a.NW_Y_NM_PLAN_AMT_01,
	a.NW_Y_NM_FOR_AMT_01,
	a.NW_Y_NM_PLAN_AMT_02,
	a.NW_Y_NM_FOR_AMT_02,
	a.NW_Y_NM_PLAN_AMT_03,
	a.NW_Y_NM_FOR_AMT_03,
	a.NW_Y_PLAN_AMT,
	a.NW_Y_FOR_AMT,
	Decode(a.MNG_CODE,'매출액',100 * Nvl(a.NW_Y_FOR_AMT,0) / NullIf(a.NW_Y_PLAN_AMT,0) ,Nvl(a.NW_Y_FOR_AMT,0) - Nvl(a.NW_Y_PLAN_AMT,0) ) NW_P_E_SUB ,	--계획비(당년)
	Decode(a.MNG_CODE,'매출액',100 * Nvl(a.NW_Y_FOR_AMT,0) / NullIf(a.BF_Y_EXEC_AMT,0) ,Nvl(a.NW_Y_FOR_AMT,0) - Nvl(a.BF_Y_EXEC_AMT,0) ) NW_B_E_SUM ,	--전년비(당년)
	a.AF_Y_PLAN_AMT,
	Decode(a.MNG_CODE,'매출액',100 * Nvl(a.AF_Y_PLAN_AMT,0) / NullIf(a.NW_Y_FOR_AMT,0) ,Nvl(a.AF_Y_PLAN_AMT,0) - Nvl(a.NW_Y_FOR_AMT,0) ) AF_P_E_SUM		--전년대비(후년)
From (
		With Base_Table As
		(
		Select
			a.RN,
			a.BIZ_PLAN_ITEM_NAME,
			a.MNG_CODE,
			Sum(
				Case When b.CLSE_ACC_ID = :CLSE_ACC_ID_BF Then
					b.EXEC_AMT
				Else
					Null
				End
			) / :BASE_AMT BF_Y_EXEC_AMT,
			Sum(
				Case When b.WORK_YM >= :CLSE_ACC_ID_BF||'01' And b.WORK_YM < :CLSE_ACC_ID_BF||:START_MM_MIN Then
					b.EXEC_AMT
				Else
					Null
				End
			) / :BASE_AMT BF_Y_BM_EXEC_AMT,
			Sum(
				Case When b.WORK_YM >= :CLSE_ACC_ID_NW||'01' And b.WORK_YM < :CLSE_ACC_ID_NW||:START_MM_MIN Then
					b.PLAN_AMT
				Else
					Null
				End
			) / :BASE_AMT NW_Y_BM_PLAN_AMT,
			Sum(
				Case When b.WORK_YM >= :CLSE_ACC_ID_NW||'01' And b.WORK_YM < :CLSE_ACC_ID_NW||:START_MM_MIN Then
					b.EXEC_AMT
				Else
					Null
				End
			) / :BASE_AMT NW_Y_BM_EXEC_AMT,
			Sum(
				Case When b.WORK_YM = :CLSE_ACC_ID_NW||:START_MM_MIN Then
					b.PLAN_AMT
				Else
					Null
				End
			) / :BASE_AMT NW_Y_NM_PLAN_AMT_01,
			Sum(
				Case When b.WORK_YM = :CLSE_ACC_ID_NW||:START_MM_MIN Then
					b.FORECAST_AMT
				Else
					Null
				End
			) / :BASE_AMT NW_Y_NM_FOR_AMT_01,
			Sum(
				Case When b.WORK_YM = :CLSE_ACC_ID_NW||:START_MM_MID Then
					b.PLAN_AMT
				Else
					Null
				End
			) / :BASE_AMT NW_Y_NM_PLAN_AMT_02,
			Sum(
				Case When b.WORK_YM = :CLSE_ACC_ID_NW||:START_MM_MID Then
					b.FORECAST_AMT
				Else
					Null
				End
			) / :BASE_AMT NW_Y_NM_FOR_AMT_02,
			Sum(
				Case When b.WORK_YM = :CLSE_ACC_ID_NW||:START_MM_MAX Then
					b.PLAN_AMT
				Else
					Null
				End
			) / :BASE_AMT NW_Y_NM_PLAN_AMT_03,
			Sum(
				Case When b.WORK_YM = :CLSE_ACC_ID_NW||:START_MM_MAX Then
					b.FORECAST_AMT
				Else
					Null
				End
			) / :BASE_AMT NW_Y_NM_FOR_AMT_03,
			Sum(
				Case When b.CLSE_ACC_ID = :CLSE_ACC_ID_NW Then
					b.PLAN_AMT
				Else
					Null
				End
			) / :BASE_AMT NW_Y_PLAN_AMT,
			Sum(
				Case
				When b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM < :CLSE_ACC_ID_NW||:START_MM_MID Then		--분기전이면 실적
					b.EXEC_AMT
				When b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM >= :CLSE_ACC_ID_NW||:START_MM_MID And b.WORK_YM <= :CLSE_ACC_ID_NW||:START_MM_MAX Then	--분기내면 전망
					b.FORECAST_AMT
				When b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM > :CLSE_ACC_ID_NW||:START_MM_MAX Then	--분기 이후면 계획금액
					b.PLAN_AMT
				Else
					Null
				End
			) / :BASE_AMT NW_Y_FOR_AMT,
			Sum(
				Case When b.CLSE_ACC_ID = :CLSE_ACC_ID_AF Then
					b.PLAN_AMT
				Else
					Null
				End
			) / :BASE_AMT AF_Y_PLAN_AMT
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
				Where	a.LEVEL_TAG In ('1','2')
				Start With
					a.P_NO = 0
				Connect By
				Prior	a.BIZ_PLAN_ITEM_NO = a.P_NO
				Order Siblings By
					a.ITEM_LEVEL_SEQ
			) a,
			T_PL_COMP_PLAN_EXEC b
		Where	a.BIZ_PLAN_ITEM_NO = b.BIZ_PLAN_ITEM_NO
		And		b.CLSE_ACC_ID In (:CLSE_ACC_ID_BF,:CLSE_ACC_ID_NW,:CLSE_ACC_ID_AF)
		And		b.COMP_CODE Like :COMP_CODE || '%'
		Group By
			a.RN,
			a.MNG_CODE,
			a.BIZ_PLAN_ITEM_NAME
		)
		Select
			a.RN,
			0 SUBRN,
			a.BIZ_PLAN_ITEM_NAME,
			a.MNG_CODE,
			a.BF_Y_EXEC_AMT,
			a.BF_Y_BM_EXEC_AMT,
			a.NW_Y_BM_PLAN_AMT,
			a.NW_Y_BM_EXEC_AMT,
			a.NW_Y_NM_PLAN_AMT_01,
			a.NW_Y_NM_FOR_AMT_01,
			a.NW_Y_NM_PLAN_AMT_02,
			a.NW_Y_NM_FOR_AMT_02,
			a.NW_Y_NM_PLAN_AMT_03,
			a.NW_Y_NM_FOR_AMT_03,
			a.NW_Y_PLAN_AMT,
			a.NW_Y_FOR_AMT,
			a.AF_Y_PLAN_AMT
		From	Base_Table a
		Union All
		Select
			a.RN,
			1 SUBRN,
			'(%)',
			a.MNG_CODE ||'율',
			a.BF_Y_EXEC_AMT / NullIf(b.BF_Y_EXEC_AMT,0 ) * 100 BF_Y_EXEC_AMT,
			a.BF_Y_BM_EXEC_AMT / NullIf(b.BF_Y_BM_EXEC_AMT ,0) * 100 BF_Y_BM_EXEC_AMT ,
			a.NW_Y_BM_PLAN_AMT / NullIf(b.NW_Y_BM_PLAN_AMT ,0) * 100  NW_Y_BM_PLAN_AMT,
			a.NW_Y_BM_EXEC_AMT / NullIf(b.NW_Y_BM_EXEC_AMT ,0) * 100  NW_Y_BM_EXEC_AMT,
			a.NW_Y_NM_PLAN_AMT_01 / NullIf(b.NW_Y_NM_PLAN_AMT_01 ,0) * 100  NW_Y_NM_PLAN_AMT_01,
			a.NW_Y_NM_FOR_AMT_01 / NullIf(b.NW_Y_NM_FOR_AMT_01 ,0) * 100  NW_Y_NM_FOR_AMT_01,
			a.NW_Y_NM_PLAN_AMT_02 / NullIf(b.NW_Y_NM_PLAN_AMT_02 ,0) * 100  NW_Y_NM_PLAN_AMT_02,
			a.NW_Y_NM_FOR_AMT_02 / NullIf(b.NW_Y_NM_FOR_AMT_02 ,0) * 100  NW_Y_NM_FOR_AMT_02,
			a.NW_Y_NM_PLAN_AMT_03 / NullIf(b.NW_Y_NM_PLAN_AMT_03 ,0) * 100  NW_Y_NM_PLAN_AMT_03,
			a.NW_Y_NM_FOR_AMT_03 / NullIf(b.NW_Y_NM_FOR_AMT_03 ,0) * 100  NW_Y_NM_FOR_AMT_03,
			a.NW_Y_PLAN_AMT / NullIf(b.NW_Y_PLAN_AMT ,0) * 100  NW_Y_PLAN_AMT,
			a.NW_Y_FOR_AMT / NullIf(b.NW_Y_FOR_AMT ,0) * 100  NW_Y_FOR_AMT,
			a.AF_Y_PLAN_AMT / NullIf(b.AF_Y_PLAN_AMT ,0) * 100  AF_Y_PLAN_AMT
		From	Base_Table a,
				Base_Table b
		Where	a.MNG_CODE = '매출이익'
		And		b.MNG_CODE = '매출액'
		Union All
		Select
			a.RN,
			1 SUBRN,
			'(%)',
			a.MNG_CODE||'율',
			a.BF_Y_EXEC_AMT / NullIf(b.BF_Y_EXEC_AMT,0 ) * 100 BF_Y_EXEC_AMT,
			a.BF_Y_BM_EXEC_AMT / NullIf(b.BF_Y_BM_EXEC_AMT ,0) * 100 BF_Y_BM_EXEC_AMT ,
			a.NW_Y_BM_PLAN_AMT / NullIf(b.NW_Y_BM_PLAN_AMT ,0) * 100  NW_Y_BM_PLAN_AMT,
			a.NW_Y_BM_EXEC_AMT / NullIf(b.NW_Y_BM_EXEC_AMT ,0) * 100  NW_Y_BM_EXEC_AMT,
			a.NW_Y_NM_PLAN_AMT_01 / NullIf(b.NW_Y_NM_PLAN_AMT_01 ,0) * 100  NW_Y_NM_PLAN_AMT_01,
			a.NW_Y_NM_FOR_AMT_01 / NullIf(b.NW_Y_NM_FOR_AMT_01 ,0) * 100  NW_Y_NM_FOR_AMT_01,
			a.NW_Y_NM_PLAN_AMT_02 / NullIf(b.NW_Y_NM_PLAN_AMT_02 ,0) * 100  NW_Y_NM_PLAN_AMT_02,
			a.NW_Y_NM_FOR_AMT_02 / NullIf(b.NW_Y_NM_FOR_AMT_02 ,0) * 100  NW_Y_NM_FOR_AMT_02,
			a.NW_Y_NM_PLAN_AMT_03 / NullIf(b.NW_Y_NM_PLAN_AMT_03 ,0) * 100  NW_Y_NM_PLAN_AMT_03,
			a.NW_Y_NM_FOR_AMT_03 / NullIf(b.NW_Y_NM_FOR_AMT_03 ,0) * 100  NW_Y_NM_FOR_AMT_03,
			a.NW_Y_PLAN_AMT / NullIf(b.NW_Y_PLAN_AMT ,0) * 100  NW_Y_PLAN_AMT,
			a.NW_Y_FOR_AMT / NullIf(b.NW_Y_FOR_AMT ,0) * 100  NW_Y_FOR_AMT,
			a.AF_Y_PLAN_AMT / NullIf(b.AF_Y_PLAN_AMT ,0) * 100  AF_Y_PLAN_AMT
		From	Base_Table a,
				Base_Table b
		Where	a.MNG_CODE = '관리판매비'
		And		b.MNG_CODE = '매출액'
		Union All
		Select
			a.RN,
			1 SUBRN,
			'(%)',
			a.MNG_CODE||'율',
			a.BF_Y_EXEC_AMT / NullIf(b.BF_Y_EXEC_AMT,0 ) * 100 BF_Y_EXEC_AMT,
			a.BF_Y_BM_EXEC_AMT / NullIf(b.BF_Y_BM_EXEC_AMT ,0) * 100 BF_Y_BM_EXEC_AMT ,
			a.NW_Y_BM_PLAN_AMT / NullIf(b.NW_Y_BM_PLAN_AMT ,0) * 100  NW_Y_BM_PLAN_AMT,
			a.NW_Y_BM_EXEC_AMT / NullIf(b.NW_Y_BM_EXEC_AMT ,0) * 100  NW_Y_BM_EXEC_AMT,
			a.NW_Y_NM_PLAN_AMT_01 / NullIf(b.NW_Y_NM_PLAN_AMT_01 ,0) * 100  NW_Y_NM_PLAN_AMT_01,
			a.NW_Y_NM_FOR_AMT_01 / NullIf(b.NW_Y_NM_FOR_AMT_01 ,0) * 100  NW_Y_NM_FOR_AMT_01,
			a.NW_Y_NM_PLAN_AMT_02 / NullIf(b.NW_Y_NM_PLAN_AMT_02 ,0) * 100  NW_Y_NM_PLAN_AMT_02,
			a.NW_Y_NM_FOR_AMT_02 / NullIf(b.NW_Y_NM_FOR_AMT_02 ,0) * 100  NW_Y_NM_FOR_AMT_02,
			a.NW_Y_NM_PLAN_AMT_03 / NullIf(b.NW_Y_NM_PLAN_AMT_03 ,0) * 100  NW_Y_NM_PLAN_AMT_03,
			a.NW_Y_NM_FOR_AMT_03 / NullIf(b.NW_Y_NM_FOR_AMT_03 ,0) * 100  NW_Y_NM_FOR_AMT_03,
			a.NW_Y_PLAN_AMT / NullIf(b.NW_Y_PLAN_AMT ,0) * 100  NW_Y_PLAN_AMT,
			a.NW_Y_FOR_AMT / NullIf(b.NW_Y_FOR_AMT ,0) * 100  NW_Y_FOR_AMT,
			a.AF_Y_PLAN_AMT / NullIf(b.AF_Y_PLAN_AMT ,0) * 100  AF_Y_PLAN_AMT
		From	Base_Table a,
				Base_Table b
		Where	a.MNG_CODE = '영업이익'
		And		b.MNG_CODE = '매출액'
		Union All
		Select
			a.RN,
			1 SUBRN,
			'(%)',
			a.MNG_CODE||'율',
			a.BF_Y_EXEC_AMT / NullIf(b.BF_Y_EXEC_AMT,0 ) * 100 BF_Y_EXEC_AMT,
			a.BF_Y_BM_EXEC_AMT / NullIf(b.BF_Y_BM_EXEC_AMT ,0) * 100 BF_Y_BM_EXEC_AMT ,
			a.NW_Y_BM_PLAN_AMT / NullIf(b.NW_Y_BM_PLAN_AMT ,0) * 100  NW_Y_BM_PLAN_AMT,
			a.NW_Y_BM_EXEC_AMT / NullIf(b.NW_Y_BM_EXEC_AMT ,0) * 100  NW_Y_BM_EXEC_AMT,
			a.NW_Y_NM_PLAN_AMT_01 / NullIf(b.NW_Y_NM_PLAN_AMT_01 ,0) * 100  NW_Y_NM_PLAN_AMT_01,
			a.NW_Y_NM_FOR_AMT_01 / NullIf(b.NW_Y_NM_FOR_AMT_01 ,0) * 100  NW_Y_NM_FOR_AMT_01,
			a.NW_Y_NM_PLAN_AMT_02 / NullIf(b.NW_Y_NM_PLAN_AMT_02 ,0) * 100  NW_Y_NM_PLAN_AMT_02,
			a.NW_Y_NM_FOR_AMT_02 / NullIf(b.NW_Y_NM_FOR_AMT_02 ,0) * 100  NW_Y_NM_FOR_AMT_02,
			a.NW_Y_NM_PLAN_AMT_03 / NullIf(b.NW_Y_NM_PLAN_AMT_03 ,0) * 100  NW_Y_NM_PLAN_AMT_03,
			a.NW_Y_NM_FOR_AMT_03 / NullIf(b.NW_Y_NM_FOR_AMT_03 ,0) * 100  NW_Y_NM_FOR_AMT_03,
			a.NW_Y_PLAN_AMT / NullIf(b.NW_Y_PLAN_AMT ,0) * 100  NW_Y_PLAN_AMT,
			a.NW_Y_FOR_AMT / NullIf(b.NW_Y_FOR_AMT ,0) * 100  NW_Y_FOR_AMT,
			a.AF_Y_PLAN_AMT / NullIf(b.AF_Y_PLAN_AMT ,0) * 100  AF_Y_PLAN_AMT
		From	Base_Table a,
				Base_Table b
		Where	a.MNG_CODE = '경상이익'
		And		b.MNG_CODE = '매출액'
		Union All
		Select
			a.RN,
			1 SUBRN,
			'(%)',
			a.MNG_CODE||'율',
			a.BF_Y_EXEC_AMT / NullIf(b.BF_Y_EXEC_AMT,0 ) * 100 BF_Y_EXEC_AMT,
			a.BF_Y_BM_EXEC_AMT / NullIf(b.BF_Y_BM_EXEC_AMT ,0) * 100 BF_Y_BM_EXEC_AMT ,
			a.NW_Y_BM_PLAN_AMT / NullIf(b.NW_Y_BM_PLAN_AMT ,0) * 100  NW_Y_BM_PLAN_AMT,
			a.NW_Y_BM_EXEC_AMT / NullIf(b.NW_Y_BM_EXEC_AMT ,0) * 100  NW_Y_BM_EXEC_AMT,
			a.NW_Y_NM_PLAN_AMT_01 / NullIf(b.NW_Y_NM_PLAN_AMT_01 ,0) * 100  NW_Y_NM_PLAN_AMT_01,
			a.NW_Y_NM_FOR_AMT_01 / NullIf(b.NW_Y_NM_FOR_AMT_01 ,0) * 100  NW_Y_NM_FOR_AMT_01,
			a.NW_Y_NM_PLAN_AMT_02 / NullIf(b.NW_Y_NM_PLAN_AMT_02 ,0) * 100  NW_Y_NM_PLAN_AMT_02,
			a.NW_Y_NM_FOR_AMT_02 / NullIf(b.NW_Y_NM_FOR_AMT_02 ,0) * 100  NW_Y_NM_FOR_AMT_02,
			a.NW_Y_NM_PLAN_AMT_03 / NullIf(b.NW_Y_NM_PLAN_AMT_03 ,0) * 100  NW_Y_NM_PLAN_AMT_03,
			a.NW_Y_NM_FOR_AMT_03 / NullIf(b.NW_Y_NM_FOR_AMT_03 ,0) * 100  NW_Y_NM_FOR_AMT_03,
			a.NW_Y_PLAN_AMT / NullIf(b.NW_Y_PLAN_AMT ,0) * 100  NW_Y_PLAN_AMT,
			a.NW_Y_FOR_AMT / NullIf(b.NW_Y_FOR_AMT ,0) * 100  NW_Y_FOR_AMT,
			a.AF_Y_PLAN_AMT / NullIf(b.AF_Y_PLAN_AMT ,0) * 100  AF_Y_PLAN_AMT
		From	Base_Table a,
				Base_Table b
		Where	a.MNG_CODE = '세전이익'
		And		b.MNG_CODE = '매출액'
	) a
Order By
	RN,SUBRN
/
