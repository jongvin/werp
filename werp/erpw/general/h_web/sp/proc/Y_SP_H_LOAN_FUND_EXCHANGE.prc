CREATE OR REPLACE PROCEDURE "Y_SP_H_LOAN_FUND_EXCHANGE" (as_dept_code             IN   VARCHAR2,
																	  as_sell_code              IN   VARCHAR2,
																	  as_dongho                 IN   VARCHAR2,
																	  as_seq                    IN   INTEGER,
																	  as_date                   IN   DATE,
		                                               as_amt                    IN   NUMBER,
																	  as_user                   IN   VARCHAR2
																	  ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR INCOME_CUR IS
SELECT receipt_date, receipt_code, deposit_no,
       receipt_class_code, receipt_number, card_app_num, card_bank_code, v_account_no,
       SUM(r_amt + delay_amt - discount_amt)
   FROM H_SALE_INCOME
  WHERE dept_code = as_dept_code
    AND sell_code = as_sell_code
    AND dongho    = as_dongho
    AND seq       = as_seq
    AND degree_code > '49'
  GROUP BY receipt_date, receipt_code, deposit_no,
       receipt_class_code, receipt_number, card_app_num, card_bank_code
  ORDER BY receipt_date, receipt_code
;
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;
   C_CNT           NUMBER(10,0);
	C_SYSDATE       DATE;
	C_SELL_AMT      NUMBER(15,0);
	C_LAND_AMT      NUMBER(15,0);
	C_BUILD_AMT     NUMBER(15,0);
	C_VAT_AMT       NUMBER(15,0);
	C_SELL_1        NUMBER(15,0);
	C_LAND_1        NUMBER(15,0);
	C_BUILD_1       NUMBER(15,0);
	C_VAT_1         NUMBER(15,0);
	v_amt                 NUMBER(15,0);
	v_receipt_code        VARCHAR(2);
	v_receipt_date        DATE;
   v_deposit_no          VARCHAR(30);
   v_receipt_class_code  VARCHAR(30);
   v_receipt_number      VARCHAR(30);
   v_card_app_num        VARCHAR(30);
   v_card_bank_code	    VARCHAR(30);
   v_v_account_no  	    VARCHAR(20);
BEGIN
	BEGIN
		-- 잔금 약정금액
		SELECT sell_amt,   land_amt,   build_amt,   vat_amt
		  INTO C_SELL_AMT, C_LAND_AMT, C_BUILD_AMT, C_VAT_AMT
		  FROM H_SALE_AGREE
		 WHERE dept_code   = as_dept_code
		   AND sell_code   = as_sell_code
			AND dongho      = as_dongho
			AND seq         = as_seq
			AND degree_code = '50'  ;
		-- 국민주택 기금
		C_SELL_1 := as_amt;
		-- 국민주택 기금 토지가
		IF C_LAND_AMT = 0 THEN
			C_LAND_1  := 0;
		ELSE
			C_LAND_1 := ROUND(C_LAND_AMT * C_SELL_1 / C_SELL_AMT);
		END IF;
		-- 국민주택 기금 건물가
		IF C_BUILD_AMT = 0 THEN
			C_BUILD_1  := 0;
		ELSE
			C_BUILD_1 := ROUND(C_BUILD_AMT * C_SELL_1 / C_SELL_AMT);
		END IF;
		-- 국민주택 기금 부가세
		IF C_VAT_AMT = 0 THEN
			C_VAT_1  := 0;
		ELSE
			C_VAT_1 := ROUND(C_VAT_AMT * C_SELL_1 / C_SELL_AMT);
		END IF;
		-- 잔금 약정이 토지/건물/부가세로 정상적으로 나누어져 있으면 국민기금도 토/건/부 금액
		-- 차이를 토지가에서 조정해서 맞춰 준다(토지가가 없으면 건물가에 조정)
		-- 잔금 약정이 토/건/부로 나누어져 있지 않은 경우에는 의미가 없음
		IF C_SELL_AMT = (C_LAND_AMT + C_BUILD_AMT + C_VAT_AMT) THEN
			IF C_LAND_AMT <> 0 THEN
				C_LAND_1  := C_LAND_1  + (C_SELL_1 - C_LAND_1 - C_BUILD_1 - C_VAT_1);
			ELSE
				C_BUILD_1 := C_BUILD_1 + (C_SELL_1 - C_LAND_1 - C_BUILD_1 - C_VAT_1);
			END IF;
		END IF;
	   -- 국민주택기금 약정차수 등록  ('81' : 국민주택기금 차수)
		INSERT INTO H_SALE_AGREE
				VALUES ( as_dept_code, as_sell_code, as_dongho, as_seq, '81',
				       as_date, C_LAND_1, C_BUILD_1, C_VAT_1, as_amt, 'N', 0,
						 SYSDATE, 0, NULL, NULL, NULL, NULL, NULL, NULL ) ;
		EXCEPTION
	      WHEN OTHERS THEN
	        IF SQL%NOTFOUND THEN
	           e_msg      := '국민기금 약정 처리 실패! [Line No: 2]';
	           Wk_errflag := -20020;
	           GOTO EXIT_ROUTINE;
	        END IF;
	END;
	BEGIN
		-- 잔금 약정금액 계산
		C_SELL_1  := C_SELL_AMT  - C_SELL_1 ;
		C_LAND_1  := C_LAND_AMT  - C_LAND_1 ;
		C_BUILD_1 := C_BUILD_AMT - C_BUILD_1 ;
		C_VAT_1   := C_VAT_AMT   - C_VAT_1 ;
		-- 잔금 약정 변경
		UPDATE H_SALE_AGREE
		   SET sell_amt  = C_SELL_1,
		       land_amt  = C_LAND_1,
		       build_amt = C_BUILD_1,
		       vat_amt   = C_VAT_1,
		       tot_amt   = 0,
		       f_pay_yn  = 'N'
		 WHERE dept_code = as_dept_code
	      AND sell_code = as_sell_code
		   AND dongho    = as_dongho
		   AND seq       = as_seq
		   AND degree_code = '50';
		EXCEPTION
	      WHEN OTHERS THEN
	        IF SQL%NOTFOUND THEN
	           e_msg      := '국민기금 처리 잔금약정 수정 실패! [Line No: 3]';
	           Wk_errflag := -20020;
	           GOTO EXIT_ROUTINE;
	        END IF;
	END;
	BEGIN
		OPEN	INCOME_CUR;
		DELETE H_SALE_INCOME
		  WHERE dept_code = as_dept_code
		    AND sell_code = as_sell_code
		    AND dongho    = as_dongho
		    AND seq       = as_seq
		    AND degree_code > '49' ;
		LOOP
			FETCH INCOME_CUR INTO v_receipt_date, v_receipt_code, v_deposit_no,
                               v_receipt_class_code, v_receipt_number, v_card_app_num, v_card_bank_code, v_v_account_no,
                               v_amt;
			EXIT WHEN INCOME_CUR%NOTFOUND;
         -- 분양 수입금 재계산(잔금 차수 이후 부터만 계산됨)
         H_Calc_Income.Y_SP_H_INCOME_CMPT ( as_dept_code, as_sell_code, as_dongho, as_seq, v_receipt_date, v_amt,
                              v_receipt_code, v_deposit_no, as_user, v_receipt_class_code,
                              v_receipt_number, v_card_app_num, v_card_bank_code, v_v_account_no,NULL );
		END LOOP;
		CLOSE INCOME_CUR;
      -- 국민주택 기금 --> 분양수입금 입력
      H_Calc_Income.Y_SP_H_INCOME_CMPT ( as_dept_code, as_sell_code, as_dongho, as_seq, as_date, as_amt,
                           '04', NULL, as_user, NULL,
                           NULL, NULL, NULL,NULL,null );
      -- 국민주택 기금 대환일자 수정
		UPDATE H_SALE_FUND
		  SET  exchange_date = as_date,
		       process_yn    = 'Y'
		 WHERE dept_code  = as_dept_code
		   AND sell_code  = as_sell_code
		   AND dongho     = as_dongho
		   AND seq        = as_seq ;
   EXCEPTION
      WHEN OTHERS THEN
        IF SQL%NOTFOUND THEN
           e_msg      := '국민기금 대체 처리 ERROR [Line No: 99]';
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
       ROLLBACK;
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END Y_Sp_H_Loan_Fund_Exchange;
/

