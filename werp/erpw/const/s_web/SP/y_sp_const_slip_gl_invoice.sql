/* ============================================================================================== */
/* 함수명 : y_sp_const_slip_gl_invoice                                                             */
/* 기  능 : 전표발생시 인터페이스에 GL 자료를  생성시킨다.                                        */
/* ---------------------------------------------------------------------------------------------- */
/* 인  수 : 사업장코드                                     ==> as_comp_code (string)              */
/*        : 전표그룹아디                                   ==> ai_group_id(INTEGER)               */
/*        : 전표그룹명칭                                   ==> as_group_name(string)              */
/*        : 전표번호                                       ==> as_invoice_num(string)             */
/*        : 정산일자                                       ==> ad_invoice_dt(DATE)                */
/*        : 증빙일자(세금계산서)                           ==> ad_gl_dt(DATE)                     */
/*        : 거래처명                                       ==> as_vendor_name(string)             */
/*        : 사업자번호                                     ==> as_vendor_site_code(string)        */
/*        : 차변금액                                       ==> ai_dr_amt(NUMBER)                  */
/*        : 대변금액                                       ==> ai_cr_amt(NUMBER)                  */
/*        : 부가세명                                       ==> as_vat_name(string)                */
/*        : 현장코드                                       ==> as_dept_code(string)               */
/*        : 프로텍트코드                                   ==> as_proj_code(string)               */
/*        : 계산서건수                                     ==> ai_cnt(INTEGER)                    */
/*        : 차변계정과목                                   ==> as_dr_coa(string)                  */
/*        : Category Name(미지급,전도금정산,수입금,출고등) ==> as_category(string)                */
/*        : SOURCE Name(자재,외주,노무,자금청구)           ==> as_source(string)                  */
/*        : 부가세연결고리                                 ==> ai_tax_seq(INTEGER)                */
/*        : 부가세연결고리가 있는건('T')                   ==> as_tax_status(string)              */
/*        : SEGMENTS의 폴더값                              ==> as_folder(string)                  */
/* ===========================[ 변   경   이   력 ]============================================== */
/* 작성자 : 김동우                                                                                */
/* 작성일 : 2005.04.25                                                                            */
/* ============================================================================================== */
CREATE OR REPLACE PROCEDURE y_sp_const_slip_gl_invoice     (as_comp_code        IN VARCHAR2,
  																       ai_group_id         IN INTEGER,
  																       as_group_name       IN VARCHAR2,
  															          --as_invoice_num      IN VARCHAR2, --삭제 
  															          ad_invoice_dt       IN DATE,
   															      ad_gl_dt            IN DATE,
   															      as_vendor_name      IN VARCHAR2,
   															      as_vendor_site_code IN VARCHAR2,
   															      ai_dr_amt           IN NUMBER,
   															      ai_cr_amt           IN NUMBER,
   																   as_vat_name			  IN VARCHAR2,
   															      as_dept_code        IN VARCHAR2,
   														         as_proj_code        IN VARCHAR2,		
   															      ai_cnt              IN INTEGER,
   															      as_dr_coa           IN VARCHAR2,
   															      as_category         IN VARCHAR2,
   															      as_source           IN VARCHAR2,
   																   ai_tax_seq          IN INTEGER,
   															      as_tax_status       IN VARCHAR2,--이값은 무조건 null값넘기세요(삭제예정)
   																   as_folder           IN VARCHAR2,
                                                      as_h_data           IN VARCHAR2, --추가(분양-동호(8)+순번(3)+차수(2)'0102120300101')
                                                      as_org_id           IN VARCHAR2, --추가 
                                                      as_dept_name        IN VARCHAR2, --추가
                                                      as_desc             IN VARCHAR2,  --추가 (적요)
                                                      as_val_flag         IN VARCHAR2 DEFAULT 'C', --'V'공급자, 'C'고객 
                                                      as_fix_qty          IN NUMBER DEFAULT 0 ,-- 추가
                                                      as_st_dt            IN DATE DEFAULT NULL, -- 추가
                                                      as_end_dt           IN DATE DEFAULT NULL, -- 추가
                                                      as_reacnt           IN VARCHAR2 DEFAULT NULL -- 추가
                                                        ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	C_ORG_ID          VARCHAR2(10);
   C_CNT             INTEGER        DEFAULT 0;   
   C_UNQ_SEQ         INTEGER        DEFAULT 0;   
	C_REFERENCE1      VARCHAR2(100);
   C_REFERENCE4      VARCHAR2(100);
	C_SEGMENTS        VARCHAR2(100);
   C_DEPT_NAME       VARCHAR2(100);
   
   --
   C_H_DONG       VARCHAR2(4);
   C_H_HO         VARCHAR2(4);
   C_H_SEQ        INTEGER;
   C_H_DEGREE     VARCHAR2(2);
BEGIN
 BEGIN
   
   C_ORG_ID := as_org_id;
   C_DEPT_NAME := as_dept_name;
    
      SELECT efin_invoice_lines_itf_s.NEXTVAL
		  INTO C_UNQ_SEQ
		  FROM dual;       

		C_REFERENCE1 := as_comp_code || '-I-' || as_source || '-' || TO_CHAR(ad_invoice_dt,'yymm') ;
      C_REFERENCE4 := as_comp_code || '-' || as_category || '-' || C_DEPT_NAME || '-' || TO_CHAR(ad_invoice_dt,'yymmdd');
		C_SEGMENTS   := as_comp_code || '.' || as_dept_code || '.' || as_dr_coa || '.' || as_folder || '.' || as_proj_code;
      
      IF LENGTHB(C_REFERENCE4) > 100 THEN
         C_DEPT_NAME := SUBSTR(C_DEPT_NAME, 1, LENGTHB(C_DEPT_NAME) - (LENGTHB(C_REFERENCE4) - 100) );
         C_REFERENCE4 := as_comp_code || '-' || as_category || '-' || C_DEPT_NAME || '-' || TO_CHAR(ad_invoice_dt,'yymmdd');
      END IF; 
      
      --tax_status_code := NULL; --무조건 null값 FI 요청사항...(기존에 as_tax_status세팅) 
      
		INSERT INTO efin_invoice_lines_itf  
				( seq,batch_date,invoice_group_id,module_name,
				  set_of_books_id,accounting_date,currency_code,actual_flag,
				  user_je_category_name,user_je_source_name,entered_dr,entered_cr,accounted_dr,accounted_cr,
				  transaction_date,reference1,reference4,reference5,reference10,period_name,
				  concatenated_segments,status,attribute5,attribute6,attribute7,attribute8,attribute9,
              attribute10,attribute11,attribute13,attribute14,
				  attribute16,attribute17,attribute18,attribute19,tax_group_id,tax_status_code,
				  last_update_date,last_updated_by,last_update_login,creation_date,created_by, line_description, validation_flag,
				  attribute3)
		VALUES (C_UNQ_SEQ,TO_CHAR(SYSDATE,'yyyy-mm-dd'),ai_group_id,'GL',
				  '1',ad_invoice_dt,'KRW','A',
				  as_category,as_source,ai_dr_amt,ai_cr_amt,ai_dr_amt,ai_cr_amt,
				  ad_gl_dt,C_REFERENCE1,C_REFERENCE1,as_desc,as_desc,TO_CHAR(ad_invoice_dt,'MON-YY'),
				  C_SEGMENTS,'NEW',as_dept_code, as_fix_qty, as_st_dt, as_end_dt, as_reacnt,
              C_ORG_ID,as_vendor_site_code,C_UNQ_SEQ,as_vat_name,
				  ai_group_id,TO_CHAR(ad_gl_dt,'yyyy-mm-dd'),as_vendor_name, ai_cnt,ai_tax_seq,NULL,
				  TO_CHAR(SYSDATE,'yyyy-mm-dd'),1,1,TO_CHAR(SYSDATE,'yyyy-mm-dd'),1, as_desc, as_val_flag,as_fix_qty);
		
      EXCEPTION
      WHEN OTHERS THEN
           RAISE;
           /*IF SQL%NOTFOUND THEN
              e_msg      := '인터페이스 GL 생성 실패! [Line No: 159]'||TO_CHAR(SYSDATE,'yyyy-mm-dd')||'/'||C_ORG_ID||'/'||C_CNT;
              Wk_errflag := -20020;
              GOTO EXIT_ROUTINE;
           END IF;*/
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
       RAISE;
       --RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END y_sp_const_slip_gl_invoice;