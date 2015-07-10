CREATE OR REPLACE PROCEDURE Y_Sp_H_Subs_Cancel (ai_save_num IN NUMBER,
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
            
    SELECT a.subs_no, 
             a.cust_code,
             a.subs_date,
             a.subs_amt,
             a.prize_date,
             a.prize_dongho,
             a.refund_date,
             c.cust_name,
             c.cust_div,
             c.biz_status,
             c.biz_type,
             c.CUR_ZIP_CODE,
             c.CUR_ADDR1,
             c.CUR_ADDR2 
        FROM H_SUBS_MASTER a,
             H_CODE_CUST c
       WHERE a.dept_code = as_dept_code
         AND a.sell_code = as_sell_code
         AND a.subs_date  BETWEEN ad_fr_date AND ad_to_date
         AND a.cust_code = c.cust_code (+)
         AND LENGTH(trim(a.refund_date)) IS NOT NULL;    
     
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	
   rec_subs_master H_SUBS_MASTER%ROWTYPE;
   rec_slip_cust  H_CODE_CUST%ROWTYPE;
   v_cust_type    VARCHAR2(10);
   
   v_amt  H_SUBS_MASTER.subs_amt%TYPE;
   v_dr_amt    H_SUBS_MASTER.subs_amt%TYPE;
   v_cr_amt    H_SUBS_MASTER.subs_amt%TYPE;
   v_acntcode  VARCHAR2(10);
   v_acntcode2  VARCHAR2(10);
   
   v_vatname   VARCHAR2(30);
   v_vat_cnt   NUMBER;
   v_tax_seq  NUMBER;
   v_tax_tag  VARCHAR2(1);
   v_cash     NUMBER;
   v_bill     NUMBER;
   
   C_TAG               VARCHAR2(20);
   C_DATE      DATE DEFAULT SYSDATE;
   C_INVOICE   VARCHAR2(100);              
   
   C_ACNTNO_SUB        VARCHAR2(50)  DEFAULT '211651';--û�༱����
   C_ACNTNO_PAY        VARCHAR2(50)  DEFAULT '211311';--�����ޱ� 
   
   C_SOURCE            VARCHAR2(50)  DEFAULT 'û��';
   C_CATEGORY          VARCHAR2(50)  DEFAULT 'û��ȯ��';
   
   C_DESC              VARCHAR2(50)  DEFAULT 'û��ȯ��';
   
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
   C_C_TAG             BOOLEAN DEFAULT FALSE;
   C_V_TAG             BOOLEAN DEFAULT FALSE;
   C_CUST_CODE_SAVE    VARCHAR2(20);
   
BEGIN
 BEGIN
   BEGIN
      
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
   e_msg      := 'EFIN_INVOICE_HEADER_ITF Insert ���� '||C_GROUP_ID||','||ai_save_num||','||'A';
	Y_Sp_D_Efin_Invoice_Copy(C_GROUP_ID,ai_save_num,'A',ad_to_date);
      
	OPEN	DETAIL_CUR;
	LOOP              
      FETCH DETAIL_CUR INTO rec_subs_master.subs_no, rec_subs_master.cust_code, 
                            rec_subs_master.subs_date, rec_subs_master.subs_amt,  
                            rec_subs_master.prize_date, rec_subs_master.prize_dongho,
                            rec_subs_master.refund_date,
                            rec_slip_cust.cust_name, rec_slip_cust.cust_div,  
                            rec_slip_cust.biz_status, rec_slip_cust.biz_type,  
                            rec_slip_cust.CUR_ZIP_CODE, rec_slip_cust.CUR_ADDR1, 
                            rec_slip_cust.CUR_ADDR2;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
			
		c_h_data := trim(rec_subs_master.prize_dongho);
      -- ����ó ���̺� �ŷ�ó�� �����ϴ��� Check�Ͽ� ������� insert�Ѵ�.
      C_DESC := C_DESC||'('||rec_subs_master.cust_code||')';
      
   	
		C_FOLDER_ID := C_COMP_CODE || '99999';
      
      v_amt  := rec_subs_master.subs_amt;
      
      
         
         -----------------------------------------------------------------------------------------
         --
         ----------------------------------------------------------------------------------------
         ---------------------------------------
      --AP ������(�ؾ�) �����ޱ�(�ڻ�,��ä)
      --------------------------------------
      /*SELECT gl_je_lines_s.NEXTVAL -- �ΰ���������� �����
	     INTO C_TAX_SEQ
	     FROM dual;
	   -- �ΰ�����,�ΰ������������ڵ带 ������ �´�.
		SELECT tax_code_name_alt
		  INTO C_VATNAME
		  FROM efin_tax_codes_v
		 WHERE org_code = C_COMP_CODE
		   AND ACCOUNT_CODE = C_ACNTNO_CLS;*/
         
      
      IF NOT F_Comm_Slip_Check_Supplier(C_ORG_ID, rec_slip_cust.cust_code) THEN   
        --INTERFACE���̺� �ŷ�ó�� �����Ѵ�.
        IF rec_slip_cust.cust_div = '02' THEN
              v_cust_type := '����';
        ELSE
           v_cust_type := '����';
        END IF;
  		  Y_Sp_Comm_Slip_Supplier(C_COMP_CODE,rec_slip_cust.cust_name,rec_subs_master.cust_code,
                                v_cust_type,as_dept_code,'211111',rec_slip_cust.cur_zip_code,rec_slip_cust.cur_ADDR1||' '||rec_slip_cust.cur_ADDR2,
                                rec_slip_cust.biz_status,rec_slip_cust.biz_type, rec_slip_cust.represent);
        IF NOT C_V_TAG THEN C_V_TAG := TRUE; END IF;
      END IF;
      
      -- ��ǥ��ȣ���ϱ�
            C_TEMP := 'S'|| '-I-û��ȯ��-' || as_dept_code || '-' || TO_CHAR(rec_subs_master.refund_date,'yymmdd') || '-';
				SELECT NVL(SUBSTRB(MAX(invoice_num),LENGTHB(MAX(invoice_num)) - 2,3),0) + 1
				  INTO C_SEQ
				  FROM efin_invoice_lines_itf
				 WHERE invoice_num LIKE C_TEMP || '%';
				IF C_SEQ < 10 THEN
					C_INVOICE := C_TEMP || '00' || C_SEQ;
				ELSE 
					IF C_SEQ < 100 THEN
						C_INVOICE := C_TEMP || '0' || C_SEQ;
					ELSE
						C_INVOICE := C_TEMP || C_SEQ;
					END IF;
				END IF;
	-- AP Interface ���̺� �ڷḦ �����Ѵ�.
		-- ���ް�
            v_dr_amt := v_amt; v_cr_amt := v_amt;
            v_vatname := NULL;
            v_vat_cnt := 0;
            v_acntcode := C_ACNTNO_SUB;
            v_acntcode2 := C_ACNTNO_PAY;
            v_tax_seq  := NULL;
            v_tax_tag  := NULL;
            v_cash := v_dr_amt;
            v_bill := 0;
            Y_Sp_Comm_Slip_Ap_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,C_INVOICE,rec_subs_master.refund_date,C_DATE,
                                      rec_slip_cust.cust_name,rec_subs_master.cust_code,
                                      V_DR_AMT,V_CR_AMT,C_DESC,V_VATNAME,as_dept_code, C_PROJ,1,V_ACNTCODE,V_ACNTCODE2,
                                      C_VENDOR_ID,C_VENDOR_SITE_ID,V_CASH,V_BILL,'ITEM', 'û��ȯ��',C_ORG_ID);
		
      -------------------------------------------------------                          
       				
	-- ���Ա����̺� ��ǥ�����͹�ȣ�� Setting �Ѵ�.
	/*		UPDATE F_PROFIT_DETAIL
				SET invoice_num = C_GROUP_ID
			 WHERE dept_code = as_dept_code
				AND inst_date = V_DATE
				AND slip_spec_unq_num = V_SEQ;
   */
	END LOOP;
	CLOSE DETAIL_CUR;
   
   Y_Sp_Comm_Slip_Batch_Flag(C_ORG_ID, 'AP Invoice');
   IF C_V_TAG THEN Y_Sp_Comm_Slip_Batch_Flag(C_ORG_ID, 'Supplier'); END IF;
   
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
  WHEN OTHERS THEN
       RAISE;
    
END Y_Sp_H_Subs_Cancel;
/

