 /* ============================================================================ */
/* �Լ��� : y_sp_m_slip_mat_request(ap)                                          */
/* ��  �� : �������-�԰���ǥ ����                                               */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ���¾�ü�ڵ�           ==> as_date(DATE)        		               */
/*        : ���缱��ȣ             ==> ai_unq_num(NUMBER)                        */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2005.04.28                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_slip_mat_request (as_dept_code    IN   VARCHAR2,
																	 as_date         IN   DATE,
																	 ai_unq_num      IN   NUMBER) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT a.vat_unq_num,a.work_dt,a.yyyymmdd,a.cont,a.cash_amt,a.bill_amt,a.amt,a.vatamount,
		 decode(lengthb(b.businessman_number),13,substrb(b.businessman_number,1,6) || '-' || substrb(b.businessman_number,7,7),substrb(b.businessman_number,1,3) || '-' || substrb(b.businessman_number,4,2) || '-' || substrb(b.businessman_number,6,5)),
		 decode(lengthb(b.businessman_number),13,'����','�����'),b.sbcr_name,b.zip_number1,b.address1,
		 b.kind_bussinesstype,b.kinditem,b.rep_name1,b.bill_dis_pay,a.vatcode
  FROM m_vat a,
		 s_sbcr b,
		efin_invoice_header_itf c	 
 WHERE a.sbcr_code = b.sbcr_code
	AND a.dept_code = as_dept_code
	AND trunc(a.work_dt,'MM')= as_date
	AND a.codetag = 'T'
	AND a.amt <> 0
	AND a.invoice_num = c.invoice_group_id (+)
	AND decode(c.complete_flag,null,'Y',decode(c.complete_flag,'3','Y',decode(c.complete_flag,'9',decode(c.relation_invoice_group_id,null,'N','Y'),'N'))) = 'Y';

CURSOR DETAIL_CUR1 (V_VAT_UNQ INTEGER )IS
SELECT ditag,nvl(sum(amt),0),nvl(sum(vatamt),0),nvl(name,'') || nvl(ssize,''),nvl(sum(qty),0)
  FROM m_input_detail
 WHERE dept_code = as_dept_code
	AND vat_unq_num = V_VAT_UNQ
GROUP BY ditag,name,ssize;

-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   Wk_Chk              NUMBER(10,0) DEFAULT 0 ;
   WK_Chk_msg          VARCHAR2(100);

-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_VAT_UNQ           INTEGER;
	V_DATE              DATE;
	V_YYMMDD            DATE;
	V_CONT              VARCHAR2(100);
	V_CASH              NUMBER(20,5);
	V_BILL              NUMBER(20,5);
	V_AMT               NUMBER(20,5);
	V_VAT               NUMBER(20,5);
	V_CUST_CODE         VARCHAR2(20);
	V_CUST_TYPE         VARCHAR2(10);
	V_SBCR_NAME         VARCHAR2(50);
	V_ZIP               VARCHAR2(10);
	V_ADDR              VARCHAR2(100);
	V_UPTAE             VARCHAR2(20);
	V_UPJONG            VARCHAR2(30);
	V_TREADE            VARCHAR2(20);
	V_BILL_PAY          VARCHAR2(1);
	V_DITAG             VARCHAR2(1);
	V_AMT1              NUMBER(20,5);
	V_VAT1              NUMBER(20,5);
	V_CONT1             VARCHAR2(100);
	V_VATTAG            VARCHAR2(1);
	V_QTY               NUMBER(20,5);
	C_DEPT_NAME         VARCHAR2(50);
	C_GROUP_ID          INTEGER;
	C_SEQ               INTEGER;
	C_TEMP_LEN			  INTEGER;
	C_DR_AMT            NUMBER(20,5);
	C_CR_AMT            NUMBER(20,5);
   C_CHK_CNT           NUMBER(20,5);  
   C_CNT               NUMBER(20,5);  
	C_CASH_RT           NUMBER(20,5);  
	C_COMP_CODE         VARCHAR2(10);
	C_ORG_ID            VARCHAR2(10);
	C_ORG_NAME          VARCHAR2(100);
	C_INVOICE           VARCHAR2(100);
	C_TEMP              VARCHAR2(50);
	C_PROJ              VARCHAR2(10);
	C_VENDOR_ID         INTEGER;	
	C_VENDOR_SITE_ID    INTEGER;
	C_WORK_DT           VARCHAR2(10);
	C_FOLDER            VARCHAR2(10);
	C_SOURCE            VARCHAR2(10);
	C_ACNTCODE          VARCHAR2(8);
	C_DR_ACNTCODE       VARCHAR2(8);
	C_VATNAME           VARCHAR2(50);
	C_TMP_ACNT            VARCHAR2(10);
