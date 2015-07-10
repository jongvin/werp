CREATE OR REPLACE Function F_T_Is_ConfSlip
(
	AR_SLIP_ID						T_ACC_SLIP_HEAD.SLIP_ID%Type
)
Return NUMBER
Is
	lsCnt NUMBER;
/**************************************************************************/
/* 1. �� �� �� �� id : F_T_Check_Slip
/* 2. ����(�ó�����) : Function
/* 3. ��  ��  ��  �� : ��ǥ���� üũ
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-12-07)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
Begin
	SELECT
		COUNT(*)
	INTO lsCnt
	FROM
		T_ACC_SLIP_HEAD
	WHERE
		SLIP_ID = AR_SLIP_ID
		AND KEEP_DT_TRANS IS NOT NULL;
	Return lsCnt;
End;
/
