 /* ============================================================================ */
/* �Լ��� : y_sp_s_slip_prgs (AP,GL)                                             */
/* ��  �� : ���ֺ�⼺ ��ǥ ����                                                 */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : �⼺���               ==> ad_yymm(DATE)                             */
/*        : �۾�����               ==> ad_date(DATE)                             */
/*        : ����  	              ==> ai_seq(integer)			 */
/*        : ���缱��ȣ             ==> ai_unq_num(NUMBER)                        */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2005.04.27                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_slip_prgs (as_dept_code    IN   VARCHAR2,
															 ad_yymm			  IN   DATE ,
															 ad_date			  IN   DATE ,
															 ai_seq          IN   INTEGER,
															 ai_unq_num      IN   NUMBER) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT a.tm_prgs_notax + a.tm_purchase_vat,a.tm_prgs,a.tm_vat,a.tm_advance_deduction,a.tm_cash,a.tm_bill,
		 b.vatcode,b.sbc_amt,b.previous_amt_rt,
		 decode(lengthb(c.businessman_number),13,substrb(c.businessman_number,1,6) || '-' || substrb(c.businessman_number,7,7),substrb(c.businessman_number,1,3) || '-' || substrb(c.businessman_number,4,2) || '-' || substrb(c.businessman_number,6,5)),
		 decode(lengthb(c.businessman_number),13,'����','�����'),c.sbcr_name,c.zip_number1,c.address1,
		 c.kind_bussinesstype,c.kinditem,c.rep_name1,b.order_number,c.bill_dis_pay,
		 a.tm_pre_tax,a.tm_pre_notax,a.tm_pre_vat,to_char(a.pay_dt,'yyyy-mm-dd'),b.order_class,b.sbc_name
  FROM s_pay a,
       s_cn_list b,
		 s_sbcr c
 WHERE b.sbcr_code = c.sbcr_code (+)
	AND a.dept_code = b.dept_code (+)
	AND a.order_number = b.order_number (+)
	AND a.dept_code = as_dept_code
	AND a.yymm      = ad_yymm
	AND a.seq       = ai_seq
	AND a.tm_pay <> 0;
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_PREPAY_AMT        NUMBER(20,5);
	V_NOTAX_AMT         NUMBER(20,5);
	V_TAX_AMT           NUMBER(20,5);
	V_VAT               NUMBER(20,5);
	V_TOTAL_AMT         NUMBER(20,5);
	V_CUST_CODE         VARCHAR2(20);
	V_SBCR_NAME         VARCHAR2(50);
	V_CUST_TYPE         VARCHAR2(10);
	V_ZIP               VARCHAR2(10);
	V_ADDR              VARCHAR2(100);
	V_UPTAE             VARCHAR2(20);
	V_UPJONG            VARCHAR2(30);
	V_TREADE            VARCHAR2(20);
	V_CASH              NUMBER(20,5);
	V_BILL              NUMBER(20,5);
	V_VATCODE           S_CN_LIST.VATCODE%TYPE;
	V_RT                NUMBER(20,5);
	V_ORDER_NUMBER      NUMBER(20,0);
	V_BILL_PAY          VARCHAR2(1);
	V_PRE_TAX           NUMBER(20,5);
	V_PRE_NOTAX         NUMBER(20,5);
	V_PRE_VAT           NUMBER(20,5);
	V_GL_DT             VARCHAR2(10);
	V_ORDER_CLASS       VARCHAR2(1);
	V_SBC_NAME          VARCHAR2(40);
	C_GROUP_ID          INTEGER;
	C_SEQ               INTEGER;
	C_CASH_RT           NUMBER(20,5);
	C_DR_AMT            NUMBER(20,5);
	C_CR_AMT            NUMBER(20,5);
	C_PREPAY_NOTAX      NUMBER(20,5);
	C_PREPAY_TAX        NUMBER(20,5);
	C_PREPAY_VAT        NUMBER(20,5);
	C_NOTAX_AMT         NUMBER(20,5);
	C_TAX_AMT           NUMBER(20,5);
	C_VAT               NUMBER(20,5);
	C_TEMP_VAT          NUMBER(20,5);
   C_CNT               NUMBER(20,5);  --
	C_CASH              NUMBER(20,5);
	C_BILL              NUMBER(20,5);
	C_COMP_CODE         VARCHAR2(10);
	C_ORG_ID            VARCHAR2(10);
	C_ORG_NAME          VARCHAR2(100);
	C_SBCR_CODE         VARCHAR2(20);
	C_INVOICE           VARCHAR2(50);
	C_TEMP              VARCHAR2(50);
	C_PREPAY_TEMP       VARCHAR2(50);
	C_PROJ_NAME         VARCHAR2(50);
	C_PROJ              VARCHAR2(10);
	C_ACNTCODE          VARCHAR2(10);
	C_ACNT              VARCHAR2(10);
	C_VATNAME           VARCHAR2(50);
	C_TEMP_VATNAME      VARCHAR2(50);
	C_VENDOR_ID         INTEGER;	
	C_VENDOR_SITE_ID    INTEGER;
	C_TAX_SEQ           INTEGER;	
	C_TAX_CNT           INTEGER;
	C_TAX_TAG           VARCHAR2(1);
	C_FOLDER            VARCHAR2(50);
	C_WORK_DT           VARCHAR2(10);
	C_CLASS_TAG         VARCHAR2(2);
	C_CONST_CLASS       VARCHAR2(2);
	C_ERR_CNT	        INTEGER;
	C_CLOSE_YN          INTEGER;
