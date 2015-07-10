CREATE OR REPLACE PROCEDURE Y_Sp_H_Recalc_Daily_Income(as_dept_code    IN   VARCHAR2,
	                                                    as_sell_code    IN   VARCHAR2,
	                                                    as_dongho       IN   VARCHAR2,
	                                                    as_seq          IN   INTEGER,
																		 as_receipt_date IN   DATE,
																		 as_daily_seq    IN   INTEGER) IS

--지정차수포함해서 이후자료에 대해서 재입금처리
--as_recalc_tag  1  *삭제하려는 차수 삭제, *이후차수 삭제, *이후차수에 대해서 재계산
--as_recalc_tag  0  *삭제하려는 차수 삭제, *이후차수 삭제  (재계산 안함)

--삭제할 차수 포함해서 이후에 대해서 보관한다. 삭제용
CURSOR DAILY_CUR IS
SELECT RECEIPT_DATE, DAILY_SEQ
  FROM H_SALE_INCOME_DAILY
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = as_seq
	AND (    receipt_date > as_receipt_date
	     OR  (receipt_date = as_receipt_date AND
		       daily_seq    >= as_daily_seq)
		 )
ORDER BY receipt_date, daily_seq;
--삭제할 차수 이후에 대해서 보관한다. 재입금 처리용(재계산)
CURSOR DAILY_RECALC_CUR IS
SELECT RECEIPT_DATE, DAILY_SEQ, AMT, RECEIPT_CODE, DEPOSIT_NO,
       RECEIPT_CLASS_CODE, CARD_APP_NUM, RECEIPT_NUMBER,CARD_BANK_CODE, v_account_no, fb_seq
  FROM H_SALE_INCOME_DAILY
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND dongho     = as_dongho
	AND seq        = as_seq
	AND (    receipt_date > as_receipt_date
	     OR  (receipt_date = as_receipt_date AND
		       daily_seq    >= as_daily_seq)
		 )
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
	BEGIN
		OPEN	DAILY_CUR;
		OPEN	DAILY_RECALC_CUR; --재계산하기 위해서 삭제 하기전에 가져온다
-----------------------------------------삭제처리
		LOOP
			FETCH DAILY_CUR INTO C_RECEIPT_DATE, C_DAILY_SEQ ;
			EXIT WHEN DAILY_CUR%NOTFOUND;

			UPDATE H_SALE_AGREE
			  SET (tot_amt,f_pay_yn)=
				   (SELECT agree.tot_amt - in_sum.amt,
				           CASE WHEN agree.tot_amt - in_sum.amt = agree.sell_amt
				                THEN 'Y'
								 	 ELSE 'N'
							  END CASE
					   FROM H_SALE_AGREE agree,
					       (SELECT income.degree_code,
					               SUM(NVL(income.r_amt, 0)) amt
					          FROM H_SALE_INCOME income
							   WHERE income.dept_code = as_dept_code
							     AND income.sell_code = as_sell_code
								  AND income.dongho    = as_dongho
								  AND income.seq       = as_seq
								  AND income.receipt_date = C_RECEIPT_DATE
								  AND income.daily_seq    = C_DAILY_SEQ
							  GROUP BY income.degree_code) in_sum

					  WHERE agree.dept_code = as_dept_code
					    AND agree.sell_code = as_sell_code
					    AND agree.dongho    = as_dongho
					    AND agree.seq       = as_seq
					    AND agree.degree_code = in_sum.degree_code
						 AND H_SALE_AGREE.degree_code = in_sum.degree_code)
			WHERE H_SALE_AGREE.dept_code = as_dept_code
			  AND H_SALE_AGREE.sell_code = as_sell_code
			  AND H_SALE_AGREE.dongho    = as_dongho
			  AND H_SALE_AGREE.seq       = as_seq
			  AND H_SALE_AGREE.degree_code IN (SELECT income.degree_code
												          FROM H_SALE_INCOME income
														   WHERE income.dept_code = as_dept_code
														     AND income.sell_code = as_sell_code
															  AND income.dongho    = as_dongho
															  AND income.seq       = as_seq
															  AND income.receipt_date = C_RECEIPT_DATE
								                       AND income.daily_seq    = C_DAILY_SEQ);


	     DELETE FROM H_SALE_INCOME income
		   WHERE income.dept_code = as_dept_code
		     AND income.sell_code = as_sell_code
			  AND income.dongho    = as_dongho
			  AND income.seq       = as_seq
			  AND income.receipt_date = C_RECEIPT_DATE
	        AND income.daily_seq    = C_DAILY_SEQ;
		  DELETE FROM H_SALE_INCOME_DAILY daily
		   WHERE daily.dept_code = as_dept_code
		     AND daily.sell_code = as_sell_code
			  AND daily.dongho    = as_dongho
			  AND daily.seq       = as_seq
			  AND daily.receipt_date = C_RECEIPT_DATE
	        AND daily.daily_seq    = C_DAILY_SEQ;

      END LOOP;
		CLOSE DAILY_CUR;

-----------------------------------------재계산처리
      --IF as_recalc_tag = 1 THEN
			LOOP
				FETCH DAILY_RECALC_CUR INTO C_RECEIPT_DATE, C_DAILY_SEQ, C_AMT, C_RECEIPT_CODE,C_DEPOSIT_NO,
	                               C_RECEIPT_CLASS_CODE, C_CARD_APP_NUM, C_RECEIPT_NUMBER,C_CARD_BANK_CODE, 
                                  c_v_account_no, c_fb_seq ;
				EXIT WHEN DAILY_RECALC_CUR%NOTFOUND;



			   H_Calc_Income.y_sp_h_income_cmpt(as_dept_code, as_sell_code, as_dongho, as_seq, C_RECEIPT_DATE, C_AMT,C_RECEIPT_CODE,
				 					 C_DEPOSIT_NO, '재계산',C_RECEIPT_CLASS_CODE,C_RECEIPT_NUMBER,C_CARD_APP_NUM,C_CARD_BANK_CODE, 
                            c_v_account_no, c_fb_seq);
			END LOOP;
		--END IF;

		CLOSE DAILY_RECALC_CUR;

	 EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '일자별수입금 삭제및 재계산 실패! [Line No: 1]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
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
END Y_Sp_H_Recalc_Daily_Income;
/

