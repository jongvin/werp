CREATE OR REPLACE PROCEDURE SP_T_PL_MA_DVD_RAT_HIST_I
(
	AR_HIST_SEQ                                NUMBER,
	AR_CRTUSERNO                               VARCHAR2,
	AR_NAME                                    VARCHAR2,
	AR_APPL_DT                                 VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_DVD_RAT_HIST_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_DVD_RAT_HIST 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	INSERT INTO T_PL_MA_DVD_RAT_HIST
	(
		HIST_SEQ,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		NAME,
		APPL_DT
	)
	VALUES
	(
		AR_HIST_SEQ,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_NAME,
		F_T_StringToDate(AR_APPL_DT)
	);
END;
/
CREATE OR REPLACE PROCEDURE SP_T_PL_MA_DVD_RAT_HIST_U
(
	AR_HIST_SEQ                                NUMBER,
	AR_MODUSERNO                               VARCHAR2,
	AR_NAME                                    VARCHAR2,
	AR_APPL_DT                                 VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_DVD_RAT_HIST_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_DVD_RAT_HIST 테이블 Update
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	UPDATE T_PL_MA_DVD_RAT_HIST
	SET
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		NAME = AR_NAME,
		APPL_DT = F_T_StringToDate(AR_APPL_DT)
	WHERE	HIST_SEQ = AR_HIST_SEQ;
END;
/
CREATE OR REPLACE PROCEDURE SP_T_PL_MA_DVD_RAT_HIST_D
(
	AR_HIST_SEQ                                NUMBER
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_PL_MA_DVD_RAT_HIST_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_PL_MA_DVD_RAT_HIST 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-04-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	DELETE T_PL_MA_DVD_RAT_HIST
	WHERE	HIST_SEQ = AR_HIST_SEQ;
END;
/