BEGIN
 BEGIN
-- ���庰 ������ڵ带 ������ �´�	
	select comp_code ,long_name,nvl(class_tag,'1'),nvl(const_class,'4')
	  into C_COMP_CODE,C_PROJ_NAME,C_CLASS_TAG,C_CONST_CLASS
	  from z_code_dept 
	 where dept_code = as_dept_code;
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
	 where a.dept_code =  as_dept_code;  

	SELECT attribute1
	  INTO C_ORG_ID
	  FROM efin_corporations_v
	 WHERE corporation_code = C_COMP_CODE;

-- ��ǥ �����͹�ȣ�� ���Ѵ�.
	select efin_invoice_header_itf_s.nextval
	  into C_GROUP_ID
	  from dual; 

-- ���缱 ������ �����Ѵ�.
	y_sp_d_efin_invoice_copy(C_GROUP_ID,ai_unq_num,'A',last_day(ad_yymm));

	C_FOLDER := C_COMP_CODE || '99999';
	C_WORK_DT := to_char(add_months(ad_yymm,1),'YYYY.MM') || '.10';

	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_NOTAX_AMT,V_TAX_AMT,V_VAT,V_PREPAY_AMT,V_CASH,V_BILL,V_VATCODE,V_TOTAL_AMT,V_RT,
									 V_CUST_CODE,V_CUST_TYPE,V_SBCR_NAME,V_ZIP,V_ADDR,V_UPTAE,V_UPJONG,V_TREADE,
									 V_ORDER_NUMBER,V_BILL_PAY,V_PRE_TAX,V_PRE_NOTAX,V_PRE_VAT,V_GL_DT,V_ORDER_CLASS,V_SBC_NAME;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
				C_CASH := 0;
				C_BILL := 0;

