 /* ============================================================================ */
/* �Լ��� : y_sp_f_slip_prerequest_as(ap,GL)                                     */
/* ��  �� : �ڱ�û��-�����û����ǥ ����(ǰ��������)                             */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ��������               ==> ad_fr_date(DATE)                          */
/*        : ��������               ==> ad_to_date(DATE)                          */
/*        : ���缱��ȣ             ==> ai_unq_num(NUMBER)                        */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2005.04.28                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_f_slip_prerequest_as (as_dept_code    IN   VARCHAR2,
																	 ad_fr_date		  IN   DATE ,
																	 ad_to_date		  IN   DATE ,
																	 as_wbs_code     IN   VARCHAR2,
																	 ai_unq_num      IN   NUMBER) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR1 IS
SELECT max(a.request_date),max(a.class)
  FROM f_preamt_request a,
		efin_invoice_header_itf c	 
 WHERE a.dept_code = as_dept_code
	AND a.invoice_num = c.invoice_group_id (+)
	AND a.request_date >= ad_fr_date
	AND a.request_date <= ad_to_date
	AND decode(c.complete_flag,null,'Y',decode(c.complete_flag,'3','Y',decode(c.complete_flag,'9',decode(c.relation_invoice_group_id,null,'N','Y'),'N'))) = 'Y'
	AND (a.cash_amt <> 0 OR a.bill_amt <> 0)
GROUP BY a.dept_code,a.request_date,a.class;
CURSOR DETAIL_CUR (V_RQST_DATE DATE, V_CLASS INTEGER ) IS
SELECT a.request_date,a.seq,a.cont,nvl(a.cash_amt,0),nvl(a.bill_amt,0),b.folder_id,a.acntcode,b.as_class
  FROM f_preamt_request a,
		 ( select max(folder_id) folder_id,max(dept_code) dept_code,max(as_class) as_class
			  from f_dept_account 
			 where dept_code = as_dept_code
				and wbs_code  = as_wbs_code) b,
		efin_invoice_header_itf c	 
 WHERE a.dept_code = b.dept_code(+)
	AND a.dept_code = as_dept_code
	AND a.wbs_code  = as_wbs_code
	AND a.invoice_num = c.invoice_group_id (+)
	AND a.request_date = V_RQST_DATE
	AND a.class = V_CLASS
	AND decode(c.complete_flag,null,'Y',decode(c.complete_flag,'3','Y',decode(c.complete_flag,'9',decode(c.relation_invoice_group_id,null,'N','Y'),'N'))) = 'Y'
	AND (a.cash_amt <> 0 OR a.bill_amt <> 0);
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
   V_RQST_DATE         DATE;
	V_CLASS             VARCHAR2(2);
	V_DATE              DATE;
	V_SEQ               INTEGER;
	V_CONT              VARCHAR2(100);
	V_CASH              NUMBER(20,5);
	V_BILL              NUMBER(20,5);
	V_FOLDER_ID         VARCHAR2(10);
	V_ACNTCODE          VARCHAR2(10);
	V_AS_CLASS          VARCHAR2(1);
	C_DATE              DATE;
	C_CUST_CODE         VARCHAR2(20);
	C_DEPT_NAME         VARCHAR2(50);
	C_CUST_TYPE         VARCHAR2(10);
	C_GROUP_ID          INTEGER;
	C_SEQ               INTEGER;
	C_AMT               NUMBER(20,5);
	C_DR_AMT            NUMBER(20,5);
	C_CR_AMT            NUMBER(20,5);
   C_CNT               NUMBER(20,5);  
	C_COMP_CODE         VARCHAR2(10);
	C_ORG_ID            VARCHAR2(10);
	C_ORG_NAME          VARCHAR2(100);
	C_INVOICE           VARCHAR2(50);
	C_TEMP              VARCHAR2(50);
	C_PROJ              VARCHAR2(10);
	C_VENDOR_ID         INTEGER;	
	C_VENDOR_SITE_ID    INTEGER;
	C_WORK_DT           VARCHAR2(10);
	C_FOLDER_ID         VARCHAR2(10);
	C_SOURCE           VARCHAR2(10);
	C_CF_DATE          DATE; --�����������
BEGIN
 BEGIN
