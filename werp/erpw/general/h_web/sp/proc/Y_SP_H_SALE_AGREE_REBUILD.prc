CREATE OR REPLACE PROCEDURE Y_Sp_H_Sale_Agree_Rebuild(as_dept_code     IN   VARCHAR2,
															  as_sell_code     IN   VARCHAR2,
															  as_pyong IN NUMBER,
															  as_style IN VARCHAR2,
															  as_class IN VARCHAR2,
															  as_option_code IN VARCHAR2,
															  as_user          IN   VARCHAR2) IS


CURSOR DETAIL_CUR IS
SELECT dongho,seq
  FROM H_SALE_AGREE
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code;

CURSOR DETAIL_CUR1 (V_DONGHO VARCHAR2,V_SEQ INTEGER )IS
SELECT d.receipt_date,
       d.receipt_code,
		 d.deposit_no,
		 d.receipt_class_code ,
	    d.receipt_number,
	    d.card_app_num,
	    d.card_bank_code,
       d.v_account_no,
       d.fb_seq,
		 d.amt,
		 d.daily_seq
  FROM H_SALE_INCOME_DAILY d
 WHERE d.dept_code  = as_dept_code
	AND d.sell_code  = as_sell_code
	AND d.dongho     = V_DONGHO
	AND d.seq        = V_SEQ
ORDER BY d.receipt_date, d.daily_seq;

