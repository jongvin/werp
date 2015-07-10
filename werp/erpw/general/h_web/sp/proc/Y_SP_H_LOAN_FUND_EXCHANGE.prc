CREATE OR REPLACE PROCEDURE "Y_SP_H_LOAN_FUND_EXCHANGE" (as_dept_code             IN   VARCHAR2,
																	  as_sell_code              IN   VARCHAR2,
																	  as_dongho                 IN   VARCHAR2,
																	  as_seq                    IN   INTEGER,
																	  as_date                   IN   DATE,
		                                               as_amt                    IN   NUMBER,
																	  as_user                   IN   VARCHAR2
																	  ) IS
-------------------------------------------------------------
-- ��������
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
-- ���� ����
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
		-- �ܱ� �����ݾ�
		SELECT sell_amt,   land_amt,   build_amt,   vat_amt
		  INTO C_SELL_AMT, C_LAND_AMT, C_BUILD_AMT, C_VAT_AMT
		  FROM H_SALE_AGREE
		 WHERE dept_code   = as_dept_code
		   AND sell_code   = as_sell_code
			AND dongho      = as_dongho
			AND seq         = as_seq
			AND degree_code = '50'  ;
		-- �������� ���
		C_SELL_1 := as_amt;
		-- �������� ��� ������
		IF C_LAND_AMT = 0 THEN
			C_LAND_1  := 0;
		ELSE
			C_LAND_1 := ROUND(C_LAND_AMT * C_SELL_1 / C_SELL_AMT);
		END IF;
		-- �������� ��� �ǹ���
		IF C_BUILD_AMT = 0 THEN
			C_BUILD_1  := 0;
		ELSE
			C_BUILD_1 := ROUND(C_BUILD_AMT * C_SELL_1 / C_SELL_AMT);
		END IF;
		-- �������� ��� �ΰ���
		IF C_VAT_AMT = 0 THEN
			C_VAT_1  := 0;
		ELSE
			C_VAT_1 := ROUND(C_VAT_AMT * C_SELL_1 / C_SELL_AMT);
		END IF;
		-- �ܱ� ������ ����/�ǹ�/�ΰ����� ���������� �������� ������ ���α�ݵ� ��/��/�� �ݾ�
		-- ���̸� ���������� �����ؼ� ���� �ش�(�������� ������ �ǹ����� ����)
		-- �ܱ� ������ ��/��/�η� �������� ���� ���� ��쿡�� �ǹ̰� ����
		IF C_SELL_AMT = (C_LAND_AMT + C_BUILD_AMT + C_VAT_AMT) THEN
			IF C_LAND_AMT <> 0 THEN
				C_LAND_1  := C_LAND_1  + (C_SELL_1 - C_LAND_1 - C_BUILD_1 - C_VAT_1);
			ELSE
				C_BUILD_1 := C_BUILD_1 + (C_SELL_1 - C_LAND_1 - C_BUILD_1 - C_VAT_1);
			END IF;
		END IF;
	   -- �������ñ�� �������� ���  ('81' : �������ñ�� ����)
		INSERT INTO H_SALE_AGREE
				VALUES ( as_dept_code, as_sell_code, as_dongho, as_seq, '81',
				       as_date, C_LAND_1, C_BUILD_1, C_VAT_1, as_amt, 'N', 0,
						 SYSDATE, 0, NULL, NULL, NULL, NULL, NULL, NULL ) ;
		EXCEPTION
	      WHEN OTHERS THEN
	        IF SQL%NOTFOUND THEN
	           e_msg      := '���α�� ���� ó�� ����! [Line No: 2]';
	           Wk_errflag := -20020;
	           GOTO EXIT_ROUTINE;
	        END IF;
	END;
	BEGIN
		-- �ܱ� �����ݾ� ���
		C_SELL_1  := C_SELL_AMT  - C_SELL_1 ;
		C_LAND_1  := C_LAND_AMT  - C_LAND_1 ;
		C_BUILD_1 := C_BUILD_AMT - C_BUILD_1 ;
		C_VAT_1   := C_VAT_AMT   - C_VAT_1 ;
		-- �ܱ� ���� ����
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
	           e_msg      := '���α�� ó�� �ܱݾ��� ���� ����! [Line No: 3]';
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
         -- �о� ���Ա� ����(�ܱ� ���� ���� ���͸� ����)
         H_Calc_Income.Y_SP_H_INCOME_CMPT ( as_dept_code, as_sell_code, as_dongho, as_seq, v_receipt_date, v_amt,
                              v_receipt_code, v_deposit_no, as_user, v_receipt_class_code,
                              v_receipt_number, v_card_app_num, v_card_bank_code, v_v_account_no,NULL );
		END LOOP;
		CLOSE INCOME_CUR;
      -- �������� ��� --> �о���Ա� �Է�
      H_Calc_Income.Y_SP_H_INCOME_CMPT ( as_dept_code, as_sell_code, as_dongho, as_seq, as_date, as_amt,
                           '04', NULL, as_user, NULL,
                           NULL, NULL, NULL,NULL,null );
      -- �������� ��� ��ȯ���� ����
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
           e_msg      := '���α�� ��ü ó�� ERROR [Line No: 99]';
           Wk_errflag := -20020;
           GOTO EXIT_ROUTINE;
        END IF;
	END;
   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   <<EXIT_ROUTINE>>
   -- ENDING...[0.1] CURSOR CLOSE �� Ȯ�� ó�� !
   IF Wk_errflag = 0 THEN
      Wk_errmsg  := '';                        -- ����� ���� Error Message
      Wk_errflag := 0;                         -- ����� ���� Error Code
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

