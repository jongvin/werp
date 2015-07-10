CREATE OR REPLACE PROCEDURE y_sp_f_slip_profit_as (as_dept_code    IN   VARCHAR2,
																	ad_fr_date		  IN   DATE ,
																	ad_to_date		  IN   DATE,
																	as_wbs_code     IN VARCHAR2,
																	ai_unq_num      IN   NUMBER ) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT a.rqst_date,a.slip_spec_unq_num,a.cont,a.acntcode,a.vatcode,
		 a.amt,a.vat,a.tax_amt,
		 decode(lengthb(a.cust_code),13,substrb(a.cust_code,1,6) || '-' || substrb(a.cust_code,7,7),substrb(a.cust_code,1,3) || '-' || substrb(a.cust_code,4,2) || '-' || substrb(a.cust_code,6,5)),
		 decode(lengthb(a.cust_code),13,'����','����'),a.cust_name,b.zip_number,b.addr,
		 b.business_condition,b.kind_businesstype,b.representative_name,a.inst_date
  FROM f_profit_detail a,
		 z_code_cust_code b,
		efin_invoice_header_itf c	 
 WHERE a.cust_code = b.cust_code (+)
	AND a.dept_code = as_dept_code
	AND a.wbs_code  = as_wbs_code
	AND a.inst_date >= ad_fr_date
	AND a.inst_date <= ad_to_date
	AND a.invoice_num = c.invoice_group_id (+)
--	AND decode(c.complete_flag,null,'Y',decode(c.complete_flag,'3','Y',decode(c.complete_flag,'9',decode(c.relation_invoice_group_id,null,'N','Y'),'N'))) = 'Y'
	AND decode(a.INVOICE_NUM,null,'0',nvl(f_slip_status(a.INVOICE_NUM),'0')) IN ('0','3','C')
	AND (a.amt <> 0 );
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_DATE       		  DATE;
    V_INST_DATE           DATE;
	V_SEQ         		  INTEGER;
	V_CONT              VARCHAR2(100);
	V_ACNTCODE          VARCHAR2(8);
	V_VATCODE           VARCHAR2(8);
	V_AMT               NUMBER(20,5);
	V_VAT               NUMBER(20,5);
	V_TAX_AMT           NUMBER(20,5);
	V_CUST_CODE         VARCHAR2(20);
	V_CUST_TYPE         VARCHAR2(10);
	V_SBCR_NAME         VARCHAR2(50);
	V_ZIP               VARCHAR2(10);
	V_ADDR              VARCHAR2(100);
	V_UPTAE             VARCHAR2(20);
	V_UPJONG            VARCHAR2(30);
	V_TREADE            VARCHAR2(20);
	V_FOLDER_ID         VARCHAR2(10);
	C_GROUP_ID          INTEGER;
	C_SEQ               INTEGER;
	C_CASH_RT           NUMBER(20,5);
	C_DR_AMT            NUMBER(20,5);
	C_CR_AMT            NUMBER(20,5);
	C_TEMP_VAT          NUMBER(20,5);
   C_CNT               NUMBER(20,5);  --
	C_TAX_CNT           NUMBER(20,5);
	C_COMP_CODE         VARCHAR2(10);
	C_ORG_ID            VARCHAR2(10);
	C_ORG_NAME          VARCHAR2(100);
	C_INVOICE           VARCHAR2(50);
	C_TEMP              VARCHAR2(50);
	C_PROJ              VARCHAR2(10);
	C_ACNTCODE          VARCHAR2(10);
	C_VATNAME           VARCHAR2(50);
	C_TEMP_VATNAME      VARCHAR2(50);
	C_DEPT_NAME         VARCHAR2(50);
	C_VENDOR_ID         INTEGER;	
	C_VENDOR_SITE_ID    INTEGER;
	C_TAX_SEQ           INTEGER;	
	C_TAX_TAG           VARCHAR2(1);
	C_CUST_CODE         VARCHAR2(20);
	C_CUST_NAME         VARCHAR2(50);
	C_FOLDER_ID         VARCHAR2(10);
	C_BANK_FOLDER       VARCHAR2(10);
