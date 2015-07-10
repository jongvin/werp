CREATE OR REPLACE PROCEDURE Y_Sp_H_Name_Chg_Insert(as_dept_code    IN   VARCHAR2,
                                                   as_sell_code    IN   VARCHAR2,
                                                   as_dongho       IN   VARCHAR2,
                                                   as_cdongho      IN   VARCHAR2,
                                                   as_b_seq        IN   INTEGER,
                                                   as_seq          IN   INTEGER) IS
-------------------------------------------------------------
-- ��������  h_sale_master
-------------------------------------------------------------
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   C_LEVEL              NUMBER(20,5);  --
   C_CNT                NUMBER(20,5);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
-- ���뺰 �������� ����
	BEGIN
	  INSERT INTO H_SALE_AGREE
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,DEGREE_CODE,AGREE_DATE,LAND_AMT,BUILD_AMT,
					VAT_AMT,SELL_AMT,F_PAY_YN,TOT_AMT,WORK_DATE,WORK_NO,
					LOAN_YN,LOAN_DATE,LOAN_INTEREST_TAG,LOAN_BANK_CODE,LOAN_RDM_YN, WORK_NO_TEMP
			 FROM H_SALE_AGREE
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		/*EXCEPTION
		WHEN others THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 �������� ���� ����! [Line No: 1]';
				  Wk_errflag := -20020;
				  --GOTO EXIT_ROUTINE;
			  END IF;*/
	END;
-- ���ں� ���Ա� ����
	BEGIN
		INSERT INTO H_SALE_INCOME_DAILY
		  SELECT DEPT_CODE, SELL_CODE, as_cdongho,
               as_seq, RECEIPT_DATE, DAILY_SEQ, AMT,RECEIPT_CODE, DEPOSIT_NO,
               RECEIPT_CLASS_CODE, CARD_APP_NUM, RECEIPT_NUMBER, CARD_BANK_CODE, SLIP_NUMB_TEMP, v_account_no, fb_seq,
               loan_interest_tag, loan_rdm_yn, loan_degree_code
			 FROM H_SALE_INCOME_DAILY
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���ں� ���Ա� ���� ����! [Line No: 2]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 ���Ա� ����
	BEGIN
		INSERT INTO H_SALE_INCOME
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,DEGREE_CODE,DEGREE_SEQ,RECEIPT_DATE,RECEIPT_CODE,DEPOSIT_NO,
					R_AMT,R_LAND_AMT,R_BUILD_AMT,R_VAT_AMT,DELAY_DAYS,DELAY_AMT,DISCOUNT_DAYS,DISCOUNT_AMT,INPUT_ID,
					INPUT_DATE,WORK_DATE,WORK_NO,TAX_DATE,TAX_NO,MODI_YN, NULL, NULL, NULL, NULL ,daily_seq,
					DELAY_AMT_CALC,DISCOUNT_AMT_CALC, NULL, NULL
			 FROM H_SALE_INCOME
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 ���Ա� ���� ����! [Line No: 2]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 �������ñ�� ����
	BEGIN
		INSERT INTO H_SALE_FUND
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,REQUEST_DATE,REQUEST_R_AMT,EXCHANGE_DATE,PROCESS_YN
			 FROM H_SALE_FUND
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 �������ñ�� ���� ����! [Line No: 3]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 �ؾ���� ����
	BEGIN
		INSERT INTO H_SALE_ANNUL
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,REFUND_DATE,PENALTY,TERM_INTEREST,INCOME_TAX,
					RESIDENCE_TAX,LEASE_DEDUCT_AMT,SUBTR_AMT,LOAN_CAP,REFUND_AMT,BANK_HEAD_CODE,DEPOSIT_NO,
					ANNUL_REASON,BANK_HEAD_NAME, NULL, NULL
			 FROM H_SALE_ANNUL
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 �ؾ���� ���� ����! [Line No: 4]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 �������� ����
	BEGIN
		INSERT INTO H_SALE_DOCUMENT
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,ISSUE_DATE,ISSUE_DOCUMENT,ISSUE_NO,
					ISSUER,ISSUE_REASON,REMARK
			 FROM H_SALE_DOCUMENT
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 �������� ���� ����! [Line No: 5]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 On-Time���� ����
	BEGIN
		INSERT INTO H_SALE_ONTIME_MASTER
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,PYONG, OPT_NAME,OPT_BASE,OPT_FINISH,OPT_REF,CONTRACT_DATE,
		         AMT,AMT_VAT,REMARK,NORM_PREM_TAG
			 FROM H_SALE_ONTIME_MASTER
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 On-Time���� ���� ����! [Line No: 6]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 �޸���� ����
	BEGIN
		INSERT INTO H_SALE_MEMO
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,INPUT_DATE,INPUT_SEQ,TITLE,
					CONTENTS,RECORD_DUTY_ID,IDENTIFY_DATE,FINISH_YN,MEMO_CODE
			 FROM H_SALE_MEMO
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 �޸���� ���� ����! [Line No: 7]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 Ư�̻��� ����
	BEGIN
		INSERT INTO H_SALE_ETC
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,UNIQUE_DIV,EFFECT_NO,DELIVERY_DATE,
					CREDITOR,BOND_AMT,CANCEL_YN,CANCEL_DATE,REMARK,CANCEL_DESC,INPUT_ID
			 FROM H_SALE_ETC
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 Ư�̻��� ���� ����! [Line No: 8]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 ���������⳻�� ����
	BEGIN
		INSERT INTO H_SALE_LOAN
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,BANK_HEAD_CODE,LOAN_REQUEST_DATE,
					LOAN_REQUEST_AMT,GUARANTEE_SOL_DATE,LOAN_DUTY_NAME,LOAN_DUTY_PHONE,REMARK
			 FROM H_SALE_LOAN
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 ���������⳻�� ���� ����! [Line No: 9]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 �������� ���޳��� ����
	BEGIN
		INSERT INTO H_SALE_LOAN_INTEREST
        SELECT DEPT_CODE, SELL_CODE, as_cdongho,as_seq, PAID_DATE,paid_seq, AMT, 
               MEMO, WORK_DATE, WORK_NO, LOAN_INTEREST_TAG, loan_bank_code
		    FROM H_SALE_LOAN_INTEREST
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 ���������⳻�� ���� ����! [Line No: 9]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;

