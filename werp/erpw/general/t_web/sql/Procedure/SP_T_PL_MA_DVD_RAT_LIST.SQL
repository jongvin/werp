CREATE OR REPLACE PROCEDURE SP_T_PL_MA_DVD_RAT_LIST_I
(
	AR_HIST_SEQ                                NUMBER,
	AR_DVD_CODE                                VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_DVD_RAT_POSITION                        NUMBER
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_DVD_RAT_LIST_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_DVD_RAT_LIST 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	INSERT INTO T_PL_MA_DVD_RAT_LIST
	(
		HIST_SEQ,
		DVD_CODE,
		DEPT_CODE,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		DVD_RAT_POSITION
	)
	VALUES
	(
		AR_HIST_SEQ,
		AR_DVD_CODE,
		AR_DEPT_CODE,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_DVD_RAT_POSITION
	);
END;
/
CREATE OR REPLACE PROCEDURE SP_T_PL_MA_DVD_RAT_LIST_U
(
	AR_HIST_SEQ                                NUMBER,
	AR_DVD_CODE                                VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_DVD_RAT_POSITION                        NUMBER
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_DVD_RAT_LIST_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_DVD_RAT_LIST 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	UPDATE T_PL_MA_DVD_RAT_LIST
	SET
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		DVD_RAT_POSITION = AR_DVD_RAT_POSITION
	WHERE	HIST_SEQ = AR_HIST_SEQ
	AND	DVD_CODE = AR_DVD_CODE
	AND	DEPT_CODE = AR_DEPT_CODE;
END;
/
CREATE OR REPLACE PROCEDURE SP_T_PL_MA_DVD_RAT_LIST_D
(
	AR_HIST_SEQ                                NUMBER,
	AR_DVD_CODE                                VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_DVD_RAT_LIST_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_DVD_RAT_LIST 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	DELETE T_PL_MA_DVD_RAT_LIST
	WHERE	HIST_SEQ = AR_HIST_SEQ
	AND	DVD_CODE = AR_DVD_CODE
	AND	DEPT_CODE = AR_DEPT_CODE;
END;
/