BEGIN
 BEGIN
-- ���庰 ������ڵ带 ������ �´�	
		select comp_code ,long_name
		  into C_COMP_CODE,C_DEPT_NAME
 		  from z_code_dept 
		 where dept_code = as_dept_code;
		C_SOURCE := '����';
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
	y_sp_d_efin_invoice_copy(C_GROUP_ID,ai_unq_num,'A',last_day(as_date));

	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_VAT_UNQ,V_DATE,V_YYMMDD,V_CONT,V_CASH,V_BILL,V_AMT,V_VAT,V_CUST_CODE,V_CUST_TYPE,
									V_SBCR_NAME,V_ZIP,V_ADDR,V_UPTAE,V_UPJONG,V_TREADE,V_BILL_PAY,V_VATTAG;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
			select count(*)
			  into C_CHK_CNT
			from (select max(dept_code)
						from m_input_detail
						where dept_code = as_dept_code
						and   vat_unq_num = V_VAT_UNQ
						group by ditag ) a;

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

		-- �ΰ�����,�ΰ������������ڵ带 ������ �´�.
				select acntcode
				  into C_ACNTCODE
				  from z_code_vatclass
				 where vattag = V_VATTAG;

				select tax_code_name_alt
				  into C_VATNAME
				  from efin_tax_codes_v
				 where org_code = C_COMP_CODE
					and account_code = C_ACNTCODE;
		-- �뺯�ݾ�
			C_CR_AMT := V_AMT + V_VAT;

