/* ============================================================================= */
/* 함수명 : y_sp_c_daily_copy                                               */
/* 기  능 : 현장일일작업 전일자료 복사                                           */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept  (string)                         */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 박두현                                                               */
/* 작성일 : 2005.05.11                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_daily_copy(as_dept         IN   VARCHAR2
                                                ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   C_DATE              C_DAILY_PARENT.YYMMDD%TYPE;    -- 일자
   C_LAST_DATE              C_DAILY_PARENT.YYMMDD%TYPE;    -- 일자
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
      SELECT MAX(yymmdd),MAX(yymmdd) + 1,count(*)
        INTO C_DATE,C_LAST_DATE,C_CNT
        FROM c_daily_parent
       WHERE dept_code  = as_dept;
         
		IF C_CNT > 0 THEN
			INSERT INTO C_DAILY_PARENT 
			  SELECT DEPT_CODE , 
               	C_LAST_DATE,
                  WEATHER_1,   
                  WEATHER_2,   
                  'N',
                  HEAT_1,   
                  HEAT_2,
                  BIGO,   
                  NEXT_BIGO,
                  REMARK 
     			FROM C_DAILY_PARENT
     		  WHERE DEPT_CODE = as_dept
             AND YYMMDD = C_DATE;

			INSERT INTO C_DAILY_DETAIL
			  SELECT DEPT_CODE , 
               	C_LAST_DATE,
                  TAG,   
                  SPEC_UNQ_NUM,   
                  NO_SEQ,
                  NAME,   
                  SSIZE_1,
                  SSIZE_2,   
                  BEF_CNT + CNT,
                  CNT 
     			FROM C_DAILY_DETAIL
     		  WHERE DEPT_CODE = as_dept
             AND YYMMDD = C_DATE;
      ELSE
			INSERT INTO C_DAILY_PARENT 
			  SELECT as_dept , 
               	to_date(to_char(sysdate,'yyyy.mm.dd')),
                  '0',   
                  '0',   
                  'N',
                  0,   
                  0,
                  '',   
                  '',
                  '' 
     			FROM DUAL;
      END IF;
      
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'BOM 전일자료복사  실패! [Line No: 159]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
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
END y_sp_c_daily_copy;

/
