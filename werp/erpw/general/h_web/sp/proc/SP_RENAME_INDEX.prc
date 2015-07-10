CREATE OR REPLACE PROCEDURE Sp_rename_index(AS_tmp IN CHAR) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT b.table_name,
       a.object_name,
       DECODE(c.constraint_type, 'P', 'XPK'||b.table_name, 
       DECODE(b.uniqueness, 'UNIQUE', 'XAK'||b.table_name,
       DECODE(b.uniqueness, 'NONUNIQUE', 'XIF'||b.table_name, ''))) 고친이름 , 
       c.constraint_type,
       a.subobject_name,
       a.status,
       b.index_type,
       b.table_type,
       b.uniqueness,
       b.tablespace_name/*,
       c.table_name,
       c.column_name,
       c.column_position*/
  FROM USER_OBJECTS a,
       USER_INDEXES b,
       USER_CONSTRAINTS c
 WHERE a.object_type = 'INDEX'
   AND a.object_name = b.index_name(+)
   AND a.object_name = c.index_name(+)
ORDER BY a.object_name 
       ;
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error 
   C_CNT               NUMBER(20,5);  --
   sql_stmt1            VARCHAR2(500);
   sql_stmt2            VARCHAR2(500);
   C1 VARCHAR2(50);
   C2 VARCHAR2(50);
   C3 VARCHAR2(50);
   C4 VARCHAR2(50);
   C5 VARCHAR2(50);
   C6 VARCHAR2(50);
   C7 VARCHAR2(50);
   C8 VARCHAR2(50);
   C9 VARCHAR2(50);
   C10 VARCHAR2(50);
   
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO C1, C2, C3, C4, C5, C6, C7, C8, C9, C10;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
		
      IF LENGTH(C3) > 26 THEN
         C3 := SUBSTR(C3, 1, 26);
      END IF;
      
      IF SUBSTR(C3, 1, 3) != 'XPK' THEN
         SELECT INDEX_NAMING_SEQ.NEXTVAL 
           INTO C_CNT
           FROM DUAL;
         C3 := C3||C_CNT;
      END IF;
      
      sql_stmt2 := 'insert into zz_index_rename values(:1, :2, :3, :4, :5, :6, :7, :8)' ;
      EXECUTE IMMEDIATE sql_stmt2 USING C1, C2, C3, C4, C9, SQL_STMT1, '', '';
      
      sql_stmt1 := 'alter index '||c2||' rename to '||c3;
      EXECUTE IMMEDIATE sql_stmt1; 
      
      --EXECUTE IMMEDIATE ’CREATE TABLE bonus (ID NUMBER, amt NUMBER)’;
      --sql_stmt := ’INSERT INTO dept VALUES (:1, :2, :3)’;
      --EXECUTE IMMEDIATE sql_stmt USING dept_id, dept_name, LOCATION;
      
      
	END LOOP;
	CLOSE DETAIL_CUR;
 END;
   
EXCEPTION
  WHEN UserErr       THEN
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END Sp_rename_index;
/