-- ���뺰 On-Time�������� ����
	BEGIN
		INSERT INTO H_SALE_ONTIME_AGREE
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,DEGREE_CODE,AGREE_DATE,AGREE_AMT,F_PAY_YN,TOT_AMT, NULL, NULL, NULL
			 FROM H_SALE_ONTIME_AGREE
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 On-Time�������� ���� ����! [Line No: 10]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���ں� On-Time���Ա� ����
	BEGIN
		INSERT INTO H_SALE_ONTIME_INCOME_DAILY
		  SELECT DEPT_CODE, SELL_CODE, as_cdongho,
               as_seq, RECEIPT_DATE, DAILY_SEQ, AMT,RECEIPT_CODE, DEPOSIT_NO,
               RECEIPT_CLASS_CODE, CARD_APP_NUM, RECEIPT_NUMBER, CARD_BANK_CODE, NULL
			 FROM H_SALE_ONTIME_INCOME_DAILY
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���ں� ����ǰ�� ���Ա� ���� ����! [Line No: 2]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;

-- ���뺰 On-Time���Ա� ����
	BEGIN
		INSERT INTO H_SALE_ONTIME_INCOME
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,DEGREE_CODE,DEGREE_SEQ,RECEIPT_DATE,RECEIPT_CODE,
					DEPOSIT_NO,R_AMT,DELAY_DAYS,DELAY_AMT,DISCOUNT_DAYS,DISCOUNT_AMT,WORK_DATE,WORK_NO,
					INPUT_ID,INPUT_DATE,MODI_YN, NULL, NULL, NULL, NULL, DAILY_SEQ, 0, 0
			 FROM H_SALE_ONTIME_INCOME
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 On-Time���Ա� ���� ����! [Line No: 11]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- �Ӵ��������� ����
	/*begin
		INSERT INTO H_LEAS_LEASE_AGREE
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,DEGREE_CODE,AGREE_DATE,S_DATE,E_DATE,DAYS,
					LEASE_AMT,VAT_YN,LEASE_SUPPLY,LEASE_VAT,F_PAY_YN,PAY_TOT_AMT
			 FROM H_LEAS_LEASE_AGREE
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN others THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '�Ӵ��������� ���� ����! [Line No: 13]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	end;
-- ���ں� �Ӵ�ᳳ�Ի��� ����
	begin
		INSERT INTO H_LEAS_LEASE_INCOME_DAILY
		  SELECT DEPT_CODE, SELL_CODE, as_cdongho,
               as_seq, RECEIPT_DATE, DAILY_SEQ, AMT,DEPOSIT_NO
			 FROM H_LEAS_LEASE_INCOME_DAILY
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN others THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���ں� �Ӵ�ᳳ�Ի��� ���� ����! [Line No: 2]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	end;

-- �Ӵ�ᳳ�Ի��� ����
	begin
	  INSERT INTO H_LEAS_LEASE_INCOME
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,DEGREE_CODE,DEGREE_SEQ,RECEIPT_DATE,DEPOSIT_NO,
					R_AMT,LEASE_SUPPLY,LEASE_VAT,DELAY_DAYS,DELAY_AMT,DISCOUNT_DAYS,DISCOUNT_AMT,WORK_DATE,WORK_NO,
					INPUT_ID,INPUT_DATE,MODI_YN, DAILY_SEQ
			 FROM H_LEAS_LEASE_INCOME
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN others THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '�Ӵ�ᳳ�Ի��� ���� ����! [Line No: 14]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	end;
*/
-- ���뺰��ü�� ����
	BEGIN
		INSERT INTO H_SALE_DELAY_RATE
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,RATE_KIND,MNTH,S_DATE,E_DATE,RATE,CUTOFF_STD,CUTOFF_UNIT
			 FROM H_SALE_DELAY_RATE
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰��ü�� ���� ����! [Line No: 16]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰������ ����
	BEGIN
		INSERT INTO H_SALE_DISCOUNT_RATE
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,RATE_KIND,S_DATE,E_DATE,RATE,CUTOFF_STD,CUTOFF_UNIT
			 FROM H_SALE_DISCOUNT_RATE
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰������ ���� ����! [Line No: 16]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 ���񽺿ɼ� ����
	BEGIN
		INSERT INTO H_SALE_OPTION
		  SELECT DEPT_CODE,SELL_CODE,as_cdongho,as_seq,CLS_CODE,ELEM_CODE,REMARK
			 FROM H_SALE_OPTION
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 ���񽺿ɼ� ���� ����! [Line No: 1]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ���뺰 ���񽺿ɼ� ����
	BEGIN
		INSERT INTO H_SALE_KEY
        SELECT DEPT_CODE, SELL_CODE, as_cdongho,as_seq, PORCH, BEDROOM1,BEDROOM2, BEDROOM3, BEDROOM4, 
               BEDROOM5, BEDROOM6, BEDROOM7, BEDROOM8, BEDROOM9, BEDROOM10, RESTROOM1, RESTROOM2, ETC_KEY, OUT_DATE, REMARK
			 FROM H_SALE_KEY
			WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 ���񽺿ɼ� ���� ����! [Line No: 1]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
-- ******************
-- ������� ������Ʈ (��ຯ���� �߻��ϸ� ������� ���̺� ����� DONGHO,SEQ,..������Ʈ)
--                    ���Ǻ���/��ȣ���� �Ͼ�� ���� ������� ����)
-- ****************** 
	BEGIN
		UPDATE H_CODE_V_ACCOUNT
         SET DONGHO = as_cdongho,
             SEQ    = as_seq,
             APPLY_DATE = (SELECT SYSDATE FROM dual),
             USE_TAG = 1
       WHERE DEPT_CODE = as_dept_code
			  AND	SELL_CODE = as_sell_code
			  AND DONGHO    = as_dongho
			  AND SEQ       = as_b_seq;
      
		EXCEPTION
		WHEN OTHERS THEN
			  IF SQL%NOTFOUND THEN
				  e_msg      := '���뺰 ���񽺿ɼ� ���� ����! [Line No: 1]';
				  Wk_errflag := -20020;
				  GOTO EXIT_ROUTINE;
			  END IF;
	END;
   
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
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END Y_Sp_H_Name_Chg_Insert;
/

