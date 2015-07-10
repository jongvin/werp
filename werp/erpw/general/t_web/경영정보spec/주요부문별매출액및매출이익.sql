--:BASE_AMT : 금액단위 기본은 백만이므로 1000000을 넘김
--:COMP_CODE : 사업장 코드
--:MIN_MM : 분기중 제일 첫 달 예를 들어 1분기인 경우는 01 2분기이면 04 3분기이면 07 4분이이면 10을 넘김
--:MID_MM : 분기중 중간 달. 만약 1분기이면 '02' 2분기이면 '05' 3분기이면 '08' 4분기이면 '11'
--:MAX_MM : 분기중 마지막 달. 만약 1분기이면 '03' 2분기이면 '06' 3분기이면 '09' 4분기이면 '12'
--:YEAR_BF : 회기상 전년도 만약 회기가 2005이면 :YEAR_BF는 2004 임
--:YEAR_NW : 당 회기
--:YEAR_AF : 다음 회기 만약 당 회기가 2005이면 2006임

Select
	DEPT_CODE,		--현장코드
	DEPT_NAME,		--현장명
	RN,				--항목 순번
	BIZ_PLAN_ITEM_NAME,	--항목명
	BF_EXEC_AMT,		--이하 금액들은 판매비및영업외수지의 항목과 동일한 의미임
	BF_BM_EXEC_AMT,
	NW_BM_PLAN_AMT,
	NW_BM_EXEC_AMT,
	NW_BM_GAP_PLAN,
	NW_BM_GAP_BYEAR,
	NW_MIN_PLAN_AMT,
	NW_MIN_FORE_AMT,
	NW_MID_PLAN_AMT,
	NW_MID_FORE_AMT,
	NW_MAX_PLAN_AMT,
	NW_MAX_FORE_AMT,
	NW_PLAN_AMT,
	NW_FORE_AMT,
	NW_GAP_PLAN_AMT,
	NW_GAP_BYEAR_AMT,
	AF_PLAN_AMT,
	AF_GAP_BYEAR_AMT
