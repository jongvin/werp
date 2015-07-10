/* ============================================================================= */
/* 함수명 : y_sp_c_progress_copy                                                 */
/* 기  능 : 보할공정 단계별 복사                                        */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 프로젝트 코드                ==> as_dept_code (string)                     */
/*        : 변경순번(이전)               ==> an_old_chg_no_seq(NUMBER)                    */
/*        : 변경순번(이후)               ==> an_new_chg_no_seq      (NUMBER)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 박두현                                                               */
/* 작성일 : 2004.10.15                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_progress_copy(as_dept_code    IN  VARCHAR2,
                                            an_old_chg_no_seq   IN   NUMBER,
                                            an_new_chg_no_seq   IN   NUMBER) IS
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
		INSERT INTO c_progress_parent                 -- 보할공정 parent 
          SELECT a.dept_code,   
                 an_new_chg_no_seq,   
                 a.wbs_code,   
                 a.seq,   
                 a.invest_class,   
                 a.plan_per,   
                 a.plan_amt,   
                 a.real_per,   
                 a.real_amt  
            FROM c_progress_parent a  
            WHERE dept_code = as_dept_code
             and chg_no_seq = an_old_chg_no_seq;
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'insert c_progress_parent 자료변환 실패! [Line No: 157]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
	END;
  BEGIN
		INSERT INTO c_progress_detail                 -- 보할공정 parent 
           SELECT a.dept_code,   
                 an_new_chg_no_seq,   
                 a.wbs_code,   
                 a.year,   
                 a.plan_mm_per,   
                 a.plan_mm_amt,   
                 a.real_mm_per,   
                 a.real_mm_amt  
            FROM c_progress_detail a  
            WHERE dept_code = as_dept_code
             and chg_no_seq = an_old_chg_no_seq;
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'insert c_progress_detail 자료변환 실패! [Line No: 157]';
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
END y_sp_c_progress_copy;

/
