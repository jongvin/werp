CREATE OR REPLACE PROCEDURE SP_T_PL_MA_DVD_CODE_I
(
	AR_DVD_CODE                                VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_DVD_NAME                                VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_DVD_CODE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_DVD_CODE 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	INSERT INTO T_PL_MA_DVD_CODE
	(
		DVD_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		DVD_NAME,
		FUNC_NAME
	)
	VALUES
	(
		AR_DVD_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_DVD_NAME,
		AR_FUNC_NAME
	);
END;
/
CREATE OR REPLACE PROCEDURE SP_T_PL_MA_DVD_CODE_U
(
	AR_DVD_CODE                                VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_DVD_NAME                                VARCHAR2,
	AR_FUNC_NAME                               VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_DVD_CODE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_DVD_CODE 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	UPDATE T_PL_MA_DVD_CODE
	SET
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		DVD_NAME = AR_DVD_NAME,
		FUNC_NAME = AR_FUNC_NAME
	WHERE	DVD_CODE = AR_DVD_CODE;
END;
/
CREATE OR REPLACE PROCEDURE SP_T_PL_MA_DVD_CODE_D
(
	AR_DVD_CODE                                VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_DVD_CODE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_DVD_CODE 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	DELETE T_PL_MA_DVD_CODE
	WHERE	DVD_CODE = AR_DVD_CODE;
END;
/
