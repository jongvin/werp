CREATE OR REPLACE PROCEDURE Sp_T_Work_Fin_Pay_Chk_Slip_U
(
	--AR_SLIP_ID                                    NUMBER,
	--AR_SLIP_IDSEQ                                 NUMBER,
	AR_MODUSERNO                                  VARCHAR2,
	AR_DB_AMT                                     NUMBER,
	AR_CR_AMT                                     NUMBER,
	AR_CUST_SEQ                                   VARCHAR2,
	AR_CHK_NO_MNG                                 VARCHAR2,
	AR_CHK_NO_MNG_TG                              VARCHAR2,
	AR_CHK_NO                                     VARCHAR2,
	AR_CHK_PUBL_DT                                VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_FIN_PAY_CHK_SLIP
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : 당좌수표밠행
/* 4. 변  경  이  력 : 최언회 작성(2005-12-07)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
BEGIN
	IF AR_CHK_NO_MNG = 'T' AND AR_CHK_NO IS NOT NULL THEN

		UPDATE	T_FIN_PAY_CHK_BILL
		SET
			MODUSERNO = AR_MODUSERNO,
			CUST_SEQ = AR_CUST_SEQ,
			PUBL_DT = F_T_Stringtodate(AR_CHK_PUBL_DT),
			PUBL_AMT = AR_DB_AMT + AR_CR_AMT
		WHERE
		CHK_BILL_CLS = 'C'
		AND	CHK_BILL_NO = AR_CHK_NO
		AND STAT_CLS = '1';
	ELSE
		NULL;
	END IF;
END;
/
