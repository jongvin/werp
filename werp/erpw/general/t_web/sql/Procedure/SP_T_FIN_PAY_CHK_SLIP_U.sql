CREATE OR REPLACE PROCEDURE Sp_T_Fin_Pay_Chk_Slip_U
(
	AR_SLIP_ID                                    NUMBER,
	AR_SLIP_IDSEQ                                 NUMBER,
	AR_MODUSERNO                                  VARCHAR2,
	AR_ACC_REMAIN_POSITION                        VARCHAR2,
	AR_DB_AMT                                     NUMBER,
	AR_CR_AMT                                     NUMBER,
	AR_CUST_SEQ                                   VARCHAR2,
	AR_CHK_NO_MNG                                 VARCHAR2,
	AR_CHK_NO_MNG_TG                              VARCHAR2,
	AR_CHK_NO                                     VARCHAR2,
	AR_CHK_PUBL_DT                                VARCHAR2,
	AR_CHK_COLL_DT                                VARCHAR2,
	AR_SUMMARY1                                VARCHAR2
)
IS
	lnCnt						T_ACC_SLIP_BODY.SLIP_ID%TYPE;
	lsMsg						VARCHAR2(4000);
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_FIN_PAY_CHK_SLIP
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : ���¼�ǥ����
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-12-07)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
BEGIN

	SELECT	COUNT(*)
	INTO	lnCnt
	FROM	T_FIN_PAY_CHK_BILL
	WHERE	CHK_BILL_CLS = 'B'
	AND		SLIP_ID = AR_SLIP_ID
	AND		SLIP_IDSEQ = AR_SLIP_IDSEQ
	AND		RESET_SLIP_ID IS NOT NULL;

	IF NVL(lnCnt,0) > 0 THEN
		lsMsg := '��ǥ��������!!!<br>'||'�ش���¼�ǥ�� �̹� ȸ���Ǿ����ϴ�.<br>�ش���ǥ������ �����Ҽ� �����ϴ�.'||lsMsg;
		RAISE_APPLICATION_ERROR (-20009, lsMsg);
	ELSE
		--���¼�ǥ ���� ���
		UPDATE	T_FIN_PAY_CHK_BILL
		SET
			MODUSERNO = AR_MODUSERNO,
			STAT_CLS = '1',
			CUST_SEQ = NULL,
			PUBL_DT = NULL,
			PUBL_AMT = 0,
			COLL_DT = NULL,
			REMARKS = NULL,
			SLIP_ID = NULL,
			SLIP_IDSEQ = NULL
		WHERE	CHK_BILL_CLS = 'C'
		AND	SLIP_ID = AR_SLIP_ID
		AND	SLIP_IDSEQ = AR_SLIP_IDSEQ;
	END IF;
	
	--���¼�ǥ ȸ�� ���
	UPDATE	T_FIN_PAY_CHK_BILL
	SET
		MODUSERNO = AR_MODUSERNO,
		COLL_DT = NULL,
		REMARKS = NULL,
		RESET_SLIP_ID = NULL,
		RESET_SLIP_IDSEQ = NULL
	WHERE	CHK_BILL_CLS = 'C'
	AND	RESET_SLIP_ID = AR_SLIP_ID
	AND	RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;
			
	IF AR_CHK_NO_MNG = 'T' AND AR_CHK_NO IS NOT NULL THEN
		IF (NVL(AR_ACC_REMAIN_POSITION,'D') = 'D' AND NVL(AR_DB_AMT, 0) > 0) OR
			(NVL(AR_ACC_REMAIN_POSITION,'D') = 'C' AND NVL(AR_CR_AMT, 0) > 0) THEN
			--���¼�ǥ ȸ��
			UPDATE	T_FIN_PAY_CHK_BILL
			SET
				MODUSERNO = AR_MODUSERNO,
				COLL_DT = NULL,
				REMARKS = NULL,
				RESET_SLIP_ID = NULL,
				RESET_SLIP_IDSEQ = NULL
			WHERE	CHK_BILL_CLS = 'C'
			AND	RESET_SLIP_ID = AR_SLIP_ID
			AND	RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;
			
			UPDATE	T_FIN_PAY_CHK_BILL
			SET
				MODUSERNO = AR_MODUSERNO,
				COLL_DT = F_T_Stringtodate(AR_CHK_COLL_DT),
				REMARKS = AR_SUMMARY1,
				RESET_SLIP_ID = AR_SLIP_ID,
				RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ
			WHERE	CHK_BILL_CLS = 'C'
			AND	CHK_BILL_NO = AR_CHK_NO;
		ELSE
			--���¼�ǥ ����
			UPDATE	T_FIN_PAY_CHK_BILL
			SET
				MODUSERNO = AR_MODUSERNO,
				STAT_CLS = '1',
				CUST_SEQ = NULL,
				PUBL_DT = NULL,
				PUBL_AMT = 0,
				COLL_DT = NULL,
				REMARKS = NULL,
				SLIP_ID = NULL,
				SLIP_IDSEQ = NULL
			WHERE	CHK_BILL_CLS = 'C'
			AND	SLIP_ID = AR_SLIP_ID
			AND	SLIP_IDSEQ = AR_SLIP_IDSEQ;
			
			UPDATE	T_FIN_PAY_CHK_BILL
			SET
				MODUSERNO = AR_MODUSERNO,
				STAT_CLS = '2',
				CUST_SEQ = AR_CUST_SEQ,
				PUBL_DT = F_T_Stringtodate(AR_CHK_PUBL_DT),
				PUBL_AMT = AR_DB_AMT + AR_CR_AMT,
				COLL_DT = F_T_Stringtodate(AR_CHK_COLL_DT),
				REMARKS = AR_SUMMARY1,
				SLIP_ID = AR_SLIP_ID,
				SLIP_IDSEQ = AR_SLIP_IDSEQ
			WHERE	CHK_BILL_CLS = 'C'
			AND	CHK_BILL_NO = AR_CHK_NO;
		END IF;
	ELSE
		NULL;
	END IF;
END;
/
