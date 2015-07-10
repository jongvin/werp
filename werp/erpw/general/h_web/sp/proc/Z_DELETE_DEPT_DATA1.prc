CREATE OR REPLACE PROCEDURE Z_DELETE_DEPT_DATA1 IS

CURSOR DETAIL_CUR IS
SELECT TABLE_NAME,
       CONSTRAINT_NAME
  FROM sys.ALL_CONSTRAINTS c
 WHERE OWNER = 'ERPW' AND CONSTRAINT_TYPE = 'R' ;

-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수

   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error

   C_CNT               NUMBER(10,5);  --
	C_TABLE_NAME        VARCHAR2(30);
	C_TRIGGER_NAME        VARCHAR2(30);
	C_CONSTRAINT_NAME   VARCHAR2(30);
	sql_stmt            VARCHAR2(100);
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_DEPT_CODE             VARCHAR(7);
   
BEGIN
	BEGIN
      
    

		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO C_TABLE_NAME, C_CONSTRAINT_NAME;
			EXIT WHEN DETAIL_CUR%NOTFOUND;

			sql_stmt := ' ALTER TABLE '||C_TABLE_NAME||' ENABLE CONSTRAINT '||C_CONSTRAINT_NAME ;

			EXECUTE IMMEDIATE sql_stmt  ;

		END LOOP;
		CLOSE DETAIL_CUR;


	END;
   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   <<EXIT_ROUTINE>>
   -- ENDING...[0.1] CURSOR CLOSE 재 확인 처리 !
   IF Wk_errflag = 0 THEN
      Wk_errmsg  := '';                        -- 사용자 정의 Error Message
      Wk_errflag := 0;                         -- 사용자 정의 Error Code
   ELSE
      Wk_errmsg := RTRIM(e_msg) || '/>';
      RAISE UserErr;
   END IF;
EXCEPTION
  WHEN UserErr       THEN
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END Z_DELETE_DEPT_DATA1;
/

