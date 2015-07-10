 /* ============================================================================ */
/* �Լ��� : y_sp_m_slip_trans(gl)                  		                        */
/* ��  �� : �������-������ǥ ����                                               */
/* ----------------------------------------------------------------------------- */
/* ��  �� : �����ڵ�               ==> as_dept_code (string)                     */
/*        : ���                   ==> as_date(DATE)        		               */
/*        : �԰����               ==> ai_seq(INTEGER)        		               */
/*        : ���缱��ȣ             ==> ai_unq_num(NUMBER)                        */
/* ===========================[ ��   ��   ��   �� ]============================= */
/* �ۼ��� : �赿��                                                               */
/* �ۼ��� : 2005.08.02                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_slip_trans (as_dept_code    IN   VARCHAR2,
																	 as_date         IN   DATE,
																	 ai_seq          IN INTEGER, 
																	 ai_unq_num      IN   NUMBER) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT ditag,amt,name || ssize cont1
  FROM m_input_detail 
 WHERE dept_code = as_dept_code
	AND yymmdd= as_date
   AND seq = ai_seq;
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_DITAG             VARCHAR2(1);
	V_AMT               NUMBER(20,5);
	V_CONT              VARCHAR2(100);
	C_DEPT_CODE         VARCHAR2(10);
	C_DEPT_NAME1        VARCHAR2(50);
	C_DEPT_NAME2        VARCHAR2(50);
	C_GROUP_ID          INTEGER;
	C_SEQ               INTEGER;
   C_CNT               NUMBER(20,5);  
	C_AMT               NUMBER(20,5);
	C_COMP_CODE         VARCHAR2(10);
	C_ORG_ID            VARCHAR2(10);
	C_ORG_NAME          VARCHAR2(100);
	C_INVOICE           VARCHAR2(50);
	C_TEMP              VARCHAR2(50);
	C_PROJ1             VARCHAR2(10);
	C_PROJ2             VARCHAR2(10);
	C_WORK_DT           VARCHAR2(10);
	C_FOLDER            VARCHAR2(10);
	C_SOURCE            VARCHAR2(10);
	C_ACNTCODE          VARCHAR2(8);
	C_DR_ACNTCODE       VARCHAR2(8);
	C_VATNAME           VARCHAR2(50);
BEGIN
 BEGIN
-- ���庰 ������ڵ带 ������ �´�	
		select relative_proj_code
		  into C_DEPT_CODE
 		  from m_input 
		 WHERE dept_code = as_dept_code
			AND yymmdd= as_date
			AND seq = ai_seq;
		select comp_code ,long_name
		  into C_COMP_CODE,C_DEPT_NAME1
 		  from z_code_dept 
		 where dept_code = as_dept_code;
		select long_name
		  into C_DEPT_NAME2
 		  from z_code_dept 
		 where dept_code = C_DEPT_CODE;
		C_SOURCE := '����';
-- ���庰������Ʈ�ڵ带 ���Ѵ�.
		select a.proj_code
		  into C_PROJ1
		 from ( select a.dept_code,c.proj_code
			 		 from  z_code_dept a,
						  ( select proj_unq_key,step     
								from r_proj_view_business_form) b,
							r_proj c
				   where a.proj_unq_key = b.proj_unq_key
					  and b.proj_unq_key = c.proj_unq_key
					  and b.step = c.step ) a
		 where a.dept_code =  as_dept_code;  
		select a.proj_code
		  into C_PROJ2
		 from ( select a.dept_code,c.proj_code
			 		 from  z_code_dept a,
						  ( select proj_unq_key,step     
								from r_proj_view_business_form) b,
							r_proj c
				   where a.proj_unq_key = b.proj_unq_key
					  and b.proj_unq_key = c.proj_unq_key
					  and b.step = c.step ) a
		 where a.dept_code =  C_DEPT_CODE;  
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
		FETCH DETAIL_CUR INTO V_DITAG,V_AMT,V_CONT;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
-- ����ó ���̺� �ŷ�ó�� �����ϴ��� Check�Ͽ� ������� insert�Ѵ�.
		IF F_COMM_SLIP_CHECK_SUPPLIER(C_ORG_ID,as_dept_code) = False THEN
-- Interface���̺� �ŷ�ó�� �����Ѵ�.
			y_sp_comm_slip_supplier(C_COMP_CODE,C_DEPT_NAME1,as_dept_code,'�μ�(����)',as_dept_code,'211111','','','','','');
		END IF;
-- ����ó ���̺� �ŷ�ó�� �����ϴ��� Check�Ͽ� ������� insert�Ѵ�.
		IF F_COMM_SLIP_CHECK_SUPPLIER(C_ORG_ID,C_DEPT_CODE) = False THEN
-- Interface���̺� �ŷ�ó�� �����Ѵ�.
			y_sp_comm_slip_supplier(C_COMP_CODE,C_DEPT_NAME2,C_DEPT_CODE,'�μ�(����)',C_DEPT_CODE,'211111','','','','','');
		END IF;
		IF V_DITAG = '1' THEN
			C_DR_ACNTCODE := '115331';
		ELSE 
			C_DR_ACNTCODE := '115351';
		END IF;
-- �����ݾ�
		C_AMT := V_AMT * -1;
-- GL Interface ���̺� �ڷḦ �����Ѵ�.
		IF (C_AMT <> 0) THEN
			y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME2 || ' ����',last_day(as_date),as_date,
												C_DEPT_NAME2,C_DEPT_CODE,C_AMT,'','',C_DEPT_CODE,C_PROJ2,'',C_DR_ACNTCODE,
												'����','����','','',C_FOLDER,'',C_ORG_ID,C_DEPT_NAME2,V_CONT,'V','','','','');
			y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME1 || ' ����',last_day(as_date),as_date,
												C_DEPT_NAME1,as_dept_code,V_AMT,'','',as_dept_code,C_PROJ1,'',C_DR_ACNTCODE,
												'����','����','','',C_FOLDER,'',C_ORG_ID,C_DEPT_NAME1,V_CONT,'V','','','','');
		END IF;
	END LOOP;
	CLOSE DETAIL_CUR;
-- ���̺� ��ǥ�����͹�ȣ�� Setting �Ѵ�.
			update m_input
				set invoice_num = C_GROUP_ID
			 where dept_code = as_dept_code
				and yymmdd = as_date
				and seq = ai_seq;
-- ��ġȭ���� Update �Ѵ�.
		y_sp_comm_slip_batch_flag(C_ORG_ID,'Journal');
      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '����������ǥ���� ����! [Line No: 159]';
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
END y_sp_m_slip_trans;
/

