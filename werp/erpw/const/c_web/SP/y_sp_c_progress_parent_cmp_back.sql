/* ============================================================================= */
/* 함수명 : y_sp_c_progress_parent_cmp                                               */
/* 기  능 : 보할공정 실행집계및 금액 계산  (상위집계)                */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 변경차수               ==> ai_chg_no_seq  (number)                         */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 박두현                                                              */
/* 작성일 : 2005.03.08                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_progress_parent_cmp(as_dept_code    IN   VARCHAR2,
                                                  ai_chg_no_seq         IN   NUMBER
                                                   ) IS
-------------------------------------------------------------
-- 변수선언
-----------------------------------------------+--------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   C_PLAN_AMT          NUMBER(14)     DEFAULT 0;   -- 실행합계
   C_REAL_AMT          NUMBER(14)     DEFAULT 0;   -- 투입합계

-- User Define Error 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
      
  -- 'A'  //건축 하위공종 DETAIL집계  건축집계는 하위테이블에도 존재함으로 일단 건축 'A'만 삭제    
    	delete from c_progress_detail
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq
              and wbs_code = 'A';
                    
       INSERT INTO c_progress_detail
          select dept_code,
                 chg_no_seq,
                'A',
                year,
                sum(plan_mm_per),
                sum(plan_mm_amt),
                sum(real_mm_per),
                sum(real_mm_amt)
          from c_progress_detail
          where dept_code = as_dept_code
            and chg_no_seq = ai_chg_no_seq
            and substr(wbs_code,2,1) is not null
          group by dept_code,chg_no_seq,year;
--  하위을 집계하여 상위에 반영 보할율과 실행금액 단 (건축일겨우에만 상위집계)
       update c_progress_parent a set (a.plan_per,a.plan_amt) = 
                    (select sum(b.plan_mm_per),sum(b.plan_mm_amt)
                         from c_progress_detail b
                         where b.dept_code = as_dept_code
                           and b.chg_no_seq = ai_chg_no_seq
                           and b.wbs_code = 'A'
                           and a.dept_code = b.dept_code
                           and a.wbs_code = b.wbs_code
                           and a.chg_no_seq = b.chg_no_seq
                           and a.wbs_code = 'A'
                           group by b.dept_code,b.chg_no_seq,b.wbs_code )
          where exists (select sum(b.plan_mm_per),sum(b.plan_mm_amt)
                         from c_progress_detail b
                         where b.dept_code = as_dept_code
                           and b.chg_no_seq = ai_chg_no_seq
                           and b.wbs_code = 'A'
                           and a.dept_code = b.dept_code
                           and a.wbs_code = b.wbs_code
                           and a.chg_no_seq = b.chg_no_seq
                           and a.wbs_code = 'A'
                           group by b.dept_code,b.chg_no_seq,b.wbs_code );

      				                             
          
  update c_progress_parent aa
  set aa.real_per = (select sum(a.real_mm_per)
                         from c_progress_detail a
                         where a.dept_code = as_dept_code
                           and a.chg_no_seq = ai_chg_no_seq
                           and a.wbs_code = 'A'
                           and aa.dept_code = a.dept_code
                           and aa.wbs_code = a.wbs_code
                           and aa.chg_no_seq = a.chg_no_seq
                           group by a.dept_code,a.chg_no_seq,a.wbs_code ),
     aa.real_amt = (select sum(a.real_mm_amt)
                         from c_progress_detail a
                         where a.dept_code = as_dept_code
                           and a.chg_no_seq = ai_chg_no_seq
                           and a.wbs_code = 'A'
                           and aa.dept_code = a.dept_code
                           and aa.wbs_code = a.wbs_code
                           and aa.chg_no_seq = a.chg_no_seq
                           group by a.dept_code,a.chg_no_seq,a.wbs_code );       				                             
     				                             
			                                  
       EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '보할 자료상위집계 실패! []';
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
END y_sp_c_progress_parent_cmp;        