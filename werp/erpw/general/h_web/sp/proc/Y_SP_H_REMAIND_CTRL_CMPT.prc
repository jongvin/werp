CREATE OR REPLACE PROCEDURE y_sp_h_remaind_ctrl_cmpt(as_dept_code     IN   VARCHAR2,
															  as_sell_code     IN   VARCHAR2,
															  as_user          IN   VARCHAR2) IS

CURSOR DETAIL_CUR IS
SELECT dongho,seq
  FROM h_sale_agree
 WHERE dept_code  = as_dept_code
	AND sell_code  = as_sell_code
	AND degree_code  > '49'
	AND tot_amt > 0
order by degree_code;
CURSOR DETAIL_CUR1 (V_DONGHO VARCHAR2,V_SEQ INTEGER )IS
SELECT receipt_date,
       receipt_code,
		 deposit_no,
		 receipt_class_code ,
	    receipt_number,
	    card_app_num,
	    card_bank_code,
		 amt,
		 daily_seq
  FROM h_sale_income_daily d,
       h_sale_agree a
 WHERE a.dept_code  = as_dept_code
	AND a.sell_code  = as_sell_code
	AND a.dongho     = V_DONGHO
	AND a.seq        = V_SEQ
	and a.dept_code  = d.dept_code
	and a.sell_code  = d.sell_code
	and a.dongho     = d.dongho
	and a.seq        = d.seq
 	AND degree_code  > '49'
order by d.receipt_date, d.daily_seq;

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
	V_AMT            H_SALE_AGREE.SELL_AMT%TYPE;        -- �����ǹ��ݾ�
	V_DAILY_SEQ      H_SALE_INCOME.DEGREE_SEQ%TYPE; 
   C_DATE           H_SALE_INCOME.RECEIPT_DATE%TYPE;   -- ���ְ�����
   C_TO_DATE        H_SALE_INCOME.RECEIPT_DATE%TYPE;   -- ����������
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN
		select moveinto_fr_date,moveinto_to_date
        into C_DATE,C_TO_DATE
        from h_code_house
		 where dept_code = as_dept_code
			and sell_code = as_sell_code;
		UPDATE h_sale_master
			SET moveinto_fr_date = C_DATE,
				 moveinto_to_date = C_TO_DATE
		 WHERE dept_code = as_dept_code
			AND sell_code = as_sell_code
			AND contract_yn = 'Y';
	  UPDATE H_SALE_AGREE
		  SET AGREE_DATE = C_DATE
		WHERE DEPT_CODE = as_dept_code
		  AND sell_code = as_sell_code
		  AND degree_code > '49';


		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO V_DONGHO,V_SEQ;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
		  UPDATE H_SALE_AGREE
			  SET tot_amt = 0,
					f_pay_yn = 'N'
			WHERE DEPT_CODE = as_dept_code
			  AND sell_code = as_sell_code
			  AND dongho    = V_DONGHO
			  AND seq       = V_SEQ
			  AND degree_code > '49';
			OPEN	DETAIL_CUR1(V_DONGHO,V_SEQ);

			                         --���Ա�ó�� �ϱ����� �ܱݳ��Ա��� ���� �����Ѵ�.
			DELETE FROM H_SALE_INCOME--�׷����� �Ա�ó���� ����ȸ���� 1ȸ���� ������ �Էµȴ�.
			WHERE DEPT_CODE = as_dept_code
			  AND sell_code = as_sell_code
			  AND dongho    = V_DONGHO
			  AND seq       = V_SEQ
			  AND degree_code > '49';
			LOOP
				FETCH DETAIL_CUR1 INTO V_DATE,V_RECEIPT_CODE,V_DEPOSIT_NO,
				                       V_RECEIPT_CLASS_CODE ,V_RECEIPT_NUMBER,
	                                V_CARD_APP_NUM,	V_CARD_BANK_CODE,V_AMT, V_DAILY_SEQ;
				EXIT WHEN DETAIL_CUR1%NOTFOUND;
            
				y_sp_h_recalc_daily_income(as_dept_code,as_sell_code,V_DONGHO,V_SEQ,V_DATE, V_DAILY_SEQ);
				--H_CALC_INCOME.Y_SP_H_INCOME_CMPT(as_dept_code,as_sell_code,V_DONGHO,V_SEQ,V_DATE,V_AMT,V_RECEIPT_CODE,V_DEPOSIT_NO,as_user,
				--                   V_RECEIPT_CLASS_CODE ,V_RECEIPT_NUMBER, V_CARD_APP_NUM,	V_CARD_BANK_CODE);
			END LOOP;
			CLOSE DETAIL_CUR1;
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
END y_sp_h_remaind_ctrl_cmpt;
/

