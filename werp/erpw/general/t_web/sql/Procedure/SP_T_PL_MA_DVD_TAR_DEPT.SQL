CREATE OR REPLACE PROCEDURE SP_T_PL_MA_DVD_TAR_DEPT_I
(
	AR_DVD_TAR_CODE                            VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_DVD_TAR_DEPT_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_DVD_TAR_DEPT 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	INSERT INTO T_PL_MA_DVD_TAR_DEPT
	(
		DVD_TAR_CODE,
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE
	)
	VALUES
	(
		AR_DVD_TAR_CODE,
		AR_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL
	);
END;
/
CREATE OR REPLACE PROCEDURE SP_T_PL_MA_DVD_TAR_DEPT_U
(
	AR_DVD_TAR_CODE                            VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_DVD_TAR_DEPT_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_DVD_TAR_DEPT 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	UPDATE T_PL_MA_DVD_TAR_DEPT
	SET
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE
	WHERE	DVD_TAR_CODE = AR_DVD_TAR_CODE
	AND	DEPT_CODE = AR_DEPT_CODE;
END;
/
CREATE OR REPLACE PROCEDURE SP_T_PL_MA_DVD_TAR_DEPT_D
(
	AR_DVD_TAR_CODE                            VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_DVD_TAR_DEPT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_DVD_TAR_DEPT 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-24)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	DELETE T_PL_MA_DVD_TAR_DEPT
	WHERE	DVD_TAR_CODE = AR_DVD_TAR_CODE
	AND	DEPT_CODE = AR_DEPT_CODE;
END;
/
