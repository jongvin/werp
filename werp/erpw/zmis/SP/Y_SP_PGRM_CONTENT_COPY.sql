CREATE OR REPLACE PROCEDURE "Y_SP_PGRM_CONTENT_COPY"  (al_from_pgrm_above_key    IN   NUMBER,
                                                       al_to_group_key           IN   NUMBER,
												                   al_to_group_seq_key        IN   NUMBER) IS
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
		INSERT INTO z_group_pgrm_content
		       ( SELECT al_to_group_key,al_to_group_seq_key,
			     		pgrm_seq_key,no_seq,rw_tag
			       FROM z_pgrm_content
				  WHERE pgrm_above_key = al_from_pgrm_above_key);
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '프로그램 복사 실패! [Line No: 2]';
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
END Y_SP_PGRM_CONTENT_COPY;
/
