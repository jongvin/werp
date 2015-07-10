CREATE OR REPLACE PROCEDURE SP_T_ACC_VAT_DIV_CODE_I
(
	AR_DIV_COMP_CODE                           VARCHAR2,
	AR_DIV_CODE                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_DIV_NAME                                VARCHAR2,
	AR_DIV_RATIO                               NUMBER,
	AR_REMARKS                                 VARCHAR2,
	AR_USE_TAG                                 VARCHAR2,
	AR_MAIN_TAG                                 VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_VAT_DIV_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_VAT_DIV_CODE 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	INSERT INTO T_ACC_VAT_DIV_CODE
	(
		DIV_COMP_CODE,
		DIV_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		DIV_NAME,
		DIV_RATIO,
		REMARKS,
		USE_TAG,
		MAIN_TAG
	)
	VALUES
	(
		AR_DIV_COMP_CODE,
		AR_DIV_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_DIV_NAME,
		AR_DIV_RATIO,
		AR_REMARKS,
		AR_USE_TAG,
		AR_MAIN_TAG
	);
END;
/
CREATE OR REPLACE PROCEDURE SP_T_ACC_VAT_DIV_CODE_U
(
	AR_DIV_COMP_CODE                           VARCHAR2,
	AR_DIV_CODE                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_DIV_NAME                                VARCHAR2,
	AR_DIV_RATIO                               NUMBER,
	AR_REMARKS                                 VARCHAR2,
	AR_USE_TAG                                 VARCHAR2,
	AR_MAIN_TAG                                 VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_VAT_DIV_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_VAT_DIV_CODE 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	UPDATE T_ACC_VAT_DIV_CODE
	SET
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		DIV_NAME = AR_DIV_NAME,
		DIV_RATIO = AR_DIV_RATIO,
		REMARKS = AR_REMARKS,
		USE_TAG = AR_USE_TAG,
		MAIN_TAG = AR_MAIN_TAG
	WHERE	DIV_COMP_CODE = AR_DIV_COMP_CODE
	AND	DIV_CODE = AR_DIV_CODE;
END;
/
CREATE OR REPLACE PROCEDURE SP_T_ACC_VAT_DIV_CODE_D
(
	AR_DIV_COMP_CODE                           VARCHAR2,
	AR_DIV_CODE                                VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_ACC_VAT_DIV_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_ACC_VAT_DIV_CODE 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-15)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	DELETE T_ACC_VAT_DIV_CODE
	WHERE	DIV_COMP_CODE = AR_DIV_COMP_CODE
	AND	DIV_CODE = AR_DIV_CODE;
END;
/
