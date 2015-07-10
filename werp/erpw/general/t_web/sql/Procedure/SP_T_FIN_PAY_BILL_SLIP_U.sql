CREATE OR REPLACE PROCEDURE Sp_T_Fin_Pay_Bill_Slip_U
(
	AR_SLIP_ID                                    NUMBER,
	AR_SLIP_IDSEQ                                 NUMBER,
	AR_MODUSERNO                                  VARCHAR2,
	AR_ACC_REMAIN_POSITION                        VARCHAR2,
	AR_DB_AMT                                     NUMBER,
	AR_CR_AMT                                     NUMBER,
	AR_CUST_SEQ                                   VARCHAR2,
	--지급어음
	AR_BILL_NO_MNG                                VARCHAR2,
	AR_BILL_NO_MNG_TG                             VARCHAR2,
	--지급어음 설정
	AR_BILL_NO_S                                  VARCHAR2,
	AR_BILL_PUBL_DT                               VARCHAR2,
	AR_BILL_EXPR_DT                               VARCHAR2,
	--지급어음 반제
	AR_BILL_NO_R                                  VARCHAR2,
	AR_BILL_PUBL_DT_R                             VARCHAR2,
	AR_BILL_EXPR_DT_R                             VARCHAR2,
	AR_BILL_CHG_EXPR_DT_R                         VARCHAR2,
	AR_BILL_COLL_DT_R                                VARCHAR2,
	AR_SUMMARY1                                VARCHAR2
)
IS
	lnCnt						T_ACC_SLIP_BODY.SLIP_ID%TYPE;
	lsMsg						VARCHAR2(4000);
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_BILL_SLIP
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : 지급어음발행
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
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
		lsMsg := '전표생성오류!!!<br>'||'해당지급어음의 반제내역이 존재합니다.<br>해당전표내역을 삭제할수 없습니다.'||lsMsg;
		RAISE_APPLICATION_ERROR (-20009, lsMsg);
	ELSE
		UPDATE T_FIN_PAY_CHK_BILL
		SET
			MODUSERNO = AR_MODUSERNO,
			STAT_CLS = '1',
			CUST_SEQ = NULL,
			PUBL_DT = NULL,
			EXPR_DT = NULL,
			PUBL_AMT = 0,
			SLIP_ID = NULL,
			SLIP_IDSEQ = NULL
		WHERE	CHK_BILL_CLS = 'B'
		AND		SLIP_ID = AR_SLIP_ID
		AND		SLIP_IDSEQ = AR_SLIP_IDSEQ
		AND		RESET_SLIP_ID IS NULL;
	END IF;

	UPDATE T_FIN_PAY_CHK_BILL
	SET
		MODUSERNO = AR_MODUSERNO,
		COLL_DT = NULL,
		REMARKS = NULL,
		RESET_SLIP_ID = NULL,
		RESET_SLIP_IDSEQ = NULL
	WHERE	CHK_BILL_CLS = 'B'
	AND	RESET_SLIP_ID = AR_SLIP_ID
	AND	RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ;
		
	IF (AR_BILL_NO_MNG = 'T' AND AR_BILL_NO_S IS NOT NULL) OR (AR_BILL_NO_MNG = 'T' AND AR_BILL_NO_R IS NOT NULL) THEN
		IF (NVL(AR_ACC_REMAIN_POSITION,'D') = 'D' AND NVL(AR_DB_AMT, 0) > 0) OR
			(NVL(AR_ACC_REMAIN_POSITION,'D') = 'C' AND NVL(AR_CR_AMT, 0) > 0) THEN
			--지급어음 설정
			UPDATE T_FIN_PAY_CHK_BILL
			SET
				MODUSERNO = AR_MODUSERNO,
				STAT_CLS = '2',
				CUST_SEQ = AR_CUST_SEQ,
				PUBL_DT = F_T_Stringtodate(AR_BILL_PUBL_DT),
				EXPR_DT = F_T_Stringtodate(AR_BILL_EXPR_DT),
				PUBL_AMT = AR_DB_AMT + AR_CR_AMT,
				SLIP_ID = AR_SLIP_ID,
				SLIP_IDSEQ = AR_SLIP_IDSEQ
			WHERE	CHK_BILL_CLS = 'B'
			AND		CHK_BILL_NO = AR_BILL_NO_S;
		ELSE
			--지급어음 반제
			UPDATE T_FIN_PAY_CHK_BILL
			SET
				MODUSERNO = AR_MODUSERNO,
				COLL_DT = F_T_Stringtodate(AR_BILL_COLL_DT_R),
				REMARKS = AR_SUMMARY1,
				RESET_SLIP_ID = AR_SLIP_ID,
				RESET_SLIP_IDSEQ = AR_SLIP_IDSEQ
			WHERE	CHK_BILL_CLS = 'B'
			AND		CHK_BILL_NO = AR_BILL_NO_R;
		END IF;
	ELSE
		NULL;
	END IF;
END;
/