-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ���� ����
   V_DONGHO         H_SALE_AGREE.DONGHO%TYPE;          -- ��ȣ
   V_SEQ            H_SALE_AGREE.SEQ%TYPE;             -- ����
	V_DEGREE_SEQ     H_SALE_INCOME.DEGREE_SEQ%TYPE;
   V_DATE           H_SALE_INCOME.RECEIPT_DATE%TYPE;   -- ��������
   V_RECEIPT_CODE   H_SALE_INCOME.RECEIPT_CODE%TYPE;   -- �Աݱ���
   V_DEPOSIT_NO     H_SALE_INCOME.DEPOSIT_NO%TYPE;     -- ���¹�ȣ
	V_RECEIPT_CLASS_CODE H_SALE_INCOME.RECEIPT_CLASS_CODE%TYPE;
	V_RECEIPT_NUMBER     H_SALE_INCOME.RECEIPT_NUMBER%TYPE;
	V_CARD_APP_NUM       H_SALE_INCOME.CARD_APP_NUM%TYPE;
	V_CARD_BANK_CODE     H_SALE_INCOME.CARD_BANK_CODE%TYPE;
   V_v_account_no       H_SALE_INCOME.v_account_no%TYPE;
   V_fb_seq             H_SALE_INCOME_DAILY.fb_seq%TYPE;
	V_AMT            H_SALE_AGREE.SELL_AMT%TYPE;        -- �����ǹ��ݾ�
	V_DAILY_SEQ      H_SALE_INCOME.DEGREE_SEQ%TYPE;
	V_CP_TAG         VARCHAR2(1);
	V_RACALC_TAG     VARCHAR2(1);
   C_DATE           H_SALE_INCOME.RECEIPT_DATE%TYPE;   -- ���ְ�����
   C_TO_DATE        H_SALE_INCOME.RECEIPT_DATE%TYPE;   -- ����������
	C_CNT            INTEGER;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN
		SELECT NVL(COUNT(a.dept_code),0)
		  INTO C_CNT
		  FROM H_SALE_MASTER a,
		       (SELECT MAX(dongho) dongho,MAX(seq) seq 
		     		 FROM H_SALE_MASTER 
		      	WHERE dept_code =  as_dept_code
		     		  AND sell_code =  as_sell_code  
		    	  GROUP BY dept_code,sell_code,dongho ) b 
		 WHERE a.dept_code = as_dept_code
		   AND a.sell_code = as_sell_code
			AND a.contract_yn = 'Y'
			AND a.dongho = b.dongho
			AND a.seq    = b.seq;
      
		IF C_CNT > 0 THEN
			C_CNT := 0;
			RAISE_APPLICATION_ERROR(-20020, '����ڰ� �ֽ��ϴ�. ���� ����� �Ұ�.');
			RETURN;
		END IF;
		
		OPEN	DETAIL_CUR;
		LOOP
		  FETCH DETAIL_CUR INTO V_DONGHO,V_SEQ;
		  EXIT WHEN DETAIL_CUR%NOTFOUND;
		  V_CP_TAG := F_H_Compare_Agree(as_dept_code,as_sell_code,as_pyong,as_style,as_class,as_option_code ,
								  V_DONGHO,V_SEQ);
		  IF V_CP_TAG <> 'Y' THEN --�ش缼���� ������ ������������ ���� ������..
		  	  SELECT COUNT(*)
			    INTO C_CNT
			    FROM H_SALE_INCOME
				WHERE DEPT_CODE = as_dept_code
				  AND sell_code = as_sell_code
				  AND dongho    = V_DONGHO
				  AND seq       = V_SEQ;
			  IF C_CNT > 0 THEN --���Ա����ִ°�� ���Ա�ó���� ���� ���Գ���Ŀ���� �����ϰ�..�Աݳ��� ����
			     OPEN	DETAIL_CUR1(V_DONGHO, V_SEQ);
				  
				  DELETE H_SALE_INCOME
				   WHERE DEPT_CODE = as_dept_code
					  AND sell_code = as_sell_code
					  AND dongho    = V_DONGHO
					  AND seq       = V_SEQ;
				  DELETE H_SALE_INCOME_DAILY
				   WHERE DEPT_CODE = as_dept_code
					  AND sell_code = as_sell_code
					  AND dongho    = V_DONGHO
					  AND seq       = V_SEQ;
			     
				  V_RACALC_TAG := 'Y';
			  ELSE
			     V_RACALC_TAG := 'N';
			  END IF;
			  --���������� �����   
			  DELETE H_SALE_AGREE
			   WHERE DEPT_CODE = as_dept_code
				  AND sell_code = as_sell_code
				  AND dongho    = V_DONGHO
				  AND seq       = V_SEQ;
			    
			  INSERT INTO H_SALE_AGREE
			  			SELECT d.dept_code,
						       d.sell_code,
								 V_DONGHO,
								 V_SEQ,
						       d.degree_code,
						       d.agree_date,
								 d.land_amt,
								 d.build_amt,
								 d.vat_amt,
								 d.sell_amt,
								 'N', 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL
						  FROM H_BASE_PYONG_MASTER m,
						       H_BASE_PYONG_DETAIL d
						 WHERE m.dept_code = as_dept_code
						   AND m.sell_code = as_sell_code
							AND m.pyong = as_pyong
							AND m.style = as_style
							AND m.CLASS = as_class
							AND m.option_code = as_option_code
							AND m.dept_code = d.dept_code
							AND m.sell_code = d.sell_code
							AND m.spec_unq_num = d.spec_unq_num; 
			  IF V_RACALC_TAG = 'Y' THEN --���Ա��� �ִ���� ���Ա� ó��
			  	  LOOP
				    FETCH DETAIL_CUR1 INTO V_DATE,V_RECEIPT_CODE,V_DEPOSIT_NO,V_RECEIPT_CLASS_CODE,
					                         V_RECEIPT_NUMBER,V_CARD_APP_NUM,V_CARD_BANK_CODE, v_v_account_no, v_fb_seq,
													 V_AMT,V_DAILY_SEQ;
					 EXIT WHEN DETAIL_CUR1%NOTFOUND;
					 
					 H_Calc_Income.y_sp_h_income_cmpt(as_dept_code, as_sell_code, V_DONGHO, V_SEQ, V_DATE, V_AMT,V_RECEIPT_CODE,
				 					 V_DEPOSIT_NO, '����',V_RECEIPT_CLASS_CODE,V_RECEIPT_NUMBER,V_CARD_APP_NUM,V_CARD_BANK_CODE, 
                            v_v_account_no, v_fb_seq);
				  END LOOP;
				  CLOSE DETAIL_CUR1;
			  END IF;
		  END IF; 
		END LOOP;
		CLOSE DETAIL_CUR;


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
END Y_Sp_H_Sale_Agree_Rebuild;
/

