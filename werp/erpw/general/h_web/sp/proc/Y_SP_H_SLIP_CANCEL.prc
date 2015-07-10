CREATE OR REPLACE PROCEDURE Y_Sp_H_Slip_Cancel (ai_save_num IN NUMBER,
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
            
    SELECT '1미수금대체' tag,
             a.dongho,
             a.seq,
		       a.contract_code,
		       a.chg_date,
		       a.cust_code,
             n.cust_name,
             b.degree_code,
             b.agree_date,
             SUM(b.sell_amt) sell_amt, 
             SUM(b.land_amt) land_amt,
		       SUM(b.build_amt) build_amt, 
             SUM(vat_amt) vat_amt,
             0 penalty,
             0 paid,
             0 sell
        FROM H_SALE_MASTER  a,
             H_SALE_AGREE b,
             H_SALE_ANNUL c,
             H_CODE_CUST n
       WHERE (LENGTH(trim(c.slip_no)) IS NULL OR             --전표생성 안？거나
              c.slip_no IN (SELECT invoice_group_id FROM v_invoice_reject WHERE dept_code = as_dept_code)  ---전표생성됐지만 (반송,취소)된거  
             )
         AND a.dept_code = b.dept_code(+)
		   AND a.sell_code = b.sell_code(+)
         AND a.dongho    = b.dongho(+)
		   AND a.seq       = b.seq(+)
         AND a.dept_code = c.dept_code
		   AND a.sell_code = c.sell_code
         AND a.dongho    = c.dongho
		   AND a.seq       = c.seq
		   AND a.dept_code = as_dept_code
		   AND a.sell_code = as_sell_code
		   AND a.chg_date  BETWEEN  ad_fr_date  AND  ad_to_date
         --AND b.agree_date <= :ad_to_date
         AND LENGTH(trim(b.work_no)) IS NOT  NULL
         AND a.cust_code = n.cust_code(+)
     GROUP BY a.dongho,
             a.seq,
		       a.contract_code,
		       a.chg_date,
		       a.cust_code,
             n.cust_name,
		       b.degree_code,
             b.agree_date
     
      UNION ALL    
         
      SELECT '2납입' tag,
             a.dongho,
             a.seq,
		       a.contract_code,
		       a.chg_date,
		       a.cust_code,
             n.cust_name,
		       '' degree_code,
             SYSDATE agree_date,
             0 sell_amt, 
             0 land_amt,
		       0 build_amt, 
             0 vat_amt,
             c.PENALTY,
             SUM( NVL(e.r_amt,0) ) paid,
             b.sell sell
        FROM H_SALE_MASTER  a,
             (SELECT dongho,
                     seq,
                     SUM(NVL(sell_amt,0)) sell
                FROM H_SALE_AGREE
               WHERE LENGTH(trim(work_no)) IS NOT  NULL
                 AND dept_code = as_dept_code
		           AND sell_code = as_sell_code
              GROUP BY dongho,
                     seq
             ) b,
             H_SALE_ANNUL c,
             H_SALE_INCOME e,
             H_CODE_CUST n
       WHERE (LENGTH(trim(c.slip_no)) IS NULL OR             --전표생성 안？거나
              c.slip_no IN (SELECT invoice_group_id FROM v_invoice_reject WHERE dept_code = as_dept_code)  ---전표생성됐지만 (반송,취소)된거  
             )
         AND a.dongho    = b.dongho
		   AND a.seq       = b.seq
         AND a.dept_code = c.dept_code
		   AND a.sell_code = c.sell_code
         AND a.dongho    = c.dongho
		   AND a.seq       = c.seq
         AND a.dept_code = e.dept_code(+)
		   AND a.sell_code = e.sell_code(+)
         AND a.dongho    = e.dongho(+)
		   AND a.seq       = e.seq(+)
         AND a.dept_code = as_dept_code
		   AND a.sell_code = as_sell_code
		   AND a.chg_date  BETWEEN  ad_fr_date  AND  ad_to_date
         AND e.degree_code <> '99'
         AND e.receipt_code <> '24'--해약환출 제외
         AND a.cust_code = n.cust_code(+)
     GROUP BY a.dongho,
             a.seq,
		       a.contract_code,
		       a.chg_date,
		       a.cust_code,
             n.cust_name,
             c.PENALTY,b.sell
     ORDER BY dongho, tag,
		       degree_code;
             
CURSOR detail_2 (vs_cust_code IN VARCHAR2) IS
  SELECT c.cust_name,
         c.cust_div,
         c.biz_status,
         c.biz_type,
         c.CUR_ZIP_CODE,
         c.CUR_ADDR1,
         c.CUR_ADDR2
    FROM H_CODE_CUST c
   WHERE c.cust_code = vs_cust_code;
       
     
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	
   rec_slip_master H_SALE_MASTER%ROWTYPE;
   rec_slip_agree H_SALE_AGREE%ROWTYPE;
   rec_slip_income H_SALE_INCOME%ROWTYPE;
   rec_slip_cust  H_CODE_CUST%ROWTYPE;
   v_degree_name  H_CODE_COMMON.code_name%TYPE;
   v_cust_type    VARCHAR2(10);
   
   v_penalty   H_SALE_AGREE.sell_amt%TYPE;
   v_paid      H_SALE_AGREE.sell_amt%TYPE;
   v_sell      H_SALE_AGREE.sell_amt%TYPE;
   v_unpaid    H_SALE_AGREE.sell_amt%TYPE;
   
   v_build_amt H_SALE_AGREE.sell_amt%TYPE;
   v_land_amt  H_SALE_AGREE.sell_amt%TYPE;
   v_vat_amt   H_SALE_AGREE.sell_amt%TYPE;
   v_sell_amt  H_SALE_AGREE.sell_amt%TYPE;
   v_dr_amt    H_SALE_AGREE.sell_amt%TYPE;
   v_cr_amt    H_SALE_AGREE.sell_amt%TYPE;
   v_acntcode  VARCHAR2(10);
   v_acntcode2  VARCHAR2(10);
   
   v_vatname   VARCHAR2(30);
   v_vat_cnt   NUMBER;
   v_tax_seq  NUMBER;
   v_tax_tag  VARCHAR2(1);
   v_cash     NUMBER;
   v_bill     NUMBER;
   
   C_TAG               VARCHAR2(20);
   C_DATE      DATE DEFAULT SYSDATE;
   C_INVOICE   VARCHAR2(100);              
   
   C_ACNTNO_PRE        VARCHAR2(50);                  --분양미수금(확정)아/상/오 
   C_ACNTNO_DUE        VARCHAR2(50);                  --분양선수금 -건물가/토지가
   C_ACNTNO_TX         VARCHAR2(50)  DEFAULT '211712';--매출과세(분양)     -부가세
   C_ACNTNO_BLL        VARCHAR2(50)  DEFAULT '211725';--분양선수금(계산서)
   C_ACNTNO_PEN        VARCHAR2(50)  DEFAULT '462517';--위약금
   C_ACNTNO_CLS        VARCHAR2(50)  DEFAULT '911050';      --가계정(해약)
   C_ACNTNO_PAY        VARCHAR2(50)  DEFAULT '211311';--미지급금   
   
   C_SOURCE            VARCHAR2(50)  DEFAULT '분양';
   C_CATEGORY          VARCHAR2(50)  DEFAULT '분양해약';
   
   C_DESC              VARCHAR2(50)  DEFAULT '해약';
   
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
   C_DESC1              VARCHAR2(100);
   C_CUST_CODE         VARCHAR2(20);
   C_C_TAG             BOOLEAN DEFAULT FALSE;
   C_V_TAG             BOOLEAN DEFAULT FALSE;
   C_CUST_CODE_SAVE    VARCHAR2(20);
   
BEGIN
 BEGIN
   BEGIN
      -- 현장별 사업장코드를 가지고 온다
      e_msg      := '분양구분별 선수금/미수금계정과목 미등록'||AS_DEPT_CODE||'/'||AS_SELL_CODE;
      SELECT ACNTNO_PRE, ACNTNO_DUE
		  INTO C_ACNTNO_PRE, C_ACNTNO_DUE
 		  FROM H_CODE_HOUSE 
		 WHERE dept_code = as_dept_code
         AND SELL_CODE = AS_SELL_CODE;
      
      IF LENGTH(trim(C_ACNTNO_PRE)) IS NULL OR LENGTH(trim(C_ACNTNO_DUE)) IS NULL THEN
         Wk_errflag := -20020;
         GOTO EXIT_ROUTINE;
      END IF;
      
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
      e_msg      := 'ORG_ID 미등록'||C_COMP_CODE;
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
      FETCH DETAIL_CUR INTO C_TAG, rec_slip_income.dongho, rec_slip_income.seq, 
                            rec_slip_master.contract_code, rec_slip_master.chg_date, 
                            rec_slip_cust.cust_code,     rec_slip_cust.cust_name,  
                            rec_slip_income.degree_code,   rec_slip_agree.agree_date,  
                            rec_slip_agree.sell_amt,       rec_slip_agree.land_amt,
                            rec_slip_agree.build_amt,      rec_slip_agree.vat_amt,
                            v_penalty, v_paid, v_sell;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
			
		c_h_data := trim(rec_slip_income.dongho)||trim(TO_CHAR(rec_slip_income.seq,'000'))||trim(rec_slip_income.degree_code);
      C_DESC1 := trim(rec_slip_income.dongho)||'-'||rec_slip_income.seq||'-'||rec_slip_cust.cust_name||'-'||rec_slip_income.degree_code;
      -- 공급처 테이블에 거래처가 존재하는지 Check하여 미존재시 insert한다.
      
      
      IF C_CUST_CODE_SAVE <> rec_slip_cust.cust_code AND LENGTH(TRIM(rec_slip_cust.cust_code)) IS NOT NULL THEN
         C_CUST_CODE_SAVE := rec_slip_cust.cust_code;
         IF NOT F_Comm_Slip_Check_Customer(C_ORG_ID, rec_slip_cust.cust_code) THEN
            OPEN detail_2(rec_slip_cust.cust_code);
            FETCH detail_2 INTO rec_slip_cust.cust_name, rec_slip_cust.cust_div,  
                               rec_slip_cust.biz_status, rec_slip_cust.biz_type,  
                               rec_slip_cust.CUR_ZIP_CODE, rec_slip_cust.CUR_ADDR1, 
                               rec_slip_cust.CUR_ADDR2;
            CLOSE detail_2;         
            -- Interface테이블에 고객을 생성한다.
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
		
		C_FOLDER_ID := C_COMP_CODE || '99999';
      
      v_build_amt := rec_slip_agree.build_amt;
      v_land_amt  := rec_slip_agree.land_amt;
      v_vat_amt   := rec_slip_agree.vat_amt;
      v_sell_amt  := rec_slip_agree.sell_amt;
      
      IF c_tag = '1미수금대체' THEN 
         ---------------------------------------------------------------------------------------
         --해약 전표 1번재라인
         ---------------------------------------------------------------------------------------
         SELECT gl_je_lines_s.NEXTVAL -- 부가세연결고리를 만든다
   	     INTO C_TAX_SEQ
   	     FROM dual;
   	   -- 부가세명,부가세계정과목코드를 가지고 온다.
   		SELECT tax_code_name_alt
   		  INTO C_VATNAME
   		  FROM efin_tax_codes_v
   		 WHERE org_code = C_COMP_CODE
   		   AND ACCOUNT_CODE = C_ACNTNO_TX;
         
         IF v_vat_amt <> 0 THEN
            v_dr_amt := v_build_amt; v_cr_amt := NULL;
         ELSE
            v_dr_amt := 0; v_cr_amt := NULL;
         END IF;
         v_vatname := C_VATNAME;
         v_vat_cnt := 1; --vatname 이 있으면 1 아니면 0 
         v_acntcode := C_ACNTNO_PRE;
         v_tax_seq  := C_TAX_SEQ; 
         v_tax_tag  := C_TAX_TAG;
         Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_master.chg_date,C_DATE,
                                   rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                   V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                   C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC1);
         ---------------------------------------------------------------------------------------
         --미수금 전표 2번재라인
         ---------------------------------------------------------------------------------------
         IF v_vat_amt <> 0 THEN
            v_dr_amt := v_vat_amt; v_cr_amt := NULL;
         ELSE
            v_dr_amt := 0; v_cr_amt := NULL;
         END IF;
         v_vatname := NULL;
         v_vat_cnt := 0; --vatname 이 있으면 1 아니면 0 
         v_acntcode := C_ACNTNO_TX;
         v_tax_seq  := C_TAX_SEQ; 
         v_tax_tag  := C_TAX_TAG;
         Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_master.chg_date,C_DATE,
                                   rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                   V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                   C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC1);
         ---------------------------------------------------------------------------------------
         --미수금 전표 3번재라인
         ---------------------------------------------------------------------------------------
         SELECT gl_je_lines_s.NEXTVAL -- 부가세연결고리를 만든다
   	     INTO C_TAX_SEQ
   	     FROM dual;
   	   -- 부가세명,부가세계정과목코드를 가지고 온다.
   		SELECT tax_code_name_alt
   		  INTO C_VATNAME
   		  FROM efin_tax_codes_v
   		 WHERE org_code = C_COMP_CODE
   		   AND ACCOUNT_CODE = C_ACNTNO_BLL;
         
         IF v_vat_amt <> 0 THEN
            v_dr_amt := v_land_amt; v_cr_amt := NULL;
         ELSE
            v_dr_amt := v_sell_amt; v_cr_amt := NULL;
         END IF;
         v_vatname := C_VATNAME;
         v_vat_cnt := 1; --vatname 이 있으면 1 아니면 0 
         v_acntcode := C_ACNTNO_PRE;
         v_tax_seq  := C_TAX_SEQ; 
         v_tax_tag  := C_TAX_TAG;
         Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name, rec_slip_master.chg_date,C_DATE,
                                   rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                   V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                   C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC1);
         ---------------------------------------------------------------------------------------
         --미수금 전표 4번재라인
         ---------------------------------------------------------------------------------------
         v_dr_amt := 0; v_cr_amt := NULL;
         
         v_vatname := NULL;
         v_vat_cnt := 0; --vatname 이 있으면 1 아니면 0 
         v_acntcode := C_ACNTNO_BLL;
         v_tax_seq  := C_TAX_SEQ; 
         v_tax_tag  := C_TAX_TAG;
         Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_master.chg_date,C_DATE,
                                   rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                   V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                   C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC1);
       
      ELSE
         ---------------------------------------------------------------------------------------
         --미수금 전표 5번재라인 분양미수금(대변)
         ---------------------------------------------------------------------------------------
         v_unpaid := v_sell - v_paid;
         v_dr_amt := NULL; v_cr_amt := v_unpaid;
         v_vatname := NULL;
         v_vat_cnt := 0;
         v_acntcode := C_ACNTNO_DUE;
         v_tax_seq  := NULL;
         v_tax_tag  := NULL;
         Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_master.chg_date,C_DATE,
                                   rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                   V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                   C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC1);
         
         ---------------------------------------------------------------------------------------
         --미수금 전표 6번재라인 위약금(대변)
         ---------------------------------------------------------------------------------------
         v_dr_amt := NULL; v_cr_amt := v_penalty;
         v_vatname := NULL;
         v_vat_cnt := 0;
         v_acntcode := C_ACNTNO_PEN;
         v_tax_seq  := NULL;
         v_tax_tag  := NULL;
         Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_master.chg_date,C_DATE,
                                   rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                   V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                   C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC1);
         
         ---------------------------------------------------------------------------------------
         --미수금 전표 7번재라인 Clearing(대변)
         ---------------------------------------------------------------------------------------
         v_dr_amt := NULL; v_cr_amt := v_paid - v_penalty;
         v_vatname := NULL;
         v_vat_cnt := 0;
         v_acntcode := C_ACNTNO_CLS;
         v_tax_seq  := NULL;
         v_tax_tag  := NULL;
         Y_Sp_Comm_Slip_Gl_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,rec_slip_master.chg_date,C_DATE,
                                   rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                   V_DR_AMT,V_CR_AMT,V_VATNAME,as_dept_code,C_PROJ,V_VAT_CNT,V_ACNTCODE,
                                   C_CATEGORY,C_SOURCE,V_TAX_SEQ,V_TAX_TAG,C_FOLDER_ID,C_H_DATA,C_ORG_ID, C_DEPT_NAME, C_DESC1);
         
         -----------------------------------------------------------------------------------------
         --
         ----------------------------------------------------------------------------------------
         ---------------------------------------
      --AP 가계정(해약) 미지급금(자산,부채)
      --------------------------------------
      /*SELECT gl_je_lines_s.NEXTVAL -- 부가세연결고리를 만든다
	     INTO C_TAX_SEQ
	     FROM dual;
	   -- 부가세명,부가세계정과목코드를 가지고 온다.
		SELECT tax_code_name_alt
		  INTO C_VATNAME
		  FROM efin_tax_codes_v
		 WHERE org_code = C_COMP_CODE
		   AND ACCOUNT_CODE = C_ACNTNO_CLS;*/
         
      IF NOT F_Comm_Slip_Check_Supplier(C_ORG_ID, rec_slip_cust.cust_code) THEN   
        --INTERFACE테이블에 거래처를 생성한다.
        IF rec_slip_cust.cust_div = '02' THEN
              v_cust_type := '법인';
        ELSE
           v_cust_type := '개인';
        END IF;
  		  Y_Sp_Comm_Slip_Supplier(C_COMP_CODE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                v_cust_type,as_dept_code,'211111',rec_slip_cust.cur_zip_code,rec_slip_cust.cur_ADDR1||' '||rec_slip_cust.cur_ADDR2,
                                rec_slip_cust.biz_status,rec_slip_cust.biz_type, rec_slip_cust.represent);
        IF c_v_tag THEN c_v_tag := TRUE; END IF ;
      END IF;
      
      -- 전표번호구하기
            C_TEMP := 'S'|| '-I-분양해약-' || as_dept_code || '-' || TO_CHAR(rec_slip_master.chg_date,'yymmdd') || '-';
				SELECT NVL(SUBSTRB(MAX(invoice_num),LENGTHB(MAX(invoice_num)) - 2,3),0) + 1
				  INTO C_SEQ
				  FROM efin_invoice_lines_itf
				 WHERE invoice_num LIKE C_TEMP || '%';
				IF C_SEQ < 10 THEN
					C_INVOICE := C_TEMP || '00' || C_SEQ;
				ELSE 
					IF C_SEQ < 100 THEN
						C_INVOICE := C_TEMP || '0' || C_SEQ;
					ELSE
						C_INVOICE := C_TEMP || C_SEQ;
					END IF;
				END IF;
	-- AP Interface 테이블에 자료를 생성한다.
		-- 공급가
            v_dr_amt := v_paid - v_penalty; v_cr_amt := v_paid - v_penalty;
            v_vatname := NULL;
            v_vat_cnt := 0;
            v_acntcode := C_ACNTNO_CLS;
            v_acntcode2 := C_ACNTNO_PAY;
            v_tax_seq  := NULL;
            v_tax_tag  := NULL;
            v_cash := v_dr_amt;
            v_bill := 0;
            Y_Sp_Comm_Slip_Ap_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,C_INVOICE,C_DATE,rec_slip_master.chg_date,
                                      rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                      V_DR_AMT,V_CR_AMT,C_DESC,V_VATNAME,as_dept_code, C_PROJ,1,V_ACNTCODE,V_ACNTCODE2,
                                      C_VENDOR_ID,C_VENDOR_SITE_ID,V_CASH,V_BILL,'ITEM', '분양해약', C_ORG_ID );
		
      
      -------------------------------------------------------                          
      
      END IF;
      
      
      UPDATE H_SALE_ANNUL
         SET slip_no = C_GROUP_ID, slip_date = C_DATE
       WHERE dept_code = as_dept_code
         AND sell_code = as_sell_code
         AND dongho    = rec_slip_income.dongho
         AND seq       = rec_slip_income.seq;
         
	END LOOP;
	CLOSE DETAIL_CUR;
   
   Y_Sp_Comm_Slip_Batch_Flag(C_ORG_ID, 'AP Invoice');
   IF C_C_TAG THEN Y_Sp_Comm_Slip_Batch_Flag(C_ORG_ID, 'Customer'); END IF;
   IF C_V_TAG THEN Y_Sp_Comm_Slip_Batch_Flag(C_ORG_ID, 'Supplier'); END IF;
   
      EXCEPTION
      WHEN OTHERS THEN
           RAISE;
           /*IF SQL%NOTFOUND THEN
              e_msg      := '미수금전표생성 실패! [Line No 159]';
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
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
  WHEN OTHERS THEN
       RAISE;
    
END Y_Sp_H_Slip_Cancel;
/

