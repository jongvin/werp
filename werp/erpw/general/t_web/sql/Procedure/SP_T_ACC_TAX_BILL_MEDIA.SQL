CREATE OR REPLACE PROCEDURE Sp_T_Acc_Tax_Bill_Media_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_SEQ                                     NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_TAX_COMP_CODE                           VARCHAR2,
	AR_COMMBUY_CLS                             VARCHAR2,
	AR_PUBL_DT                                 VARCHAR2,
	AR_VAT_CODE                                VARCHAR2,
	AR_BOOK_NO                                 NUMBER,
	AR_BOOK_SEQ                                NUMBER,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CUST_SEQ                                NUMBER,
	AR_SUPAMT                                  NUMBER,
	AR_VATAMT                                  NUMBER,
	AR_ANNULMENT_CLS                           VARCHAR2,
	AR_ANNULMENT_DT                            VARCHAR2,
	AR_OUT_CNT                                 NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_MISSING_TAG                             VARCHAR2,
	AR_REMARK                                  VARCHAR2,
	AR_UDT_TAG                                 VARCHAR2,
	AR_CARD_CASH_NO                            VARCHAR2,
	AR_ACC_CODE                                VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_TAX_BILL_MEDIA_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_TAX_BILL_MEDIA 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-22)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
BEGIN
	INSERT INTO T_ACC_TAX_BILL_MEDIA
	(
		COMP_CODE,
		WORK_NO,
		SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		TAX_COMP_CODE,
		COMMBUY_CLS,
		PUBL_DT,
		VAT_CODE,
		BOOK_NO,
		BOOK_SEQ,
		DEPT_CODE,
		CUST_SEQ,
		SUPAMT,
		VATAMT,
		ANNULMENT_CLS,
		ANNULMENT_DT,
		OUT_CNT,
		SLIP_ID,
		SLIP_IDSEQ,
		MISSING_TAG,
		REMARK,
		UDT_TAG,
		CARD_CASH_NO,
		ACC_CODE
	)
	VALUES
	(
		AR_COMP_CODE,
		AR_WORK_NO,
		AR_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_TAX_COMP_CODE,
		AR_COMMBUY_CLS,
		F_T_Stringtodate(AR_PUBL_DT),
		AR_VAT_CODE,
		AR_BOOK_NO,
		AR_BOOK_SEQ,
		AR_DEPT_CODE,
		AR_CUST_SEQ,
		AR_SUPAMT,
		AR_VATAMT,
		AR_ANNULMENT_CLS,
		F_T_Stringtodate(AR_ANNULMENT_DT),
		AR_OUT_CNT,
		AR_SLIP_ID,
		AR_SLIP_IDSEQ,
		AR_MISSING_TAG,
		AR_REMARK,
		AR_UDT_TAG,
		AR_CARD_CASH_NO,
		AR_ACC_CODE
	);
END;
/


CREATE OR REPLACE PROCEDURE Sp_T_Acc_Tax_Bill_Media_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_SEQ                                     NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_TAX_COMP_CODE                           VARCHAR2,
	AR_COMMBUY_CLS                             VARCHAR2,
	AR_PUBL_DT                                 VARCHAR2,
	AR_VAT_CODE                                VARCHAR2,
	AR_BOOK_NO                                 NUMBER,
	AR_BOOK_SEQ                                NUMBER,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CUST_SEQ                                NUMBER,
	AR_SUPAMT                                  NUMBER,
	AR_VATAMT                                  NUMBER,
	AR_ANNULMENT_CLS                           VARCHAR2,
	AR_ANNULMENT_DT                            VARCHAR2,
	AR_OUT_CNT                                 NUMBER,
	AR_SLIP_ID                                 NUMBER,
	AR_SLIP_IDSEQ                              NUMBER,
	AR_MISSING_TAG                             VARCHAR2,
	AR_REMARK                                  VARCHAR2,
	AR_UDT_TAG                                 VARCHAR2,
	AR_CARD_CASH_NO                            VARCHAR2,
	AR_ACC_CODE                                VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_TAX_BILL_MEDIA_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_TAX_BILL_MEDIA 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-22)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
BEGIN
	UPDATE T_ACC_TAX_BILL_MEDIA
	SET
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		TAX_COMP_CODE = AR_TAX_COMP_CODE,
		COMMBUY_CLS = AR_COMMBUY_CLS,
		PUBL_DT = F_T_Stringtodate(AR_PUBL_DT),
		VAT_CODE = AR_VAT_CODE,
		BOOK_NO = AR_BOOK_NO,
		BOOK_SEQ = AR_BOOK_SEQ,
		DEPT_CODE = AR_DEPT_CODE,
		CUST_SEQ = AR_CUST_SEQ,
		SUPAMT = AR_SUPAMT,
		VATAMT = AR_VATAMT,
		ANNULMENT_CLS = AR_ANNULMENT_CLS,
		ANNULMENT_DT = F_T_Stringtodate(AR_ANNULMENT_DT),
		OUT_CNT = AR_OUT_CNT,
		SLIP_ID = AR_SLIP_ID,
		SLIP_IDSEQ = AR_SLIP_IDSEQ,
		MISSING_TAG = AR_MISSING_TAG,
		REMARK = AR_REMARK,
		UDT_TAG = DECODE(AR_UDT_TAG, 'D', 'D', DECODE(UDT_TAG, 'O', 'U', AR_UDT_TAG)),
		CARD_CASH_NO = AR_CARD_CASH_NO,
		ACC_CODE = AR_ACC_CODE
	WHERE	COMP_CODE = AR_COMP_CODE
	AND	WORK_NO = AR_WORK_NO
	AND	SEQ = AR_SEQ;
END;
/



CREATE OR REPLACE PROCEDURE SP_T_ACC_TAX_BILL_MEDIA_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_WORK_NO                                 NUMBER,
	AR_SEQ                                     NUMBER
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_TAX_BILL_MEDIA_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_TAX_BILL_MEDIA 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-22)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	DELETE T_ACC_TAX_BILL_MEDIA
	WHERE	COMP_CODE = AR_COMP_CODE
	AND	WORK_NO = AR_WORK_NO
	AND	SEQ = AR_SEQ;
END;
/
