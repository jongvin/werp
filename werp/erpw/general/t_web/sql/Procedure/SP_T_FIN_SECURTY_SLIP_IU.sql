CREATE OR REPLACE PROCEDURE Sp_T_Fin_Securty_Slip_Iu
(
	AR_SLIP_ID                                    NUMBER,
	AR_SLIP_IDSEQ                                 NUMBER,
	AR_CRTUSERNO                                  VARCHAR2,
	AR_ACC_REMAIN_POSITION                        VARCHAR2,
	AR_COMP_CODE                                  VARCHAR2,
	AR_DB_AMT                                     NUMBER,
	AR_CR_AMT                                     NUMBER,
	--��������
	AR_SECU_MNG                                   VARCHAR2,
	AR_SECU_MNG_TG                                VARCHAR2,
	--�������� ����
	AR_SECU_NO_S                                           NUMBER,
	AR_SECU_REAL_SECU_NO_S                                   VARCHAR2,
	AR_SECU_SEC_KIND_CODE                                  VARCHAR2,
	AR_SECU_GET_DT                                         VARCHAR2,
	AR_SECU_GET_PLACE                                      VARCHAR2,
	AR_SECU_PERSTOCK_AMT                                   NUMBER,
	AR_SECU_INCOME_AMT                                     NUMBER,
	AR_SECU_BF_GET_ITR_AMT                                 NUMBER,
	AR_SECU_GET_ITR_AMT                                    NUMBER,
	AR_SECU_PUBL_DT                                        VARCHAR2,
	AR_SECU_ITR_TAG                                        VARCHAR2,
	AR_SECU_EXPR_DT                                        VARCHAR2,
	AR_SECU_INTR_RATE                                      NUMBER,
	--�������� ����
	AR_SECU_NO_R                                           NUMBER,
	AR_SECU_REAL_SECU_NO_R                                 VARCHAR2,
	AR_SECU_PERSTOCK_AMT_R                                 NUMBER,
	AR_SECU_PUBL_DT_R                                      VARCHAR2,
	AR_SECU_EXPR_DT_R                                      VARCHAR2,
	AR_SECU_INTR_RATE_R                                    NUMBER,
	AR_SECU_SALE_AMT_R                                     NUMBER,
	AR_SECU_SALE_DT_R                                      VARCHAR2,
	AR_SECU_RETURN_DT_R                                    VARCHAR2,
	AR_SECU_CONSIGN_BANK_R                                 VARCHAR2,
	AR_SECU_SALE_ITR_AMT_R                                 NUMBER,
	AR_SECU_SALE_TAX_R                                     NUMBER,
	AR_SECU_SALE_LOSS_R                                    NUMBER,
	AR_SECU_SALE_NP_ITR_AMT_R                              NUMBER
)
IS
	lnCnt						NUMBER;
	lnSECU_NO					NUMBER;
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

	IF (AR_SECU_MNG = 'T' AND AR_SECU_REAL_SECU_NO_S IS NOT NULL) OR (AR_SECU_MNG = 'T' AND AR_SECU_REAL_SECU_NO_R IS NOT NULL) THEN
		IF (NVL(AR_ACC_REMAIN_POSITION,'D') = 'D' AND NVL(AR_DB_AMT, 0) > 0) OR
			(NVL(AR_ACC_REMAIN_POSITION,'D') = 'C' AND NVL(AR_CR_AMT, 0) > 0) THEN
			--�������� ����
			SELECT	COUNT(*)
			INTO	lnCnt
			FROM	T_FIN_SECURTY
			WHERE	SLIP_ID = AR_SLIP_ID
			AND	SLIP_IDSEQ = AR_SLIP_IDSEQ
			AND	RESET_SLIP_ID IS NOT NULL;
	
			IF NVL(lnCnt,0) > 0 THEN
				lsMsg := '��ǥ��������!!!<br>'||'�ش����������� ���������� �����մϴ�.<br>���������� ��ϵ� �׸��� ������ �� �����ϴ�.'||lsMsg;
				RAISE_APPLICATION_ERROR (-20009, lsMsg);
			END IF;
			
			SELECT	COUNT(*)
			INTO	lnCnt
			FROM	T_FIN_SECURTY
			WHERE	SLIP_ID = AR_SLIP_ID
			AND	SLIP_IDSEQ = AR_SLIP_IDSEQ;
			
			IF lnCnt = 0 THEN
				SELECT	SQ_T_SECU_NO.NEXTVAL
				INTO	lnSECU_NO
				FROM	DUAL;
				
				Sp_T_Fin_Securty_I
				(
					lnSECU_NO,
					AR_CRTUSERNO,
					AR_SECU_SEC_KIND_CODE,
					AR_SECU_REAL_SECU_NO_S,
					AR_SLIP_ID,
					AR_SLIP_IDSEQ,
					NULL,--AR_RESET_SLIP_ID,
					NULL,--AR_RESET_SLIP_IDSEQ,
					AR_COMP_CODE,
					AR_SECU_GET_DT,
					AR_SECU_GET_PLACE,
					AR_SECU_PERSTOCK_AMT,
					AR_SECU_INCOME_AMT,
					AR_SECU_BF_GET_ITR_AMT,
					AR_SECU_GET_ITR_AMT,
					NULL,--AR_SALE_AMT,
					AR_SECU_PUBL_DT,
					AR_SECU_ITR_TAG,
					AR_SECU_INTR_RATE,
					AR_SECU_EXPR_DT,
					NULL,--AR_SALE_DT,
					NULL,--AR_RETURN_DT,
					NULL,--AR_CONSIGN_BANK,
					NULL,--AR_SALE_ITR_AMT,
					NULL,--AR_SALE_TAX,
					NULL,--AR_SALE_LOSS,
					NULL,--AR_SALE_NP_ITR_AMT
					NULL
				);
			ELSE
				UPDATE T_FIN_SECURTY
				SET
					MODUSERNO = AR_CRTUSERNO,
					SEC_KIND_CODE = AR_SECU_SEC_KIND_CODE,
					REAL_SECU_NO = AR_SECU_REAL_SECU_NO_S,
					SLIP_ID = AR_SLIP_ID,
					SLIP_IDSEQ = AR_SLIP_IDSEQ,
					COMP_CODE = AR_COMP_CODE,
					GET_DT = AR_SECU_GET_DT,
					GET_PLACE = AR_SECU_GET_PLACE,
					PERSTOCK_AMT = AR_SECU_PERSTOCK_AMT,
					INCOME_AMT = AR_SECU_INCOME_AMT,
					BF_GET_ITR_AMT = AR_SECU_BF_GET_ITR_AMT,
					GET_ITR_AMT = AR_SECU_GET_ITR_AMT,
					PUBL_DT = AR_SECU_PUBL_DT,
					ITR_TAG = AR_SECU_ITR_TAG,
					INTR_RATE = AR_SECU_INTR_RATE,
					EXPR_DT = AR_SECU_EXPR_DT
				WHERE	SECU_NO = AR_SECU_NO_S;
			END IF;
			
			--�������� ���� Ŭ����(Ȥ�ó� ���� ���¿��� �����Ǿ� ������ �������...)		
			UPDATE T_FIN_SECURTY
			SET
				MODUSERNO = AR_CRTUSERNO,
				SALE_AMT = NULL,
				SALE_DT = NULL,
				RETURN_DT = NULL,
				CONSIGN_BANK = NULL,
				SALE_ITR_AMT = NULL,
				SALE_TAX = NULL,
				SALE_LOSS = NULL,
				SALE_NP_ITR_AMT = NULL,
				RESET_SLIP_ID = NULL,
				RESET_SLIP_IDSEQ = NULL
			WHERE	RESET_SLIP_ID = AR_SLIP_ID
			AND	RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;
			
			UPDATE T_ACC_SLIP_BODY
			SET
				SECU_NO = (
					SELECT
						SECU_NO
					FROM
						T_FIN_SECURTY
					WHERE
						SLIP_ID = AR_SLIP_ID
					AND	SLIP_IDSEQ = AR_SLIP_IDSEQ
				)
			WHERE
				SLIP_ID = AR_SLIP_ID
			AND	SLIP_IDSEQ = AR_SLIP_IDSEQ;
		ELSE
			--�������� ����
			UPDATE T_FIN_SECURTY
			SET
				MODUSERNO = AR_CRTUSERNO,
				SALE_AMT = NULL,
				SALE_DT = NULL,
				RETURN_DT = NULL,
				CONSIGN_BANK = NULL,
				SALE_ITR_AMT = NULL,
				SALE_TAX = NULL,
				SALE_LOSS = NULL,
				SALE_NP_ITR_AMT = NULL,
				RESET_SLIP_ID = NULL,
				RESET_SLIP_IDSEQ = NULL
			WHERE	RESET_SLIP_ID = AR_SLIP_ID
			AND	RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;
			
			UPDATE T_FIN_SECURTY
			SET
				MODUSERNO = AR_CRTUSERNO,
				SALE_AMT = AR_SECU_SALE_AMT_R,
				SALE_DT = AR_SECU_SALE_DT_R,
				RETURN_DT = AR_SECU_RETURN_DT_R,
				CONSIGN_BANK = AR_SECU_CONSIGN_BANK_R,
				SALE_ITR_AMT = AR_SECU_SALE_ITR_AMT_R,
				SALE_TAX = AR_SECU_SALE_TAX_R,
				SALE_LOSS = AR_SECU_SALE_LOSS_R,
				SALE_NP_ITR_AMT = AR_SECU_SALE_NP_ITR_AMT_R,
				RESET_SLIP_ID = AR_SLIP_ID,
				RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ
			WHERE	SECU_NO = AR_SECU_NO_R;
			
			--�������� ���� Ŭ����(Ȥ�ó� ���� ���¿��� �����Ǿ� ������ �������...)
			SELECT	COUNT(*)
			INTO	lnCnt
			FROM
				T_FIN_SECURTY A,
				T_FIN_SEC_ITR_AMT B
			WHERE
			A.SECU_NO = B.SECU_NO
			AND	A.SLIP_ID = AR_SLIP_ID
			AND	A.SLIP_IDSEQ = AR_SLIP_IDSEQ;
			
			IF NVL(lnCnt,0) > 0 THEN
				lsMsg := '��ǥ��������!!!<br>'||'�ش����������� �̼����ڰ� �����մϴ�.<br>�����Ҽ� �����ϴ�.'||lsMsg;
				RAISE_APPLICATION_ERROR (-20009, lsMsg);
			END IF;	
		
			SELECT	COUNT(*)
			INTO	lnCnt
			FROM	T_FIN_SECURTY
			WHERE	SLIP_ID = AR_SLIP_ID
			AND	SLIP_IDSEQ = AR_SLIP_IDSEQ
			AND	RESET_SLIP_ID IS NOT NULL;
	
			IF NVL(lnCnt,0) > 0 THEN
				lsMsg := '��ǥ��������!!!<br>'||'�ش����������� ���������� �����մϴ�.<br>�����Ҽ� �����ϴ�.'||lsMsg;
				RAISE_APPLICATION_ERROR (-20009, lsMsg);
			ELSE
				DELETE	T_FIN_SECURTY
				WHERE	SLIP_ID = AR_SLIP_ID
				AND	SLIP_IDSEQ = AR_SLIP_IDSEQ
				AND	RESET_SLIP_ID IS NULL;
			END IF;
		END IF;

	ELSE
		-- �������� �̼����ڰ� ��ϵǾ� ������ ����
		SELECT	COUNT(*)
		INTO	lnCnt
		FROM
			T_FIN_SECURTY A,
			T_FIN_SEC_ITR_AMT B
		WHERE
		A.SECU_NO = B.SECU_NO
		AND	A.SLIP_ID = AR_SLIP_ID
		AND	A.SLIP_IDSEQ = AR_SLIP_IDSEQ;
		
		IF NVL(lnCnt,0) > 0 THEN
			lsMsg := '��ǥ��������!!!<br>'||'�ش����������� �̼����ڰ� �����մϴ�.<br>�����Ҽ� �����ϴ�.'||lsMsg;
			RAISE_APPLICATION_ERROR (-20009, lsMsg);
		END IF;	
	
		SELECT	COUNT(*)
		INTO	lnCnt
		FROM	T_FIN_SECURTY
		WHERE	SLIP_ID = AR_SLIP_ID
		AND	SLIP_IDSEQ = AR_SLIP_IDSEQ
		AND	RESET_SLIP_ID IS NOT NULL;

		IF NVL(lnCnt,0) > 0 THEN
			lsMsg := '��ǥ��������!!!<br>'||'�ش����������� ���������� �����մϴ�.<br>�����Ҽ� �����ϴ�.'||lsMsg;
			RAISE_APPLICATION_ERROR (-20009, lsMsg);
		ELSE
			DELETE	T_FIN_SECURTY
			WHERE	SLIP_ID = AR_SLIP_ID
			AND	SLIP_IDSEQ = AR_SLIP_IDSEQ
			AND	RESET_SLIP_ID IS NULL;
		END IF;
		
		-- ������ǥ�ΰ�� Clear
		UPDATE T_FIN_SECURTY
		SET
			MODUSERNO = AR_CRTUSERNO,
			SALE_AMT = NULL,
			SALE_DT = NULL,
			RETURN_DT = NULL,
			CONSIGN_BANK = NULL,
			SALE_ITR_AMT = NULL,
			SALE_TAX = NULL,
			SALE_LOSS = NULL,
			SALE_NP_ITR_AMT = NULL,
			RESET_SLIP_ID = NULL,
			RESET_SLIP_IDSEQ = NULL
		WHERE	RESET_SLIP_ID = AR_SLIP_ID
		AND	RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;
	END IF;
END;
/
