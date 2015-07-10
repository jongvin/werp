 /* ============================================================================================= */
/* 함수명 : y_sp_comm_slip_ap_invoice                                                            */
/* 기  능 : 전표발생시 인터페이스에 AP 자료를  생성시킨다.                                        */
/* ---------------------------------------------------------------------------------------------- */
/* 인  수 : 사업장코드                                     ==> as_comp_code (string)              */
/*        : 전표그룹아디                                   ==> ai_group_id(INTEGER)               */
/*        : 전표그룹명칭                                   ==> as_group_name(string)              */
/*        : 전표번호                                       ==> as_invoice_num(string)             */
/*        : 송장일자                                       ==> ad_invoice_dt(DATE)                */
/*        : 회계일자                                       ==> ad_gl_dt(DATE)                     */
/*        : 거래처명                                       ==> as_vendor_name(string)             */
/*        : 사업자번호                                     ==> as_vendor_site_code(string)        */
/*        : 차변금액                                       ==> ai_dr_amt(NUMBER)                  */
/*        : 대변금액                                       ==> ai_cr_amt(NUMBER)                  */
/*        : 적요                                           ==> as_desc(string)                    */
/*        : 부가세명                                       ==> as_vat_name(string)                */
/*        : 현장코드                                       ==> as_dept_code(string)               */
/*        : 프로텍트코드                                   ==> as_proj_code(string)               */
/*        : 계산서건수                                     ==> ai_cnt(INTEGER)                    */
/*        : 차변계정과목                                   ==> as_dr_coa(string)                  */
/*        : 대변계정과목                                   ==> as_cr_coa(string)                  */
/*        : VENDOR_ID                                 	  ==> ai_vendor_id(INTEGER)              */
/*        : VENDOR_SITE_ID                                 ==> ai_vendor_site_id(INTEGER)         */
/*        : 현금                                       	  ==> ai_cash(NUMBER)                    */
/*        : 어음                                       	  ==> ai_bill(NUMBER)                    */
/*        : LINE-ATTRIBUER1                                ==> as_line(string)                    */
/*        : SOURCE			                                ==> as_source(string)                  */
/* ===========================[ 변   경   이   력 ]============================================== */
/* 작성자 : 김동우                                                                                */
/* 작성일 : 2005.04.25                                                                            */
/* ============================================================================================== */
CREATE OR REPLACE PROCEDURE y_sp_comm_slip_ap_invoice (as_comp_code        IN VARCHAR2,
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
																		  as_source           IN VARCHAR2) IS
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
	C_SOURCE					 VARCHAR2(20);
BEGIN
 BEGIN

-- 현장의 사업장코드로 ORG-ID 를 구한다.
		select attribute1
		  into C_ORG_ID
		  from efin_corporations_v@crp
		 where corporation_code = as_comp_code;

		C_LINE_ACCOUNTS  := as_comp_code || '.' || as_dept_code || '.' || as_dr_coa || '.' || as_comp_code || '99999.' || as_proj_code;
		C_ACCTS_ACCOUNTS := as_comp_code || '.' || as_dept_code || '.' || as_cr_coa || '.' || as_comp_code || '99999.' || as_proj_code;
		
		IF as_source = NULL THEN
			C_SOURCE := 'ADD-ON';
		ELSE
		   C_SOURCE := as_source;
		END IF;		
		
		INSERT INTO efin_ap_invoices_itf@crp  
				( seq,batch_date,org_id,invoice_group_id,approval_name,
				  approval_num,invoice_num,invoice_date,gl_date,vendor_name,vat_registration_num,
				  invoice_currency_code,invoice_amount,source,description,line_amount,line_dist_code_accounts,
				  line_tax_code,line_description,global_attribute1,terms_name,terms_id,payment_method_lookup_code,
				  accts_pay_code_accounts,vendor_id,vendor_site_id,status,last_update_date,
				  last_updated_by,last_update_login,creation_date,created_by,attribute3,attribute4 ,line_attribute1,
				  global_attribute_category )
		SELECT efin_invoice_lines_itf_s.nextval@crp,to_char(sysdate,'yyyy-mm-dd'),C_ORG_ID,ai_group_id,as_group_name,
				 ai_group_id,as_invoice_num,ad_invoice_dt,ad_gl_dt,as_vendor_name,as_vendor_site_code,
				 'KRW',ai_cr_amt,C_SOURCE,as_desc,ai_dr_amt,C_LINE_ACCOUNTS,
				 as_vat_name,as_desc,ai_cnt,'현금즉시지급',10000,'CHECK',
				 C_ACCTS_ACCOUNTS,ai_vendor_id,ai_vendor_site_id,'NEW',to_char(sysdate,'yyyy-mm-dd'),
				 '1','1',to_char(sysdate,'yyyy-mm-dd'),'1',ai_cash,ai_bill,as_line,
				 'JA.KR.APXINWKB.INVOICES'
		  from dual;

		select NVL(COUNT(*),0)
		  into C_CNT
		  from efin_batch_flag@crp
		 where to_char(batch_date,'yyyy-mm-dd') = to_char(sysdate,'yyyy-mm-dd')
			and org_id = C_ORG_ID
			and batch_type = 'AP Invoice' ;

		IF C_CNT = 0 THEN
			INSERT INTO efin_batch_flag@crp  
							( batch_date,org_id,batch_type,status,last_update_date,last_updated_by,last_update_login,
					  		  creation_date,created_by )  
				  VALUES ( to_date(sysdate,'yyyy-mm-dd'),C_ORG_ID,'AP Invoice','1',sysdate,1,1,sysdate,1)  ;
		ELSE
			UPDATE efin_batch_flag@crp
			   SET last_update_date = sysdate
			 where to_char(batch_date,'yyyy-mm-dd') = to_char(sysdate,'yyyy-mm-dd')
				and org_id = C_ORG_ID
				and batch_type = 'AP Invoice' ;
		END IF;

      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '인터페이스 AP 생성 실패! [Line No: 159]';
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
END y_sp_comm_slip_ap_invoice;
/


