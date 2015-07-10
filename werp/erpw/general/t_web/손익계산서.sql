--���� ����
--:CLSE_ACC_ID_BF : ���⵵ ȸ�� ==> ��� ȸ�Ⱑ 2005�̸� 2004�� �ѱ�
--:CLSE_ACC_ID_NW : ��⵵ ȸ��
--:CLSE_ACC_ID_AF : �ĳ⵵ ȸ�� ==> ��� ȸ�Ⱑ 2005�̸� 2006�� �ѱ�
--:START_MM_MIN : �б���ۿ� ==>���� 1�б��̸� '01' 2�б��̸� '04' 3�б��̸� '07' 4�б��̸� '10'
--:START_MM_MID : �б���ۿ� ==>���� 1�б��̸� '02' 2�б��̸� '05' 3�б��̸� '08' 4�б��̸� '11'
--:START_MM_MAX : �б���ۿ� ==>���� 1�б��̸� '03' 2�б��̸� '06' 3�б��̸� '09' 4�б��̸� '12'
--:BASE_AMT : �ݾ� ���� �⺻�� �鸸�����̹Ƿ� 1000000�� �ѱ�
Select
	a.RN,
	a.SUBRN,
	a.BIZ_PLAN_ITEM_NAME,		--�׸��
	a.BF_Y_EXEC_AMT,				--�������
	a.BF_Y_BM_EXEC_AMT,			--����б�������
	a.NW_Y_BM_PLAN_AMT,			--���б�����ȹ
	a.NW_Y_BM_EXEC_AMT,			--���б�������
	Decode(a.MNG_CODE,'�����',100 * Nvl(a.NW_Y_BM_EXEC_AMT,0) / NullIf(a.NW_Y_BM_PLAN_AMT,0) ,Nvl(a.NW_Y_BM_EXEC_AMT,0) - Nvl(a.NW_Y_BM_PLAN_AMT,0) ) NW_BM_P_E_SUB ,	--��ȹ��(�б���)
	Decode(a.MNG_CODE,'�����',100 * Nvl(a.NW_Y_BM_EXEC_AMT,0) / NullIf(a.BF_Y_BM_EXEC_AMT,0) ,Nvl(a.NW_Y_BM_EXEC_AMT,0) - Nvl(a.BF_Y_BM_EXEC_AMT,0) ) NW_BM_B_E_SUM ,	--�����(�б���)
	a.NW_Y_NM_PLAN_AMT_01,
	a.NW_Y_NM_FOR_AMT_01,
	a.NW_Y_NM_PLAN_AMT_02,
	a.NW_Y_NM_FOR_AMT_02,
	a.NW_Y_NM_PLAN_AMT_03,
	a.NW_Y_NM_FOR_AMT_03,
	a.NW_Y_PLAN_AMT,
	a.NW_Y_FOR_AMT,
	Decode(a.MNG_CODE,'�����',100 * Nvl(a.NW_Y_FOR_AMT,0) / NullIf(a.NW_Y_PLAN_AMT,0) ,Nvl(a.NW_Y_FOR_AMT,0) - Nvl(a.NW_Y_PLAN_AMT,0) ) NW_P_E_SUB ,	--��ȹ��(���)
	Decode(a.MNG_CODE,'�����',100 * Nvl(a.NW_Y_FOR_AMT,0) / NullIf(a.BF_Y_EXEC_AMT,0) ,Nvl(a.NW_Y_FOR_AMT,0) - Nvl(a.BF_Y_EXEC_AMT,0) ) NW_B_E_SUM ,	--�����(���)
	a.AF_Y_PLAN_AMT,
	Decode(a.MNG_CODE,'�����',100 * Nvl(a.AF_Y_PLAN_AMT,0) / NullIf(a.NW_Y_FOR_AMT,0) ,Nvl(a.AF_Y_PLAN_AMT,0) - Nvl(a.NW_Y_FOR_AMT,0) ) AF_P_E_SUM		--������(�ĳ�)
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
				When b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM < :CLSE_ACC_ID_NW||:START_MM_MID Then		--�б����̸� ����
					b.EXEC_AMT
				When b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM >= :CLSE_ACC_ID_NW||:START_MM_MID And b.WORK_YM <= :CLSE_ACC_ID_NW||:START_MM_MAX Then	--�б⳻�� ����
					b.FORECAST_AMT
				When b.CLSE_ACC_ID = :CLSE_ACC_ID_NW And b.WORK_YM > :CLSE_ACC_ID_NW||:START_MM_MAX Then	--�б� ���ĸ� ��ȹ�ݾ�
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
			a.MNG_CODE ||'��',
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
		Where	a.MNG_CODE = '��������'
		And		b.MNG_CODE = '�����'
		Union All
		Select
			a.RN,
			1 SUBRN,
			'(%)',
			a.MNG_CODE||'��',
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
		Where	a.MNG_CODE = '�����Ǹź�'
		And		b.MNG_CODE = '�����'
		Union All
		Select
			a.RN,
			1 SUBRN,
			'(%)',
			a.MNG_CODE||'��',
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
		Where	a.MNG_CODE = '��������'
		And		b.MNG_CODE = '�����'
		Union All
		Select
			a.RN,
			1 SUBRN,
			'(%)',
			a.MNG_CODE||'��',
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
		Where	a.MNG_CODE = '�������'
		And		b.MNG_CODE = '�����'
		Union All
		Select
			a.RN,
			1 SUBRN,
			'(%)',
			a.MNG_CODE||'��',
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
		Where	a.MNG_CODE = '��������'
		And		b.MNG_CODE = '�����'
	) a
Order By
	RN,SUBRN
/
