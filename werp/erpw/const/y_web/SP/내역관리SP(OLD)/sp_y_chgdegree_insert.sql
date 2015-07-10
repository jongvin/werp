/* ============================================================================= */
/* 함수명 : sp_y_chgdegree_insert                                                */
/* 기  능 : 변경실행차수 입력시 실행집계구조,실행내역의 자료를 복사한다.         */
/*          (변경실행집계구조,변경실행내역)                                      */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_proj_code (string)                     */
/*        : 번호(TO  )             ==> ai_no        (Integer)                    */
/*        : 사용자                 ==> as_user      (string)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2001.08.14                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_chgdegree_insert(as_proj_code    IN   VARCHAR2,
                                                  ai_no           IN   INTEGER,
                                                  as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found

BEGIN

 BEGIN
-- 해당차수의 변경실행내역과 변경실행집계구조의 자료를 삭제한다. 
   DELETE FROM Y_CHG_BUDGET_DETAIL
         WHERE ( proj_code  = as_proj_code ) AND  
               ( no         = ai_no )   ;
   DELETE FROM Y_CHG_BUDGET_SUMMARY
         WHERE ( proj_code  = as_proj_code ) AND  
               ( no         = ai_no )   ;

-- 최종실행집계구조를 해당차수의 변경실행집계구조로 복사한다. 
   INSERT INTO Y_CHG_BUDGET_SUMMARY  
        SELECT a.proj_code,ai_no,a.sum_code,a.direct_class,
               a.mng_code,a.wbs_code,a.seq,a.llevel,a.parent_sum_code,
               a.invest_class,a.detail_yn,'Y',a.name,a.ssize,a.unit,
               NVL(a.cnt_qty,0),   
               NVL(a.cnt_amt,0),   
               NVL(a.cnt_mat_amt,0),   
               NVL(a.cnt_lab_amt,0),   
               NVL(a.cnt_exp_amt,0),   
               NVL(a.qty,0),   
               NVL(a.amt,0),   
               NVL(a.mat_amt,0),
               NVL(a.lab_amt,0),
               NVL(a.exp_amt,0),
               NVL(a.equ_amt,0),
               NVL(a.sub_amt,0),
               NVL(a.cost_amt,0),
               a.note,a.temp1,a.temp2,a.temp3,a.temp4,a.temp5,sysdate,as_user
          FROM y_budget_summary a 
         WHERE ( a.proj_code = as_proj_code );

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '실행집계구조복사 실패! [Line No: 159]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
 END;
 BEGIN
-- 최종실행내역를 해당차수의 변경실행내역으로 복사한다. 
   INSERT INTO Y_CHG_BUDGET_DETAIL  
        SELECT a.proj_code,ai_no,a.sum_code,a.spec_unq_num,a.detail_code,a.res_class,
               a.seq,a.mng_code,a.wbs_code,a.mat_code,'Y',a.add_yn,
               a.name,a.ssize,a.unit,
               NVL(a.cnt_qty,0),   
               NVL(a.cnt_price,0),   
               NVL(a.cnt_amt,0),   
               NVL(a.cnt_mat_price,0),   
               NVL(a.cnt_mat_amt,0),   
               NVL(a.cnt_lab_price,0),   
               NVL(a.cnt_lab_amt,0),   
               NVL(a.cnt_exp_price,0),   
               NVL(a.cnt_exp_amt,0),   
               NVL(a.qty,0),   
               NVL(a.sub_qty,0),
               NVL(a.price,0),   
               NVL(a.amt,0),   
               NVL(a.mat_price,0),
               NVL(a.mat_amt,0),
               NVL(a.lab_price,0),
               NVL(a.lab_amt,0),
               NVL(a.exp_price,0),
               NVL(a.exp_amt,0),
               NVL(a.equ_price,0),
               NVL(a.equ_amt,0),
               NVL(a.sub_price,0),
               NVL(a.sub_amt,0),
               NVL(a.cost_price,0),
               NVL(a.cost_amt,0),
               a.note,a.temp1,a.temp2,a.temp3,a.temp4,a.temp5,sysdate,as_user
          FROM y_budget_detail a 
         WHERE ( a.proj_code = as_proj_code );

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '실행내역복사 실패! [Line No: 159]';
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
END sp_y_chgdegree_insert;

/