From
	(
		With Base_Table As
		(
		Select
			x.DEPT_CODE,
			y.RN,
			y.MNG_CODE,
			z.DEPT_NAME,
			y.BIZ_PLAN_ITEM_NO ,
			y.BIZ_PLAN_ITEM_NAME,
			Sum(
				Case
					When x.CLSE_ACC_ID = :YEAR_BF Then
						x.EXEC_AMT
					Else
						Null
				End
			) BF_EXEC_AMT,
			Sum(
				Case
					When x.WORK_YM >= :YEAR_BF || '01' And x.WORK_YM < :YEAR_BF || :MIN_MM Then
						x.EXEC_AMT
					Else
						Null
				End
			) BF_BM_EXEC_AMT,
			Sum(
				Case
					When x.WORK_YM >= :YEAR_NW || '01' And x.WORK_YM < :YEAR_NW || :MIN_MM Then
						x.PLAN_AMT
					Else
						Null
				End
			) NW_BM_PLAN_AMT,
			Sum(
				Case
					When x.WORK_YM >= :YEAR_NW || '01' And x.WORK_YM < :YEAR_NW || :MIN_MM Then
						x.EXEC_AMT
					Else
						Null
				End
			) NW_BM_EXEC_AMT,
			Nvl(Sum(
				Case
					When x.WORK_YM >= :YEAR_NW || '01' And x.WORK_YM < :YEAR_NW || :MIN_MM Then
						x.EXEC_AMT
					Else
						Null
				End
			),0) - 
			Nvl(Sum(
				Case
					When x.WORK_YM >= :YEAR_NW || '01' And x.WORK_YM < :YEAR_NW || :MIN_MM Then
						x.PLAN_AMT
					Else
						Null
				End
			),0) NW_BM_GAP_PLAN,
			Nvl(Sum(
				Case
					When x.WORK_YM >= :YEAR_NW || '01' And x.WORK_YM < :YEAR_NW || :MIN_MM Then
						x.EXEC_AMT
					Else
						Null
				End
			),0) - 
			Nvl(Sum(
				Case
					When x.WORK_YM >= :YEAR_BF || '01' And x.WORK_YM < :YEAR_BF || :MIN_MM Then
						x.EXEC_AMT
					Else
						Null
				End
			),0) NW_BM_GAP_BYEAR,
			Sum(
				Case
					When x.WORK_YM = :YEAR_NW || :MIN_MM Then
						x.PLAN_AMT
					Else
						Null
				End
			) NW_MIN_PLAN_AMT,
			Sum(
				Case
					When x.WORK_YM = :YEAR_NW || :MIN_MM Then
						x.FORECAST_AMT
					Else
						Null
				End
			) NW_MIN_FORE_AMT,
			Sum(
				Case
					When x.WORK_YM = :YEAR_NW || :MID_MM Then
						x.PLAN_AMT
					Else
						Null
				End
			) NW_MID_PLAN_AMT,
			Sum(
				Case
					When x.WORK_YM = :YEAR_NW || :MID_MM Then
						x.FORECAST_AMT
					Else
						Null
				End
			) NW_MID_FORE_AMT,
			Sum(
				Case
					When x.WORK_YM = :YEAR_NW || :MAX_MM Then
						x.PLAN_AMT
					Else
						Null
				End
			) NW_MAX_PLAN_AMT,
			Sum(
				Case
					When x.WORK_YM = :YEAR_NW || :MAX_MM Then
						x.FORECAST_AMT
					Else
						Null
				End
			) NW_MAX_FORE_AMT,
			Sum(
				Case
					When x.CLSE_ACC_ID = :YEAR_NW Then
						x.PLAN_AMT
					Else
						Null
				End
			) NW_PLAN_AMT,
			Sum(
				Case
					When x.CLSE_ACC_ID = :YEAR_NW And  x.WORK_YM < :YEAR_NW || :MIN_MM Then
						x.EXEC_AMT
					When x.CLSE_ACC_ID = :YEAR_NW And  x.WORK_YM Between :YEAR_NW || :MIN_MM And :YEAR_NW || :MAX_MM Then
						x.FORECAST_AMT
					When x.CLSE_ACC_ID = :YEAR_NW And  x.WORK_YM > :YEAR_NW || :MAX_MM Then
						x.PLAN_AMT
					Else
						Null
				End
			) NW_FORE_AMT,
			Nvl(Sum(
				Case
					When x.CLSE_ACC_ID = :YEAR_NW And  x.WORK_YM < :YEAR_NW || :MIN_MM Then
						x.EXEC_AMT
					When x.CLSE_ACC_ID = :YEAR_NW And  x.WORK_YM Between :YEAR_NW || :MIN_MM And :YEAR_NW || :MAX_MM Then
						x.FORECAST_AMT
					When x.CLSE_ACC_ID = :YEAR_NW And  x.WORK_YM > :YEAR_NW || :MAX_MM Then
						x.PLAN_AMT
					Else
						Null
				End
			),0) - 
			Nvl(Sum(
				Case
					When x.CLSE_ACC_ID = :YEAR_NW Then
						x.PLAN_AMT
					Else
						Null
				End
			),0) NW_GAP_PLAN_AMT,
			Nvl(Sum(
				Case
					When x.CLSE_ACC_ID = :YEAR_NW And  x.WORK_YM < :YEAR_NW || :MIN_MM Then
						x.EXEC_AMT
					When x.CLSE_ACC_ID = :YEAR_NW And  x.WORK_YM Between :YEAR_NW || :MIN_MM And :YEAR_NW || :MAX_MM Then
						x.FORECAST_AMT
					When x.CLSE_ACC_ID = :YEAR_NW And  x.WORK_YM > :YEAR_NW || :MAX_MM Then
						x.PLAN_AMT
					Else
						Null
				End
			),0) - 
			Nvl(Sum(
				Case
					When x.CLSE_ACC_ID = :YEAR_BF Then
						x.EXEC_AMT
					Else
						Null
				End
			),0) NW_GAP_BYEAR_AMT,
			Sum(
				Case
					When x.CLSE_ACC_ID = :YEAR_AF Then
						x.PLAN_AMT
					Else
						Null
				End
			) AF_PLAN_AMT,
			Nvl(Sum(
				Case
					When x.CLSE_ACC_ID = :YEAR_AF Then
						x.PLAN_AMT
					Else
						Null
				End
			),0) - 
			Nvl(Sum(
				Case
					When x.CLSE_ACC_ID = :YEAR_NW And  x.WORK_YM < :YEAR_NW || :MIN_MM Then
						x.EXEC_AMT
					When x.CLSE_ACC_ID = :YEAR_NW And  x.WORK_YM Between :YEAR_NW || :MIN_MM And :YEAR_NW || :MAX_MM Then
						x.FORECAST_AMT
					When x.CLSE_ACC_ID = :YEAR_NW And  x.WORK_YM > :YEAR_NW || :MAX_MM Then
						x.PLAN_AMT
					Else
						Null
				End
			),0) AF_GAP_BYEAR_AMT
		From	
				(
					Select
						x.COMP_CODE ,
						x.CLSE_ACC_ID ,
						x.CHG_SEQ ,
						x.DEPT_CODE ,
						x.WORK_YM ,
						x.BIZ_PLAN_ITEM_NO,
						x.PLAN_AMT /:BASE_AMT PLAN_AMT,
						x.FORECAST_AMT /:BASE_AMT  FORECAST_AMT,
						x.EXEC_AMT /:BASE_AMT EXEC_AMT
					From	T_PL_COMP_DEPT_PLAN_EXEC x,
							T_PL_PLAN_DEPT xx
					Where	x.CLSE_ACC_ID In (:YEAR_BF, :YEAR_NW,:YEAR_AF)
					And		x.COMP_CODE Like :COMP_CODE || '%'
					And		x.COMP_CODE = xx.COMP_CODE
					And		x.DEPT_CODE = xx.DEPT_CODE
					And		xx.CLSE_ACC_ID = :YEAR_NW
				) x,
				(
					Select
						a.BIZ_PLAN_ITEM_NO,
						a.BIZ_PLAN_ITEM_NAME,
						a.MNG_CODE,
						Decode(a.MNG_CODE,'매출액',1,2) RN
					From	T_PL_ITEM a
					Where	a.MNG_CODE In ('매출액','매출이익')
				) y,
				T_PL_REAL_N_VIR_DEPT z
		Where	x.BIZ_PLAN_ITEM_NO = y.BIZ_PLAN_ITEM_NO
		And		x.DEPT_CODE = z.DEPT_CODE
		Group By
			x.DEPT_CODE,
			y.RN,
			y.MNG_CODE,
			z.DEPT_NAME,
			y.BIZ_PLAN_ITEM_NO ,
			y.BIZ_PLAN_ITEM_NAME
		)
		Select
			DEPT_CODE,
			RN,
			MNG_CODE,
			DEPT_NAME,
			BIZ_PLAN_ITEM_NO ,
			BIZ_PLAN_ITEM_NAME,
			BF_EXEC_AMT,
			BF_BM_EXEC_AMT,
			NW_BM_PLAN_AMT,
			NW_BM_EXEC_AMT,
			NW_BM_GAP_PLAN,
			NW_BM_GAP_BYEAR,
			NW_MIN_PLAN_AMT,
			NW_MIN_FORE_AMT,
			NW_MID_PLAN_AMT,
			NW_MID_FORE_AMT,
			NW_MAX_PLAN_AMT,
			NW_MAX_FORE_AMT,
			NW_PLAN_AMT,
			NW_FORE_AMT,
			NW_GAP_PLAN_AMT,
			NW_GAP_BYEAR_AMT,
			AF_PLAN_AMT,
			AF_GAP_BYEAR_AMT
		From Base_Table	
		Union All
		Select
			DEPT_CODE,
			3,
			'매출이익율',
			DEPT_NAME,
			0 ,
			'매출이익율',
			100* Sum(Decode(RN,2,BF_EXEC_AMT)) / NullIf(Sum(Decode(RN,1,BF_EXEC_AMT)),0) BF_EXEC_AMT,
			100* Sum(Decode(RN,2,BF_BM_EXEC_AMT)) / NullIf(Sum(Decode(RN,1,BF_BM_EXEC_AMT)),0) BF_BM_EXEC_AMT,
			100* Sum(Decode(RN,2,NW_BM_PLAN_AMT)) / NullIf(Sum(Decode(RN,1,NW_BM_PLAN_AMT)),0) NW_BM_PLAN_AMT,
			100* Sum(Decode(RN,2,NW_BM_EXEC_AMT)) / NullIf(Sum(Decode(RN,1,NW_BM_EXEC_AMT)),0) NW_BM_EXEC_AMT,
			Nvl(100* Sum(Decode(RN,2,NW_BM_EXEC_AMT)) / NullIf(Sum(Decode(RN,1,NW_BM_EXEC_AMT)),0),0) - Nvl(100* Sum(Decode(RN,2,NW_BM_PLAN_AMT)) / NullIf(Sum(Decode(RN,1,NW_BM_PLAN_AMT)),0),0)  NW_BM_GAP_PLAN,
			Nvl(100* Sum(Decode(RN,2,NW_BM_EXEC_AMT)) / NullIf(Sum(Decode(RN,1,NW_BM_EXEC_AMT)),0),0) - Nvl(100* Sum(Decode(RN,2,BF_BM_EXEC_AMT)) / NullIf(Sum(Decode(RN,1,BF_BM_EXEC_AMT)),0),0) NW_BM_GAP_BYEAR,
			100* Sum(Decode(RN,2,NW_MIN_PLAN_AMT)) / NullIf(Sum(Decode(RN,1,NW_MIN_PLAN_AMT)),0) NW_MIN_PLAN_AMT,
			100* Sum(Decode(RN,2,NW_MIN_FORE_AMT)) / NullIf(Sum(Decode(RN,1,NW_MIN_FORE_AMT)),0) NW_MIN_FORE_AMT,
			100* Sum(Decode(RN,2,NW_MID_PLAN_AMT)) / NullIf(Sum(Decode(RN,1,NW_MID_PLAN_AMT)),0) NW_MID_PLAN_AMT,
			100* Sum(Decode(RN,2,NW_MID_FORE_AMT)) / NullIf(Sum(Decode(RN,1,NW_MID_FORE_AMT)),0) NW_MID_FORE_AMT,
			100* Sum(Decode(RN,2,NW_MAX_PLAN_AMT)) / NullIf(Sum(Decode(RN,1,NW_MAX_PLAN_AMT)),0) NW_MAX_PLAN_AMT,
			100* Sum(Decode(RN,2,NW_MAX_FORE_AMT)) / NullIf(Sum(Decode(RN,1,NW_MAX_FORE_AMT)),0) NW_MAX_FORE_AMT,
			100* Sum(Decode(RN,2,NW_PLAN_AMT)) / NullIf(Sum(Decode(RN,1,NW_PLAN_AMT)),0) NW_PLAN_AMT,
			100* Sum(Decode(RN,2,NW_FORE_AMT)) / NullIf(Sum(Decode(RN,1,NW_FORE_AMT)),0) NW_FORE_AMT,
			Nvl(100* Sum(Decode(RN,2,NW_FORE_AMT)) / NullIf(Sum(Decode(RN,1,NW_FORE_AMT)),0),0) - Nvl(100* Sum(Decode(RN,2,NW_PLAN_AMT)) / NullIf(Sum(Decode(RN,1,NW_PLAN_AMT)),0),0) NW_GAP_PLAN_AMT,
			Nvl(100* Sum(Decode(RN,2,NW_FORE_AMT)) / NullIf(Sum(Decode(RN,1,NW_FORE_AMT)),0),0) - Nvl(100* Sum(Decode(RN,2,BF_EXEC_AMT)) / NullIf(Sum(Decode(RN,1,BF_EXEC_AMT)),0),0) NW_GAP_BYEAR_AMT,
			100* Sum(Decode(RN,2,AF_PLAN_AMT)) / NullIf(Sum(Decode(RN,1,AF_PLAN_AMT)),0) AF_PLAN_AMT,
			Nvl(100* Sum(Decode(RN,2,AF_PLAN_AMT)) / NullIf(Sum(Decode(RN,1,AF_PLAN_AMT)),0),0) - Nvl(100* Sum(Decode(RN,2,NW_FORE_AMT)) / NullIf(Sum(Decode(RN,1,NW_FORE_AMT)),0),0) AF_GAP_BYEAR_AMT
		From Base_Table	
		Group by
			DEPT_CODE,
			DEPT_NAME
	)
Order By
	DEPT_CODE,
	RN
