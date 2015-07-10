 /* ============================================================================ */
/* �Լ��� : y_sp_m_slip_output(gl)                  		                        */
/* ��  �� : �������-�����ǥ(������ü) ����                                     */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ���                   ==> as_date(DATE)        		               */
/*        : ���缱��ȣ             ==> ai_unq_num(NUMBER)                        */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2005.04.28                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_slip_output (as_dept_code    IN   VARCHAR2,
																	 as_date         IN   DATE,
																	 ai_unq_num      IN   NUMBER) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT a.vat_unq_num,a.work_dt,a.yyyymmdd,a.cont
  FROM m_output_slip a
 WHERE a.dept_code = as_dept_code
	AND trunc(a.work_dt,'MM')= as_date
	AND a.work_process = 'T';

CURSOR DETAIL_CUR1 (V_VAT_UNQ INTEGER )IS
SELECT NVL(SUM(amt),0) amt,NVL(SUM(vat_amt),0) vatamt,max(name) || max(ssize) cont1
  FROM m_output_detail 
 WHERE dept_code = as_dept_code
	AND vat_unq_num = V_VAT_UNQ
GROUP BY name,ssize;

-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_VAT_UNQ           INTEGER;
	V_DATE              DATE;
	V_YYMMDD            DATE;
	V_CONT              VARCHAR2(100);
	V_AMT               NUMBER(20,5);
	V_VAT               NUMBER(20,5);
	V_CONT1             VARCHAR2(100);
	C_DEPT_NAME         VARCHAR2(50);
	C_GROUP_ID          INTEGER;
	C_SEQ               INTEGER;
	C_DR_AMT            NUMBER(20,5);
	C_CR_AMT            NUMBER(20,5);
	C_TOT_AMT           NUMBER(20,5);
   C_CHK_CNT           NUMBER(20,5);  
   C_CNT               NUMBER(20,5);  
	C_CASH_RT           NUMBER(20,5);  
	C_COMP_CODE         VARCHAR2(10);
	C_ORG_ID            VARCHAR2(10);
	C_ORG_NAME          VARCHAR2(100);
	C_INVOICE           VARCHAR2(50);
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

	C_FOLDER := C_COMP_CODE || '99999';

	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_VAT_UNQ,V_DATE,V_YYMMDD,V_CONT;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
		
-- ����ó ���̺� �ŷ�ó�� �����ϴ��� Check�Ͽ� ������� insert�Ѵ�.
		IF F_COMM_SLIP_CHECK_SUPPLIER(C_ORG_ID,as_dept_code) = False THEN
-- Interface���̺� �ŷ�ó�� �����Ѵ�.
			y_sp_comm_slip_supplier(C_COMP_CODE,C_DEPT_NAME,as_dept_code,'�μ�(����)',as_dept_code,'211111','','','','','');
		END IF;
		-- ����ó���̺��� vendor_id�� vendor_site_id�� �����´�
		--		select nvl(vendor_id,0),nvl(vendor_site_id,0)
		--		  into C_VENDOR_ID,C_VENDOR_SITE_ID
		--		  from efin_supplier_v
		--		 where org_id = C_ORG_ID
		--			and vat_registration_num = V_CUST_CODE; 
		C_TOT_AMT := 0;
		OPEN	DETAIL_CUR1(V_VAT_UNQ);
		LOOP
			FETCH DETAIL_CUR1 INTO V_AMT,V_VAT,V_CONT1;
			EXIT WHEN DETAIL_CUR1%NOTFOUND;

			C_DR_ACNTCODE := '711111';
	-- �����ݾ�
			C_CR_AMT := V_AMT + V_VAT;
			C_TOT_AMT := C_TOT_AMT + C_CR_AMT;
	-- GL Interface ���̺� �ڷḦ �����Ѵ�.
			y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' ���(������ü)',last_day(as_date),last_day(as_date),
												C_DEPT_NAME,as_dept_code,C_CR_AMT,'','',as_dept_code,C_PROJ,'',C_DR_ACNTCODE,
												'���','����','','',C_FOLDER,'',C_ORG_ID,C_DEPT_NAME,V_CONT1,'V','','','','');

		END LOOP;
		CLOSE DETAIL_CUR1;

	-- GL Interface ���̺� �ڷḦ �����Ѵ�.
		y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' ���(������ü)',last_day(as_date),last_day(as_date),
											C_DEPT_NAME,as_dept_code,'',C_TOT_AMT,'',as_dept_code,C_PROJ,'','115339',
											'���','����','','',C_FOLDER,'',C_ORG_ID,C_DEPT_NAME,V_CONT,'V','','','','');

-- ���̺� ��ǥ�����͹�ȣ�� Setting �Ѵ�.
			update m_output_slip
				set invoice_num = C_GROUP_ID,
					 work_process = ''
			 where dept_code = as_dept_code
				and vat_unq_num = V_VAT_UNQ;
	END LOOP;
	CLOSE DETAIL_CUR;
-- ��ġȭ���� Update �Ѵ�.
		y_sp_comm_slip_batch_flag(C_ORG_ID,'Journal');

      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '���������ǥ���� ����! [Line No: 159]';
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
END y_sp_m_slip_output;
/