-- ��ǥ��ȣ�� ���ϱ����� TEMP

				SELECT V_ORDER_NUMBER || '-����-' || replace(last_day(ad_yymm),'-','') || '-'
				  INTO C_TEMP
				  FROM dual;
		
				SELECT C_TEMP || substrb(C_PROJ_NAME,1, 44 - lengthb(C_TEMP)) || '-'
				  INTO C_TEMP
				  FROM dual;

		
		-- �ΰ�����,�ΰ������������ڵ带 ������ �´�.
				select acntcode,nvl(COUNT(*),0)
				  into C_ACNTCODE,C_ERR_CNT
				  from z_code_vatclass
				 where vattag = V_VATCODE
				GROUP BY acntcode;
			if C_ERR_CNT = 0 THEN
				e_msg      := '���ֺ���ǥ���� ����! [Line No: 159]';
              	Wk_errflag := -20020;
                GOTO EXIT_ROUTINE;
			END IF;
		
			IF C_CLASS_TAG = '5' AND C_ACNTCODE = '112412' THEN --���Ͽ�� ���԰����ϰ�� ����M/H
				select tax_id,tax_code_name_alt,nvl(COUNT(*),0)
				  into V_VATCODE,C_VATNAME,C_ERR_CNT
				  from efin_tax_codes_v
				 where org_code = C_COMP_CODE
					and account_code = '112414'
				group by tax_id,tax_code_name_alt;
				if C_ERR_CNT = 0 THEN
					e_msg      := '���ֺ���ǥ���� ����! [Line No: 159]';
        	      	Wk_errflag := -20020;
    	            GOTO EXIT_ROUTINE;
				END IF;
				C_ACNTCODE := '112414';
			ELSE
				select tax_id,tax_code_name_alt,nvl(COUNT(*),0)
				  into V_VATCODE,C_VATNAME,C_ERR_CNT
				  from efin_tax_codes_v
				 where org_code = C_COMP_CODE
					and account_code = C_ACNTCODE
				group by tax_id,tax_code_name_alt;
				if C_ERR_CNT = 0 THEN
					e_msg      := '���ֺ���ǥ���� ����! [Line No: 159]';
        	      	Wk_errflag := -20020;
    	            GOTO EXIT_ROUTINE;
				END IF;
			END IF;
		-- ����ó ���̺� �ŷ�ó�� �����ϴ��� Check�Ͽ� ������� insert�Ѵ�.
				IF F_COMM_SLIP_CHECK_SUPPLIER(C_ORG_ID,V_CUST_CODE) = False THEN
		-- Interface���̺� �ŷ�ó�� �����Ѵ�.
					y_sp_comm_slip_supplier(C_COMP_CODE,V_SBCR_NAME,V_CUST_CODE,V_CUST_TYPE,as_dept_code,'211111',V_ZIP,V_ADDR,V_UPTAE,V_UPJONG,V_TREADE);
				END IF;
		-- ����ó���̺��� vendor_id�� vendor_site_id�� �����´�
		--		select nvl(vendor_id,0),nvl(vendor_site_id,0)
		--		  into C_VENDOR_ID,C_VENDOR_SITE_ID
		--		  from efin_supplier_v
		--		 where org_id = C_ORG_ID
		--			and vat_registration_num = V_CUST_CODE; 
