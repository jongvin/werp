CREATE OR REPLACE PROCEDURE Y_Sp_H_Slip_Income (ai_save_num IN NUMBER,
                                               as_approval_num IN VARCHAR2,
                                               as_approval_name IN VARCHAR2, 
                                               as_dept_code    IN   VARCHAR2,
                                               as_sell_code    IN   VARCHAR2,
															  ad_fr_date		  IN   DATE ,
															  ad_to_date		  IN   DATE ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
              
      SELECT a.dongho,
             a.seq,
		       a.contract_code,
		       b.degree_code,
             b.receipt_date,
             bank.folder_code,  
             a.cust_code,
		       c.cust_name,
             c.cust_div,
             c.biz_status,
             c.biz_type,
             c.CUR_ZIP_CODE,
             c.CUR_ADDR1,
             c.CUR_ADDR2,
		       d.code_name,
             SUM(b.r_amt)     r_amt,
		       SUM(b.delay_amt)     delay_amt,
		       SUM(b.discount_amt)  discount_amt,
		       SUM(b.r_amt + b.delay_amt - b.discount_amt)  sell_amt
		  FROM H_SALE_MASTER a,
		       H_SALE_INCOME  b,
		       H_CODE_CUST   c,
             H_CODE_COMMON d,
             (SELECT bank_account_number, folder_code 
                FROM efin_internal_bank_account_v ) bank
		 WHERE (LENGTH(trim(b.work_no)) IS NULL OR             --��ǥ���� �ȣ��ų�
              b.work_no IN (SELECT invoice_group_id FROM v_invoice_reject WHERE dept_code = as_dept_code)  ---��ǥ���������� (�ݼ�,���)�Ȱ�  
             )
         AND a.dept_code = b.dept_code
		   AND a.sell_code = b.sell_code
		   AND a.dongho    = b.dongho
		   AND a.seq       = b.seq
		   AND a.cust_code = c.cust_code (+)
         AND b.degree_code = d.code (+)
         AND d.code_div    = '02'
		   AND a.dept_code = as_dept_code
		   AND a.sell_code = as_sell_code
		   AND b.receipt_date  BETWEEN ad_fr_date AND ad_to_date
		   AND a.last_contract_date <= ad_to_date
		   AND a.chg_date    > ad_to_date
		   AND a.chg_div     <> '00'
         AND b.degree_seq  < '70'
         AND REPLACE(b.deposit_no,'-','') = bank_account_number(+)
         AND b.receipt_code  IN ('11','12','15','18','19','1A','23') 
                                 --11(CMS/FBS�Ա�)  12(�����Ա�)   15(û�༱���ݴ�ü) 18(��������)?, 
                                 --19(�����ݴ�ü)   1A(ī�������) 23(�����Ա�ȯ��)
		 GROUP BY a.dongho,
             a.seq,
		       a.contract_code,
		       b.receipt_date,
             bank.folder_code,
             b.degree_code,
		       a.cust_code,
		       c.cust_name,
             c.cust_div,
             c.biz_status,
             c.biz_type,
             c.CUR_ZIP_CODE,
             c.CUR_ADDR1,
             c.CUR_ADDR2,
		       d.code_name
		 HAVING  SUM(b.r_amt) <> 0 OR SUM(b.delay_amt) <> 0 OR SUM(b.discount_amt) <> 0
		
   ORDER BY  a.dongho,
             a.seq,
		       a.contract_code,
		       b.degree_code,
             b.receipt_date;
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	
   rec_slip_master H_SALE_MASTER%ROWTYPE;
   rec_slip_income H_SALE_INCOME%ROWTYPE;
   rec_slip_cust  H_CODE_CUST%ROWTYPE;
   v_tag               VARCHAR2(10);
   v_degree_name  H_CODE_COMMON.code_name%TYPE;
   v_cust_type    VARCHAR2(10);
   
   v_r_amt     H_SALE_INCOME.r_amt%TYPE;
   v_delay_amt H_SALE_INCOME.r_amt%TYPE;
   v_discount_amt  H_SALE_INCOME.r_amt%TYPE;
   v_sell_amt  H_SALE_INCOME.r_amt%TYPE;
   v_dr_amt    H_SALE_INCOME.r_amt%TYPE;
   v_cr_amt    H_SALE_INCOME.r_amt%TYPE;
   v_acntcode  VARCHAR2(10);
   
   v_vatname   VARCHAR2(30);
   v_vat_cnt   NUMBER;
   v_tax_seq  NUMBER;
   v_tax_tag  VARCHAR2(1);
   
   C_DATE      DATE DEFAULT SYSDATE;              
   
   C_ACNTNO_PRE        VARCHAR2(50);                  --�о�̼��� 
   C_ACNTNO_DUE        VARCHAR2(50);                  --�о缱����
   C_ACNTNO_ACC        VARCHAR2(50)  DEFAULT '111131';--���뿹��(��ȭ)
   C_ACNTNO_DIS        VARCHAR2(50)  DEFAULT '411117';--��������(�о����)     -���η�
   C_ACNTNO_DEL        VARCHAR2(50)  DEFAULT '461112';--���ڼ���(��ü��) 
   
   C_SOURCE            VARCHAR2(50)  DEFAULT '�о�';
   C_CATEGORY          VARCHAR2(50)  DEFAULT '���Ա�';
   
	C_H_DATA            VARCHAR2(30);
   C_GROUP_ID          INTEGER;
	C_SEQ               INTEGER;
	C_CASH_RT           NUMBER(20,5);
	C_TEMP_VAT          NUMBER(20,5);
   C_CNT               NUMBER(20,5);  --
	C_COMP_CODE         VARCHAR2(10);
	C_ORG_ID            VARCHAR2(10);
	C_ORG_NAME          VARCHAR2(100);
	C_TEMP              VARCHAR2(50);
	C_PROJ              VARCHAR2(10);
	C_ACNTCODE          VARCHAR2(10);
	C_VATNAME           VARCHAR2(50);
	C_TEMP_VATNAME      VARCHAR2(50);
	C_DEPT_NAME         VARCHAR2(50);
	C_VENDOR_ID         INTEGER;	
	C_VENDOR_SITE_ID    INTEGER;
	C_TAX_SEQ           INTEGER;	
	C_TAX_TAG           VARCHAR2(1) DEFAULT 'T';
	C_CUST_CODE         VARCHAR2(20);
	C_CUST_NAME         VARCHAR2(50);
	C_FOLDER_ID         VARCHAR2(10);
   C_FOLDER_CODE       VARCHAR2(10);
   C_DESC              VARCHAR2(100);
   C_C_TAG             BOOLEAN DEFAULT FALSE;
   C_V_TAG             BOOLEAN DEFAULT FALSE;
   C_CUST_CODE_SAVE    VARCHAR2(20);
BEGIN
 BEGIN
   BEGIN
      -- ���庰 ������ڵ带 ������ �´�
      e_msg      := '�о籸�к� ������/�̼��ݰ������� �̵��'||AS_DEPT_CODE||'/'||AS_SELL_CODE;
      SELECT ACNTNO_PRE, ACNTNO_DUE
		  INTO C_ACNTNO_PRE, C_ACNTNO_DUE
 		  FROM H_CODE_HOUSE 
		 WHERE dept_code = as_dept_code
         AND SELL_CODE = AS_SELL_CODE;
      
      IF LENGTH(trim(C_ACNTNO_PRE)) IS NULL OR LENGTH(trim(C_ACNTNO_DUE)) IS NULL THEN
         Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      END IF;
      
      -- ���庰 ������ڵ带 ������ �´�
      e_msg      := '���� �����ڵ� �̵��(Z_CODE_DEPT)-'||AS_DEPT_CODE;
      SELECT comp_code ,long_name
		  INTO C_COMP_CODE,C_DEPT_NAME
 		  FROM Z_CODE_DEPT 
		 WHERE dept_code = as_dept_code;
      
       
      -- ���庰������Ʈ�ڵ带 ���Ѵ�.
      e_msg      := '������Ʈ�ڵ� �̵��(R_PROJ)-'||AS_DEPT_CODE;
		SELECT b.proj_code
        INTO C_PROJ
        FROM Z_CODE_DEPT a,
             r_proj_view_business_form  b
       WHERE a.proj_unq_key = b.proj_unq_key
         AND a.dept_code = as_dept_code;
      
      IF LENGTH(trim(C_PROJ)) IS NULL THEN
         Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      END IF;
      
      -- ������ ������ڵ�� ORG-ID �� ���Ѵ�.
		SELECT attribute1
		  INTO C_ORG_ID
		  FROM efin_corporations_v
		 WHERE corporation_code = C_COMP_CODE;
      
   EXCEPTION 
      WHEN NO_DATA_FOUND THEN
       Wk_errflag := -20020;
       GOTO EXIT_ROUTINE;
   END;
     
   -- ��ǥ �����͹�ȣ�� ���Ѵ�.(�ӽ� ������� �� �����Ǹ� parameter�� ���۹���.)
	SELECT efin_invoice_header_itf_s.NEXTVAL
	  INTO C_GROUP_ID
	  FROM dual;
   --c_group_id := as_group_id
   
   -- ���缱 ������ �����Ѵ�.
   e_msg      := 'EFIN_INVOICE_HEADER_ITF Insert ���� '||C_GROUP_ID||','||ai_save_num||','||'A';
	Y_Sp_D_Efin_Invoice_Copy(C_GROUP_ID,ai_save_num,'A',ad_to_date);  
      
	OPEN	DETAIL_CUR;
	LOOP
      FETCH DETAIL_CUR INTO rec_slip_income.dongho, rec_slip_income.seq, 
                            rec_slip_master.contract_code, rec_slip_income.degree_code, rec_slip_income.receipt_date, C_FOLDER_CODE, 
                            rec_slip_cust.cust_code, rec_slip_cust.cust_name, rec_slip_cust.cust_div, 
                            rec_slip_cust.biz_status, rec_slip_cust.biz_type, rec_slip_cust.cur_zip_code, 
                            rec_slip_cust.cur_addr1, rec_slip_cust.cur_addr2, v_degree_name, 
                            rec_slip_income.r_amt, rec_slip_income.delay_amt, rec_slip_income.discount_amt,
                            v_sell_amt ;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
			
		c_h_data := trim(rec_slip_income.dongho)||trim(TO_CHAR(rec_slip_income.seq,'000'))||trim(rec_slip_income.degree_code);
      C_DESC := trim(rec_slip_income.dongho)||'-'||rec_slip_income.seq||'-'||rec_slip_cust.cust_name||'-'||rec_slip_income.degree_code;
      
      -- �� ���̺� �ŷ�ó�� �����ϴ��� Check�Ͽ� ������� insert�Ѵ�.
  		
      IF C_CUST_CODE_SAVE <> rec_slip_cust.cust_code AND LENGTH(TRIM(rec_slip_cust.cust_code)) IS NOT NULL THEN
         C_CUST_CODE_SAVE := rec_slip_cust.cust_code;
         IF NOT F_Comm_Slip_Check_Customer(C_ORG_ID, rec_slip_cust.cust_code) THEN 
            IF rec_slip_cust.cust_div = '02' THEN
                  v_cust_type := '����';
            ELSE
               v_cust_type := '����';
            END IF; 
            Y_Sp_Comm_Slip_Customer(C_COMP_CODE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                    V_CUST_TYPE,as_dept_code,rec_slip_cust.cur_zip_code,rec_slip_cust.cur_ADDR1,rec_slip_cust.cur_ADDR2,
                                    rec_slip_cust.biz_status,rec_slip_cust.biz_type);
            IF NOT C_C_TAG THEN C_C_TAG := TRUE; END IF;
         END IF;
      END IF;
      
      
		-- ����ó���̺��� vendor_id�� vendor_site_id�� �����´�
		--		select nvl(vendor_id,0),nvl(vendor_site_id,0)
		--		  into C_VENDOR_ID,C_VENDOR_SITE_ID
		--		  from efin_supplier_v
		--		 where org_id = C_ORG_ID
		--			and vat_registration_num = V_CUST_CODE; 
		
      IF LENGTH(trim(C_FOLDER_CODE)) IS NULL THEN 
		   C_FOLDER_ID := C_COMP_CODE || '99999';
      ELSE
         C_FOLDER_ID := C_FOLDER_CODE;
      END IF;
      
      v_delay_amt     := rec_slip_income.delay_amt;
      v_discount_amt  := rec_slip_income.discount_amt;
      v_r_amt         := rec_slip_income.r_amt;
      
      ---------------------------------------------------------------------------------------
      --���Ա� ��ǥ 1��°����
      ---------------------------------------------------------------------------------------
      v_dr_amt := v_sell_amt; v_cr_amt := NULL;
      v_vatname := NULL;
      v_vat_cnt := 0;
      v_acntcode := C_ACNTNO_ACC;
      v_tax_seq  := NULL;
      v_tax_tag  := NULL;
      C_FOLDER_ID := C_FOLDER_CODE;
      Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_income.receipt_date,
                                C_DATE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC);
      ---------------------------------------------------------------------------------------
      --���Ա� ��ǥ 2��°����
      ---------------------------------------------------------------------------------------
      v_dr_amt := NULL; v_cr_amt := v_r_amt;
      v_vatname := NULL;
      v_vat_cnt := 0;
      v_acntcode := C_ACNTNO_DUE;
      v_tax_seq  := NULL;
      v_tax_tag  := NULL;
      C_FOLDER_ID := C_COMP_CODE || '99999';
      Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_income.receipt_date,
                                C_DATE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC);
      ---------------------------------------------------------------------------------------
      --���Ա� ��ǥ 3��°���� (����/����)
      ---------------------------------------------------------------------------------------
      IF v_discount_amt > 0 THEN
         v_dr_amt := v_discount_amt; v_cr_amt := NULL;
         v_vatname := NULL;
         v_vat_cnt := 0;
         v_acntcode := C_ACNTNO_DIS;
         v_tax_seq  := NULL;
         v_tax_tag  := NULL;
         C_FOLDER_ID := C_COMP_CODE || '99999';
         Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_income.receipt_date,
                                   C_DATE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                   V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                   C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME,C_DESC);
      END IF;
      
      ---------------------------------------------------------------------------------------
      --���Ա� ��ǥ 6��°���� (��ü/�뺯)
      ---------------------------------------------------------------------------------------
      IF v_delay_amt > 0 THEN
         v_dr_amt := NULL; v_cr_amt := v_delay_amt;
         v_vatname := NULL;
         v_vat_cnt := 0;
         v_acntcode := C_ACNTNO_DEL;
         v_tax_seq  := NULL;
         v_tax_tag  := NULL;
         C_FOLDER_ID := C_COMP_CODE || '99999';
         Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_income.receipt_date,
                                   C_DATE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                   V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                   C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC);
      END IF;   
      
       				
	-- ���Ա����̺� ��ǥ�����͹�ȣ�� Setting �Ѵ�.
	/*		UPDATE F_PROFIT_DETAIL
				SET invoice_num = C_GROUP_ID
			 WHERE dept_code = as_dept_code
				AND inst_date = V_DATE
				AND slip_spec_unq_num = V_SEQ;
   */
   UPDATE H_SALE_INCOME
      SET WORK_NO = c_group_id, work_date = c_date
    WHERE dept_code = as_dept_code
      AND sell_code = as_sell_code
      AND dongho = rec_slip_income.dongho
      AND seq    = rec_slip_income.seq
      AND degree_code = rec_slip_income.degree_code;
   
   
	END LOOP;
	CLOSE DETAIL_CUR;
   
   Y_Sp_Comm_Slip_Batch_Flag(C_ORG_ID, 'Journal');
   IF C_C_TAG THEN Y_Sp_Comm_Slip_Batch_Flag(C_ORG_ID, 'Customer'); END IF;
   
      EXCEPTION
      WHEN OTHERS THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '���Ա���ǥ���� ����! [Line No 159]';
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
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
  WHEN OTHERS THEN
       RAISE;
    
END Y_Sp_H_Slip_Income;
/

