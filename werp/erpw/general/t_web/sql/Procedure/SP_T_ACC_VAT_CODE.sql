CREATE OR REPLACE PROCEDURE Sp_T_Acc_Vat_Code_I
(
	AR_VAT_CODE                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_VAT_NAME                                VARCHAR2,
	AR_SUBTR_CLS                               VARCHAR2,
	AR_SALEBUY_CLS                             VARCHAR2,
	AR_RCPTBILL_CLS                            VARCHAR2,
	AR_VATOCCUR_CLS                            VARCHAR2,
	AR_DIVI_CLS                                VARCHAR2,
	AR_SLIP_DETAIL_LIST                        VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_BRAIN_CLS                               VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_VAT_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_VAT_CODE 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	INSERT INTO T_ACC_VAT_CODE
	(
		VAT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		VAT_NAME,
		SUBTR_CLS,
		SALEBUY_CLS,
		RCPTBILL_CLS,
		VATOCCUR_CLS,
		DIVI_CLS,
		SLIP_DETAIL_LIST,
		ACC_CODE,
		BRAIN_CLS
	)
	VALUES
	(
		AR_VAT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_VAT_NAME,
		AR_SUBTR_CLS,
		AR_SALEBUY_CLS,
		AR_RCPTBILL_CLS,
		AR_VATOCCUR_CLS,
		AR_DIVI_CLS,
		AR_SLIP_DETAIL_LIST,
		AR_ACC_CODE,
		AR_BRAIN_CLS
	);
END;
/
CREATE OR REPLACE PROCEDURE Sp_T_Acc_Vat_Code_U
(
	AR_VAT_CODE                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_VAT_NAME                                VARCHAR2,
	AR_SUBTR_CLS                               VARCHAR2,
	AR_SALEBUY_CLS                             VARCHAR2,
	AR_RCPTBILL_CLS                            VARCHAR2,
	AR_VATOCCUR_CLS                            VARCHAR2,
	AR_DIVI_CLS                                VARCHAR2,
	AR_SLIP_DETAIL_LIST                        VARCHAR2,
	AR_ACC_CODE                                VARCHAR2,
	AR_BRAIN_CLS                               VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_VAT_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_VAT_CODE 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	UPDATE T_ACC_VAT_CODE
	SET
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		VAT_NAME = AR_VAT_NAME,
		SUBTR_CLS = AR_SUBTR_CLS,
		SALEBUY_CLS = AR_SALEBUY_CLS,
		RCPTBILL_CLS = AR_RCPTBILL_CLS,
		VATOCCUR_CLS = AR_VATOCCUR_CLS,
		DIVI_CLS = AR_DIVI_CLS,
		SLIP_DETAIL_LIST = AR_SLIP_DETAIL_LIST,
		ACC_CODE = AR_ACC_CODE,
		BRAIN_CLS = AR_BRAIN_CLS
	WHERE	VAT_CODE = AR_VAT_CODE;
END;
/
CREATE OR REPLACE PROCEDURE Sp_T_Acc_Vat_Code_D
(
	AR_VAT_CODE                                VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_VAT_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_VAT_CODE 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-05-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	DELETE T_ACC_VAT_CODE
	WHERE	VAT_CODE = AR_VAT_CODE;
END;
/
