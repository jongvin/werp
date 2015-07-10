/* ============================================================================================== */
/* �Լ��� : y_sp_comm_slip_gl_invoice                                                             */
/* ��  �� : ��ǥ�߻��� �������̽��� GL �ڷḦ  ������Ų��.                                        */
/* ---------------------------------------------------------------------------------------------- */
/* ��  �� : ������ڵ�                                     ==> as_comp_code (string)              */
/*        : ��ǥ�׷�Ƶ�                                   ==> ai_group_id(INTEGER)               */
/*        : ��ǥ�׷��Ī                                   ==> as_group_name(string)              */
/*        : ��ǥ��ȣ                                       ==> as_invoice_num(string)             */
/*        : ��������                                       ==> ad_invoice_dt(DATE)                */
/*        : �߻�����                                       ==> ad_gl_dt(DATE)                     */
/*        : �ŷ�ó��                                       ==> as_vendor_name(string)             */
/*        : ����ڹ�ȣ                                     ==> as_vendor_site_code(string)        */
/*        : �����ݾ�                                       ==> ai_dr_amt(NUMBER)                  */
/*        : �뺯�ݾ�                                       ==> ai_cr_amt(NUMBER)                  */
/*        : �ΰ�����                                       ==> as_vat_name(string)                */
/*        : �����ڵ�                                       ==> as_dept_code(string)               */
/*        : ������Ʈ�ڵ�                                   ==> as_proj_code(string)               */
/*        : ��꼭�Ǽ�                                     ==> ai_cnt(INTEGER)                    */
/*        : ������������                                   ==> as_dr_coa(string)                  */
/*        : Category Name(������,����������,���Ա�,����) ==> as_category(string)                */
/*        : SOURCE Name(����,����,�빫,�ڱ�û��)           ==> as_source(string)                  */
/*        : �ΰ��������                                 ==> ai_tax_seq(INTEGER)                */
/*        : �ΰ���������� �ִ°�('T')                   ==> as_tax_status(string)              */
/*        : SEGMENTS�� ������                              ==> as_folder(string)                  */
/* ===========================[ ��   ��   ��   �� ]============================================== */
/* �ۼ��� : �赿��                                                                                */
/* �ۼ��� : 2005.04.25                                                                            */
/* ============================================================================================== */
CREATE OR REPLACE PROCEDURE y_sp_comm_slip_gl_invoice (as_comp_code        IN VARCHAR2,
 																	     ai_group_id         IN INTEGER,
																		  as_group_name       IN VARCHAR2,
																	     as_invoice_num      IN VARCHAR2,
																	     ad_invoice_dt       IN DATE,
																	     ad_gl_dt            IN DATE,
																	     as_vendor_name      IN VARCHAR2,
																	     as_vendor_site_code IN VARCHAR2,
																	     ai_dr_amt           IN NUMBER,
																	     ai_cr_amt           IN NUMBER,
																		  as_vat_name			 IN VARCHAR2,
																	     as_dept_code        IN VARCHAR2,
																        as_proj_code        IN VARCHAR2,		
																	     ai_cnt              IN INTEGER,
																	     as_dr_coa           IN VARCHAR2,
																	     as_category         IN VARCHAR2,
																	     as_source           IN VARCHAR2,
 																	     ai_tax_seq          IN INTEGER,
																	     as_tax_status       IN VARCHAR2,
																		  as_folder           IN VARCHAR2) IS
-------------------------------------------------------------
-- ��������
-------------------------------------------------------------
-- ���� ����
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	C_ORG_ID          VARCHAR2(10);
   C_CNT             INTEGER        DEFAULT 0;   
   C_UNQ_SEQ         INTEGER        DEFAULT 0;   
	C_REFERENCE1      VARCHAR2(100);
	C_SEGMENTS        VARCHAR2(100);
BEGIN
 BEGIN

-- ������ ������ڵ�� ORG-ID �� ���Ѵ�.
		select attribute1
		  into C_ORG_ID
		  from efin_corporations_v@crp
		 where corporation_code = as_comp_code;

		select efin_invoice_lines_itf_s.nextval@crp
		  into C_UNQ_SEQ
		  from dual;

		C_REFERENCE1 := as_comp_code || '-I-' || as_source || '-' || to_char(ad_gl_dt,'yymmdd') ;
		C_SEGMENTS   := as_comp_code || '.' || as_dept_code || '.' || as_dr_coa || '.' || as_folder || '.' || as_proj_code;

		INSERT INTO efin_gl_import_itf@crp  
				( seq,batch_date,invoice_group_id,approval_name,approval_num,
				  set_of_books_id,accounting_date,currency_code,actual_flag,
				  user_je_category_name,user_je_source_name,entered_dr,entered_cr,accounted_dr,accounted_cr,
				  transaction_date,reference1,reference4,reference5,period_name,
				  concatenated_segments,status,attribute10,attribute11,attribute13,attribute14,
				  attribute16,attribute17,attribute19,tax_group_id,tax_status_code,
				  last_update_date,last_updated_by,last_update_login,creation_date,created_by)
		VALUES (C_UNQ_SEQ,to_char(sysdate,'yyyy-mm-dd'),ai_group_id,as_group_name,ai_group_id,
				  '1',ad_invoice_dt,'KRW','A',
				  as_category,as_source,ai_dr_amt,ai_cr_amt,ai_dr_amt,ai_cr_amt,
				  ad_invoice_dt,C_REFERENCE1,as_invoice_num,as_dept_code,to_char(sysdate,'MON-YY'),
				  C_SEGMENTS,'NEW',C_ORG_ID,as_vendor_site_code,C_UNQ_SEQ,as_vat_name,
				  ai_group_id,to_char(ad_invoice_dt,'DD-MON-YY'),ai_cnt,ai_tax_seq,as_tax_status,
				  to_char(sysdate,'yyyy-mm-dd'),1,1,to_char(sysdate,'yyyy-mm-dd'),1);

		select NVL(COUNT(*),0)
		  into C_CNT
		  from efin_batch_flag@crp
		 where to_char(batch_date,'yyyy-mm-dd') = to_char(sysdate,'yyyy-mm-dd')
			and org_id = C_ORG_ID
			and batch_type = 'Journal' ;

		IF C_CNT = 0 THEN
			INSERT INTO efin_batch_flag@crp  
							( batch_date,org_id,batch_type,status,last_update_date,last_updated_by,last_update_login,
					  		  creation_date,created_by )  
				  VALUES ( to_date(sysdate,'yyyy-mm-dd'),C_ORG_ID,'Journal','1',sysdate,1,1,sysdate,1)  ;
		ELSE
			UPDATE efin_batch_flag@crp
			   SET last_update_date = sysdate
			 where to_char(batch_date,'yyyy-mm-dd') = to_char(sysdate,'yyyy-mm-dd')
				and org_id = C_ORG_ID
				and batch_type = 'Journal' ;
		END IF;

      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '�������̽� GL ���� ����! [Line No: 159]';
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
END y_sp_comm_slip_gl_invoice;
/