-- ���ޱ� ���� ó��.		
		-- ���ޱݰ��� �ݾ��� ������ ��� ó��..
				IF V_PREPAY_AMT <> 0 THEN
					C_PREPAY_NOTAX := V_PRE_NOTAX;
					C_PREPAY_TAX   := V_PRE_TAX;
					C_PREPAY_VAT   := V_PRE_VAT;

					C_NOTAX_AMT    := V_NOTAX_AMT - C_PREPAY_NOTAX;
					C_TAX_AMT      := V_TAX_AMT - C_PREPAY_TAX;
					C_VAT          := V_VAT - C_PREPAY_VAT;

		--���ޱ� �鼼�ݾ��� ������ ��� ó��
					IF C_PREPAY_NOTAX <> 0 THEN
			-- GL Interface ���̺� �ڷḦ �����Ѵ�.
				-- ���ޱ�(�鼼)
						IF C_CLASS_TAG = '5' THEN
							IF C_CONST_CLASS = '1' THEN
								C_ACNT := '115511';  -- �ߺ�����(�����)
							ELSIF C_CONST_CLASS = '2' OR C_CONST_CLASS = '3' THEN
								C_ACNT := '742611';  -- �ߺ���(�����)
							ELSIF V_ORDER_CLASS = '2' THEN
								C_ACNT := '115331';  -- ���
							ELSE
								C_ACNT := '731113'; --���ϼ���(051004) C_ACNT := '915117';  -- ���ֺ�(�鼼)
							END IF;
						ELSIF C_CLASS_TAG = '10' THEN
							C_ACNT := '915118';  --���ϼ���(051004) C_ACNT := '915117';  -- ����ڻ�
						ELSIF V_ORDER_CLASS = '2' THEN
							C_ACNT := '115331';  -- ���
						ELSE
							C_ACNT := '731113';  -- ���ֺ�(�鼼)
						END IF;
						y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,V_SBCR_NAME || ' ���ޱ� ����',last_day(ad_yymm),V_GL_DT,
														  V_SBCR_NAME,V_CUST_CODE,C_PREPAY_NOTAX,'','',as_dept_code,
														  C_PROJ,'',C_ACNT,'���ޱ�����','����','','',C_FOLDER,'',C_ORG_ID,C_PROJ_NAME,
														  V_SBCR_NAME || ' ���ޱ� ����','V','','','','');
						C_ACNT := '112211'; -- ���ޱ�(�鼼)
						y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,V_SBCR_NAME || ' ���ޱ� ����',last_day(ad_yymm),V_GL_DT,
														  V_SBCR_NAME,V_CUST_CODE,'',C_PREPAY_NOTAX,'',as_dept_code,
														  C_PROJ,'',C_ACNT,'���ޱ�����','����','','',C_FOLDER,'',C_ORG_ID,C_PROJ_NAME,
														  V_SBCR_NAME || ' ���ޱ� ����','V','','','','');
					END IF;
		--���ޱ� �����ݾ��� ������ ��� ó��
					IF C_PREPAY_TAX <> 0 THEN
						IF C_ACNTCODE = '112421' THEN  -- �Ұ����� ���
							select gl_je_lines_s.nextval -- �ΰ���������� �����
							  into C_TAX_SEQ
							  from dual;
							C_TAX_TAG := 'T';
							C_TAX_CNT := 1;
							C_DR_AMT := C_PREPAY_TAX + C_PREPAY_VAT; -- �Ұ����� ��� �����ݾ׿� �ΰ����� ����.
						ELSE
							C_TAX_SEQ := '';
							C_TAX_TAG := '';
							C_TAX_CNT := '';
							C_DR_AMT := C_PREPAY_TAX;
						END IF;
			-- GL Interface ���̺� �ڷḦ �����Ѵ�.
				-- ���ޱ�(����)
						IF C_CLASS_TAG = '5' THEN
							IF C_CONST_CLASS = '1' THEN
								C_ACNT := '115511';  -- �ߺ�����(�����)
							ELSIF C_CONST_CLASS = '2' OR C_CONST_CLASS = '3' THEN
								C_ACNT := '742611';  -- �ߺ���(�����)
							ELSIF V_ORDER_CLASS = '2' THEN
								C_ACNT := '115331';  -- ���
							ELSE
								C_ACNT := '731111';  -- ���ֺ�(����)
							END IF;
						ELSIF C_CLASS_TAG = '10' THEN
							C_ACNT := '915118';  --���ϼ���(051004) C_ACNT := '915117';  -- ����ڻ�
						ELSIF V_ORDER_CLASS = '2' THEN
							C_ACNT := '115331';  -- ���
						ELSE
							C_ACNT := '731111';  -- ���ֺ�(����)
						END IF;
						y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,V_SBCR_NAME || ' ���ޱ� ����',last_day(ad_yymm),V_GL_DT,
														  V_SBCR_NAME,V_CUST_CODE,C_DR_AMT,'','',as_dept_code,
														  C_PROJ,C_TAX_CNT,C_ACNT,'���ޱ�����','����',C_TAX_SEQ,C_TAX_TAG,C_FOLDER,'',
														  C_ORG_ID,C_PROJ_NAME,V_SBCR_NAME || ' ���ޱ� ����','V','','','','');
						C_ACNT := '112212'; -- ���ޱ�(����)
						y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,V_SBCR_NAME || ' ���ޱ� ����',last_day(ad_yymm),V_GL_DT,
														  V_SBCR_NAME,V_CUST_CODE,'',C_PREPAY_TAX,'',as_dept_code,
														  C_PROJ,'',C_ACNT,'���ޱ�����','����','','',C_FOLDER,'',C_ORG_ID,C_PROJ_NAME,
														  V_SBCR_NAME || ' ���ޱ� ����','V','','','','');
						IF C_ACNTCODE = '112421' THEN  -- �Ұ����ϰ�� �ϳ� �� ����.
							IF C_CLASS_TAG = '5' THEN
								IF C_CONST_CLASS = '1' THEN
									C_ACNT := '115511';  -- �ߺ�����(�����)
								ELSIF C_CONST_CLASS = '2' OR C_CONST_CLASS = '3' THEN
									C_ACNT := '742611';  -- �ߺ���(�����)
								ELSIF V_ORDER_CLASS = '2' THEN
									C_ACNT := '115331';  -- ���
								ELSE
									C_ACNT := '731111';  -- ���ֺ�(����)
								END IF;
							ELSIF C_CLASS_TAG = '10' THEN
								C_ACNT := '915118';  --���ϼ���(051004) C_ACNT := '915117';  -- ����ڻ�
							ELSIF V_ORDER_CLASS = '2' THEN
								C_ACNT := '115331';  -- ���
							ELSE
								C_ACNT := '731111';  -- ���ֺ�(����)
							END IF;
							y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,V_SBCR_NAME || ' ���ޱ� ����',last_day(ad_yymm),V_GL_DT,
															  V_SBCR_NAME,V_CUST_CODE,'',C_PREPAY_VAT,'',as_dept_code,
															  C_PROJ,'',C_ACNT,'���ޱ�����','����',C_TAX_SEQ,C_TAX_TAG,C_FOLDER,'',
															  C_ORG_ID,C_PROJ_NAME,V_SBCR_NAME || ' ���ޱ� ����','V','','','','');
						END IF;
					END IF;
			-- ��ġȭ���� Update �Ѵ�.
					y_sp_comm_slip_batch_flag(C_ORG_ID,'Journal');
				ELSE
					C_NOTAX_AMT := V_NOTAX_AMT;
					C_TAX_AMT   := V_TAX_AMT;
					C_VAT       := V_VAT;
				END IF;

