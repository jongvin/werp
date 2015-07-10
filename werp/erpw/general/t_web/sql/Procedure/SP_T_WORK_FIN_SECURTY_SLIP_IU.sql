CREATE OR REPLACE PROCEDURE Sp_T_Work_Fin_Securty_Slip_Iu
(
	AR_SLIP_ID                                    NUMBER,
	AR_SLIP_IDSEQ                                 NUMBER,
	AR_CRTUSERNO                                  VARCHAR2,
	AR_ACC_REMAIN_POSITION                        VARCHAR2,
	AR_COMP_CODE                                  VARCHAR2,
	AR_DB_AMT                                     NUMBER,
	AR_CR_AMT                                     NUMBER,
	--유가증권
	AR_SECU_MNG                                   VARCHAR2,
	AR_SECU_MNG_TG                                VARCHAR2,
	--유가증권 설정
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
	--유가증권 반제
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
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_CHK_SLIP
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : 당좌수표？행
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
BEGIN

	SELECT	COUNT(*)
	INTO	lnCnt
	FROM	T_FIN_SECURTY
	WHERE
		( SECU_NO = AR_SECU_NO_S AND SLIP_ID IS NOT NULL );

	IF NVL(lnCnt,0) > 0 THEN
		lsMsg := '전표생성오류!!!<br>'||'유가증권의 설정전표가 이미 존재합니다.<br>해당내역을 수정할 수 없습니다.'||lsMsg;
		RAISE_APPLICATION_ERROR (-20009, lsMsg);
	ELSE
		NULL;
	END IF;
	
	SELECT	COUNT(*)
	INTO	lnCnt
	FROM	T_FIN_SECURTY
	WHERE
		( SECU_NO = AR_SECU_NO_R AND RESET_SLIP_ID IS NOT NULL );

	IF NVL(lnCnt,0) > 0 THEN
		lsMsg := '전표생성오류!!!<br>'||'해당유가증권의 반제전표가 이미 존재합니다.<br>해당내역을 수정할 수 없습니다.'||lsMsg;
		RAISE_APPLICATION_ERROR (-20009, lsMsg);
	ELSE
		NULL;
	END IF;

	IF (AR_SECU_MNG = 'T' AND AR_SECU_REAL_SECU_NO_S IS NOT NULL) OR (AR_SECU_MNG = 'T' AND AR_SECU_REAL_SECU_NO_R IS NOT NULL) THEN
		IF (NVL(AR_ACC_REMAIN_POSITION,'D') = 'D' AND NVL(AR_DB_AMT, 0) > 0) OR
			(NVL(AR_ACC_REMAIN_POSITION,'D') = 'C' AND NVL(AR_CR_AMT, 0) > 0) THEN
			--유가증권 설정
			SELECT	COUNT(*)
			INTO	lnCnt
			FROM	T_FIN_SECURTY
			WHERE	SECU_NO = AR_SECU_NO_S;
			
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
					NULL,--AR_SLIP_ID,
					NULL,--AR_SLIP_IDSEQ,
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
				UPDATE T_WORK_ACC_SLIP_BODY
				SET
					SECU_NO = lnSECU_NO
				WHERE
					SLIP_ID = AR_SLIP_ID
				AND	SLIP_IDSEQ = AR_SLIP_IDSEQ;
			ELSE
				UPDATE T_FIN_SECURTY
				SET
					MODUSERNO = AR_CRTUSERNO,
					SEC_KIND_CODE = AR_SECU_SEC_KIND_CODE,
					REAL_SECU_NO = AR_SECU_REAL_SECU_NO_S,
					--SLIP_ID = AR_SLIP_ID,
					--SLIP_IDSEQ = AR_SLIP_IDSEQ,
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
		ELSE
			--유가증권 반제
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
				RESET_SLIP_ID = NULL,
				RESET_SLIP_IDSEQ = NULL
			WHERE	SECU_NO = AR_SECU_NO_R;
		END IF;
	ELSE
		NULL;
	END IF;
END;
/