-- ��ǥ��ȣ�� ���ϱ����� TEMP
			SELECT V_VAT_UNQ || '-����-' || to_char(V_YYMMDD,'yymmdd') || '-'
			  INTO C_TEMP
			  FROM dual;

			SELECT C_TEMP || substrb(C_DEPT_NAME,1, 44 - lengthb(C_TEMP)) || '-'
			  INTO C_TEMP
			  FROM dual;

			C_WORK_DT := to_char(add_months(V_DATE,1),'YYYY.MM') || '.10';
	-- ��ǥ��ȣ���ϱ�
			select nvl(substrb(max(invoice_num),lengthb(max(invoice_num)) - 2,3),0) + 1
			  into C_SEQ
			  from efin_invoice_lines_itf
			 where invoice_num like C_TEMP || '%';

			IF C_SEQ < 10 THEN
				C_INVOICE := C_TEMP || '00' || C_SEQ;
			ELSIF C_SEQ < 100 THEN
				C_INVOICE := C_TEMP || '0' || C_SEQ;
			ELSE
				C_INVOICE := C_TEMP || C_SEQ;
			END IF;

			OPEN	DETAIL_CUR1(V_VAT_UNQ);
			LOOP
				FETCH DETAIL_CUR1 INTO V_DITAG,V_AMT1,V_VAT1,V_CONT1,V_QTY;
				EXIT WHEN DETAIL_CUR1%NOTFOUND;

				C_TMP_ACNT := '';
				IF V_DITAG = '1' THEN  -- ���
					C_DR_ACNTCODE := '115331';
				END IF;
				IF V_DITAG = '2' THEN    -- ������
					C_DR_ACNTCODE := '115351';
				END IF;
				IF V_DITAG = '3' THEN    --�����ͱⱸ
					C_DR_ACNTCODE := '915090';
				END IF;
				IF V_DITAG = '4' THEN    -- �����ǰ
					C_DR_ACNTCODE := '915100';
					C_TMP_ACNT := '915100';
					IF V_VATTAG <> '3' THEN --�Ұ����� ��� �Ұ����� ǥ�� ��Ÿ �����ǰ�� �ΰ��������ڻ�
						C_ACNTCODE := '112417';
						select tax_code_name_alt
						  into C_VATNAME
						  from efin_tax_codes_v
						 where org_code = C_COMP_CODE
							and account_code = C_ACNTCODE;
					END IF;
				END IF;
				IF V_DITAG = '5' THEN    -- �Ҹ�ǰ��
					C_DR_ACNTCODE := '743619';
				END IF;
				IF V_DITAG = '6' THEN    -- ����������
					C_DR_ACNTCODE := '741319';
				END IF;
				IF V_DITAG = '7' THEN    -- �ߺ�����(�����)
					C_DR_ACNTCODE := '115511';
				END IF;
				IF V_DITAG = '8' THEN    -- �ߺ���(�����)
					C_DR_ACNTCODE := '742611';
				END IF;
				IF V_DITAG = '9' THEN    -- ����ڻ�
					C_DR_ACNTCODE := '915118'; --���ϼ���(051004) C_DR_ACNTCODE := '915117';
				END IF;

				IF V_VATTAG = '3' THEN
					C_ACNTCODE := C_DR_ACNTCODE;
				END IF;

	-- AP Interface ���̺� �ڷḦ �����Ѵ�.
				y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' ������û��',C_INVOICE,V_DATE,V_YYMMDD,
												  V_SBCR_NAME,V_CUST_CODE,V_AMT1,C_CR_AMT,V_CONT,C_VATNAME,as_dept_code,
												  C_PROJ,1,C_DR_ACNTCODE,'211111',C_VENDOR_ID,C_VENDOR_SITE_ID,V_CASH,V_BILL,'ITEM',
												  C_SOURCE,C_ORG_ID,'V',V_VAT_UNQ,V_BILL_PAY,C_WORK_DT,C_COMP_CODE || '99999',V_CONT1,V_QTY,C_TMP_ACNT);

				IF V_VATTAG = '3' and C_CHK_CNT > 1 THEN
					--y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' ������û��',C_INVOICE,V_DATE,V_YYMMDD,
					--								  V_SBCR_NAME,V_CUST_CODE,V_VAT1,C_CR_AMT,V_CONT,C_VATNAME,as_dept_code,
					--								  C_PROJ,1,C_ACNTCODE,'211111',C_VENDOR_ID,C_VENDOR_SITE_ID,V_CASH,V_BILL,'TAX',
					--								  C_SOURCE,C_ORG_ID,'V',V_VAT_UNQ,V_BILL_PAY,C_WORK_DT,C_COMP_CODE || '99999',C_VATNAME,V_QTY,C_TMP_ACNT);
					--������� ����
					y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' ������û��',C_INVOICE,V_DATE,V_YYMMDD,
													  V_SBCR_NAME,V_CUST_CODE,V_VAT1,C_CR_AMT,V_CONT,C_VATNAME,as_dept_code,
													  C_PROJ,1,C_ACNTCODE,'211111',C_VENDOR_ID,C_VENDOR_SITE_ID,V_CASH,V_BILL,'TAX',
													  C_SOURCE,C_ORG_ID,'V',V_VAT_UNQ,V_BILL_PAY,C_WORK_DT,C_COMP_CODE || '99999',V_CONT1,V_QTY,C_TMP_ACNT);
				END IF;
		END LOOP;
		CLOSE DETAIL_CUR1;
		IF V_VATTAG <> '3' or C_CHK_CNT = 1 THEN
	-- AP Interface ���̺� �ڷḦ �����Ѵ�.
			--y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' ������û��',C_INVOICE,V_DATE,V_YYMMDD,
			--								  V_SBCR_NAME,V_CUST_CODE,V_VAT,C_CR_AMT,V_CONT,C_VATNAME,as_dept_code,
			--								  C_PROJ,1,C_ACNTCODE,'211111',C_VENDOR_ID,C_VENDOR_SITE_ID,V_CASH,V_BILL,'TAX',
			--								  C_SOURCE,C_ORG_ID,'V',V_VAT_UNQ,V_BILL_PAY,C_WORK_DT,C_COMP_CODE || '99999',C_VATNAME,V_QTY,'');
			--������� ����
			y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' ������û��',C_INVOICE,V_DATE,V_YYMMDD,
											  V_SBCR_NAME,V_CUST_CODE,V_VAT,C_CR_AMT,V_CONT,C_VATNAME,as_dept_code,
											  C_PROJ,1,C_ACNTCODE,'211111',C_VENDOR_ID,C_VENDOR_SITE_ID,V_CASH,V_BILL,'TAX',
											  C_SOURCE,C_ORG_ID,'V',V_VAT_UNQ,V_BILL_PAY,C_WORK_DT,C_COMP_CODE || '99999',V_CONT1,V_QTY,'');
		END IF;

--�ڻ���
        y_sp_m_tmat_master(as_dept_code,as_date,V_VAT_UNQ);

-- ���̺� ��ǥ�����͹�ȣ�� Setting �Ѵ�.
			update m_vat
				set invoice_num = C_GROUP_ID,
					 codetag = 'F'
			 where dept_code = as_dept_code
				and vat_unq_num = V_VAT_UNQ;
	END LOOP;
	CLOSE DETAIL_CUR;
-- ��ġȭ���� Update �Ѵ�.
		y_sp_comm_slip_batch_flag(C_ORG_ID,'AP Invoice');

      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
			SELECT to_char(Wk_Chk) INTO WK_Chk_msg FROM DUAL;
              e_msg      := '���û����ǥ���� ����! [Line No: 159]' || WK_Chk_msg;
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
END y_sp_m_slip_mat_request;
