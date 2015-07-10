CREATE OR REPLACE PROCEDURE Y_Sp_H_Slip_Agree (ai_save_num IN NUMBER,
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
		       b.agree_date,
             b.degree_code,
		       a.cust_code,
		       c.cust_name,
             c.cust_div,
             c.biz_status,
             c.biz_type,
             c.CUR_ZIP_CODE,
             c.CUR_ADDR1,
             c.CUR_ADDR2,
		       d.code_name,
		       SUM(b.land_amt)  land_amt,
		       SUM(b.build_amt) build_amt,
		       SUM(b.vat_amt)   vat_amt,
		       SUM(b.sell_amt)  sell_amt
		  FROM H_SALE_MASTER a,
		       H_SALE_AGREE  b,
		       H_CODE_CUST   c,
             H_CODE_COMMON d
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
		   AND b.agree_date  BETWEEN ad_fr_date AND ad_to_date
		   AND a.last_contract_date <= ad_to_date
		   AND a.chg_date    > ad_to_date
		   AND a.chg_div     <> '00'
		 GROUP BY a.dongho,
             a.seq,
		       a.contract_code,
		       b.agree_date,
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
		 HAVING SUM(b.land_amt) <> 0
		    AND SUM(b.build_amt)  <> 0
		    AND (SUM(b.sell_amt) = (SUM(b.land_amt) + SUM(b.build_amt) + SUM(b.vat_amt)))
		
   ORDER BY  a.dongho,
             a.seq,
		       b.degree_code ;
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	
   rec_slip_master H_SALE_MASTER%ROWTYPE;
   rec_slip_agree H_SALE_AGREE%ROWTYPE;
   rec_slip_cust  H_CODE_CUST%ROWTYPE;
   v_tag               VARCHAR2(10);
   v_degree_name  H_CODE_COMMON.code_name%TYPE;
   v_cust_type    VARCHAR2(10);
   
   v_build_amt H_SALE_AGREE.sell_amt%TYPE;
   v_land_amt  H_SALE_AGREE.sell_amt%TYPE;
   v_vat_amt   H_SALE_AGREE.sell_amt%TYPE;
   v_sell_amt  H_SALE_AGREE.sell_amt%TYPE;
   v_dr_amt    H_SALE_AGREE.sell_amt%TYPE;
   v_cr_amt    H_SALE_AGREE.sell_amt%TYPE;
   v_acntcode  VARCHAR2(10);
   
   v_vatname   VARCHAR2(30);
   v_vat_cnt   NUMBER;
   v_tax_seq  NUMBER;
   v_tax_tag  VARCHAR2(1);
   
   C_DATE      DATE DEFAULT SYSDATE;              
   
   C_ACNTNO_PRE        VARCHAR2(50);                  --�о�̼���(Ȯ��)��/��/�� 
   C_ACNTNO_DUE        VARCHAR2(50);                  --�о缱���� -�ǹ���/������
   C_ACNTNO_TX         VARCHAR2(50)  DEFAULT '211712';--�������(�о�)     -�ΰ���
   C_ACNTNO_BLL        VARCHAR2(50)  DEFAULT '211725';--�о缱����(��꼭) 
   
   C_SOURCE            VARCHAR2(50)  DEFAULT '�о�';
   C_CATEGORY          VARCHAR2(50)  DEFAULT '�̼���';
   
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
   C_CUST_CODE_SAVE    VARCHAR2(50) DEFAULT '.';
   C_DESC              VARCHAR2(100);
   C_C_TAG             BOOLEAN DEFAULT FALSE; 
   C_V_TAG             BOOLEAN DEFAULT FALSE;
   
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
      e_msg      := 'ORG_ID �̵��'||C_COMP_CODE;
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
   e_msg      := 'EFIN_INVOICE_HEADER_ITF Insert ���� '||C_GROUP_ID||','||ai_save_num||','||'A'||SQLERRM;
	Y_Sp_D_Efin_Invoice_Copy(C_GROUP_ID,ai_save_num,'A', ad_to_date);  
      
	OPEN	DETAIL_CUR;
	LOOP
      FETCH DETAIL_CUR INTO rec_slip_agree.dongho, rec_slip_agree.seq, 
                            rec_slip_master.contract_code, rec_slip_agree.agree_date, rec_slip_agree.degree_code, 
                            rec_slip_cust.cust_code, rec_slip_cust.cust_name, rec_slip_cust.cust_div, 
                            rec_slip_cust.biz_status, rec_slip_cust.biz_type, rec_slip_cust.cur_zip_code, 
                            rec_slip_cust.cur_addr1, rec_slip_cust.cur_addr2, v_degree_name, 
                            rec_slip_agree.land_amt, rec_slip_agree.build_amt, rec_slip_agree.vat_amt, rec_slip_agree.sell_amt;
                            --V_DATE,V_SEQ,V_CONT,V_ACNTCODE,V_VATCODE,V_AMT,V_VAT,V_TAX_AMT,V_CUST_CODE,V_CUST_TYPE,
									 --V_SBCR_NAME,V_ZIP,V_ADDR,V_UPTAE,V_UPJONG,V_TREADE,V_FOLDER_ID;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
			
		c_h_data := trim(rec_slip_agree.dongho)||trim(TO_CHAR(rec_slip_agree.seq,'000'))||trim(rec_slip_agree.degree_code);
      C_DESC := trim(rec_slip_agree.dongho)||'-'||rec_slip_agree.seq||'-'||rec_slip_cust.cust_name||'-'||v_degree_name; 
      
      -- ����ó ���̺� �ŷ�ó�� �����ϴ��� Check�Ͽ� ������� insert�Ѵ�.
      
      
      
      IF C_CUST_CODE_SAVE <> rec_slip_cust.cust_code AND LENGTH(TRIM(rec_slip_cust.cust_code)) IS NOT NULL THEN
         C_CUST_CODE_SAVE := rec_slip_cust.cust_code;
        IF NOT F_Comm_Slip_Check_Customer(C_ORG_ID, rec_slip_cust.cust_code) THEN         
           -- Interface���̺� ���� �����Ѵ�.
           IF rec_slip_cust.cust_div = '02' THEN
              v_cust_type := '����';
           ELSE
              v_cust_type := '����';
           END IF; 
           Y_Sp_H_Slip_Customer(C_COMP_CODE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
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
		
		C_FOLDER_ID := C_COMP_CODE || '99999';
      
      v_build_amt := rec_slip_agree.build_amt;
      v_land_amt  := rec_slip_agree.land_amt;
      v_vat_amt   := rec_slip_agree.vat_amt;
      v_sell_amt  := rec_slip_agree.sell_amt;
      
      ---------------------------------------------------------------------------------------
      --�̼��� ��ǥ 1��°����
      ---------------------------------------------------------------------------------------
      v_dr_amt := v_sell_amt; v_cr_amt := NULL;--�о�̼���(Ȯ��)
      v_vatname := NULL;
      v_vat_cnt := 0;
      v_acntcode := C_ACNTNO_DUE;
      v_tax_seq  := NULL;
      v_tax_tag  := NULL;
      Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,                 --as_comp_code
                                C_GROUP_ID,                  --ai_group_id
                                as_approval_name,            --as_group_name 
                                --C_INVOICE,                 --as_invoice_num
                                rec_slip_agree.agree_date,   --ad_invoice_dt ������
                                C_DATE,                      --ad_gl_dt      �߻��� 
							           rec_slip_cust.cust_name,     --as_vendor_name 
                                rec_slip_cust.cust_code,     --as_vendor_site_code
                                V_DR_AMT,                    --ai_dr_amt
                                V_CR_AMT,                    --ai_cr_amt
                                V_VATNAME,       --as_vat_name
                                as_dept_code,    --as_dept_code
							           C_PROJ,          --as_proj_code 
                                V_VAT_CNT,       --ai_cnt
                                V_ACNTCODE,      --as_dr_coa
                                C_CATEGORY,      --as_category
                                C_SOURCE,        --as_source
                                V_TAX_SEQ,       --ai_tax_seq
                                V_TAX_TAG,       --as_tax_status
                                C_FOLDER_ID,     --as_folder
                                C_H_DATA,
                                C_ORG_ID,
                                C_DEPT_NAME,
                                C_DESC);       --as_h_data
      
      ---------------------------------------------------------------------------------------
      --�̼��� ��ǥ 2�������
      ---------------------------------------------------------------------------------------
      IF V_VAT_AMT <> 0 THEN 
         SELECT gl_je_lines_s.NEXTVAL -- �ΰ���������� �����
   	     INTO C_TAX_SEQ
   	     FROM dual;
   	   -- �ΰ�����,�ΰ������������ڵ带 ������ �´�.
   		SELECT tax_code_name_alt
   		  INTO C_VATNAME
   		  FROM efin_tax_codes_v
   		 WHERE org_code = C_COMP_CODE
   		   AND ACCOUNT_CODE = C_ACNTNO_TX;
         
         IF v_vat_amt <> 0 THEN
            v_dr_amt := NULL; v_cr_amt := v_build_amt;
         ELSE
            v_dr_amt := NULL; v_cr_amt := 0;
         END IF;
         v_vatname := C_VATNAME;
         v_vat_cnt := 1; --vatname �� ������ 1 �ƴϸ� 0 
         v_acntcode := C_ACNTNO_PRE;
         v_tax_seq  := C_TAX_SEQ; 
         v_tax_tag  := C_TAX_TAG;
         Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_agree.agree_date,
                                   C_DATE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                   V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                   C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC);
      END IF;
      ---------------------------------------------------------------------------------------
      --�̼��� ��ǥ 3�������
      ---------------------------------------------------------------------------------------
      IF V_VAT_AMT <> 0 THEN
        IF v_vat_amt <> 0 THEN
           v_dr_amt := NULL; v_cr_amt := v_vat_amt;
        ELSE
           v_dr_amt := NULL; v_cr_amt := 0;
        END IF;
        v_vatname := NULL;
        v_vat_cnt := 0; --vatname �� ������ 1 �ƴϸ� 0 
        v_acntcode := C_ACNTNO_TX;
        v_tax_seq  := C_TAX_SEQ; 
        v_tax_tag  := C_TAX_TAG;
        Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_agree.agree_date,
                                  C_DATE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                  V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                  C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC);
      END IF;
      ---------------------------------------------------------------------------------------
      --�̼��� ��ǥ 4�������
      ---------------------------------------------------------------------------------------
      SELECT gl_je_lines_s.NEXTVAL -- �ΰ���������� �����
	     INTO C_TAX_SEQ
	     FROM dual;
	   -- �ΰ�����,�ΰ������������ڵ带 ������ �´�.
		SELECT tax_code_name_alt
		  INTO C_VATNAME
		  FROM efin_tax_codes_v
		 WHERE org_code = C_COMP_CODE
		   AND ACCOUNT_CODE = C_ACNTNO_BLL;
      
      IF v_vat_amt <> 0 THEN
         v_dr_amt := NULL; v_cr_amt := v_land_amt;
      ELSE
         v_dr_amt := NULL; v_cr_amt := v_sell_amt;
      END IF;
      v_vatname := C_VATNAME;
      v_vat_cnt := 1; --vatname �� ������ 1 �ƴϸ� 0 
      v_acntcode := C_ACNTNO_PRE;
      v_tax_seq  := C_TAX_SEQ; 
      v_tax_tag  := C_TAX_TAG;
      Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_agree.agree_date,
                                C_DATE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC);
      ---------------------------------------------------------------------------------------
      --�̼��� ��ǥ 5�������
      ---------------------------------------------------------------------------------------
      v_dr_amt := NULL; v_cr_amt := 0;
      
      v_vatname := NULL;
      v_vat_cnt := 0; --vatname �� ������ 1 �ƴϸ� 0 
      v_acntcode := C_ACNTNO_BLL;
      v_tax_seq  := C_TAX_SEQ; 
      v_tax_tag  := C_TAX_TAG;
      Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_agree.agree_date,
                                C_DATE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC);
      
      --��ǥ��ȣ ����(H_SALE_AGREE) 				
	   UPDATE H_SALE_AGREE
         SET WORK_NO = C_GROUP_ID, WORK_DATE = C_DATE
       WHERE DEPT_CODE = as_dept_code
         AND SELL_CODE = as_sell_code
         AND DONGHO = rec_slip_agree.dongho
         AND SEQ = rec_slip_agree.seq
         AND DEGREE_CODE = rec_slip_agree.degree_code;
         
	END LOOP;
	CLOSE DETAIL_CUR;
   
   Y_Sp_Comm_Slip_Batch_Flag(C_ORG_ID, 'Journal');
   IF C_C_TAG THEN Y_Sp_Comm_Slip_Batch_Flag(C_ORG_ID, 'Customer'); END IF;
   
      EXCEPTION
      WHEN OTHERS THEN
           RAISE;
           /*IF SQL%NOTFOUND THEN
              e_msg      := '�̼�����ǥ���� ����! [Line No 159]';
              Wk_errflag := -20020;
              GOTO EXIT_ROUTINE;
           END IF;*/
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
    
END Y_Sp_H_Slip_Agree;
/

