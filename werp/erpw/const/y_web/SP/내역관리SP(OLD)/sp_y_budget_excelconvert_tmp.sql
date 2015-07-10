/* ============================================================================= */
/* 함수명 : sp_y_budget_excelconvert_tmp                                         */
/* 기  능 : 엑셀자료 변환시(실행) 하위구분과 자원코드 Match Check함.              */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_proj_code (string)                     */
/*        : 부분                   ==> as_part      (string)                     */
/*        : 번호                   ==> ai_degree    (string)                     */
/*        : 사용자                 ==> as_user      (string)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2002.11.20                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_budget_excelconvert_tmp(as_proj_code    IN   VARCHAR2,
                                                       as_part         IN   VARCHAR2,
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

   delete from y_tmp_detail
         where proj_code = as_proj_code
			  and part_class = as_part
           and name is null;

-- 표준자원과 연계안되면 'N'를 Setting한다. 
   UPDATE y_tmp_detail a
      SET a.res_connect_yn = 'Y'
    WHERE (a.proj_code = as_proj_code) AND 
          (a.part_class = as_part) AND
         EXISTS (SELECT b.detail_code
	                FROM y_stand_spec b
                  WHERE  a.name_key = b.name_key);

   UPDATE y_tmp_detail a
      SET (a.detail_code) = 
          ( SELECT min(b.detail_code)
              FROM y_stand_spec b
             WHERE a.name_key = b.name_key )
    WHERE (a.proj_code = as_proj_code) AND 
          (a.part_class = as_part) AND
          (a.res_connect_yn = 'Y') ;

-- 해당차수의 실행내역과 연계되면 'Y'를 Setting한다. 
--   UPDATE y_tmp_detail a
--      SET a.connect_yn = 'Y'
--    WHERE (a.proj_code = as_proj_code) AND 
--          (a.part_class = as_part) AND
--         EXISTS (SELECT b.detail_code
--	                FROM y_chg_budget_detail b
--                  WHERE a.sum_code    = b.sum_code
--                    AND a.detail_code = b.detail_code
--                    AND b.proj_code = as_proj_code
--                    AND b.no        = ai_no);

-- 해당차수의 실행집계구조와 연계되면 'Y'를 Setting한다. 
--   UPDATE y_tmp_summary a
--      SET a.connect_yn  = 'Y'
--    WHERE (a.proj_code  = as_proj_code) AND 
--          (a.part_class = as_part) AND
--         EXISTS (SELECT b.sum_code
--	                FROM y_chg_budget_summary b
--                  WHERE a.sum_code    = b.sum_code
--                    AND b.proj_code = as_proj_code
--                    AND b.no        = ai_no);

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'EMS 자료변환 실패! [Line No: 159]';
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
END sp_y_budget_excelconvert_tmp;

/
