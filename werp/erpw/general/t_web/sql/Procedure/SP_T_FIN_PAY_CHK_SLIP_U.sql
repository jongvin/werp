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
	FROM	T_FIN_PAY_CHK_BILL
	WHERE	CHK_BILL_CLS = 'B'
	AND		SLIP_ID = AR_SLIP_ID
	AND		SLIP_IDSEQ = AR_SLIP_IDSEQ
	AND		RESET_SLIP_ID IS NOT NULL;

	IF NVL(lnCnt,0) > 0 THEN
		lsMsg := '전표생성오류!!!<br>'||'해당당좌수표가 이미 회수되었습니다.<br>해당전표내역을 수정할수 없습니다.'||lsMsg;
		RAISE_APPLICATION_ERROR (-20009, lsMsg);
	ELSE
		--당좌수표 발행 취소
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
	
	--당좌수표 회수 취소
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
			--당좌수표 회수
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
			--당좌수표 발행
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
