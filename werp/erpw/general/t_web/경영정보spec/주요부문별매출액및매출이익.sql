--:BASE_AMT : �ݾ״��� �⺻�� �鸸�̹Ƿ� 1000000�� �ѱ�
--:COMP_CODE : ����� �ڵ�
--:MIN_MM : �б��� ���� ù �� ���� ��� 1�б��� ���� 01 2�б��̸� 04 3�б��̸� 07 4�����̸� 10�� �ѱ�
--:MID_MM : �б��� �߰� ��. ���� 1�б��̸� '02' 2�б��̸� '05' 3�б��̸� '08' 4�б��̸� '11'
--:MAX_MM : �б��� ������ ��. ���� 1�б��̸� '03' 2�б��̸� '06' 3�б��̸� '09' 4�б��̸� '12'
--:YEAR_BF : ȸ��� ���⵵ ���� ȸ�Ⱑ 2005�̸� :YEAR_BF�� 2004 ��
--:YEAR_NW : �� ȸ��
--:YEAR_AF : ���� ȸ�� ���� �� ȸ�Ⱑ 2005�̸� 2006��

Select
	DEPT_CODE,		--�����ڵ�
	DEPT_NAME,		--�����
	RN,				--�׸� ����
	BIZ_PLAN_ITEM_NAME,	--�׸��
	BF_EXEC_AMT,		--���� �ݾ׵��� �Ǹź�׿����ܼ����� �׸�� ������ �ǹ���
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
						Decode(a.MNG_CODE,'�����',1,2) RN
					From	T_PL_ITEM a
					Where	a.MNG_CODE In ('�����','��������')
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
			'����������',
			DEPT_NAME,
			0 ,
			'����������',
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
