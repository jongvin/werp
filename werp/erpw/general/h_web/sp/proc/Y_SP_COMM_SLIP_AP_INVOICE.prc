CREATE OR REPLACE PROCEDURE        "Y_SP_COMM_SLIP_AP_INVOICE" (as_comp_code        IN VARCHAR2,
 																	     ai_group_id         IN INTEGER,
																		  as_group_name       IN VARCHAR2,
																	     as_invoice_num      IN VARCHAR2,
																	     ad_invoice_dt       IN DATE,
																	     ad_gl_dt	          IN DATE,
																	     as_vendor_name      IN VARCHAR2,
																	     as_vendor_site_code IN VARCHAR2,
																	     ai_dr_amt           IN NUMBER,
																	     ai_cr_amt           IN NUMBER,
																	     as_desc             IN VARCHAR2,
																		  as_vat_name			 IN VARCHAR2,
																	     as_dept_code        IN VARCHAR2,
																        as_proj_code        IN VARCHAR2,		
																	     ai_cnt              IN INTEGER,
																	     as_dr_coa           IN VARCHAR2,
																	     as_cr_coa           IN VARCHAR2,
 																	     ai_vendor_id        IN INTEGER,
 																	     ai_vendor_site_id   IN INTEGER,
																		  ai_cash             IN NUMBER,
																		  ai_bill             IN NUMBER ,
																		  as_line             IN VARCHAR2,
																		  as_source           IN VARCHAR2,
                                                        as_org_id           IN VARCHAR2, --추가
                                                        as_val_flag         IN VARCHAR2 DEFAULT 'V', --'V'공급자, 'C'고객
                                                        as_const_no         IN VARCHAR2 DEFAULT NULL, -- 추가
                                                        as_dis_pay          IN VARCHAR2 DEFAULT NULL, -- 추가
                                                        as_hope_dt          IN DATE DEFAULT NULL, -- 추가
																		  as_folder           IN VARCHAR2 DEFAULT NULL, -- 추가
																		  as_desc1            IN VARCHAR2 DEFAULT NULL, -- 추가
																		  as_qty              IN NUMBER DEFAULT NULL -- 추가 
                                                        ) IS		-- as_source 추가: 업무구분 정의(예:인사-급여)
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_CNT          		 INTEGER        DEFAULT 0;   
	C_ORG_ID              VARCHAR2(10);
	C_LINE_ACCOUNTS       VARCHAR2(100);
	C_ACCTS_ACCOUNTS      VARCHAR2(100);
	C_DESC      VARCHAR2(100);
	C_SOURCE					 VARCHAR2(20);
BEGIN
 BEGIN

-- 현장의 사업장코드로 ORG-ID 를 구한다.
		C_ORG_ID := as_org_id;
    IF as_desc1 IS NULL THEN
      C_DESC := as_desc;
    ELSE
      C_DESC := as_desc1;
    END IF;
		IF as_folder IS NULL THEN
			C_LINE_ACCOUNTS  := as_comp_code || '.' || as_dept_code || '.' || as_dr_coa || '.' || as_comp_code || '99999.' || as_proj_code;
		ELSE
			C_LINE_ACCOUNTS  := as_comp_code || '.' || as_dept_code || '.' || as_dr_coa || '.' || as_folder || '.' || as_proj_code;
		END IF;
		C_ACCTS_ACCOUNTS := as_comp_code || '.' || as_dept_code || '.' || as_cr_coa || '.' || as_comp_code || '99999.' || as_proj_code;
		
		IF as_source IS NULL THEN
			C_SOURCE := 'ADD-ON';
		ELSE
		   C_SOURCE := as_source;
		END IF;		
		
		INSERT INTO efin_invoice_lines_itf  
				( seq,batch_date,org_id,invoice_group_id,
				  invoice_num,invoice_date,gl_date,vendor_name,vat_registration_num,
				  invoice_currency_code,invoice_amount,SOURCE,description,line_amount,line_dist_code_accounts,
				  line_tax_code,line_description,global_attribute1,terms_name,terms_id,payment_method_lookup_code,
				  accts_pay_code_accounts,vendor_id,vendor_site_id,status,last_update_date,
				  last_updated_by,last_update_login,creation_date,created_by,attribute3,attribute4 ,line_attribute1,
				  global_attribute_category,module_name, validation_flag ,attribute6,attribute7,attribute8,line_attribute10)
		SELECT efin_invoice_lines_itf_s.NEXTVAL,TO_CHAR(SYSDATE,'yyyy-mm-dd'),C_ORG_ID,ai_group_id,
				 as_invoice_num,ad_invoice_dt,ad_gl_dt,as_vendor_name,as_vendor_site_code,
				 'KRW',ai_cr_amt,C_SOURCE,as_desc,ai_dr_amt,C_LINE_ACCOUNTS,
				 as_vat_name,C_DESC,ai_cnt,'현금즉시지급',10000,'CHECK',
				 C_ACCTS_ACCOUNTS,ai_vendor_id,ai_vendor_site_id,'NEW',TO_CHAR(SYSDATE,'yyyy-mm-dd'),
				 '1','1',TO_CHAR(SYSDATE,'yyyy-mm-dd'),'1',ai_cash,ai_bill,as_line,
				 'JA.KR.APXINWKB.INVOICES','AP', as_val_flag,as_const_no,as_dis_pay,as_hope_dt,as_qty
		  FROM dual;

      EXCEPTION
      WHEN OTHERS THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '인터페이스 AP 생성 실패! [Line No: 159]'||SQLERRM||'/'||SQLCODE;
              Wk_errflag := -20020;
              GOTO EXIT_ROUTINE;
           END IF;
 END;
   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   <<EXIT_ROUTINE>>
   -- ENDING...[0.1] CURSOR CLOSE 재 확인 처리 !
   IF Wk_errflag = 0 THEN
      Wk_errmsg  := '';                        -- 사용자 정의 Error Message
      Wk_errflag := 0;                         -- 사용자 정의 Error Code
   ELSE
      Wk_errmsg := RTRIM(e_msg) || '/>';
      RAISE UserErr;
   END IF;
EXCEPTION
  WHEN UserErr       THEN
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END Y_Sp_Comm_Slip_Ap_Invoice;
/

