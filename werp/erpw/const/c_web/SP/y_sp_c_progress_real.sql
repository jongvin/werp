/* ============================================================================= */
/* 함수명 : y_sp_c_progress_real                                               */
/* 기  능 : 보할공정 원가투입계산                   */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 변경차수               ==> ai_chg_no_seq  (number)                         */
/*        : 시작일자               ==> as_start_date  (string)                         */
/*        : 마지막일자             ==> as_last_date  (string)                         */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 박두현                                                              */
/* 작성일 : 2005.03.08                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_progress_real(as_dept_code    IN   VARCHAR2,
                                                  ai_chg_no_seq         IN   NUMBER,
                                                  as_start_date         IN   VARCHAR2,
                                                  as_last_date         IN   VARCHAR2 ) IS
-------------------------------------------------------------
-- 변수선언
-----------------------------------------------+--------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   C_PLAN_AMT          NUMBER(14)     DEFAULT 0;   -- 실행합계
   C_REAL_AMT          NUMBER(14)     DEFAULT 0;   -- 투입합계
   C_CNT          NUMBER(14)     DEFAULT 0;   -- 투입합계

-- User Define Error 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
  		select count(*)
		  into C_CNT
		  from c_progress_detail
		 where dept_code = as_dept_code
			and chg_no_seq = ai_chg_no_seq;


		IF C_CNT < 1 THEN        -- 보할공정이 존재하지않으면  
         GOTO EXIT_ROUTINE;
		END IF;
   -- copy table 삭제 
    	delete from c_progress_detail_copy
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
   -- 원가투입자료를 집계함  wbs 구조로 집계함 
       INSERT INTO c_progress_detail_copy
            select as_dept_code,ai_chg_no_seq,a.wbs_code,a.yymm,0,0,0,a.real_mm_amt
              from y_wbs_code b,
                   (
                         select a.yymm,
                                substr(b.wbs_code,1,1) wbs_code,   -- 공종 1자리로 집계 
                                sum(a.cost_amt) real_mm_amt
                           from c_spec_const_detail a,y_budget_parent b
                           where a.dept_code = b.dept_code
                             and a.spec_no_seq = b.spec_no_seq
                             and a.yymm >= as_start_date
                             and a.yymm <= as_last_date
                             and a.dept_code = as_dept_code
                           group by a.yymm,substr(b.wbs_code,1,1)
                       union all
                         select a.yymm,
                                substr(b.wbs_code,1,3),   --건축일경우에만 공종 3자리로 집계  
                                sum(a.cost_amt) real_mm_amt
                           from c_spec_const_detail a,y_budget_parent b
                           where a.dept_code = b.dept_code
                             and a.spec_no_seq = b.spec_no_seq
                             and a.yymm >= as_start_date
                             and a.yymm <= as_last_date
                             and a.dept_code = as_dept_code
                             AND substr(b.wbs_code,1,1) = 'A'
                           group by a.yymm,substr(b.wbs_code,1,3) ) a
                where a.wbs_code = b.wbs_code;
       -- UPDATE 
       update c_progress_detail a set (a.real_mm_amt) = 
                        (select b.real_mm_amt
                             from c_progress_detail_copy b
						         	  where a.dept_code = b.dept_code 
							             and a.chg_no_seq  = b.chg_no_seq
							             and a.wbs_code   = b.wbs_code
                                  and a.year       = b.year
							             and a.dept_code = as_dept_code
							             and a.chg_no_seq = ai_chg_no_seq
                                   )
          where exists (select b.real_mm_amt
                             from c_progress_detail_copy b
						         	  where a.dept_code = b.dept_code 
							             and a.chg_no_seq  = b.chg_no_seq
							             and a.wbs_code   = b.wbs_code
                                  and a.year       = b.year 
							             and a.dept_code = as_dept_code
							             and a.chg_no_seq = ai_chg_no_seq
                                  );
    -- 실행합계와 투입합계 금액계산                                   
		select nvl(sum(a.plan_amt),0)
		  into C_PLAN_AMT
		  from c_progress_parent a
		  where a.dept_code = as_dept_code
			 and a.chg_no_seq  = ai_chg_no_seq
			 and a.wbs_code <> 'A';      -- 'A'는 건축 합계금액이므로 건축만제외하고 SUM하면 전체 실행금액및투입금액구함
    -- 실행 보정율 계산			 
      IF C_PLAN_AMT <> 0 THEN 
         update c_progress_detail a set a.real_mm_per = 
                           decode(C_PLAN_AMT,0,0,decode(sign(trunc((nvl(a.real_mm_amt,0) / C_PLAN_AMT ) * 100,2) - 999),
																				1,999,trunc((nvl(a.real_mm_amt,0) / C_PLAN_AMT ) * 100,2)))
		         	  where a.dept_code =  as_dept_code
							             and a.chg_no_seq  = ai_chg_no_seq;
      END IF;  			
                
    	delete from c_progress_detail_copy
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
       EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '보할 공정집계 실패! []';
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
END y_sp_c_progress_real;        