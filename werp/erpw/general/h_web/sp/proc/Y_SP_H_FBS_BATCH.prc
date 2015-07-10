CREATE OR REPLACE PROCEDURE Y_Sp_H_fbs_batch  (ai_work_seq IN NUMBER,
                                               as_work_tag IN VARCHAR2,
                                               as_sms_yn   IN VARCHAR2) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
      SELECT fb_seq
        FROM H_FB_INTF_INCOME
       WHERE work_seq = ai_work_seq;
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
   
   C_FB_SEQ H_FB_INTF_INCOME.FB_SEQ%TYPE;
	
BEGIN
 BEGIN
   OPEN	DETAIL_CUR;
	LOOP
      FETCH DETAIL_CUR INTO C_FB_SEQ;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
      
      IF AS_WORK_TAG = 'MAP' THEN
         Y_Sp_H_Fbs_Apply_Income(C_FB_SEQ);
      ELSIF AS_WORK_TAG = 'APP' THEN
         Y_Sp_H_Fbs_Apply_Mapped(C_FB_SEQ);
      ELSE
         RAISE_APPLICATION_ERROR(-20001, '사용하지 않는 작업태그 입니다'||ai_work_seq||'/'||as_work_tag||'/'||as_sms_yn);
      END IF;
      	
	END LOOP;
	CLOSE DETAIL_CUR;
   
   IF AS_SMS_YN = 'N' THEN
      UPDATE H_FB_INTF_INCOME
         SET WORK_SEQ = NULL
       WHERE FB_SEQ = C_FB_SEQ;
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
  /*WHEN UserErr       THEN
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);*/
  WHEN OTHERS THEN
       RAISE;
    
END Y_Sp_H_fbs_batch;
/

