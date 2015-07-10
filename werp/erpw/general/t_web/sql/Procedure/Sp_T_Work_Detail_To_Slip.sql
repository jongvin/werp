CREATE OR REPLACE PROCEDURE Sp_T_Work_Detail_To_Slip
(
	AR_WORK_SLIP_ID                        NUMBER,
	AR_WORK_SLIP_IDSEQ                 NUMBER,
	AR_MODUSERNO                          VARCHAR2,
	AR_SLIP_ID                                    NUMBER,
	AR_SLIP_IDSEQ                             NUMBER
)
IS
lrWORK_SLIP_BODY     T_WORK_ACC_SLIP_BODY%ROWTYPE;
lrACC_CODE						T_ACC_CODE%ROWTYPE;
lnCnt							NUMBER;
/**************************************************************************/
/* 1. �� �� �� �� id : Sp_T_Work_Detail_To_Slip
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : ����ϵ� �ڵ���ǥ ������ ���λ����� ��ǥ��ȣ �Է�....
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-12-07)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
BEGIN
	BEGIN
		SELECT *
		INTO lrWORK_SLIP_BODY
		FROM T_WORK_ACC_SLIP_BODY
		WHERE
			SLIP_ID = AR_WORK_SLIP_ID
			AND SLIP_IDSEQ = AR_WORK_SLIP_IDSEQ;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RAISE_APPLICATION_ERROR	(-20009, '������ �Է������� ã�� �� �����ϴ�.');
	END;
	
	BEGIN
		SELECT *
		INTO lrACC_CODE
		FROM T_ACC_CODE
		WHERE
			ACC_CODE = lrWORK_SLIP_BODY.ACC_CODE;
	EXCEPTION WHEN NO_DATA_FOUND THEN
		RAISE_APPLICATION_ERROR	(-20009, '�������� ã�� �� �����ϴ�.');
	END;
	
	-- ���¼�ǥ
	IF lrACC_CODE.CHK_NO_MNG = 'T' AND lrWORK_SLIP_BODY.CHK_NO IS NOT NULL THEN
	
		SELECT COUNT(*)
		INTO lnCnt
		FROM T_FIN_PAY_CHK_BILL
		WHERE
			CHK_BILL_CLS = 'C'
			AND	CHK_BILL_NO = lrWORK_SLIP_BODY.CHK_NO
			AND SLIP_ID IS NOT NULL;
			
		IF lnCnt <> 0 THEN
			RAISE_APPLICATION_ERROR	(-20009, '��ǥ�� ����� ���¼�ǥ�Դϴ�.<br>�ߺ� ������ �� �����ϴ�.');
		END IF;
				
		UPDATE	T_FIN_PAY_CHK_BILL
		SET
			MODUSERNO = AR_MODUSERNO,
			SLIP_ID = AR_SLIP_ID,
			SLIP_IDSEQ = AR_SLIP_IDSEQ,
			STAT_CLS = '2'
		WHERE
			CHK_BILL_CLS = 'C'
			AND	CHK_BILL_NO = lrWORK_SLIP_BODY.CHK_NO
			AND STAT_CLS = '1';
	ELSE
		NULL;
	END IF;
	
	--���޾��� : BILL_NO
	IF lrACC_CODE.BILL_NO_MNG = 'T' AND lrWORK_SLIP_BODY.BILL_NO IS NOT NULL THEN
		IF (NVL(lrACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrWORK_SLIP_BODY.DB_AMT, 0) > 0) OR
			(NVL(lrACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrWORK_SLIP_BODY.CR_AMT, 0) > 0) THEN
			
			SELECT COUNT(*)
			INTO lnCnt
			FROM T_FIN_PAY_CHK_BILL
			WHERE
				CHK_BILL_CLS = 'B'
				AND	CHK_BILL_NO = lrWORK_SLIP_BODY.BILL_NO
				AND SLIP_ID IS NOT NULL;
				
			IF lnCnt <> 0 THEN
				RAISE_APPLICATION_ERROR	(-20009, '������ǥ�� ����� ���޾����Դϴ�.<br>�ߺ� ������ �� �����ϴ�.');
			END IF;
			--���޾��� ����
			UPDATE T_FIN_PAY_CHK_BILL
			SET
				MODUSERNO = AR_MODUSERNO,
				SLIP_ID = AR_SLIP_ID,
				SLIP_IDSEQ = AR_SLIP_IDSEQ,
				STAT_CLS = '2'
			WHERE	CHK_BILL_CLS = 'B'
				AND	CHK_BILL_NO = lrWORK_SLIP_BODY.BILL_NO
				AND STAT_CLS = '1';
		ELSE
			SELECT COUNT(*)
			INTO lnCnt
			FROM T_FIN_PAY_CHK_BILL
			WHERE
				CHK_BILL_CLS = 'B'
				AND	CHK_BILL_NO = lrWORK_SLIP_BODY.BILL_NO
				AND RESET_SLIP_ID IS NOT NULL;
				
			IF lnCnt <> 0 THEN
				RAISE_APPLICATION_ERROR	(-20009, '������ǥ�� ����� ���޾����Դϴ�.<br>�ߺ� ������ �� �����ϴ�.');
			END IF;
			--���޾��� ����
			UPDATE T_FIN_PAY_CHK_BILL
			SET
				MODUSERNO = AR_MODUSERNO,
				RESET_SLIP_ID = AR_SLIP_ID,
				RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ
			WHERE
				CHK_BILL_CLS = 'B'
				AND	CHK_BILL_NO = lrWORK_SLIP_BODY.BILL_NO;
		END IF;
	ELSE
		NULL;
	END IF;
	
	--�������� : REC_BILL_NO
	IF lrACC_CODE.REC_BILL_NO_MNG = 'T' AND lrWORK_SLIP_BODY.REC_BILL_NO IS NOT NULL THEN
		IF (NVL(lrACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrWORK_SLIP_BODY.DB_AMT, 0) > 0) OR
			(NVL(lrACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrWORK_SLIP_BODY.CR_AMT, 0) > 0) THEN
			--�������� ����
			SELECT COUNT(*)
			INTO lnCnt
			FROM T_FIN_RECEIVE_CHK_BILL
			WHERE
				REC_CHK_BILL_NO = lrWORK_SLIP_BODY.REC_BILL_NO
				AND SLIP_ID IS NOT NULL;
				
			IF lnCnt <> 0 THEN
				RAISE_APPLICATION_ERROR	(-20009, '������ǥ�� ����� ���޾����Դϴ�.<br>�ߺ� ������ �� �����ϴ�.');
			END IF;
			
			UPDATE T_FIN_RECEIVE_CHK_BILL
			SET
				MODUSERNO = AR_MODUSERNO,
				SLIP_ID = AR_SLIP_ID,
				SLIP_IDSEQ = AR_SLIP_IDSEQ
			WHERE	REC_CHK_BILL_NO = lrWORK_SLIP_BODY.REC_BILL_NO;
		ELSE
			--�������� ����
			SELECT COUNT(*)
			INTO lnCnt
			FROM T_FIN_RECEIVE_CHK_BILL
			WHERE
				REC_CHK_BILL_NO = lrWORK_SLIP_BODY.REC_BILL_NO
				AND RESET_SLIP_ID IS NOT NULL;
				
			IF lnCnt <> 0 THEN
				RAISE_APPLICATION_ERROR	(-20009, '������ǥ�� ����� ���������Դϴ�.<br>�ߺ� ������ �� �����ϴ�.');
			END IF;
			
			UPDATE T_FIN_RECEIVE_CHK_BILL
			SET
				MODUSERNO = AR_MODUSERNO,
				RESET_SLIP_ID = AR_SLIP_ID,
				RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ
			WHERE	REC_CHK_BILL_NO = lrWORK_SLIP_BODY.REC_BILL_NO;
		END IF;
	ELSE
		NULL;
	END IF;
	
	--�������� : SECU_NO
	IF lrACC_CODE.SECU_MNG = 'T' AND lrWORK_SLIP_BODY.SECU_NO IS NOT NULL THEN
		IF (NVL(lrACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrWORK_SLIP_BODY.DB_AMT, 0) > 0) OR
			(NVL(lrACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrWORK_SLIP_BODY.CR_AMT, 0) > 0) THEN
			--�������� ����
			SELECT COUNT(*)
			INTO lnCnt
			FROM T_FIN_SECURTY
			WHERE
				SECU_NO = lrWORK_SLIP_BODY.SECU_NO
				AND SLIP_ID IS NOT NULL;
				
			IF lnCnt <> 0 THEN
				RAISE_APPLICATION_ERROR	(-20009, '������ǥ�� ����� ���������Դϴ�.<br>�ߺ� ������ �� �����ϴ�.');
			END IF;
			
			UPDATE T_FIN_SECURTY
			SET
				MODUSERNO = AR_MODUSERNO,
				SLIP_ID = AR_SLIP_ID,
				SLIP_IDSEQ = AR_SLIP_IDSEQ
			WHERE	SECU_NO = lrWORK_SLIP_BODY.SECU_NO;
		ELSE
			--�������� ����
			SELECT COUNT(*)
			INTO lnCnt
			FROM T_FIN_SECURTY
			WHERE
				SECU_NO = lrWORK_SLIP_BODY.SECU_NO
				AND RESET_SLIP_ID IS NOT NULL;
				
			IF lnCnt <> 0 THEN
				RAISE_APPLICATION_ERROR	(-20009, '������ǥ�� ����� ���������Դϴ�.<br>�ߺ� ������ �� �����ϴ�.');
			END IF;
			
			UPDATE T_FIN_SECURTY
			SET
				MODUSERNO = AR_MODUSERNO,
				RESET_SLIP_ID = AR_SLIP_ID,
				RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ
			WHERE	SECU_NO = lrWORK_SLIP_BODY.SECU_NO;
		END IF;
	ELSE
		NULL;
	END IF;
	
	--����/��ȯ : ��ȣ�� ���� : LOAN_NO(X), LOAN_REFUND_NO, LOAN_REFUND_SEQ
	IF lrACC_CODE.LOAN_NO_MNG = 'T' AND lrWORK_SLIP_BODY.LOAN_REFUND_NO IS NOT NULL THEN
		IF (NVL(lrACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrWORK_SLIP_BODY.DB_AMT, 0) > 0) OR
			(NVL(lrACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrWORK_SLIP_BODY.CR_AMT, 0) > 0) THEN
			--���� ����
			SELECT COUNT(*)
			INTO lnCnt
			FROM T_FIN_LOAN_REFUND_LIST
			WHERE
				LOAN_NO = lrWORK_SLIP_BODY.LOAN_REFUND_NO
				AND	LOAN_REFUND_SEQ = lrWORK_SLIP_BODY.LOAN_REFUND_SEQ
				AND LOAN_SLIP_ID IS NOT NULL;
				
			IF lnCnt <> 0 THEN
				RAISE_APPLICATION_ERROR	(-20009, '��ǥ�� ����� ���Ա��Դϴ�.<br>�ߺ� ������ �� �����ϴ�.');
			END IF;
			
			UPDATE T_FIN_LOAN_REFUND_LIST
			SET
				MODUSERNO = AR_MODUSERNO,
				LOAN_SLIP_ID = AR_SLIP_ID,
				LOAN_SLIP_IDSEQ = AR_SLIP_IDSEQ
			WHERE
				LOAN_NO = lrWORK_SLIP_BODY.LOAN_REFUND_NO
				AND	LOAN_REFUND_SEQ = lrWORK_SLIP_BODY.LOAN_REFUND_SEQ;
		ELSE
			--���� ��ȯ(����)
			SELECT COUNT(*)
			INTO lnCnt
			FROM T_FIN_LOAN_REFUND_LIST
			WHERE
				LOAN_NO = lrWORK_SLIP_BODY.LOAN_REFUND_NO
				AND	LOAN_REFUND_SEQ = lrWORK_SLIP_BODY.LOAN_REFUND_SEQ
				AND REFUND_SLIP_ID IS NOT NULL;
				
			IF lnCnt <> 0 THEN
				RAISE_APPLICATION_ERROR	(-20009, '��ǥ�� ����� ���Ի�ȯ���Դϴ�.<br>�ߺ� ������ �� �����ϴ�.');
			END IF;
			
			UPDATE T_FIN_LOAN_REFUND_LIST
			SET
				MODUSERNO = AR_MODUSERNO,
				REFUND_SLIP_ID = AR_SLIP_ID,
				REFUND_SLIP_IDSEQ = AR_SLIP_IDSEQ
			WHERE
				LOAN_NO = lrWORK_SLIP_BODY.LOAN_REFUND_NO
				AND	LOAN_REFUND_SEQ = lrWORK_SLIP_BODY.LOAN_REFUND_SEQ;
		END IF;
	ELSE
		NULL;
	END IF;
	
	--������ : ��ȣ�� ���� : DEPOSIT_ACCNO, 	PAYMENT_SEQ
	IF lrACC_CODE.DEPOSIT_PAY_MNG = 'T' AND lrWORK_SLIP_BODY.PAYMENT_SEQ IS NOT NULL THEN
		IF (NVL(lrACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrWORK_SLIP_BODY.DB_AMT, 0) > 0) OR
			(NVL(lrACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrWORK_SLIP_BODY.CR_AMT, 0) > 0) THEN
			--���� ����
			SELECT COUNT(*)
			INTO lnCnt
			FROM T_DEPOSIT_PAYMENT_LIST
			WHERE
				ACCNO = lrWORK_SLIP_BODY.DEPOSIT_ACCNO
				AND PAYMENT_SEQ = lrWORK_SLIP_BODY.PAYMENT_SEQ
				AND SLIP_ID IS NOT NULL;
				
			IF lnCnt <> 0 THEN
				RAISE_APPLICATION_ERROR	(-20009, '��ǥ�� ����� �����Դϴ�.<br>�ߺ� ������ �� �����ϴ�.');
			END IF;
			
			UPDATE T_DEPOSIT_PAYMENT_LIST
			SET
				MODUSERNO = AR_MODUSERNO,
				SLIP_ID = AR_SLIP_ID,
				SLIP_IDSEQ = AR_SLIP_IDSEQ
			WHERE	ACCNO = lrWORK_SLIP_BODY.DEPOSIT_ACCNO
			AND PAYMENT_SEQ = lrWORK_SLIP_BODY.PAYMENT_SEQ;
		ELSE
			--���� ����
			NULL;
		END IF;
	ELSE
		NULL;
	END IF;

	--������� : CP_NO
	IF lrACC_CODE.CP_NO_MNG = 'T' AND lrWORK_SLIP_BODY.CP_NO IS NOT NULL THEN
		IF (NVL(lrACC_CODE.ACC_REMAIN_POSITION,'D') = 'D' AND NVL(lrWORK_SLIP_BODY.DB_AMT, 0) > 0) OR
			(NVL(lrACC_CODE.ACC_REMAIN_POSITION,'D') = 'C' AND NVL(lrWORK_SLIP_BODY.CR_AMT, 0) > 0) THEN
			--CP���� ����
			SELECT COUNT(*)
			INTO lnCnt
			FROM T_FIN_CP_BUY
			WHERE
				CP_NO = lrWORK_SLIP_BODY.CP_NO
				AND SLIP_ID IS NOT NULL;
				
			IF lnCnt <> 0 THEN
				RAISE_APPLICATION_ERROR	(-20009, '������ǥ�� ����� CP(����)�Դϴ�.<br>�ߺ� ������ �� �����ϴ�.');
			END IF;
			
			UPDATE T_FIN_CP_BUY
			SET
				MODUSERNO = AR_MODUSERNO,
				SLIP_ID = AR_SLIP_ID,
				SLIP_IDSEQ = AR_SLIP_IDSEQ
			WHERE	CP_NO = lrWORK_SLIP_BODY.CP_NO;
		ELSE
			--CP���� ����
			SELECT COUNT(*)
			INTO lnCnt
			FROM T_FIN_CP_BUY
			WHERE
				CP_NO = lrWORK_SLIP_BODY.CP_NO
				AND RESET_SLIP_ID IS NOT NULL;
				
			IF lnCnt <> 0 THEN
				RAISE_APPLICATION_ERROR	(-20009, '������ǥ�� ����� CP(����)�Դϴ�.<br>�ߺ� ������ �� �����ϴ�.');
			END IF;
			
			UPDATE T_FIN_CP_BUY
			SET
				MODUSERNO = AR_MODUSERNO,
				RESET_SLIP_ID = AR_SLIP_ID,
				RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ
			WHERE	CP_NO = lrWORK_SLIP_BODY.CP_NO;
		END IF;
	ELSE
		NULL;
	END IF;

	--���ݿ�����
	INSERT INTO T_ACC_SLIP_EXPENSE_CASH
	(
		SLIP_ID,
		SLIP_IDSEQ,
		CASH_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CASHNO,
		USE_DT,
		EMP_NO,
		HAVE_PERS,
		CUST_CODE,
		CUST_NAME,
		TRADE_AMT,
		REQ_TG
	)
	SELECT 
		AR_SLIP_ID,--SLIP_ID,
		AR_SLIP_IDSEQ,--SLIP_IDSEQ,
		CASH_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CASHNO,
		USE_DT,
		EMP_NO,
		HAVE_PERS,
		CUST_CODE,
		CUST_NAME,
		TRADE_AMT,
		REQ_TG
	FROM
		T_WORK_ACC_SLIP_EXPENSE_CASH
	WHERE
		SLIP_ID = AR_WORK_SLIP_ID
		AND SLIP_IDSEQ = AR_WORK_SLIP_IDSEQ;

	--ī�念����
	INSERT INTO T_ACC_SLIP_EXPENSE_CARDS
	(
		SLIP_ID,
		SLIP_IDSEQ,
		CARD_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CARDNO,
		USE_DT,
		HAVE_PERS,
		CUST_CODE,
		CUST_NAME,
		TRADE_AMT,
		REQ_TG
	)
	SELECT
		AR_SLIP_ID,--SLIP_ID,
		AR_SLIP_IDSEQ,--SLIP_IDSEQ,
		CARD_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		CARDNO,
		USE_DT,
		HAVE_PERS,
		CUST_CODE,
		CUST_NAME,
		TRADE_AMT,
		REQ_TG
	FROM
		T_WORK_ACC_SLIP_EXPENSE_CARDS
	WHERE
		SLIP_ID = AR_WORK_SLIP_ID
		AND SLIP_IDSEQ = AR_WORK_SLIP_IDSEQ;
END;
/