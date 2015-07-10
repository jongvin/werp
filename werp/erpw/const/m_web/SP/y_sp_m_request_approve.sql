/* ============================================================================= */
/* 함수명 : y_sp_m_request_approve.sql                                                       */
/* 기  능 : 자재청구 전자결재 승인 프로세스                               */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 요청 순번               ==> ai_requestseq(Integer)                    */
/*        : 요청일자                ==> as_request_date(string)                    */
/*        : 승인tag                ==> as_approve_class (string)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 박두현                                                               */
/* 작성일 : 2003.09.15                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_request_approve(as_dept_code    IN   VARCHAR2,
                                           ai_requestseq   IN   INTEGER,
                                           as_requestdate   IN   VARCHAR2,
                                           as_approve_class        IN   VARCHAR2) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   Wk_approve_class    VARCHAR2(1);
-- User Define Error 
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
  
     IF as_approve_class = '1' THEN
        Wk_approve_class := '2';
     END IF;   
     IF as_approve_class = '2' THEN
        Wk_approve_class := '2';
     END IF;   
     IF as_approve_class = '3' THEN
        Wk_approve_class := '2';
     END IF;   
     IF as_approve_class = '4' THEN
        Wk_approve_class := '4';
     END IF;   
     IF as_approve_class = '5' THEN
        Wk_approve_class := '1';
     END IF;   

		UPDATE m_request set approve_class = Wk_approve_class
				where dept_code = as_dept_code and REQUESTSEQ= ai_requestseq;
      COMMIT;
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'update 승인과정  자료변환 실패! [Line No: 55]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
	END;
	BEGIN
     IF as_approve_class = '4' THEN
		 UPDATE m_request set requestdate = as_requestdate
				where dept_code = as_dept_code and REQUESTSEQ= ai_requestseq;
		 COMMIT;
     END IF;   
	      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '요청일자 자료변환 실패! [Line No: 68]';
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
END y_sp_m_request_approve;

/
