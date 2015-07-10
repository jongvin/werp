--:BASE_AMT : 금액단위 기본은 백만이므로 1000000을 넘김
--:GBN : 관리판매비 또는 영업외수지를 구분하기 위해 사용한다 1 : 관리판매비 2 : 영업외수지 3 : 관리판매비 및 영업외 수지
--:COMP_CODE : 사업장 코드
--:MIN_MM : 분기중 제일 첫 달 예를 들어 1분기인 경우는 01 2분기이면 04 3분기이면 07 4분이이면 10을 넘김
--:MID_MM : 분기중 중간 달. 만약 1분기이면 '02' 2분기이면 '05' 3분기이면 '08' 4분기이면 '11'
--:MAX_MM : 분기중 마지막 달. 만약 1분기이면 '03' 2분기이면 '06' 3분기이면 '09' 4분기이면 '12'
--:YEAR_BF : 회기상 전년도 만약 회기가 2005이면 :YEAR_BF는 2004 임
--:YEAR_NW : 당 회기
--:YEAR_AF : 다음 회기 만약 당 회기가 2005이면 2006임


Select
	y.PRN,		--항목상의 대분류번호
	y.RN,		--항목상의 분류번호
	y.BIZ_PLAN_ITEM_NO ,	--실제 키
	y.P_NAME,				--대분류명
	y.BIZ_PLAN_ITEM_NAME,	--항목명
	Sum(
		Case
			When x.CLSE_ACC_ID = :YEAR_BF Then
				x.EXEC_AMT
			Else
				Null
		End
	) BF_EXEC_AMT,	--전년실적
	Sum(
		Case
			When x.WORK_YM >= :YEAR_BF || '01' And x.WORK_YM < :YEAR_BF || :MIN_MM Then
				x.EXEC_AMT
			Else
				Null
		End
	) BF_BM_EXEC_AMT,	--전년 전월까지의 실적
	Sum(
		Case
			When x.WORK_YM >= :YEAR_NW || '01' And x.WORK_YM < :YEAR_NW || :MIN_MM Then
				x.PLAN_AMT
			Else
				Null
		End
	) NW_BM_PLAN_AMT,	--당년 전월까지의 계획
	Sum(
		Case
			When x.WORK_YM >= :YEAR_NW || '01' And x.WORK_YM < :YEAR_NW || :MIN_MM Then
				x.EXEC_AMT
			Else
				Null
		End
	) NW_BM_EXEC_AMT,	--당년 전월까지의 실적
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
	),0) NW_BM_GAP_PLAN,	--당년 전월까지의 계획비
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
	),0) NW_BM_GAP_BYEAR,	--당년 전월까지의 전년비
	Sum(
		Case
			When x.WORK_YM = :YEAR_NW || :MIN_MM Then
				x.PLAN_AMT
			Else
				Null
		End
	) NW_MIN_PLAN_AMT,		--분기 첫 달 계획
	Sum(
		Case
			When x.WORK_YM = :YEAR_NW || :MIN_MM Then
				x.FORECAST_AMT
			Else
				Null
		End
	) NW_MIN_FORE_AMT,		--분기 첫 달 예상
	Sum(
		Case
			When x.WORK_YM = :YEAR_NW || :MID_MM Then
				x.PLAN_AMT
			Else
				Null
		End
	) NW_MID_PLAN_AMT,		--분기 두번째 달 계획
	Sum(
		Case
			When x.WORK_YM = :YEAR_NW || :MID_MM Then
				x.FORECAST_AMT
			Else
				Null
		End
	) NW_MID_FORE_AMT,		--분기 두번째 달 예상
	Sum(
		Case
			When x.WORK_YM = :YEAR_NW || :MAX_MM Then
				x.PLAN_AMT
			Else
				Null
		End
	) NW_MAX_PLAN_AMT,		--분기 마지막 달 계획
	Sum(
		Case
			When x.WORK_YM = :YEAR_NW || :MAX_MM Then
				x.FORECAST_AMT
			Else
				Null
		End
	) NW_MAX_FORE_AMT,		--분기 마지막 달 예상
	Sum(
		Case
			When x.CLSE_ACC_ID = :YEAR_NW Then
				x.PLAN_AMT
			Else
				Null
		End
	) NW_PLAN_AMT,			--당년 계획
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
	) NW_FORE_AMT,			--당년 예상
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
	),0) NW_GAP_PLAN_AMT,		--당년 계획비
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
	),0) NW_GAP_BYEAR_AMT,		--당년 전년비
	Sum(
		Case
			When x.CLSE_ACC_ID = :YEAR_AF Then
				x.PLAN_AMT
			Else
				Null
		End
	) AF_PLAN_AMT,				--후년 계획
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
	),0) AF_GAP_BYEAR_AMT		--후년 계획비