BEGIN
 BEGIN
-- ���庰 ������ڵ带 ������ �´�	
		select comp_code ,long_name
		  into C_COMP_CODE,C_DEPT_NAME
 		  from z_code_dept 
		 where dept_code = as_wbs_code;
-- ���庰������Ʈ�ڵ带 ���Ѵ�.
		select a.proj_code
		  into C_PROJ
		 from ( select a.dept_code,c.proj_code
			 		 from  z_code_dept a,
						  ( select proj_unq_key,step     
								from r_proj_view_business_form) b,
							r_proj c
				   where a.proj_unq_key = b.proj_unq_key
					  and b.proj_unq_key = c.proj_unq_key
					  and b.step = c.step ) a
		 where a.dept_code =  as_wbs_code;  
	SELECT attribute1
	  INTO C_ORG_ID
	  FROM efin_corporations_v
	 WHERE corporation_code = C_COMP_CODE;
-- ��ǥ �����͹�ȣ�� ���Ѵ�.
	select efin_invoice_header_itf_s.nextval
	  into C_GROUP_ID
	  from dual;
-- ������������� �����´�.
 	select folder_id
	  into C_BANK_FOLDER
	  from f_dept_account
	 where dept_code = as_dept_code
		and wbs_code = as_wbs_code;
	IF C_BANK_FOLDER IS NULL THEN
		C_BANK_FOLDER := C_COMP_CODE || '99999';
	END IF;
