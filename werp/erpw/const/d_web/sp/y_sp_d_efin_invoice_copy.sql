/* ============================================================================= */
/* 함수명 : y_sp_d_efin_invoice_copy.sql                                                */
/* 기  능 :   결재헤더정보 복사                                       */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 해더 unq_num               ==> ai_invoice_group_id                     */
/*        : temp unq_num             ==> ai_spec_no_seq(NUMBER)                    */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 박두현                                                               */
/* 작성일 : 2004.10.15                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_d_efin_invoice_copy(ai_invoice_group_id    IN  NUMBER,
                                            ai_spec_no_seq   IN   NUMBER,as_source IN VARCHAR2,
                                            arg_batch_date   IN   DATE
                                            ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   wk_created_dept_code      VARCHAR2(7);
   wk_approval_num     VARCHAR2(100);
   C_CNT               INTEGER        DEFAULT 0;
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
   -- 결재번호를 구하기위해서 생성부서코드를 구함.             
		select ATTRIBUTE2
		  into wk_created_dept_code
		  from EFIN_INVOICE_HEADER_SAVE_ITF
		 WHERE INVOICE_GROUP_ID = ai_spec_no_seq;
   -- 결재번호를 구함.
       		 		   
      apps.efin_invoice_approval_pkg.get_approval_num(substr(wk_created_dept_code,1,2),to_char(arg_batch_date,'yyyymmdd'),wk_approval_num);
  
		INSERT INTO EFIN_INVOICE_HEADER_ITF (
		            INVOICE_GROUP_ID,   
                  APPROVAL_NUM,   
                  APPROVAL_NAME,   
                  SOURCE,   
                  COMPLETE_FLAG,   
                  INTERFACE_FLAG,   
                  CURRENT_APPROVAL_ID,   
                  ACCOUNT_DEPT_CODE,   
                  SECRETARY_DEPT_CODE,   
                  APPROVAL_ID_LAST,   
                  APPROVAL_ID_1,   
                  APPROVAL_JIK_1,   
                  APPROVAL_NAME_1,   
                  APPROVAL_DATE_1,   
                  APPROVAL_STATUS_1,   
                  APPROVAL_ID_2,   
                  APPROVAL_JIK_2,   
                  APPROVAL_NAME_2,   
                  APPROVAL_DATE_2,   
                  APPROVAL_STATUS_2,   
                  APPROVAL_ID_3,   
                  APPROVAL_JIK_3,   
                  APPROVAL_NAME_3,   
                  APPROVAL_DATE_3,   
                  APPROVAL_STATUS_3,   
                  APPROVAL_ID_4,   
                  APPROVAL_JIK_4,   
                  APPROVAL_NAME_4,   
                  APPROVAL_DATE_4,   
                  APPROVAL_STATUS_4,   
                  APPROVAL_ID_5,   
                  APPROVAL_JIK_5,   
                  APPROVAL_NAME_5,   
                  APPROVAL_DATE_5,   
                  APPROVAL_STATUS_5,   
                  APPROVAL_ID_6,   
                  APPROVAL_JIK_6,   
                  APPROVAL_NAME_6,   
                  APPROVAL_DATE_6,   
                  APPROVAL_STATUS_6,   
                  APPROVAL_ID_7,   
                  APPROVAL_JIK_7,   
                  APPROVAL_NAME_7,   
                  APPROVAL_DATE_7,   
                  APPROVAL_STATUS_7,   
                  APPROVAL_ID_8,   
                  APPROVAL_JIK_8,   
                  APPROVAL_NAME_8,   
                  APPROVAL_DATE_8,   
                  APPROVAL_STATUS_8,   
                  APPROVAL_ID_9,   
                  APPROVAL_JIK_9,   
                  APPROVAL_NAME_9,   
                  APPROVAL_DATE_9,   
                  APPROVAL_STATUS_9,   
                  APPROVAL_ID_10,   
                  APPROVAL_JIK_10,   
                  APPROVAL_NAME_10,   
                  APPROVAL_DATE_10,   
                  APPROVAL_STATUS_10,   
                  APPROVAL_ID_11,   
                  APPROVAL_JIK_11,   
                  APPROVAL_NAME_11,   
                  APPROVAL_DATE_11,   
                  APPROVAL_STATUS_11,   
                  CREATION_DATE,   
                  CREATED_BY,   
                  CREATED_DEPT_CODE,   
                  CREATED_DEPT_NAME,   
                  BATCH_DATE,   
                  LAST_UPDATE_DATE,   
                  LAST_UPDATE_LOGIN,   
                  LAST_UPDATED_BY,
                  relation_invoice_group_id,   
                  ATTRIBUTE1,   
                  ATTRIBUTE2,   
                  ATTRIBUTE3,   
                  ATTRIBUTE4,   
                  ATTRIBUTE5,   
                  ATTRIBUTE6,   
                  ATTRIBUTE7,   
                  ATTRIBUTE8,   
                  ATTRIBUTE9,   
                  ATTRIBUTE10  
		     )
           SELECT ai_invoice_group_id,   
                  ' ',     
                  a.APPROVAL_NAME,   
                  as_source,   
                  a.COMPLETE_FLAG,   
                  a.INTERFACE_FLAG,   
                  a.CURRENT_APPROVAL_ID,   
                  a.ACCOUNT_DEPT_CODE,   
                  a.SECRETARY_DEPT_CODE,   
                  a.APPROVAL_ID_LAST,   
                  a.APPROVAL_ID_1,   
                  a.APPROVAL_JIK_1,   
                  a.APPROVAL_NAME_1,   
                  a.APPROVAL_DATE_1,   
                  a.APPROVAL_STATUS_1,   
                  a.APPROVAL_ID_2,   
                  a.APPROVAL_JIK_2,   
                  a.APPROVAL_NAME_2,   
                  a.APPROVAL_DATE_2,   
                  a.APPROVAL_STATUS_2,   
                  a.APPROVAL_ID_3,   
                  a.APPROVAL_JIK_3,   
                  a.APPROVAL_NAME_3,   
                  a.APPROVAL_DATE_3,   
                  a.APPROVAL_STATUS_3,   
                  a.APPROVAL_ID_4,   
                  a.APPROVAL_JIK_4,   
                  a.APPROVAL_NAME_4,   
                  a.APPROVAL_DATE_4,   
                  a.APPROVAL_STATUS_4,   
                  a.APPROVAL_ID_5,   
                  a.APPROVAL_JIK_5,   
                  a.APPROVAL_NAME_5,   
                  a.APPROVAL_DATE_5,   
                  a.APPROVAL_STATUS_5,   
                  a.APPROVAL_ID_6,   
                  a.APPROVAL_JIK_6,   
                  a.APPROVAL_NAME_6,   
                  a.APPROVAL_DATE_6,   
                  a.APPROVAL_STATUS_6,   
                  a.APPROVAL_ID_7,   
                  a.APPROVAL_JIK_7,   
                  a.APPROVAL_NAME_7,   
                  a.APPROVAL_DATE_7,   
                  a.APPROVAL_STATUS_7,   
                  a.APPROVAL_ID_8,   
                  a.APPROVAL_JIK_8,   
                  a.APPROVAL_NAME_8,   
                  a.APPROVAL_DATE_8,   
                  a.APPROVAL_STATUS_8,   
                  a.APPROVAL_ID_9,   
                  a.APPROVAL_JIK_9,   
                  a.APPROVAL_NAME_9,   
                  a.APPROVAL_DATE_9,   
                  a.APPROVAL_STATUS_9,   
                  a.APPROVAL_ID_10,   
                  a.APPROVAL_JIK_10,   
                  a.APPROVAL_NAME_10,   
                  a.APPROVAL_DATE_10,   
                  a.APPROVAL_STATUS_10,   
                  a.APPROVAL_ID_11,   
                  a.APPROVAL_JIK_11,   
                  a.APPROVAL_NAME_11,   
                  a.APPROVAL_DATE_11,   
                  a.APPROVAL_STATUS_11,   
                  a.CREATION_DATE,   
                  a.CREATED_BY,   
                  a.CREATED_DEPT_CODE,   
                  a.CREATED_DEPT_NAME,   
                  a.BATCH_DATE,   
                  a.LAST_UPDATE_DATE,   
                  a.LAST_UPDATE_LOGIN,   
                  a.LAST_UPDATED_BY,
                  a.relation_invoice_group_id,   
                  a.ATTRIBUTE1,    
                  a.ATTRIBUTE2,  -- 사업장 코드  
                  a.ATTRIBUTE3,   
                  a.ATTRIBUTE4,   
                  a.ATTRIBUTE5,   
                  a.ATTRIBUTE6,   
                  a.ATTRIBUTE7,   
                  a.ATTRIBUTE8,   
                  a.ATTRIBUTE9,   
                  a.ATTRIBUTE10  
             FROM EFIN_INVOICE_HEADER_SAVE_ITF a   
            WHERE a.INVOICE_GROUP_ID = ai_spec_no_seq;
            


   -- 결전번호 수정   
		UPDATE EFIN_INVOICE_HEADER_ITF  
		  SET approval_num  = wk_approval_num,
		      batch_date = arg_batch_date
		 WHERE INVOICE_GROUP_ID = ai_invoice_group_id;
             
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'insert EFIN_INVOICE_HEADER_ITF 자료복사 실패! [Line No: 157]';
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
END y_sp_d_efin_invoice_copy;

/
