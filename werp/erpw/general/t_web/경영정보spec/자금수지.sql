--:BASE_AMT : �ݾ״��� �⺻�� �鸸�̹Ƿ� 1000000�� �ѱ�
--:COMP_CODE : ����� �ڵ�
--:MIN_MM : �б��� ���� ù �� ���� ��� 1�б��� ���� 01 2�б��̸� 04 3�б��̸� 07 4�����̸� 10�� �ѱ�
--:MID_MM : �б��� �߰� ��. ���� 1�б��̸� '02' 2�б��̸� '05' 3�б��̸� '08' 4�б��̸� '11'
--:MAX_MM : �б��� ������ ��. ���� 1�б��̸� '03' 2�б��̸� '06' 3�б��̸� '09' 4�б��̸� '12'
--:YEAR_BF : ȸ��� ���⵵ ���� ȸ�Ⱑ 2005�̸� :YEAR_BF�� 2004 ��
--:YEAR_NW : �� ȸ��
--:YEAR_AF : ���� ȸ�� ���� �� ȸ�Ⱑ 2005�̸� 2006��


Select
	y.RN,		--�׸���� �з���ȣ
	y.BIZ_PLAN_ITEM_NO ,	--���� Ű
	y.LEVELED_NAME,			--�ε�Ʈ�� �׸��
	Sum(
		Case
			When x.CLSE_ACC_ID = :YEAR_BF Then
				x.EXEC_AMT
			Else
				Null
		End
	) BF_EXEC_AMT,	--�������
	Sum(
		Case
			When x.WORK_YM >= :YEAR_NW || '01' And x.WORK_YM < :YEAR_NW || :MIN_MM Then
				x.EXEC_AMT
			Else
				Null
		End
	) NW_BM_EXEC_AMT,	--��� ���������� ����
	Sum(
		Case
			When x.WORK_YM = :YEAR_NW || :MIN_MM Then
				x.FORECAST_AMT
			Else
				Null
		End
	) NW_MIN_FORE_AMT,		--�б� ù �� ����
	Sum(
		Case
			When x.WORK_YM = :YEAR_NW || :MID_MM Then
				x.FORECAST_AMT
			Else
				Null
		End
	) NW_MID_FORE_AMT,		--�б� �ι�° �� ����
	Sum(
		Case
			When x.WORK_YM = :YEAR_NW || :MAX_MM Then
				x.FORECAST_AMT
			Else
				Null
		End
	) NW_MAX_FORE_AMT,		--�б� ������ �� ����
	Sum(
		Case
			When x.CLSE_ACC_ID = :YEAR_NW Then
				x.PLAN_AMT
			Else
				Null
		End
	) NW_PLAN_AMT,			--��� ��ȹ
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
	) NW_FORE_AMT,			--��� ����
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
	),0) NW_GAP_PLAN_AMT,		--��� ��ȹ��
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
	),0) NW_GAP_BYEAR_AMT,		--��� �����
	Sum(
		Case
			When x.CLSE_ACC_ID = :YEAR_AF Then
				x.PLAN_AMT
			Else
				Null
		End
	) AF_PLAN_AMT,				--�ĳ� ��ȹ
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
	),0) AF_GAP_BYEAR_AMT		--�ĳ� ��ȹ��
From	
		(
			Select
				x.COMP_CODE ,
				x.CLSE_ACC_ID ,
				0 CHG_SEQ ,
				x.WORK_YM ,
				x.FLOW_CODE_B BIZ_PLAN_ITEM_NO ,
				x.PLAN_AMT /:BASE_AMT PLAN_AMT,
				x.FORECAST_AMT /:BASE_AMT  FORECAST_AMT,
				x.EXEC_AMT /:BASE_AMT EXEC_AMT
			From	T_FL_MONTH_PLAN_EXEC_B x
			Where	x.CLSE_ACC_ID In (:YEAR_BF, :YEAR_NW,:YEAR_AF)
			And		x.COMP_CODE Like :COMP_CODE || '%'
		) x,
		(
			Select
				a.FLOW_CODE_B BIZ_PLAN_ITEM_NO ,
				a.P_NO ,
				a.FLOW_ITEM_NAME BIZ_PLAN_ITEM_NAME ,
				RPad(' ',(Level - 1)*2)|| a.FLOW_ITEM_NAME LEVELED_NAME,
				a.MNG_CODE MNG_CODE,
				a.LEVEL_SEQ ITEM_LEVEL_SEQ ,
				RowNum RN
			From	T_FL_FLOW_CODE_B a
			Connect By
				Prior	a.FLOW_CODE_B = a.P_NO
			Start With
				a.P_NO = 0
			Order Siblings By
				a.LEVEL_SEQ
		) y
Where	x.BIZ_PLAN_ITEM_NO (+) = y.BIZ_PLAN_ITEM_NO
Group By
	y.RN,
	y.BIZ_PLAN_ITEM_NO ,
	y.LEVELED_NAME,
	y.BIZ_PLAN_ITEM_NAME
/
