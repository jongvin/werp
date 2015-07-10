CREATE OR REPLACE PROCEDURE Y_Sp_H_Set_V_Account_No (as_dept_code             IN   VARCHAR2,
																	  as_sell_code             IN   VARCHAR2,
																	  as_dongho                IN   VARCHAR2,
																	  as_seq                   IN   INTEGER,
                                                     as_deposit_no            IN   VARCHAR2,
                                                     as_v_account_no          IN   VARCHAR2
																	  ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;
   C_CNT           NUMBER(10,0);
	C_SYSDATE       DATE;
	V_AMT           NUMBER(15,0);
	V_AMT_VAT       NUMBER(15,0);
	V_DEGREE_CODE   VARCHAR2(2);
	V_AGREE_DATE    DATE;
	V_AMT_PER       NUMBER(5,2);
	V_AGREE_AMT     NUMBER(15,0);
BEGIN
	BEGIN
		SELECT COUNT(*)
        INTO C_CNT
        FROM H_CODE_V_ACCOUNT
       WHERE DEPT_CODE    = AS_DEPT_CODE
         AND SELL_CODE    = AS_SELL_CODE
         AND DEPOSIT_NO   = AS_DEPOSIT_NO
         AND V_ACCOUNT_NO = AS_V_ACCOUNT_NO 
         AND USE_TAG = 0 ;
       
       IF C_CNT != 1  THEN
          RAISE_APPLICATION_ERROR(-20001, AS_DEPOSIT_NO||'/'||AS_V_ACCOUNT_NO||'가상계좌 부여 실패, 다시 시도 하세요..');
          RETURN;
       END IF; 
       
       UPDATE H_CODE_V_ACCOUNT
          SET DONGHO = AS_DONGHO,
              SEQ    = AS_SEQ,
              APPLY_DATE = (SELECT SYSDATE FROM DUAL),
              CANCEL_DATE = NULL,
              USE_TAG    = 1
        WHERE DEPT_CODE = AS_DEPT_CODE
          AND SELL_CODE = AS_SELL_CODE
          AND DEPOSIT_NO = AS_DEPOSIT_NO
          AND V_ACCOUNT_NO = AS_V_ACCOUNT_NO;
       
       UPDATE H_SALE_MASTER
          SET DEPOSIT_NO = AS_DEPOSIT_NO,
              V_ACCOUNT_NO = AS_V_ACCOUNT_NO
        WHERE DEPT_CODE = AS_DEPT_CODE
          AND SELL_CODE = AS_SELL_CODE
          AND DONGHO    = AS_DONGHO
          AND SEQ       = AS_SEQ;
            
       
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
END Y_Sp_H_Set_V_Account_No;
/

