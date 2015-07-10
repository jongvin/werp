 /* ============================================================================ */
/* 함수명 : y_sp_slip_delete(CJ개발)                                             */
/* 기  능 : 전표를 삭제한다                                                      */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 전표번호               ==> ai_seq (number)                           */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2006.04.12                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_slip_delete (ai_seq   IN   NUMBER) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------

-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   Wk_Chk              NUMBER(10,0) DEFAULT 0 ;
   WK_Chk_msg          VARCHAR2(100);

-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
 BEGIN
-- 전표를 삭제한다
  		PKG_T_Check_Slip.DeleteMaster(ai_seq);

		update f_request
			set invoice_num = '',work_date = ''
		 where invoice_num = ai_seq;

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '전표삭제 실패! [Line No: 1]';
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
END y_sp_slip_delete;
