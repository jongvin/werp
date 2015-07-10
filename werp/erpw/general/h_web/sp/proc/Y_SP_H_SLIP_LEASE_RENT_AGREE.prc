CREATE OR REPLACE PROCEDURE Y_Sp_H_Slip_Lease_Rent_Agree (ai_save_num IN NUMBER,
                                               as_approval_num IN VARCHAR2,
                                               as_approval_name IN VARCHAR2, 
                                               as_dept_code    IN   VARCHAR2,
                                               as_sell_code    IN   VARCHAR2,
															  ad_fr_date		  IN   DATE ,
															  ad_to_date		  IN   DATE ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
              
      
SELECT a.cont_date,
             a.cont_seq,
		       a.cont_type,
		       b.degree_code,
             b.agree_date,
             --b.receipt_date,
             --bank.folder_code,  
             a.cust_code,
		       c.cust_name,
             c.cust_div,
             c.biz_status,
             c.biz_type,
             c.CUR_ZIP_CODE,
             c.CUR_ADDR1,
             c.CUR_ADDR2,
		       d.code_name,
		       SUM(b.rent_amt)  rent_amt,
             SUM(b.rent_supply)  rent_supply,
		       SUM(b.rent_vat)  rent_vat
		       
		  FROM H_LEASE_MASTER a,
		       H_LEASE_RENT_AGREE b,
		       H_CODE_CUST   c,
             H_CODE_COMMON d
             --(SELECT bank_account_number, folder_code 
             --   FROM efin_internal_bank_account_v ) bank
		 WHERE a.dept_code = b.dept_code
		   AND a.sell_code = b.sell_code
		   AND a.cont_date    = b.cont_date
		   AND a.cont_seq       = b.cont_seq
		   AND a.cust_code = c.cust_code (+)
         AND b.degree_code = d.code (+)
         AND d.code_div (+)   = '02'
		   AND a.dept_code = as_dept_code
		   AND a.sell_code = as_sell_code
         AND b.agree_date  BETWEEN ad_fr_date AND ad_to_date
		   --AND b.receipt_date  BETWEEN ad_fr_date AND ad_to_date
		   AND a.exp_tag = 'N' --계약자
         
         --AND REPLACE(b.deposit_no,'-','') = bank_account_number(+)
         
		 GROUP BY a.cont_date,
             a.cont_seq,
		       a.cont_type,
		       
             --bank.folder_code,
             b.degree_code,
             b.agree_date,
		       a.cust_code,
		       c.cust_name,
             c.cust_div,
             c.biz_status,
             c.biz_type,
             c.CUR_ZIP_CODE,
             c.CUR_ADDR1,
             c.CUR_ADDR2,
		       d.code_name
		 HAVING  SUM(b.rent_amt) <> 0 
		
   ORDER BY  a.cont_date,
             a.cont_seq,
		       a.cont_type,
		       b.degree_code;    
     
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	
   rec_slip_lease_master H_LEASE_MASTER%ROWTYPE;
   rec_slip_rent_agree   H_LEASE_RENT_AGREE%ROWTYPE;
   rec_slip_cust  H_CODE_CUST%ROWTYPE;
   v_tag               VARCHAR2(10);
   v_degree_name  H_CODE_COMMON.code_name%TYPE;
   v_cust_type    VARCHAR2(10);
   
   v_rent_amt    H_LEASE_GRT_INCOME.r_amt%TYPE;
   v_rent_supply H_LEASE_GRT_INCOME.r_amt%TYPE;
   v_rent_vat    H_LEASE_GRT_INCOME.r_amt%TYPE;
   v_dr_amt    H_LEASE_GRT_INCOME.r_amt%TYPE;
   v_cr_amt    H_LEASE_GRT_INCOME.r_amt%TYPE;
   v_acntcode  VARCHAR2(10);
   
   v_vatname   VARCHAR2(30);
   v_vat_cnt   NUMBER;
   v_tax_seq  NUMBER;
   v_tax_tag  VARCHAR2(1);
   
   C_DATE      DATE DEFAULT SYSDATE;              
   
   C_ACNTNO_ACC        VARCHAR2(50)  DEFAULT '111131';--보통예금(원화)
   C_ACNTNO_RNT        VARCHAR2(50)  DEFAULT '111811';--미수금(임대료)
   C_ACNTNO_RIN        VARCHAR2(50)  DEFAULT '411311';--임대수익
   C_ACNTNO_RVT        VARCHAR2(50)  DEFAULT '211713';--매출과세(임대)
   
   C_SOURCE            VARCHAR2(50)  DEFAULT '임대';
   C_CATEGORY          VARCHAR2(50)  DEFAULT '월임대료(청구)';
   
	C_H_DATA            VARCHAR2(30);
   C_GROUP_ID          INTEGER;
	C_SEQ               INTEGER;
	C_CASH_RT           NUMBER(20,5);
	C_TEMP_VAT          NUMBER(20,5);
   C_CNT               NUMBER(20,5);  --
	C_COMP_CODE         VARCHAR2(10);
	C_ORG_ID            VARCHAR2(10);
	C_ORG_NAME          VARCHAR2(100);
	C_TEMP              VARCHAR2(50);
	C_PROJ              VARCHAR2(10);
	C_ACNTCODE          VARCHAR2(10);
	C_VATNAME           VARCHAR2(50);
	C_TEMP_VATNAME      VARCHAR2(50);
	C_DEPT_NAME         VARCHAR2(50);
	C_VENDOR_ID         INTEGER;	
	C_VENDOR_SITE_ID    INTEGER;
	C_TAX_SEQ           INTEGER;	
	C_TAX_TAG           VARCHAR2(1) DEFAULT 'T';
	C_CUST_CODE         VARCHAR2(20);
	C_CUST_NAME         VARCHAR2(50);
	C_FOLDER_ID         VARCHAR2(10);
   C_FOLDER_CODE       VARCHAR2(10);
   C_DESC              VARCHAR2(100);
   C_C_TAG             BOOLEAN DEFAULT FALSE;
   C_V_TAG             BOOLEAN DEFAULT FALSE;
   C_CUST_CODE_SAVE    VARCHAR2(20);
BEGIN
 BEGIN
   BEGIN
      
      
      -- 현장별 사업장코드를 가지고 온다
      e_msg      := '공통 현장코드 미등록(Z_CODE_DEPT)-'||AS_DEPT_CODE;
      SELECT comp_code ,long_name
		  INTO C_COMP_CODE,C_DEPT_NAME
 		  FROM Z_CODE_DEPT 
		 WHERE dept_code = as_dept_code;
      
       
      -- 현장별프로젝트코드를 구한다.
      e_msg      := '프로젝트코드 미등록(R_PROJ)-'||AS_DEPT_CODE;
		SELECT b.proj_code
        INTO C_PROJ
        FROM Z_CODE_DEPT a,
             r_proj_view_business_form  b
       WHERE a.proj_unq_key = b.proj_unq_key
         AND a.dept_code = as_dept_code;
      
      IF LENGTH(trim(C_PROJ)) IS NULL THEN
         Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      END IF;
      
      -- 현장의 사업장코드로 ORG-ID 를 구한다.
		SELECT attribute1
		  INTO C_ORG_ID
		  FROM efin_corporations_v
		 WHERE corporation_code = C_COMP_CODE;
      
   EXCEPTION 
      WHEN NO_DATA_FOUND THEN
       Wk_errflag := -20020;
       GOTO EXIT_ROUTINE;
   END;
     
   -- 전표 마스터번호를 구한다.(임시 전산결재 시 생성되면 parameter로 전송받음.)
	SELECT efin_invoice_header_itf_s.NEXTVAL
	  INTO C_GROUP_ID
	  FROM dual;
   --c_group_id := as_group_id  
   
   -- 결재선 정보를 저장한다.
   e_msg      := 'EFIN_INVOICE_HEADER_ITF Insert 실패 '||C_GROUP_ID||','||ai_save_num||','||'A';
	Y_Sp_D_Efin_Invoice_Copy(C_GROUP_ID,ai_save_num,'A',ad_to_date);
      
	OPEN	DETAIL_CUR;
	LOOP
      FETCH DETAIL_CUR INTO rec_slip_rent_agree.cont_date, rec_slip_rent_agree.cont_seq, 
                            rec_slip_lease_master.cont_type, rec_slip_rent_agree.degree_code,rec_slip_rent_agree.agree_date,  
                            rec_slip_cust.cust_code, rec_slip_cust.cust_name, rec_slip_cust.cust_div, 
                            rec_slip_cust.biz_status, rec_slip_cust.biz_type, rec_slip_cust.cur_zip_code, 
                            rec_slip_cust.cur_addr1, rec_slip_cust.cur_addr2, v_degree_name, 
                            rec_slip_rent_agree.rent_amt, rec_slip_rent_agree.rent_supply, rec_slip_rent_agree.rent_vat;
                            --V_DATE,V_SEQ,V_CONT,V_ACNTCODE,V_VATCODE,V_AMT,V_VAT,V_TAX_AMT,V_CUST_CODE,V_CUST_TYPE,
									 --V_SBCR_NAME,V_ZIP,V_ADDR,V_UPTAE,V_UPJONG,V_TREADE,V_FOLDER_ID;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
			
		c_h_data := trim(TO_CHAR(rec_slip_rent_agree.cont_date,'yyyymm'))||trim(TO_CHAR(rec_slip_rent_agree.cont_seq,'000'))||trim(rec_slip_rent_agree.degree_code);
      C_DESC := trim(TO_CHAR(rec_slip_rent_agree.cont_date,'yyyymm'))||'-'||trim(TO_CHAR(rec_slip_rent_agree.cont_seq,'00'))||'-'||rec_slip_cust.cust_name||'-'||trim(rec_slip_rent_agree.agree_date)||'임대료청구';
      
      -- 고객 테이블에 거래처가 존재하는지 Check하여 미존재시 insert한다.
  		
      IF C_CUST_CODE_SAVE <> rec_slip_cust.cust_code AND LENGTH(TRIM(rec_slip_cust.cust_code)) IS NOT NULL THEN
         C_CUST_CODE_SAVE := rec_slip_cust.cust_code;
         IF NOT F_Comm_Slip_Check_Customer(C_ORG_ID, rec_slip_cust.cust_code) THEN 
            IF rec_slip_cust.cust_div = '02' THEN
                  v_cust_type := '법인';
            ELSE
               v_cust_type := '개인';
            END IF; 
            Y_Sp_Comm_Slip_Customer(C_COMP_CODE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                    V_CUST_TYPE,as_dept_code,rec_slip_cust.cur_zip_code,rec_slip_cust.cur_ADDR1,rec_slip_cust.cur_ADDR2,
                                    rec_slip_cust.biz_status,rec_slip_cust.biz_type);
            IF NOT C_C_TAG THEN C_C_TAG := TRUE; END IF;
         END IF;
      END IF;
      
		-- 공급처테이블에서 vendor_id와 vendor_site_id를 가져온다
		--		select nvl(vendor_id,0),nvl(vendor_site_id,0)
		--		  into C_VENDOR_ID,C_VENDOR_SITE_ID
		--		  from efin_supplier_v
		--		 where org_id = C_ORG_ID
		--			and vat_registration_num = V_CUST_CODE; 
		
      
      v_rent_amt     := rec_slip_rent_agree.rent_amt;
      v_rent_supply  := rec_slip_rent_agree.rent_supply;
      v_rent_vat     := rec_slip_rent_agree.rent_vat;
      
      ---------------------------------------------------------------------------------------
      --수입금 전표 1번째라인
      ---------------------------------------------------------------------------------------
      v_dr_amt := v_rent_amt; v_cr_amt := NULL;
      v_vatname := NULL;
      v_vat_cnt := 0;
      v_acntcode := C_ACNTNO_RNT;
      v_tax_seq  := NULL;
      v_tax_tag  := NULL;
      C_FOLDER_ID := C_COMP_CODE || '99999';
      Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_rent_agree.agree_date,
                                C_DATE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC);
      ---------------------------------------------------------------------------------------
      --미수금 전표 2번재라인
      ---------------------------------------------------------------------------------------
      SELECT gl_je_lines_s.NEXTVAL -- 부가세연결고리를 만든다
	     INTO C_TAX_SEQ
	     FROM dual;
	   -- 부가세명,부가세계정과목코드를 가지고 온다.
		SELECT tax_code_name_alt
		  INTO C_VATNAME
		  FROM efin_tax_codes_v
		 WHERE org_code = C_COMP_CODE
		   AND ACCOUNT_CODE = C_ACNTNO_RVT;
      
      IF v_rent_vat <> 0 THEN
         v_dr_amt := NULL; v_cr_amt := v_rent_supply;
      ELSE
         v_dr_amt := NULL; v_cr_amt := 0;
      END IF;
      v_vatname := C_VATNAME;
      v_vat_cnt := 1; --vatname 이 있으면 1 아니면 0 
      v_acntcode := C_ACNTNO_RIN;
      v_tax_seq  := C_TAX_SEQ; 
      v_tax_tag  := C_TAX_TAG;
      Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_rent_agree.agree_date,
                                C_DATE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC);
      ---------------------------------------------------------------------------------------
      --미수금 전표 3번재라인
      ---------------------------------------------------------------------------------------
      IF v_rent_vat <> 0 THEN
         v_dr_amt := NULL; v_cr_amt := v_rent_vat;
      ELSE
         v_dr_amt := NULL; v_cr_amt := 0;
      END IF;
      v_vatname := NULL;
      v_vat_cnt := 0; --vatname 이 있으면 1 아니면 0 
      v_acntcode := C_ACNTNO_RVT;
      v_tax_seq  := C_TAX_SEQ; 
      v_tax_tag  := C_TAX_TAG;
      Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_rent_agree.agree_date,
                                C_DATE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC);
         
      
       				
	-- 수입금테이블에 전표마스터번호를 Setting 한다.
	/*		UPDATE F_PROFIT_DETAIL
				SET invoice_num = C_GROUP_ID
			 WHERE dept_code = as_dept_code
				AND inst_date = V_DATE
				AND slip_spec_unq_num = V_SEQ;
   */
	END LOOP;
	CLOSE DETAIL_CUR;
   
   Y_Sp_Comm_Slip_Batch_Flag(C_ORG_ID, 'Journal');
   IF C_C_TAG THEN Y_Sp_Comm_Slip_Batch_Flag(C_ORG_ID, 'Customer'); END IF;
   
      EXCEPTION
      WHEN OTHERS THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '임대계약전표생성 실패! [Line No 159]';
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
  WHEN OTHERS THEN
       RAISE;
    
END Y_Sp_H_Slip_Lease_Rent_Agree;
/

