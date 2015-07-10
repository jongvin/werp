CREATE OR REPLACE PROCEDURE Sp_T_Work_Fin_Pay_Bill_Slip_U
(
	--AR_SLIP_ID                                    NUMBER,
	--AR_SLIP_IDSEQ                                 NUMBER,
	AR_MODUSERNO                                  VARCHAR2,
	AR_ACC_REMAIN_POSITION                        VARCHAR2,
	AR_DB_AMT                                     NUMBER,
	AR_CR_AMT                                     NUMBER,
	AR_CUST_SEQ                                   VARCHAR2,
	--���޾���
	AR_BILL_NO_MNG                                VARCHAR2,
	AR_BILL_NO_MNG_TG                             VARCHAR2,
	--���޾��� ����
	AR_BILL_NO_S                                  VARCHAR2,
	AR_BILL_PUBL_DT                               VARCHAR2,
	AR_BILL_EXPR_DT                               VARCHAR2,
	--���޾��� ����
	AR_BILL_NO_R                                  VARCHAR2,
	AR_BILL_PUBL_DT_R                             VARCHAR2,
	AR_BILL_EXPR_DT_R                             VARCHAR2,
	AR_BILL_CHG_EXPR_DT_R                         VARCHAR2
)
IS
	lnCnt						T_ACC_SLIP_BODY.SLIP_ID%TYPE;
	lsMsg						VARCHAR2(4000);
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_BILL_SLIP
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : ���޾�������
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-12-07)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
BEGIN

	SELECT	COUNT(*)
	INTO	lnCnt
	FROM	T_FIN_PAY_CHK_BILL
	WHERE
	CHK_BILL_CLS = 'B'
	AND CHK_BILL_NO = AR_BILL_NO_S
	AND SLIP_ID IS NOT NULL;

	IF NVL(lnCnt,0) > 0 THEN
		lsMsg := '��ǥ��������!!!<br>'||'�ش����޾����� ������ǥ�� �̹� �����մϴ�.<br>�ش系���� ������ �� �����ϴ�.'||lsMsg;
		RAISE_APPLICATION_ERROR (-20009, lsMsg);
	ELSE
		NULL;
	END IF;
	
	SELECT	COUNT(*)
	INTO	lnCnt
	FROM	T_FIN_PAY_CHK_BILL
	WHERE
		CHK_BILL_CLS = 'B'
		AND CHK_BILL_NO = AR_BILL_NO_R
		AND RESET_SLIP_ID IS NOT NULL;

	IF NVL(lnCnt,0) > 0 THEN
		lsMsg := '��ǥ��������!!!<br>'||'�ش����޾����� ������ǥ�� �̹� �����մϴ�.<br>�ش系���� ������ �� �����ϴ�.'||lsMsg;
		RAISE_APPLICATION_ERROR (-20009, lsMsg);
	ELSE
		NULL;
	END IF;

		
	IF (AR_BILL_NO_MNG = 'T' AND AR_BILL_NO_S IS NOT NULL) OR (AR_BILL_NO_MNG = 'T' AND AR_BILL_NO_R IS NOT NULL) THEN
		IF (NVL(AR_ACC_REMAIN_POSITION,'D') = 'D' AND NVL(AR_DB_AMT, 0) > 0) OR
			(NVL(AR_ACC_REMAIN_POSITION,'D') = 'C' AND NVL(AR_CR_AMT, 0) > 0) THEN
			--���޾��� ����
			UPDATE T_FIN_PAY_CHK_BILL
			SET
				MODUSERNO = AR_MODUSERNO,
				CUST_SEQ = AR_CUST_SEQ,
				PUBL_DT = F_T_Stringtodate(AR_BILL_PUBL_DT),
				EXPR_DT = F_T_Stringtodate(AR_BILL_EXPR_DT),
				PUBL_AMT = AR_DB_AMT + AR_CR_AMT,
				SLIP_ID = NULL,
				SLIP_IDSEQ = NULL
			WHERE	CHK_BILL_CLS = 'B'
			AND CHK_BILL_NO = AR_BILL_NO_S;
		ELSE
			--���޾��� ����
			UPDATE T_FIN_PAY_CHK_BILL
			SET
				MODUSERNO = AR_MODUSERNO,
				RESET_SLIP_ID = NULL,
				RESET_SLIP_IDSEQ = NULL
			WHERE	CHK_BILL_CLS = 'B'
			AND CHK_BILL_NO = AR_BILL_NO_R;
		END IF;
	ELSE
		NULL;
	END IF;
END;
/