-- ���ֱ⼺ó��
				IF (V_CASH + V_BILL) <> 0 THEN		
					C_CASH_RT := trunc(V_CASH / (V_CASH + V_BILL),4); -- ������������ ���Ѵ�.
				ELSE
					C_CASH_RT := 1;
				END IF;
		-- �鼼�ݾ��� ������ ��� ó��
				IF C_NOTAX_AMT <> 0 THEN
					C_DR_AMT := C_NOTAX_AMT; -- �����ݾ�
					C_CR_AMT := C_DR_AMT; -- �뺯�ݾ�
					C_CASH   := TRUNC(C_DR_AMT * C_CASH_RT,0); -- ����
					C_BILL   := C_DR_AMT - C_CASH;
		-- ��ǥ��ȣ���ϱ�
					select nvl(substrb(max(invoice_num),lengthb(max(invoice_num)) - 2,3),0) + 1
					  into C_SEQ
					  from efin_invoice_lines_itf
					 where invoice_num like C_TEMP || '%';
		
					IF C_SEQ < 10 THEN
						C_INVOICE := C_TEMP || '00' || C_SEQ;
					ELSE 
						IF C_SEQ < 100 THEN
							C_INVOICE := C_TEMP || '0' || C_SEQ;
						ELSE
							C_INVOICE := C_TEMP || C_SEQ;
						END IF;
					END IF;
		
		-- �ΰ����� ������ �´�.(���Ը鼼(��꼭)�������� �ΰ������� ������)
					select tax_code_name_alt
					  into C_TEMP_VATNAME
					  from efin_tax_codes_v
					 where org_code = C_COMP_CODE
						and account_code = '112423';
		
		-- AP Interface ���̺� �ڷḦ �����Ѵ�.
			-- ���ֺ�(�鼼)
					IF C_CLASS_TAG = '5' THEN
						IF C_CONST_CLASS = '1' THEN
							C_ACNT := '115511';  -- �ߺ�����(�����)
						ELSIF C_CONST_CLASS = '2' OR C_CONST_CLASS = '3' THEN
							C_ACNT := '742611';  -- �ߺ���(�����)
						ELSIF V_ORDER_CLASS = '2' THEN
							C_ACNT := '115331';  -- ���
						ELSE
							C_ACNT := '731113';  -- ���ֺ�(�鼼)
						END IF;
					ELSIF C_CLASS_TAG = '10' THEN
						C_ACNT := '915118';  --���ϼ���(051004) C_ACNT := '915117';  -- ����ڻ�
					ELSIF V_ORDER_CLASS = '2' THEN
						C_ACNT := '115331';  -- ���
					ELSE
						C_ACNT := '731113';  -- ���ֺ�(�鼼)
					END IF;
					y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,to_char(ad_date,'yyyy-mm') || '�� ���ֱ⼺',C_INVOICE,V_GL_DT,V_GL_DT,
													  V_SBCR_NAME,V_CUST_CODE,C_DR_AMT,C_CR_AMT,V_SBC_NAME || ' ���ֱ⼺',C_TEMP_VATNAME,as_dept_code,
													  C_PROJ,1,C_ACNT,'211111',C_VENDOR_ID,C_VENDOR_SITE_ID,C_CASH,C_BILL,'ITEM','����',C_ORG_ID,'V',
													  V_ORDER_NUMBER,V_BILL_PAY,C_WORK_DT,C_FOLDER,'',0);
			-- ���Ը鼼(��꼭)		
					C_ACNT := '112423'; -- ���Ը鼼(��꼭)
					y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,to_char(ad_date,'yyyy-mm') || '�� ���ֱ⼺',C_INVOICE,V_GL_DT,V_GL_DT,
													  V_SBCR_NAME,V_CUST_CODE,0,C_CR_AMT,substr(V_SBC_NAME || ' ���ֱ⼺',1,50),C_TEMP_VATNAME,as_dept_code,
													  C_PROJ,1,C_ACNT,'211111',C_VENDOR_ID,C_VENDOR_SITE_ID,C_CASH,C_BILL,'TAX','����',C_ORG_ID,'V',
											        V_ORDER_NUMBER,V_BILL_PAY,C_WORK_DT,C_FOLDER,'',0);
				END IF;
		
		-- �����ݾ��� ������ ��� ó��
				IF C_TAX_AMT <> 0 THEN
					C_DR_AMT   := C_TAX_AMT; -- �����ݾ�
					C_TEMP_VAT := C_VAT;     -- �ΰ����ݾ�
					C_CR_AMT   := C_DR_AMT + C_TEMP_VAT ; -- �뺯�ݾ�(����+�ΰ���)
					C_CASH     := V_CASH - C_CASH; -- ����
					C_BILL     := V_BILL - C_BILL; -- ����
		
		-- ��ǥ��ȣ���ϱ�
					select nvl(substrb(max(invoice_num),lengthb(max(invoice_num)) - 2,3),0) + 1
					  into C_SEQ
					  from efin_invoice_lines_itf
					 where invoice_num like C_TEMP || '%';
		
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
			-- ���ޱ�(����)
					IF C_CLASS_TAG = '5' THEN
						IF C_CONST_CLASS = '1' THEN
							C_ACNT := '115511';  -- �ߺ�����(�����)
						ELSIF C_CONST_CLASS = '2' OR C_CONST_CLASS = '3' THEN
							C_ACNT := '742611';  -- �ߺ���(�����)
						ELSIF V_ORDER_CLASS = '2' THEN
							C_ACNT := '115331';  -- ���
						ELSE
							C_ACNT := '731111';  -- ���ֺ�(����)
						END IF;
					ELSIF C_CLASS_TAG = '10' THEN
						C_ACNT := '915118';  --���ϼ���(051004) C_ACNT := '915117';  -- ����ڻ�
					ELSIF V_ORDER_CLASS = '2' THEN
						C_ACNT := '115331';  -- ���
					ELSE
						C_ACNT := '731111';  -- ���ֺ�(����)
					END IF;

					y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,to_char(ad_date,'yyyy-mm') || '�� ���ֱ⼺',C_INVOICE,V_GL_DT,V_GL_DT,
													  V_SBCR_NAME,V_CUST_CODE,C_DR_AMT,C_CR_AMT,V_SBC_NAME || ' ���ֱ⼺',C_VATNAME,as_dept_code,
													  C_PROJ,1,C_ACNT,'211111',C_VENDOR_ID,C_VENDOR_SITE_ID,C_CASH,C_BILL,'ITEM','����',
														C_ORG_ID,'V',V_ORDER_NUMBER,V_BILL_PAY,C_WORK_DT,C_FOLDER,'',0);

			-- ���԰���OR���԰���OR���ԺҰ���(���õ� �ΰ����ڵ�� ����Ȱ��������� ������ ����)
					IF C_ACNTCODE = '112421' THEN
						y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,to_char(ad_date,'yyyy-mm') || '�� ���ֱ⼺',C_INVOICE,V_GL_DT,V_GL_DT,
														  V_SBCR_NAME,V_CUST_CODE,C_TEMP_VAT,C_CR_AMT,substr(V_SBC_NAME || ' ���ֱ⼺',1,50),C_VATNAME,as_dept_code,
														  C_PROJ,1,C_ACNT,'211111',C_VENDOR_ID,C_VENDOR_SITE_ID,C_CASH,C_BILL,'TAX','����',
															C_ORG_ID,'V',V_ORDER_NUMBER,V_BILL_PAY,C_WORK_DT,C_FOLDER,'',0);
					ELSE
						y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,to_char(ad_date,'yyyy-mm') || '�� ���ֱ⼺',C_INVOICE,V_GL_DT,V_GL_DT,
														  V_SBCR_NAME,V_CUST_CODE,C_TEMP_VAT,C_CR_AMT,substr(V_SBC_NAME || ' ���ֱ⼺',1,50),C_VATNAME,as_dept_code,
														  C_PROJ,1,C_ACNTCODE,'211111',C_VENDOR_ID,C_VENDOR_SITE_ID,C_CASH,C_BILL,'TAX','����',
															C_ORG_ID,'V',V_ORDER_NUMBER,V_BILL_PAY,C_WORK_DT,C_FOLDER,'',0);
					END IF;
				END IF;
				IF V_ORDER_CLASS = '2' THEN
					IF C_ACNTCODE = '112421' THEN
						C_DR_AMT := C_DR_AMT + C_TEMP_VAT;
					END IF;
					y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_PROJ_NAME || ' ���(������ü)',last_day(ad_yymm),V_GL_DT,
														C_PROJ_NAME,as_dept_code,C_DR_AMT,'','',as_dept_code,C_PROJ,'','711111',
														'���','����','','',C_FOLDER,'',C_ORG_ID,C_PROJ_NAME,V_SBC_NAME || ' (������ü)','V','','','','');
					y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_PROJ_NAME || ' ���(������ü)',last_day(ad_yymm),V_GL_DT,
														C_PROJ_NAME,as_dept_code,'',C_DR_AMT,'',as_dept_code,C_PROJ,'','115339',
														'���','����','','',C_FOLDER,'',C_ORG_ID,C_PROJ_NAME,V_SBC_NAME || ' (������ü)','V','','','','');
				END IF;

		
		--����⼺�� ��� ���꿩�� �����Ѵ� ����
		SELECT
			nvl(COUNT(*),0)
		INTO
			C_CLOSE_YN
		FROM
			s_cn_list a,
        	(
        	SELECT
        		B.DEPT_CODE, B.ORDER_NUMBER,
        		SUM(nvl(B.TM_PRGS,0)) TM_PRGS,
        		SUM(nvl(B.TM_PRGS_NOTAX,0)) TM_PRGS_NOTAX,
        		SUM(nvl(B.TM_PURCHASE_VAT,0)) TM_PURCHASE_VAT,
        		SUM(nvl(B.TM_VAT,0)) TM_VAT,
        		SUM(nvl(B.TM_PRE_TAX,0)) TM_PRE_TAX,
        		SUM(nvl(B.TM_PRE_NOTAX,0)) TM_PRE_NOTAX,
        		SUM(nvl(B.TM_PRE_VAT,0)) TM_PRE_VAT
        	FROM
        		S_PAY B
			WHERE
				B.DEPT_CODE = as_dept_code AND B.ORDER_NUMBER = V_ORDER_NUMBER
        	GROUP BY
        		B.DEPT_CODE, B.ORDER_NUMBER
        	) C
		WHERE
			A.DEPT_CODE = C.DEPT_CODE(+) AND A.ORDER_NUMBER = C.ORDER_NUMBER(+)
		AND A.DEPT_CODE = as_dept_code AND A.ORDER_NUMBER = V_ORDER_NUMBER
        AND 
        (
        	A.SUPPLY_AMT_TAX = nvl(C.TM_PRGS,0)
        AND A.SUPPLY_AMT_NOTAX = nvl(C.TM_PRGS_NOTAX,0)
        AND A.purchase_vat = nvl(C.TM_PURCHASE_VAT,0)
        AND A.vat = nvl(C.TM_VAT,0)
        AND A.safety_amt1 = nvl(C.TM_PRE_TAX,0)
        AND A.safety_amt2 = nvl(C.TM_PRE_NOTAX,0)
        AND A.previous_vat = nvl(C.TM_PRE_VAT,0)
        );
		IF C_CLOSE_YN > 0 THEN
			SELECT nvl(MAX(CHG_DEGREE),1) INTO C_CNT FROM S_CHG_CN_LIST WHERE DEPT_CODE = as_dept_code AND ORDER_NUMBER = V_ORDER_NUMBER;
			UPDATE S_CN_LIST SET close_tag  = 'Y' WHERE dept_code = as_dept_code AND order_number = V_ORDER_NUMBER;
			UPDATE S_CHG_CN_LIST SET close_tag  = 'Y' WHERE dept_code = as_dept_code AND order_number = V_ORDER_NUMBER AND chg_degree = C_CNT;
		END IF;
		--����⼺�� ��� ���꿩�� �����Ѵ� ����

	END LOOP;
	CLOSE DETAIL_CUR;

-- ��ġȭ���� Update �Ѵ�.
		y_sp_comm_slip_batch_flag(C_ORG_ID,'AP Invoice');

-- ������������Ȳ���̺� ��ǥ�����͹�ȣ�� Setting �Ѵ�.
		update s_pay
			set invoice_num = C_GROUP_ID
	    where dept_code = as_dept_code
			and yymm = ad_yymm
			and seq = ai_seq;

      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '���ֺ���ǥ���� ����! [Line No: 159]';
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
END y_sp_s_slip_prgs;
