CREATE OR REPLACE PROCEDURE Y_Sp_H_Batch_Loan_Interest(as_dept_code     IN   VARCHAR2,
                                                  as_sell_code     IN   VARCHAR2,
																  as_receipt_date  IN   DATE) IS
CURSOR DETAIL_CUR IS
SELECT receipt_seq, dongho, seq, amt, col_1, col_2, col_3, 
       process, error_process, error_data, error_data_message
  FROM H_BATCH_LOAN_INTEREST
 WHERE dept_code = as_dept_code
	AND sell_code = as_sell_code
	AND receipt_date = as_receipt_date
	AND process <> 'Y';
   
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   C_CNT               INTEGER;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error

   C_RECEIPT_SEQ       H_BATCH_LOAN_INTEREST.RECEIPT_SEQ%TYPE;
	C_DONGHO            H_BATCH_LOAN_INTEREST.DONGHO%TYPE;
	C_SEQ               H_BATCH_LOAN_INTEREST.SEQ%TYPE;
	C_AMT               H_BATCH_LOAN_INTEREST.AMT%TYPE;
	C_COL_1             H_BATCH_LOAN_INTEREST.COL_1%TYPE;
	C_COL_2             H_BATCH_LOAN_INTEREST.COL_2%TYPE;
	C_COL_3             H_BATCH_LOAN_INTEREST.COL_3%TYPE;
	C_PROCESS           H_BATCH_LOAN_INTEREST.PROCESS%TYPE;
	C_ERROR_PROCESS     H_BATCH_LOAN_INTEREST.ERROR_PROCESS%TYPE;
	C_ERROR_DATA        H_BATCH_LOAN_INTEREST.ERROR_DATA%TYPE;
	C_ERROR_DATA_MESSAGE H_BATCH_LOAN_INTEREST.ERROR_DATA_MESSAGE%TYPE;
   c_paid_seq          H_SALE_LOAN_INTEREST.paid_seq%TYPE;
	sql_stmt            VARCHAR2(100);
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN

		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO C_RECEIPT_SEQ,C_DONGHO,C_SEQ,C_AMT,C_COL_1,C_COL_2,C_COL_3,
			                      C_PROCESS,C_ERROR_PROCESS,C_ERROR_DATA,C_ERROR_DATA_MESSAGE;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
         
			IF C_DONGHO = '' OR C_DONGHO IS NULL THEN
			   C_PROCESS := 'Y';
			   C_ERROR_PROCESS := 'Y';
			   C_ERROR_DATA    := 'Y';
			   C_ERROR_DATA_MESSAGE := '동호가 없습니다. 확인요망';
			   GOTO UPDATE_BATCH;
			END IF;
			
			--SELECT MAX(SEQ)
         SELECT SEQ
			  INTO C_SEQ
			  FROM H_SALE_MASTER
			 WHERE DEPT_CODE = as_dept_code
			   AND SELL_CODE = as_sell_code
            AND last_contract_date <= as_receipt_date
            AND chg_date > as_receipt_date
            AND chg_div <> '00'
				AND DONGHO = C_DONGHO;
				--AND CONTRACT_YN = 'Y';

			IF NOT(C_SEQ > 0) OR C_SEQ IS NULL THEN
			   C_PROCESS := 'Y';
			   C_ERROR_PROCESS := 'Y';
			   C_ERROR_DATA    := 'Y';
			   C_ERROR_DATA_MESSAGE := '해당동호로 계약된 세대가 없습니다. 확인요망';
			   GOTO UPDATE_BATCH;
			END IF;
         
         SELECT NVL(MAX(paid_seq) , 0) +1
           INTO c_paid_seq
           FROM H_SALE_LOAN_INTEREST
          WHERE DEPT_CODE = as_dept_code
			   AND SELL_CODE = as_sell_code
				AND DONGHO    = C_DONGHO
				AND SEQ       = C_SEQ
				AND PAID_DATE = as_receipt_date;
			
			/*SELECT COUNT(*)
			  INTO C_CNT
			  FROM H_SALE_LOAN_INTEREST
			 WHERE DEPT_CODE = as_dept_code
			   AND SELL_CODE = as_sell_code
				AND DONGHO    = C_DONGHO
				AND SEQ       = C_SEQ
				AND PAID_DATE = as_receipt_date;
			
			IF C_CNT > 0 THEN
			   C_PROCESS := 'Y';
			   C_ERROR_PROCESS := 'Y';
			   C_ERROR_DATA    := 'Y';
			   C_ERROR_DATA_MESSAGE := '해당일자로 납입된내역이 존재합니다. 확인요망';
			   GOTO UPDATE_BATCH;
			END IF;*/
         
			INSERT INTO H_SALE_LOAN_INTEREST
			       VALUES(as_dept_code, as_sell_code, C_DONGHO, C_SEQ, as_receipt_date,c_paid_seq, C_AMT, '일괄입력', NULL, NULL, C_COL_2,c_col_3);
			C_PROCESS := 'Y';
		   C_ERROR_PROCESS := 'N';
		   C_ERROR_DATA    := 'N';
		   C_ERROR_DATA_MESSAGE := ''; 

		   <<UPDATE_BATCH>>
			UPDATE H_BATCH_LOAN_INTEREST
			   SET seq = C_SEQ,
				    process = c_process,
				    error_process = c_error_process,
					 error_data    = c_error_data,
					 error_data_message = c_error_data_message
			 WHERE DEPT_CODE = as_dept_code
				AND SELL_CODE = as_sell_code
				AND RECEIPT_DATE = as_receipt_date
				AND RECEIPT_SEQ  = C_RECEIPT_SEQ;

			COMMIT;

		END LOOP;
		CLOSE DETAIL_CUR;



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
END Y_Sp_H_Batch_Loan_Interest;
/

