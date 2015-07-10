CREATE OR REPLACE PROCEDURE Sp_T_Work_Report_I
(
	AR_PAGE_ID                                 VARCHAR2,
	AR_JOB_SEQ                                 NUMBER,
	AR_COL_NAME01                              VARCHAR2,
	AR_COL_VALUE01                             VARCHAR2,
	AR_COL_NAME02                              VARCHAR2,
	AR_COL_VALUE02                             VARCHAR2,
	AR_COL_NAME03                              VARCHAR2,
	AR_COL_VALUE03                             VARCHAR2,
	AR_COL_NAME04                              VARCHAR2,
	AR_COL_VALUE04                             VARCHAR2,
	AR_COL_NAME05                              VARCHAR2,
	AR_COL_VALUE05                             VARCHAR2,
	AR_COL_NAME06                              VARCHAR2,
	AR_COL_VALUE06                             VARCHAR2,
	AR_COL_NAME07                              VARCHAR2,
	AR_COL_VALUE07                             VARCHAR2,
	AR_COL_NAME08                              VARCHAR2,
	AR_COL_VALUE08                             VARCHAR2,
	AR_COL_NAME09                              VARCHAR2,
	AR_COL_VALUE09                             VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_WORK_REPORT_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_WORK_REPORT 테이블 Insert
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	INSERT INTO T_WORK_REPORT
	(
		PAGE_ID,
		JOB_SEQ,
		COL_NAME01,
		COL_VALUE01,
		COL_NAME02,
		COL_VALUE02,
		COL_NAME03,
		COL_VALUE03,
		COL_NAME04,
		COL_VALUE04,
		COL_NAME05,
		COL_VALUE05,
		COL_NAME06,
		COL_VALUE06,
		COL_NAME07,
		COL_VALUE07,
		COL_NAME08,
		COL_VALUE08,
		COL_NAME09,
		COL_VALUE09
	)
	VALUES
	(
		AR_PAGE_ID,
		( SELECT NVL(MAX(TO_NUMBER(JOB_SEQ)),0)+1 FROM T_WORK_REPORT WHERE PAGE_ID = AR_PAGE_ID ),
		AR_COL_NAME01,
		AR_COL_VALUE01,
		AR_COL_NAME02,
		AR_COL_VALUE02,
		AR_COL_NAME03,
		AR_COL_VALUE03,
		AR_COL_NAME04,
		AR_COL_VALUE04,
		AR_COL_NAME05,
		AR_COL_VALUE05,
		AR_COL_NAME06,
		AR_COL_VALUE06,
		AR_COL_NAME07,
		AR_COL_VALUE07,
		AR_COL_NAME08,
		AR_COL_VALUE08,
		AR_COL_NAME09,
		AR_COL_VALUE09
	);
END;
/

CREATE OR REPLACE PROCEDURE Sp_T_Work_Report_D
(
	AR_PAGE_ID                                 VARCHAR2,
	AR_JOB_SEQ                                 NUMBER
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_WORK_REPORT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_WORK_REPORT 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	DELETE T_WORK_REPORT
	WHERE	PAGE_ID = AR_PAGE_ID
	AND	JOB_SEQ = AR_JOB_SEQ;
END;
/

CREATE OR REPLACE PROCEDURE Sp_T_Work_Report_D_ALL
(
	AR_PAGE_ID                                 VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_WORK_REPORT_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_WORK_REPORT 테이블 Delete
/* 4. 변  경  이  력 : 홍길동 작성(2006-02-07)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN
	DELETE T_WORK_REPORT
	WHERE	PAGE_ID = AR_PAGE_ID;
END;
/
