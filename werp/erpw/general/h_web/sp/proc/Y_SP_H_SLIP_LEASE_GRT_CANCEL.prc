CREATE OR REPLACE PROCEDURE Y_Sp_H_Slip_Lease_Grt_Cancel (ai_save_num IN NUMBER,
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
           a.exp_date,
             a.cont_seq,
		       a.cont_type,
		       b.degree_code,
             b.receipt_date,
             a.cust_code,
		       c.cust_name,
             c.cust_div,
             c.biz_status,
             c.biz_type,
             c.CUR_ZIP_CODE,
             c.CUR_ADDR1,
             c.CUR_ADDR2,
		       d.code_name,
		       SUM(b.delay_amt)     delay_amt,
		       SUM(b.discount_amt)  discount_amt,
		       SUM(b.r_amt + b.delay_amt - b.discount_amt)  sell_amt
		  FROM H_LEASE_MASTER a,
		       H_LEASE_GRT_INCOME  b,
		       H_CODE_CUST   c,
             H_CODE_COMMON d
		 WHERE a.dept_code = b.dept_code
		   AND a.sell_code = b.sell_code
		   AND a.cont_date    = b.cont_date
		   AND a.cont_seq       = b.cont_seq
		   AND a.cust_code = c.cust_code (+)
         AND b.degree_code = d.code (+)
         AND d.code_div    = '02'
		   AND a.dept_code = as_dept_code
		   AND a.sell_code = as_sell_code
		   AND b.receipt_date  BETWEEN ad_fr_date AND ad_to_date
		   AND a.exp_tag = 'Y' --해약자
         AND b.degree_seq  < '70'
         
		 GROUP BY a.cont_date,
           a.exp_date,
             a.cont_seq,
		       a.cont_type,
		       b.degree_code,
             b.receipt_date,
             a.cust_code,
		       c.cust_name,
             c.cust_div,
             c.biz_status,
             c.biz_type,
             c.CUR_ZIP_CODE,
             c.CUR_ADDR1,
             c.CUR_ADDR2,
		       d.code_name
		 HAVING  SUM(b.r_amt) <> 0 OR SUM(b.delay_amt) <> 0 OR SUM(b.discount_amt) <> 0
		
   ORDER BY  a.cont_date,
             a.cont_seq,
		       a.cont_type,
		       b.degree_code,
             b.receipt_date;    
     
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	
   rec_slip_lease_master H_LEASE_MASTER%ROWTYPE;
   rec_slip_grt_income H_LEASE_GRT_INCOME%ROWTYPE;
   rec_slip_cust  H_CODE_CUST%ROWTYPE;
   v_degree_name  H_CODE_COMMON.code_name%TYPE;
   v_cust_type    VARCHAR2(10);
   
   
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
   
   C_ACNTNO_GRT        VARCHAR2(50)  DEFAULT '251511';--임대보증금
   C_ACNTNO_PAY        VARCHAR2(50)  DEFAULT '211311';--미지급금   
   
   C_SOURCE            VARCHAR2(50)  DEFAULT '임대';
   C_CATEGORY          VARCHAR2(50)  DEFAULT '임대환출';
   
   C_DESC              VARCHAR2(50)  DEFAULT '임대환출';
   
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
   C_C_TAG             BOOLEAN DEFAULT FALSE;
   C_V_TAG             BOOLEAN DEFAULT FALSE;
   C_CUST_CODE_SAVE    VARCHAR2(20);
BEGIN
 BEGIN
   BEGIN
      -- 현장별 사업장코드를 가지고 온다
      
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
      FETCH DETAIL_CUR INTO rec_slip_grt_income.cont_date,rec_slip_lease_master.exp_date, rec_slip_grt_income.cont_seq, 
                            rec_slip_lease_master.cont_type, rec_slip_grt_income.degree_code, rec_slip_grt_income.receipt_date, 
                            rec_slip_cust.cust_code, rec_slip_cust.cust_name, rec_slip_cust.cust_div, 
                            rec_slip_cust.biz_status, rec_slip_cust.biz_type, rec_slip_cust.cur_zip_code, 
                            rec_slip_cust.cur_addr1, rec_slip_cust.cur_addr2, v_degree_name, 
                            rec_slip_grt_income.delay_amt, rec_slip_grt_income.discount_amt, rec_slip_grt_income.r_amt;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
			
		c_h_data := rec_slip_grt_income.cont_date||rec_slip_grt_income.cont_SEQ;
      C_DESC1 := '임대환출('||rec_slip_lease_master.exp_date||')'||'-'||rec_slip_cust.cust_name;
      -- 공급처 테이블에 거래처가 존재하는지 Check하여 미존재시 insert한다.
      
      /*IF C_CUST_CODE_SAVE <> rec_slip_cust.cust_code AND LENGTH(TRIM(rec_slip_cust.cust_code)) IS NOT NULL THEN
         C_CUST_CODE_SAVE := rec_slip_cust.cust_code;
         IF NOT F_Comm_Slip_Check_Customer(C_ORG_ID, rec_slip_cust.cust_code) THEN         
            -- Interface테이블에 고객을 생성한다.
            IF rec_slip_cust.cust_div = '02' THEN
               v_cust_type := '법인';
            ELSE
               v_cust_type := '개인';
            END IF; 
            Y_Sp_Comm_Slip_Customer(C_COMP_CODE,rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                    V_CUST_TYPE,as_dept_code,rec_slip_cust.cur_zip_code,rec_slip_cust.cur_ADDR1,rec_slip_cust.cur_ADDR2,
                                    rec_slip_cust.biz_status,rec_slip_cust.biz_type);
   		END IF;
      END IF;*/
		-- 공급처테이블에서 vendor_id와 vendor_site_id를 가져온다
		--		select nvl(vendor_id,0),nvl(vendor_site_id,0)
		--		  into C_VENDOR_ID,C_VENDOR_SITE_ID
		--		  from efin_supplier_v
		--		 where org_id = C_ORG_ID
		--			and vat_registration_num = V_CUST_CODE; 
		
		C_FOLDER_ID := C_COMP_CODE || '99999';
      
      v_sell_amt  := rec_slip_grt_income.r_amt; --입금액(R_AMT+연체-할인)
      
         ---------------------------------------
      --AP 임대보증금(해약) 미지급금(자산,부채)
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
        IF NOT C_V_TAG THEN C_V_TAG := TRUE; END IF;
      END IF;
      
      -- 전표번호구하기
            C_TEMP := 'S'|| '-I-임대환출-' || as_dept_code || '-' || TO_CHAR(rec_slip_lease_master.exp_date,'yymmdd') || '-';
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
            v_dr_amt := v_SELL_AMT; v_cr_amt := v_SELL_AMT;
            v_vatname := NULL;
            v_vat_cnt := 0;
            v_acntcode := C_ACNTNO_GRT;
            v_acntcode2 := C_ACNTNO_PAY;
            v_tax_seq  := NULL;
            v_tax_tag  := NULL;
            v_cash := v_dr_amt;
            v_bill := 0;
            Y_Sp_Comm_Slip_Ap_Invoice(C_COMP_CODE,C_GROUP_ID,as_approval_name,C_INVOICE,rec_slip_lease_master.exp_date,C_DATE,
                                      rec_slip_cust.cust_name,rec_slip_cust.cust_code,
                                      V_DR_AMT,V_CR_AMT,C_DESC,V_VATNAME,as_dept_code, C_PROJ,1,V_ACNTCODE,V_ACNTCODE2,
                                      C_VENDOR_ID,C_VENDOR_SITE_ID,V_CASH,V_BILL,'ITEM', '임대환출',C_ORG_ID );
		
      
      
      
       				
	-- 수입금테이블에 전표마스터번호를 Setting 한다.
	/*		UPDATE F_PROFIT_DETAIL
				SET invoice_num = C_GROUP_ID
			 WHERE dept_code = as_dept_code
				AND inst_date = V_DATE
				AND slip_spec_unq_num = V_SEQ;
   */
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
    
END Y_Sp_H_Slip_Lease_Grt_Cancel;
/