-- ���庰 ������ڵ带 ������ �´�	
		select comp_code ,long_name
		  into C_COMP_CODE,C_DEPT_NAME
 		  from z_code_dept 
		 where dept_code = as_wbs_code;
		C_SOURCE := '�ڱ�û��';
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
-- ��ǥ���ڸ� ���Ѵ�...
	select to_char(last_day(ad_to_date),'yyyy.mm.dd')
	  into C_DATE
	  from dual;
	OPEN	DETAIL_CUR1;
	LOOP
		FETCH DETAIL_CUR1 INTO V_RQST_DATE,V_CLASS;
		EXIT WHEN DETAIL_CUR1%NOTFOUND;
	-- ��ǥ �����͹�ȣ�� ���Ѵ�.
		select efin_invoice_header_itf_s.nextval
		  into C_GROUP_ID
		  from dual;
	-- ���缱 ������ �����Ѵ�.
		y_sp_d_efin_invoice_copy(C_GROUP_ID,ai_unq_num,'A',last_day(ad_to_date));
	-- ���� ����� �ڸ� ���Ѵ�
		select to_date(ATTRIBUTE1)
		into C_CF_DATE
		from efin_invoice_header_itf
		where INVOICE_GROUP_ID = C_GROUP_ID;
	-- ��ǥ��ȣ�� ���ϱ����� TEMP
			SELECT '�ڱ�û��-' || to_char(C_DATE,'yymmdd') || '-'
			  INTO C_TEMP
			  FROM dual;
			SELECT C_TEMP || substrb(C_DEPT_NAME,1, 44 - lengthb(C_TEMP)) || '-'
			  INTO C_TEMP
			  FROM dual;
			C_WORK_DT := to_char(add_months(C_DATE,1),'YYYY.MM') || '.10';
		OPEN	DETAIL_CUR(V_RQST_DATE,V_CLASS);
		LOOP
			FETCH DETAIL_CUR INTO V_DATE,V_SEQ,V_CONT,V_CASH,V_BILL,V_FOLDER_ID,V_ACNTCODE,V_AS_CLASS;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
	-- ����ó ���̺� �ŷ�ó�� �����ϴ��� Check�Ͽ� ������� insert�Ѵ�.
					IF F_COMM_SLIP_CHECK_SUPPLIER(C_ORG_ID,as_wbs_code) = False THEN
	-- Interface���̺� �ŷ�ó�� �����Ѵ�.
						y_sp_comm_slip_supplier(C_COMP_CODE,C_DEPT_NAME,as_wbs_code,'�μ�(����)',as_wbs_code,'211111','','','','','');
					END IF;
			-- ����ó���̺��� vendor_id�� vendor_site_id�� �����´�
			--		select nvl(vendor_id,0),nvl(vendor_site_id,0)
			--		  into C_VENDOR_ID,C_VENDOR_SITE_ID
			--		  from efin_supplier_v
			--		 where org_id = C_ORG_ID
			--			and vat_registration_num = V_CUST_CODE; 
					IF V_ACNTCODE = '111131' THEN
						select max(folder_id) 
						  into C_FOLDER_ID
						  from f_dept_bonsa_account 
						 where dept_code = as_dept_code 
							and wbs_code = as_wbs_code;
						C_AMT := V_CASH + V_BILL;
						IF C_AMT < 0 THEN
							C_AMT := C_AMT * (-1);
						END IF;
					-- GL Interface ���̺� �ڷḦ �����Ѵ�.
						y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' �����û��',C_DATE,V_DATE,
														  C_DEPT_NAME,as_wbs_code,C_AMT,'','',as_wbs_code,
														  C_PROJ,'','111131','�����ȯ��','�ڱ�û��','','',C_FOLDER_ID,
														  '',C_ORG_ID,C_DEPT_NAME,V_CONT,'V',
														  '','','','');
						y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' �����û��',C_DATE,V_DATE,
														  C_DEPT_NAME,as_wbs_code,'',C_AMT,'',as_wbs_code,
														  C_PROJ,'','111114','�����ȯ��','�ڱ�û��','','',V_FOLDER_ID,
														  '',C_ORG_ID,C_DEPT_NAME,V_CONT,'V',
														  '','','','');
						y_sp_comm_slip_batch_flag(C_ORG_ID,'Journal');
					ELSE
						C_DR_AMT := V_CASH + V_BILL; -- �����ݾ�
						C_CR_AMT := C_DR_AMT; -- �뺯�ݾ�
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
						IF V_FOLDER_ID = Null THEN
							V_FOLDER_ID := C_COMP_CODE || '99999';
						END IF;
			-- AP Interface ���̺� �ڷḦ �����Ѵ�.
					-- y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' �����û��',C_INVOICE,V_DATE,V_DATE,
					--									  C_DEPT_NAME,as_wbs_code,C_DR_AMT,C_CR_AMT,V_CONT,'',as_wbs_code,
					--									  C_PROJ,0,'111114','211311',C_VENDOR_ID,C_VENDOR_SITE_ID,V_CASH,V_BILL,'ITEM',C_SOURCE,C_ORG_ID,'V','','',C_WORK_DT,V_FOLDER_ID,V_CONT);
					  y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' �����û��',C_INVOICE,C_CF_DATE,C_CF_DATE,
														  C_DEPT_NAME,as_wbs_code,C_DR_AMT,C_CR_AMT,V_CONT,'',as_wbs_code,
														  C_PROJ,0,'111114','211311',C_VENDOR_ID,C_VENDOR_SITE_ID,V_CASH,V_BILL,'ITEM',C_SOURCE,C_ORG_ID,'V','','',C_WORK_DT,V_FOLDER_ID,V_CONT);
					END IF;	
		-- �����û���������̺� ��ǥ�����͹�ȣ�� Setting �Ѵ�.
					update f_preamt_request
						set invoice_num = C_GROUP_ID
					 where dept_code = as_dept_code
						and request_date = V_DATE
						and seq = V_SEQ;
		END LOOP;
		CLOSE DETAIL_CUR;
	END LOOP;
	CLOSE DETAIL_CUR1;
-- ��ġȭ���� Update �Ѵ�.
	y_sp_comm_slip_batch_flag(C_ORG_ID,'AP Invoice');
	EXCEPTION
	WHEN others THEN
		  IF SQL%NOTFOUND THEN
			  e_msg      := '�����û����ǥ���� ����! [Line No: 159]';
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
END y_sp_f_slip_prerequest_as;
/
