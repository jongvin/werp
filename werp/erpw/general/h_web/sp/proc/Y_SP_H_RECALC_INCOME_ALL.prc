CREATE OR REPLACE PROCEDURE Y_Sp_H_Recalc_Income_All(as_dept_code    IN   VARCHAR2,
	                                                    as_sell_code    IN   VARCHAR2,
	                                                    as_dongho       IN   VARCHAR2,
	                                                    as_seq          IN   INTEGER
																		 ) IS

CURSOR DAILY_CUR IS
SELECT RECEIPT_DATE, DAILY_SEQ, AMT, RECEIPT_CODE, DEPOSIT_NO,
       RECEIPT_CLASS_CODE, CARD_APP_NUM, RECEIPT_NUMBER,CARD_BANK_CODE, v_account_no, fb_seq
  FROM H_SALE_INCOME_DAILY
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = as_seq
ORDER BY receipt_date, daily_seq;
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
C_RECEIPT_DATE       H_SALE_INCOME_DAILY.RECEIPT_DATE%TYPE;
C_DAILY_SEQ          H_SALE_INCOME_DAILY.DAILY_SEQ%TYPE;
C_AMT                H_SALE_INCOME_DAILY.AMT%TYPE;
C_RECEIPT_CODE       H_SALE_INCOME_DAILY.RECEIPT_CODE%TYPE;
C_DEPOSIT_NO         H_SALE_INCOME_DAILY.DEPOSIT_NO%TYPE;
C_RECEIPT_CLASS_CODE H_SALE_INCOME_DAILY.RECEIPT_CLASS_CODE%TYPE;
C_CARD_APP_NUM       H_SALE_INCOME_DAILY.CARD_APP_NUM%TYPE;
C_RECEIPT_NUMBER     H_SALE_INCOME_DAILY.RECEIPT_NUMBER%TYPE;
C_CARD_BANK_CODE     H_SALE_INCOME_DAILY.CARD_BANK_CODE%TYPE;
C_v_account_no       H_SALE_INCOME_DAILY.v_account_no%TYPE;
C_fb_seq             H_SALE_INCOME_DAILY.fb_seq%TYPE;
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   C_CNT                NUMBER(20,5);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
      
		OPEN	DAILY_CUR;  --삭제하기전에 커서 오픈/저장
		
		DELETE FROM H_SALE_INCOME income
	    WHERE income.dept_code = as_dept_code
	      AND income.sell_code = as_sell_code
		   AND income.dongho    = as_dongho
		   AND income.seq       = as_seq;
		  
	   DELETE FROM H_SALE_INCOME_DAILY daily
	    WHERE daily.dept_code = as_dept_code
	      AND daily.sell_code = as_sell_code
		   AND daily.dongho    = as_dongho
		   AND daily.seq       = as_seq;
		  
	   UPDATE H_SALE_AGREE
		   SET tot_amt= 0,f_pay_yn='N';

	   
		LOOP
			FETCH DAILY_CUR INTO C_RECEIPT_DATE, C_DAILY_SEQ, C_AMT, C_RECEIPT_CODE,C_DEPOSIT_NO,
                               C_RECEIPT_CLASS_CODE, C_CARD_APP_NUM, C_RECEIPT_NUMBER,C_CARD_BANK_CODE, 
                               c_v_account_no, c_fb_seq ;
			EXIT WHEN DAILY_CUR%NOTFOUND;
			
		   H_Calc_Income.y_sp_h_income_cmpt(as_dept_code, as_sell_code, as_dongho, as_seq, C_RECEIPT_DATE, C_AMT,C_RECEIPT_CODE,
			 					 C_DEPOSIT_NO, '재계산',C_RECEIPT_CLASS_CODE,C_RECEIPT_NUMBER,C_CARD_APP_NUM,C_CARD_BANK_CODE, 
                         c_v_account_no, c_fb_seq);

      END LOOP;
		CLOSE DAILY_CUR;


	EXCEPTION
	  WHEN OTHERS THEN
		 IF SQL%NOTFOUND THEN
			 e_msg      := '재계산 실패! [Line No: 1]';
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
END Y_Sp_H_Recalc_Income_All;
/

