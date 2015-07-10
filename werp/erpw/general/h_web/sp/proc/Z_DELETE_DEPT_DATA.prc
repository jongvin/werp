CREATE OR REPLACE PROCEDURE Z_Delete_Dept_Data IS

CURSOR DETAIL_CUR IS
SELECT TABLE_NAME,
       CONSTRAINT_NAME
  FROM sys.ALL_CONSTRAINTS c
 WHERE OWNER = 'ERPW' AND CONSTRAINT_TYPE = 'R' 
   AND SUBSTR(TABLE_NAME, 1, 2) = 'H_';

CURSOR DETAIL_CUR1 IS
SELECT tr.trigger_name
  FROM sys.ALL_TRIGGERS tr
 WHERE tr.owner = 'ERPW'
   AND SUBSTR(TABLE_NAME, 1, 2) = 'H_'
   AND TABLE_NAME <> 'H_FB_INTF_INCOME';

CURSOR DEPT_TAB_CUR IS  
SELECT TA.TABLE_NAME
  FROM SYS.ALL_COL_COMMENTS CO,
  		 SYS.ALL_TABLES TA
 WHERE CO.TABLE_NAME = TA.TABLE_NAME
   AND CO.COLUMN_NAME = 'DEPT_CODE'
	AND TA.OWNER = 'ERPW'
   AND SUBSTR(TA.TABLE_NAME, 1, 2) = 'H_'
   AND TA.TABLE_NAME NOT IN ('H_CODE_HOUSE','H_CODE_DEPT','H_CODE_DEPOSIT', 'H_CODE_CUST','H_FB_INTF_INCOME')
   AND UPPER(SUBSTR(ta.table_name,1,6)) <> 'H_UNIN';
   
CURSOR DEPT IS 
SELECT DEPT_CODE
  FROM H_CODE_HOUSE
 WHERE --DEPT_CODE IN  ('A05034');
       DEPT_CODE NOT IN  ('120301');
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

			sql_stmt := ' ALTER TABLE '||C_TABLE_NAME||' DISABLE CONSTRAINT '||C_CONSTRAINT_NAME ;

			EXECUTE IMMEDIATE sql_stmt  ;

		END LOOP;
		CLOSE DETAIL_CUR;

		OPEN	DETAIL_CUR1;
		LOOP
			FETCH DETAIL_CUR1 INTO C_TRIGGER_NAME;
			EXIT WHEN DETAIL_CUR1%NOTFOUND;

			sql_stmt := ' ALTER TRIGGER '||C_TRIGGER_NAME||' DISABLE ';

			EXECUTE IMMEDIATE sql_stmt  ;

		END LOOP;
		CLOSE DETAIL_CUR1;
      
      OPEN	DEPT;
		LOOP
			FETCH DEPT INTO C_DEPT_CODE;
			EXIT WHEN DEPT%NOTFOUND;
       
   		OPEN	DEPT_TAB_CUR;
   		LOOP
   			FETCH DEPT_TAB_CUR INTO C_TABLE_NAME;
   			EXIT WHEN DEPT_TAB_CUR%NOTFOUND;
   
   			sql_stmt := ' DELETE '||C_TABLE_NAME||' WHERE DEPT_CODE LIKE :b' ;
   
   			EXECUTE IMMEDIATE sql_stmt USING C_dept_code ;
   
   		END LOOP;
   		CLOSE DEPT_TAB_CUR;
      
      END LOOP;
   	CLOSE DEPT;

		OPEN	DETAIL_CUR1;
		LOOP
			FETCH DETAIL_CUR1 INTO C_TRIGGER_NAME;
			EXIT WHEN DETAIL_CUR1%NOTFOUND;

			sql_stmt := ' ALTER TRIGGER '||C_TRIGGER_NAME||' ENABLE ';

			EXECUTE IMMEDIATE sql_stmt  ;

		END LOOP;
		CLOSE DETAIL_CUR1;

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
END Z_Delete_Dept_Data;
/

