CREATE OR REPLACE PROCEDURE Sp_T_Year_Close_I
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2,
	AR_ACC_ID                                  VARCHAR2,
	AR_ACCOUNT_FDT                             VARCHAR2,
	AR_ACCOUNT_EDT                             VARCHAR2,
	AR_CLSE_CLS                                VARCHAR2,
	AR_CLSE_DT                                 VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_YEAR_CLOSE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_YEAR_CLOSE 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2005-11-28)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
lnLastDay NUMBER;
BEGIN
	INSERT INTO T_YEAR_CLOSE
	(
		COMP_CODE,
		CLSE_ACC_ID,
		CRTUSERNO,
		CRTDATE,
		MODUSERNO,
		MODDATE,
		ACC_ID,
		ACCOUNT_FDT,
		ACCOUNT_EDT,
		CLSE_CLS,
		CLSE_DT
	)
	VALUES
	(
		AR_COMP_CODE,
		AR_CLSE_ACC_ID,
		AR_CRTUSERNO,
		SYSDATE,
		NULL,
		NULL,
		AR_ACC_ID,
		F_T_Stringtodate(AR_ACCOUNT_FDT),
		F_T_Stringtodate(AR_ACCOUNT_EDT),
		AR_CLSE_CLS,
		F_T_Stringtodate(AR_CLSE_DT)
	);
	
	Sp_T_Year_Close_Batch(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_CRTUSERNO);	
END;
/
CREATE OR REPLACE PROCEDURE Sp_T_Year_Close_U
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_MODUSERNO                               VARCHAR2,
	AR_ACC_ID                                  VARCHAR2,
	AR_ACCOUNT_FDT                             VARCHAR2,
	AR_ACCOUNT_EDT                             VARCHAR2,
	AR_CLSE_CLS                                VARCHAR2,
	AR_CLSE_DT                                 VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_YEAR_CLOSE_U
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_YEAR_CLOSE 테이블 Update
/* 4. 변  경  이  력 : 한재원 작성(2005-11-28)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
BEGIN
	UPDATE T_YEAR_CLOSE
	SET
		MODUSERNO = AR_MODUSERNO,
		MODDATE = SYSDATE,
		ACC_ID = AR_ACC_ID,
		ACCOUNT_FDT = F_T_Stringtodate(AR_ACCOUNT_FDT),
		ACCOUNT_EDT = F_T_Stringtodate(AR_ACCOUNT_EDT),
		CLSE_CLS = AR_CLSE_CLS,
		CLSE_DT = F_T_Stringtodate(AR_CLSE_DT)
	WHERE	COMP_CODE = AR_COMP_CODE
	AND	CLSE_ACC_ID = AR_CLSE_ACC_ID;
	
	Sp_T_Year_Close_Batch(AR_COMP_CODE, AR_CLSE_ACC_ID, AR_MODUSERNO);
END;
/
CREATE OR REPLACE PROCEDURE Sp_T_Year_Close_D
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_YEAR_CLOSE_D
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_YEAR_CLOSE 테이블 Delete
/* 4. 변  경  이  력 : 한재원 작성(2005-11-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
BEGIN

	DELETE T_DAY_CLOSE
	WHERE
		COMP_CODE = AR_COMP_CODE
		AND CLSE_ACC_ID = AR_CLSE_ACC_ID;
		
	DELETE T_MONTH_CLOSE
	WHERE
		COMP_CODE = AR_COMP_CODE
		AND CLSE_ACC_ID = AR_CLSE_ACC_ID;
		
	DELETE T_YEAR_CLOSE
	WHERE	COMP_CODE =AR_COMP_CODE
	AND	CLSE_ACC_ID = AR_CLSE_ACC_ID;
END;
/

CREATE OR REPLACE PROCEDURE Sp_T_Year_Close_Batch
(
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_CRTUSERNO                               VARCHAR2
)
IS
/**************************************************************************/
/* 1. 프 로 그 램 id : SP_T_YEAR_CLOSE_I
/* 2. 유형(시나리오) : Procedure
/* 3. 기  능  정  의 : T_YEAR_CLOSE 테이블 Insert
/* 4. 변  경  이  력 : 한재원 작성(2005-11-28)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/
lnDataCnt NUMBER;
lnLastDay NUMBER;
BEGIN

	SELECT
		COUNT(*)
	INTO lnDataCnt
	FROM
		T_MONTH_CLOSE
	WHERE
		COMP_CODE = AR_COMP_CODE
		AND CLSE_ACC_ID = AR_CLSE_ACC_ID;
		
	IF lnDataCnt <> 12 THEN	
		DELETE FROM T_DAY_CLOSE
		WHERE
			COMP_CODE = AR_COMP_CODE
			AND CLSE_ACC_ID = AR_CLSE_ACC_ID;
			
		DELETE FROM T_MONTH_CLOSE
		WHERE
			COMP_CODE = AR_COMP_CODE
			AND CLSE_ACC_ID = AR_CLSE_ACC_ID;
	
		INSERT INTO T_MONTH_CLOSE
		(
			COMP_CODE,
			CLSE_ACC_ID,
			CLSE_MONTH,
			CRTUSERNO,
			CRTDATE,
			MODUSERNO,
			MODDATE,
			CLSE_CLS,
			CLSE_DT
		)
		SELECT
			AR_COMP_CODE,
			AR_CLSE_ACC_ID,
			AR_CLSE_ACC_ID||TO_CHAR(ROWNUM,'FM09') CLSE_MONTH,
			AR_CRTUSERNO,
			SYSDATE,
			NULL,
			NULL,
			'F',
			NULL
		FROM
			ALL_OBJECTS
		WHERE
			ROWNUM<=12;
			
		FOR lrA IN
		(
			SELECT
				*
			FROM
				T_MONTH_CLOSE
			WHERE
				COMP_CODE = AR_COMP_CODE
				AND CLSE_ACC_ID = AR_CLSE_ACC_ID
		)
		LOOP
			SELECT
				TO_NUMBER(TO_CHAR(LAST_DAY(F_T_Stringtodate(lrA.CLSE_MONTH||'01')),'DD'))
			INTO lnLastDay
			FROM DUAL;
		
			FOR lnI IN 1 .. lnLastDay
			LOOP
				INSERT INTO T_DAY_CLOSE
				(
					COMP_CODE,
					CLSE_ACC_ID,
					CLSE_MONTH,
					CLSE_DAY,
					CRTUSERNO,
					CRTDATE,
					MODUSERNO,
					MODDATE,
					CLSE_CLS
				) VALUES (
					lrA.COMP_CODE,
					lrA.CLSE_ACC_ID,
					lrA.CLSE_MONTH,
					F_T_Stringtodate(lrA.CLSE_MONTH||TO_CHAR(lnI,'FM09')),
					AR_CRTUSERNO,
					SYSDATE,
					NULL,
					NULL,
					'F'
				);
			END LOOP;
		END LOOP;
	END IF;	
END;
/


