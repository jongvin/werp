/* ============================================================================= */
/* 함수명 : sp_y_esmt_emsconvert_tmp                                             */
/* 기  능 : EMS자료 변환시(실행) 하위구분과 자원코드 Match Check함.              */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_receive_code (string)                     */
/*        : 부분                   ==> as_part      (string)                     */
/*        : 번호                   ==> ai_degree    (string)                     */
/*        : 사용자                 ==> as_user      (string)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2001.08.14                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_esmt_emsconvert_tmp(as_receive_code    IN   VARCHAR2,
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
-- 표준자원과 연계안되면 'N'를 Setting한다. 
   UPDATE y_esmt_tmp_detail a
      SET a.res_connect_yn = 'Y'
    WHERE (a.receive_code = as_receive_code) AND 
          (a.part_class   = as_part) AND
         EXISTS (SELECT b.detail_code
	                FROM y_stand_spec b
                  WHERE  a.detail_code = b.detail_code);


-- 집계구조마지막 하위구분에 'Y'를 Setting 한다. 
   update y_esmt_tmp_summary a
      set a.detail_yn = 'Y'
   WHERE (a.receive_code = as_receive_code) AND 
         (a.part_class   = as_part) and
         (a.sum_code  in (select b.parent_sum_code
                            from y_esmt_tmp_summary b
                           where a.receive_code = b.receive_code
                             and a.part_class   = b.part_class));


   update y_esmt_tmp_summary a
      set a.invest_class = 'Y',
          a.detail_yn = 'Y'
    where (a.receive_code  = as_receive_code)
      and (a.part_class = as_part)
      and (a.sum_code  in ( select sum_code
                              from y_esmt_tmp_detail
                             where receive_code  = as_receive_code
                               and part_class = as_part
                          group by receive_code,
                                   part_class,
                                   sum_code));

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
END sp_y_esmt_emsconvert_tmp;

/