From	
		(
			Select
				x.COMP_CODE ,
				x.CLSE_ACC_ID ,
				x.CHG_SEQ ,
				x.WORK_YM ,
				x.BIZ_PLAN_ITEM_NO ,
				x.PLAN_AMT /:BASE_AMT PLAN_AMT,
				x.FORECAST_AMT /:BASE_AMT  FORECAST_AMT,
				x.EXEC_AMT /:BASE_AMT EXEC_AMT
			From	T_PL_COMP_PLAN_EXEC x
			Where	x.CLSE_ACC_ID In (:YEAR_BF, :YEAR_NW,:YEAR_AF)
			And		x.COMP_CODE Like :COMP_CODE || '%'
		) x,
		(
			Select
				pa.PRN,
				pa.BIZ_PLAN_ITEM_NAME P_NAME,
				pb.BIZ_PLAN_ITEM_NO ,
				pb.P_NO ,
				pb.BIZ_PLAN_ITEM_NAME ,
				pb.ITEM_LEVEL_SEQ ,
				pb.REMARKS ,
				pb.MNG_CODE ,
				pb.IS_LEAF_TAG,
				pb.RN
			From	
					(
						Select
							a.BIZ_PLAN_ITEM_NO ,
							a.P_NO ,
							a.BIZ_PLAN_ITEM_NAME ,
							a.MNG_CODE,
							a.ITEM_LEVEL_SEQ ,
							RowNum PRN
						From	T_PL_ITEM a
						Connect By
							Prior	a.BIZ_PLAN_ITEM_NO = a.P_NO
						Start With
							a.P_NO = 0
						Order Siblings By
							a.ITEM_LEVEL_SEQ
					) pa,
					(
						Select
							a.BIZ_PLAN_ITEM_NO ,
							a.P_NO ,
							a.BIZ_PLAN_ITEM_NAME ,
							a.ITEM_LEVEL_SEQ ,
							a.REMARKS ,
							a.MNG_CODE ,
							a.IS_LEAF_TAG,
							RowNum RN
						From	T_PL_ITEM a
						Connect By
							Prior	a.BIZ_PLAN_ITEM_NO = a.P_NO
						Start With
							a.MNG_CODE In(	Decode(:GBN,'1', '관리판매비','3','관리판매비',' '),
											Decode(:GBN,'2', '영업외수익','3','영업외수익',' '),
											Decode(:GBN,'2', '영업외비용','3','영업외비용',' ')
							)
						Order Siblings By
							a.ITEM_LEVEL_SEQ
					) pb
			Where	pb.P_NO = pa.BIZ_PLAN_ITEM_NO
			And		pb.IS_LEAF_TAG = 'T'
		) y
Where	x.BIZ_PLAN_ITEM_NO (+) = y.BIZ_PLAN_ITEM_NO
Group By
	y.PRN,
	y.RN,
	y.BIZ_PLAN_ITEM_NO ,
	y.P_NAME,
	y.BIZ_PLAN_ITEM_NAME
