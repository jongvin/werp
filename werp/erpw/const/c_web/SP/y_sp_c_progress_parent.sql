/* ============================================================================= */
/* 함수명 : y_sp_c_progress_parent                                               */
/* 기  능 : 보할공정 실행집계및 금액 계산                  */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 변경차수               ==> ai_chg_no_seq  (number)                         */
/*        : 시작일자               ==> as_start_date  (string)                         */
/*        : 마지막일자             ==> as_last_date  (string)                         */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 박두현                                                              */
/* 작성일 : 2005.03.08                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_progress_parent(as_dept_code    IN   VARCHAR2,
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

-- User Define Error 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
   -- copy table 삭제 
    	delete from c_progress_detail_copy
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
    	delete from c_progress_parent_copy
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
  -- 기존 데이타 보조파일로 복사
      insert into c_progress_parent_copy
                  select * from c_progress_parent
                       where dept_code = as_dept_code
                         and chg_no_seq = ai_chg_no_seq;
      insert into c_progress_detail_copy
                  select * from c_progress_detail
                       where dept_code = as_dept_code
                         and chg_no_seq = ai_chg_no_seq;
 -- 지존자료 삭제 
    	delete from c_progress_detail
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
    	delete from c_progress_parent
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
   -- 실행자료를 wbs 구조로 집계함 (실행금액구별별 가져와서 PARENT에 삽입)
       INSERT INTO c_progress_parent
            select as_dept_code,ai_chg_no_seq,a.wbs_code,b.no_seq,a.invest_class,0, a.amt,0,0
              from y_wbs_code b,
                   (
                         select substr(a.wbs_code,1,1) wbs_code,   -- 공종 1자리로 집계 
                                DECODE(substr(a.wbs_code,1,1),'A','N','Y') invest_class,
                                sum(a.amt) amt
                           from y_budget_parent a
                           where a.dept_code = as_dept_code
                             AND a.invest_class = 'Y'
                           group by substr(a.wbs_code,1,1)
                       union all
                         select substr(a.wbs_code,1,3),   --건축일경우에만 공종 3자리로 집계  
                                'Y',
                                sum(a.amt)
                           from y_budget_parent a
                           where a.dept_code = as_dept_code
                             AND a.invest_class = 'Y'
                             AND substr(a.wbs_code,1,1) = 'A'
                           group by substr(a.wbs_code,1,3) ) a
                where a.wbs_code = b.wbs_code;
                
   -- 실행자료를 wbs 구조 년월별로  집계함(wbs구조로 c_progress_detail 테이블에 년도 추가 ) 
       INSERT INTO c_progress_detail
            select a.dept_code,
                   a.chg_no_seq,
                   a.wbs_code,
                   b.c_yymm,0,0,0,0
              from c_progress_parent a,
                   c_calendar_yymm b
              where a.dept_code = as_dept_code
                and a.chg_no_seq = ai_chg_no_seq
                and b.c_yymm >= as_start_date 
                and b.c_yymm <= as_last_date;  
                
   -- 이전의 계힉과 투입자료가 있다면 detail자료 복구 

       update c_progress_detail a set (a.plan_mm_per,a.plan_mm_amt,a.real_mm_per,a.real_mm_amt) = 
                        (select b.plan_mm_per,b.plan_mm_amt,b.real_mm_per,b.real_mm_amt
                             from c_progress_detail_copy b
						         	  where a.dept_code = b.dept_code 
							             and a.chg_no_seq  = b.chg_no_seq
							             and a.wbs_code   = b.wbs_code
                                  and a.year       = b.year
							             and a.dept_code = as_dept_code
							             and a.chg_no_seq = ai_chg_no_seq
                                   )
          where exists (select b.plan_mm_per,b.plan_mm_amt,b.real_mm_per,b.real_mm_amt
                             from c_progress_detail_copy b
						         	  where a.dept_code = b.dept_code 
							             and a.chg_no_seq  = b.chg_no_seq
							             and a.wbs_code   = b.wbs_code
                                  and a.year       = b.year 
							             and a.dept_code = as_dept_code
							             and a.chg_no_seq = ai_chg_no_seq
                                  );
    -- 실행합계와 투입합계 금액계산                                   
		select nvl(sum(a.plan_amt),0),nvl(sum(a.real_amt),0)
		  into C_PLAN_AMT,C_REAL_AMT
		  from c_progress_parent a
		  where a.dept_code = as_dept_code
			 and a.chg_no_seq  = ai_chg_no_seq
			 and a.wbs_code <> 'A';      -- 'A'는 건축 합계금액이므로 건축만제외하고 SUM하면 전체 실행금액및투입금액구함
    -- 실행 보정율 계산			 
      IF C_PLAN_AMT <> 0 THEN 
         update c_progress_parent a set a.plan_per = 
                                  decode(C_PLAN_AMT,0,0,decode(sign(ROUND((nvl(a.plan_amt,0) / C_PLAN_AMT ) * 100,2) - 999),
																				1,999,ROUND((nvl(a.plan_amt,0) / C_PLAN_AMT ) * 100,2)))
						         	  where a.dept_code =  as_dept_code
							             and a.chg_no_seq  = ai_chg_no_seq;
         update c_progress_detail a set a.plan_mm_amt = TRUNC(a.plan_mm_per *  C_PLAN_AMT / 100,0)
						         	  where a.dept_code =  as_dept_code
							             and a.chg_no_seq  = ai_chg_no_seq;
         update c_progress_detail a set a.real_mm_per = 
                                  decode(C_PLAN_AMT,0,0,decode(sign(ROUND((nvl(a.real_mm_amt,0) / C_PLAN_AMT ) * 100,2) - 999),
																				1,999,ROUND((nvl(a.real_mm_amt,0) / C_PLAN_AMT ) * 100,2)))
						         	  where a.dept_code =  as_dept_code
							             and a.chg_no_seq  = ai_chg_no_seq;
      END IF;  			
   -- detail에서 실행율과 투입율을 재계산      
      
  -- 'A'  //건축 하위공종 DETAIL집계       건축은 하위테이블에서도 'A' 상위집계금액이 존재하므로 삭제후 다시 집계함.
    	delete from c_progress_detail
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq
              and wbs_code = 'A';

          
       INSERT INTO c_progress_detail    -- 건축하위공종만 집계하여 'A'로 삽입 
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
            and substr(wbs_code,2,1) is not null    -- 건축을 의미함(다른파트는 2번째가 NULL임)
          group by dept_code,chg_no_seq,year;
      				                             
--  하위을 집계하여 상위에 반영 보할율과 실행금액 단 (건축일경우에만 상위집계)
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


--  하위을 집계하여 상위에 반영 투입금액과 투입율만 재계산한다.
 update c_progress_parent aa
  set aa.real_per = (select sum(a.real_mm_per)
                         from c_progress_detail a
                         where a.dept_code = as_dept_code
                           and a.chg_no_seq = ai_chg_no_seq
                           and aa.dept_code = a.dept_code
                           and aa.wbs_code = a.wbs_code
                           and aa.chg_no_seq = a.chg_no_seq
                           group by a.dept_code,a.chg_no_seq,a.wbs_code ),
     aa.real_amt = (select sum(a.real_mm_amt)
                         from c_progress_detail a
                         where a.dept_code = as_dept_code
                           and a.chg_no_seq = ai_chg_no_seq
                           and aa.dept_code = a.dept_code
                           and aa.wbs_code = a.wbs_code
                           and aa.chg_no_seq = a.chg_no_seq
                           group by a.dept_code,a.chg_no_seq,a.wbs_code );    

   -- copy table 삭제 
    	delete from c_progress_detail_copy
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
    	delete from c_progress_parent_copy
            where dept_code = as_dept_code
              and chg_no_seq = ai_chg_no_seq;
                              				                             
      				                                  
       EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '보할 자료집계 실패! []';
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
END y_sp_c_progress_parent;        