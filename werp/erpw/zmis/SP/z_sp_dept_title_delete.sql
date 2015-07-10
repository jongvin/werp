/* ============================================================================= */
/* 함수명 : z_sp_dept_title_delete                                                 */
/* 기  능 : 조직도 삭제                                       */
/* ----------------------------------------------------------------------------- */
/*        : 변경순번                 ==> an_degree      (NUMBER)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 박두현                                                               */
/* 작성일 : 2004.10.15                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE z_sp_dept_title_delete(   an_degree   IN   NUMBER) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
  
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
		delete from z_code_chg_dept_content
          WHERE degree = an_degree;
		delete from z_code_chg_dept_title
          WHERE degree = an_degree;
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '삭제 자료변환 실패! [Line No: 157]';
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
END z_sp_dept_title_delete;

/