-- ���缱 ������ �����Ѵ�.
	y_sp_d_efin_invoice_copy(C_GROUP_ID,ai_unq_num,'A',last_day(ad_to_date));
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_DATE,V_SEQ,V_CONT,V_ACNTCODE,V_VATCODE,V_AMT,V_VAT,V_TAX_AMT,V_CUST_CODE,V_CUST_TYPE,
									 V_SBCR_NAME,V_ZIP,V_ADDR,V_UPTAE,V_UPJONG,V_TREADE,V_INST_DATE;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
			IF V_ACNTCODE = '462513' THEN
		-- �ΰ�����,�ΰ������������ڵ带 ������ �´�.
				IF V_CUST_CODE = '--' THEN
					V_CUST_CODE := '';
				ELSE 
					IF F_COMM_SLIP_CHECK_CUSTOMER(C_ORG_ID,V_CUST_CODE) = False THEN
			-- Interface���̺� �ŷ�ó�� �����Ѵ�.
						y_sp_comm_slip_customer(C_COMP_CODE,V_SBCR_NAME,V_CUST_CODE,V_CUST_TYPE,as_wbs_code,V_ZIP,V_ADDR,'',V_UPTAE,V_UPJONG);
					END IF;
				END IF;
		-- ����ó���̺��� vendor_id�� vendor_site_id�� �����´�
		--		select nvl(vendor_id,0),nvl(vendor_site_id,0)
		--		  into C_VENDOR_ID,C_VENDOR_SITE_ID
		--		  from efin_supplier_v
		--		 where org_id = C_ORG_ID
		--			and vat_registration_num = V_CUST_CODE; 
				C_FOLDER_ID := C_COMP_CODE || '99999';
				IF V_VATCODE is null THEN
					C_VATNAME := '';
					C_TAX_SEQ := '';
					C_TAX_TAG := '';
					C_TAX_CNT := '';
				ELSE
					select account_code,tax_code_name_alt
					  into C_ACNTCODE,C_VATNAME
					  from efin_tax_codes_v
					 where org_code = C_COMP_CODE
						and tax_id = V_VATCODE;
					select gl_je_lines_s.nextval -- �ΰ���������� �����
					  into C_TAX_SEQ
					  from dual;
					C_TAX_TAG := 'T';
					C_TAX_CNT := 1;
				END IF;	
				C_DR_AMT := V_AMT + V_VAT; -- �Ұ����� ��� �����ݾ׿� �ΰ����� ����.
			-- GL Interface ���̺� �ڷḦ �����Ѵ�.
				y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' ���Ա�',last_day(ad_to_date),V_DATE,
												  V_SBCR_NAME,V_CUST_CODE,'',V_AMT,C_VATNAME,as_wbs_code,
												  C_PROJ,C_TAX_CNT,V_ACNTCODE,'���Ա�','�ڱ�û��',C_TAX_SEQ,C_TAX_TAG,
												  C_FOLDER_ID,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' ���Ա�','C');
				IF V_VATCODE IS NOT NULL THEN
					y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' ���Ա�',last_day(ad_to_date),V_DATE,
													  V_SBCR_NAME,V_CUST_CODE,'',V_VAT,'',as_wbs_code,
													  C_PROJ,'',C_ACNTCODE,'���Ա�','�ڱ�û��',C_TAX_SEQ,C_TAX_TAG,
													  C_FOLDER_ID,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' ���Ա�','C');
				END IF;
				y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' ���Ա�',last_day(ad_to_date),V_DATE,
												  V_SBCR_NAME,V_CUST_CODE,C_DR_AMT,'','',as_wbs_code,
												  C_PROJ,'','111114','���Ա�','�ڱ�û��','','',
												  C_BANK_FOLDER,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' ���Ա�','C');
			ELSE
		-- ����ó ���̺� �ŷ�ó�� �����ϴ��� Check�Ͽ� ������� insert�Ѵ�.
				IF V_CUST_CODE = '--' THEN
					V_CUST_CODE := '';
				ELSE 
					IF F_COMM_SLIP_CHECK_CUSTOMER(C_ORG_ID,V_CUST_CODE) = False THEN
			-- Interface���̺� �ŷ�ó�� �����Ѵ�.
						y_sp_comm_slip_customer(C_COMP_CODE,V_SBCR_NAME,V_CUST_CODE,V_CUST_TYPE,as_wbs_code,V_ZIP,V_ADDR,'',V_UPTAE,V_UPJONG);
					END IF;
				END IF;
		-- ����ó���̺��� vendor_id�� vendor_site_id�� �����´�
		--		select nvl(vendor_id,0),nvl(vendor_site_id,0)
		--		  into C_VENDOR_ID,C_VENDOR_SITE_ID
		--		  from efin_supplier_v
		--		 where org_id = C_ORG_ID
		--			and vat_registration_num = V_CUST_CODE; 
				C_CR_AMT := V_AMT + V_TAX_AMT; 
			-- GL Interface ���̺� �ڷḦ �����Ѵ�.
				y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' ���Ա�',last_day(ad_to_date),V_DATE,
												  V_SBCR_NAME,V_CUST_CODE,'',C_CR_AMT,C_VATNAME,as_wbs_code,
												  C_PROJ,'',V_ACNTCODE,'���Ա�','�ڱ�û��','','',C_BANK_FOLDER,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' ���Ա�','C');
				y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' ���Ա�',last_day(ad_to_date),V_DATE,
												  V_SBCR_NAME,V_CUST_CODE,V_AMT,'','',as_wbs_code,
												  C_PROJ,'','111114','���Ա�','�ڱ�û��','','',C_BANK_FOLDER,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' ���Ա�','C');
				IF V_TAX_AMT <> 0 THEN
					y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' ���Ա�',last_day(ad_to_date),V_DATE,
													  V_SBCR_NAME,V_CUST_CODE,V_TAX_AMT,'','',as_wbs_code,
													  C_PROJ,'','112511','���Ա�','�ڱ�û��','','',C_BANK_FOLDER,'',C_ORG_ID,C_DEPT_NAME,C_DEPT_NAME || ' ���Ա�','C');
				END IF;
			END IF;
	-- ���Ա����̺� ��ǥ�����͹�ȣ�� Setting �Ѵ�.
			update f_profit_detail
				set invoice_num = C_GROUP_ID
			 where dept_code = as_dept_code
				and inst_date = V_INST_DATE
				and slip_spec_unq_num = V_SEQ;
	END LOOP;
	CLOSE DETAIL_CUR;
	-- ��ġȭ���� Update �Ѵ�.
			y_sp_comm_slip_batch_flag(C_ORG_ID,'Journal');
      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '���Ա���ǥ���� ����! [Line No: 159]';
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
END y_sp_f_slip_profit_as;
/
