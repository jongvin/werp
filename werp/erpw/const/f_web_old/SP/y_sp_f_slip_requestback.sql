 /* ============================================================================ */
/* 함수명 : y_sp_f_slip_request(GL)                                              */
/* 기  능 : 자금청구 - 예비비정산 전표 발행                                      */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 시작일자               ==> ad_fr_date(DATE)                          */
/*        : 종료일자               ==> ad_to_date(DATE)                          */
/*        : 결재선번호             ==> ai_unq_num(NUMBER)                        */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2005.04.27                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_f_slip_request (as_dept_code    IN   VARCHAR2,
																 ad_fr_date		  IN   DATE ,
																 ad_to_date		  IN   DATE ,
																 ai_unq_num      IN   NUMBER) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT max(a.rqst_date),nvl(max(a.slip_seq),0),max(b.folder_id)
  FROM f_request a,
		 ( select max(dept_code) dept_code,max(folder_id) folder_id
			  from f_dept_account 
			 where dept_code = as_dept_code ) b,
		efin_invoice_header_itf c	 
 WHERE a.dept_code = b.dept_code(+)
	AND a.dept_code = as_dept_code
	AND a.rqst_date >= ad_fr_date
	AND a.rqst_date <= ad_to_date
	AND a.invoice_num = c.invoice_group_id (+)
	AND decode(c.complete_flag,null,'Y',decode(c.complete_flag,'3','Y',decode(c.complete_flag,'9',decode(c.relation_invoice_group_id,null,'N','Y'),'N'))) = 'Y'
group by a.dept_code,a.rqst_date,a.slip_seq;

CURSOR DETAIL_CUR1 (V_RQST_DATE DATE, V_SLIP_SEQ INTEGER )IS
SELECT a.receipt_date,a.slip_spec_unq_num,a.res_type,a.cr_class,
		 a.cont,a.acntcode,a.vatcode,a.amt,a.vat,a.profit_amt,
		 decode(lengthb(a.cust_code),13,substrb(a.cust_code,1,6) || '-' || substrb(a.cust_code,7,7),substrb(a.cust_code,1,3) || '-' || substrb(a.cust_code,4,2) || '-' || substrb(a.cust_code,6,5)),
		 decode(lengthb(a.cust_code),13,'개인','사업자'),a.cust_name,b.zip_number,b.addr,
		 b.business_condition,b.kind_businesstype,b.representative_name,a.prepay_date1,a.prepay_date2,a.prepay_acntcode,a.fa_qnty
  FROM f_request a,
		 z_code_cust_code b
 WHERE a.cust_code = b.cust_code (+)
	AND a.dept_code = as_dept_code
	AND a.rqst_date = V_RQST_DATE
	AND a.slip_seq  = V_SLIP_SEQ
	AND (a.amt <> 0 );
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_RQST_DATE  		  DATE;
	V_SLIP_SEQ    		  INTEGER;
	V_DATE       		  DATE;
	V_SEQ         		  INTEGER;
	V_RES_TYPE          VARCHAR2(1);
	V_FOLDER_ID         VARCHAR2(10);
	V_CR_CLASS          VARCHAR2(1);
	V_CONT              VARCHAR2(100);
	V_ACNTCODE          VARCHAR2(8);
	V_VATCODE           VARCHAR2(8);
	V_AMT               NUMBER(20,5);
	V_VAT               NUMBER(20,5);
	V_PROFIT_AMT        NUMBER(20,5);
	V_ST_DT				  DATE;
	V_END_DT				  DATE;
	V_REACNT            VARCHAR2(8);
	V_FIX_QTY           NUMBER(20,5);
	V_CUST_CODE         VARCHAR2(20);
	V_CUST_TYPE         VARCHAR2(10);
	V_SBCR_NAME         VARCHAR2(50);
	V_ZIP               VARCHAR2(10);
	V_ADDR              VARCHAR2(100);
	V_UPTAE             VARCHAR2(20);
	V_UPJONG            VARCHAR2(30);
	V_TREADE            VARCHAR2(20);
	C_GROUP_ID          INTEGER;
	C_SEQ               INTEGER;
	C_CASH_RT           NUMBER(20,5);
	C_DR_AMT            NUMBER(20,5);
	C_CR_AMT            NUMBER(20,5);
	C_TOT_DR_AMT        NUMBER(20,5);
	C_TOT_CR_AMT        NUMBER(20,5);
	C_TEMP_VAT          NUMBER(20,5);
   C_TAX_CNT           NUMBER(20,5);  --
   C_CNT               NUMBER(20,5);  --
	C_COMP_CODE         VARCHAR2(10);
	C_ORG_ID            VARCHAR2(10);
	C_ORG_NAME          VARCHAR2(100);
	C_INVOICE           VARCHAR2(50);
	C_TEMP              VARCHAR2(50);
	C_PROJ              VARCHAR2(10);
	C_ACNTCODE          VARCHAR2(10);
	C_CAT_NAME          VARCHAR2(50);
	C_VATNAME           VARCHAR2(50);
	C_TEMP_VATNAME      VARCHAR2(50);
	C_DEPT_NAME         VARCHAR2(50);
	C_VENDOR_ID         INTEGER;	
	C_VENDOR_SITE_ID    INTEGER;
	C_TAX_SEQ           INTEGER;	
	C_TAX_TAG           VARCHAR2(1);
	C_CUST_CODE         VARCHAR2(20);
	C_CUST_NAME         VARCHAR2(50);
	C_FOLDER_ID         VARCHAR2(10);
	C_REQ_DATE          VARCHAR2(10);

BEGIN
 BEGIN
-- 현장별 사업장코드를 가지고 온다	
		select comp_code ,long_name
		  into C_COMP_CODE,C_DEPT_NAME
 		  from z_code_dept 
		 where dept_code = as_dept_code;
-- 현장별프로젝트코드를 구한다.
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

	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_RQST_DATE,V_SLIP_SEQ,V_FOLDER_ID;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
	-- 전표 마스터번호를 구한다.
		select efin_invoice_header_itf_s.nextval
		  into C_GROUP_ID
		  from dual;
		-- 결재선 정보를 저장한다.
			y_sp_d_efin_invoice_copy(C_GROUP_ID,ai_unq_num,'A',V_RQST_DATE);
		C_TOT_DR_AMT := 0;
		C_TOT_CR_AMT := 0;

		OPEN	DETAIL_CUR1(V_RQST_DATE,V_SLIP_SEQ);
		LOOP
			FETCH DETAIL_CUR1 INTO V_DATE,V_SEQ,V_RES_TYPE,V_CR_CLASS,V_CONT,V_ACNTCODE,V_VATCODE,V_AMT,V_VAT,V_PROFIT_AMT,
										  V_CUST_CODE,V_CUST_TYPE,V_SBCR_NAME,V_ZIP,V_ADDR,V_UPTAE,V_UPJONG,V_TREADE,V_ST_DT,
										  V_END_DT,V_REACNT,V_FIX_QTY;
			EXIT WHEN DETAIL_CUR1%NOTFOUND;
				IF V_ACNTCODE = '915100' THEN
					C_CAT_NAME := '고정자산';
				ELSE
					C_CAT_NAME := '전도금정산';
					V_FIX_QTY := 0;
				END IF;
				IF V_CUST_CODE = '--' THEN
					V_CUST_CODE := '999-99-99999';
				ELSE
			-- 공급처 테이블에 거래처가 존재하는지 Check하여 미존재시 insert한다.
					IF F_COMM_SLIP_CHECK_SUPPLIER(C_ORG_ID,V_CUST_CODE) = False THEN
						y_sp_comm_slip_supplier(C_COMP_CODE,V_SBCR_NAME,V_CUST_CODE,V_CUST_TYPE,as_dept_code,'211111',V_ZIP,V_ADDR,V_UPTAE,V_UPJONG,V_TREADE);
					END IF;
			-- 공급처테이블에서 vendor_id와 vendor_site_id를 가져온다
			--		select nvl(vendor_id,0),nvl(vendor_site_id,0)
			--		  into C_VENDOR_ID,C_VENDOR_SITE_ID
			--		  from efin_supplier_v
			--		 where org_id = C_ORG_ID
			--			and vat_registration_num = V_CUST_CODE; 
				END IF;
				IF V_CR_CLASS = '1' THEN  -- 차변일 경우 처리
			-- 부가세명,부가세계정과목코드를 가지고 온다.
					IF V_VATCODE is null THEN
						C_VATNAME := '';
						C_TAX_SEQ := '';
						C_TAX_TAG := '';
						C_TAX_CNT := '';
					ELSE
						select account_code,tax_code_name_alt
						  into C_ACNTCODE,C_VATNAME
						  from efin_tax_codes_v
						 where org_code = C_COMP_CODE
							and tax_id = V_VATCODE;

						select gl_je_lines_s.nextval -- 부가세연결고리를 만든다
						  into C_TAX_SEQ
						  from dual;
						C_TAX_TAG := 'T';
						C_TAX_CNT := 1;
					END IF;	

	
					C_FOLDER_ID := C_COMP_CODE || '99999';
					IF V_PROFIT_AMT <> 0 THEN
						C_CR_AMT := V_AMT + V_VAT - V_PROFIT_AMT; -- 잡이익이 있을경우 대변금액에서 잡이익을 따로 잡아준다.
					ELSE
						C_CR_AMT := V_AMT + V_VAT; 
					END IF;
					C_TOT_DR_AMT := C_TOT_DR_AMT + V_AMT;
				-- GL Interface 테이블에 자료를 생성한다.
					y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 예비비정산',V_DATE,V_DATE,
													  V_SBCR_NAME,V_CUST_CODE,V_AMT,'',C_VATNAME,as_dept_code,
													  C_PROJ,C_TAX_CNT,V_ACNTCODE,C_CAT_NAME,'자금청구',C_TAX_SEQ,C_TAX_TAG,C_FOLDER_ID,
													  '',C_ORG_ID,C_DEPT_NAME,V_CONT,'V',
													  V_FIX_QTY,V_ST_DT,V_END_DT,V_REACNT);
					
					IF V_VATCODE IS NOT NULL THEN
						y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 예비비정산',V_DATE,V_DATE,
														  V_SBCR_NAME,V_CUST_CODE,V_VAT,'','',as_dept_code,
														  C_PROJ,'',C_ACNTCODE,C_CAT_NAME,'자금청구',C_TAX_SEQ,C_TAX_TAG,C_FOLDER_ID,
														  '',C_ORG_ID,C_DEPT_NAME,V_CONT,'V',
														  V_FIX_QTY,V_ST_DT,V_END_DT,V_REACNT);
					END IF;
					IF V_RES_TYPE <> 'L' THEN
						y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 예비비정산',V_DATE,V_DATE,
														  V_SBCR_NAME,V_CUST_CODE,'',C_CR_AMT,'',as_dept_code,
														  C_PROJ,'','111114',C_CAT_NAME,'자금청구','','',V_FOLDER_ID,
														  '',C_ORG_ID,C_DEPT_NAME,V_CONT,'V',
														  V_FIX_QTY,V_ST_DT,V_END_DT,V_REACNT);
					END IF;
					IF V_PROFIT_AMT <> 0 THEN
						y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 예비비정산',V_DATE,V_DATE,
														  V_SBCR_NAME,V_CUST_CODE,'',V_PROFIT_AMT,'',as_dept_code,
														  C_PROJ,'','462513',C_CAT_NAME,'자금청구','','',C_FOLDER_ID,
												        '',C_ORG_ID,C_DEPT_NAME,V_CONT,'V',
														  V_FIX_QTY,V_ST_DT,V_END_DT,V_REACNT);
					END IF;
				ELSE  -- 대변일 경우 처리
					C_FOLDER_ID := C_COMP_CODE || '99999';
					C_CR_AMT := V_AMT * (-1); 
					C_TOT_CR_AMT := C_TOT_CR_AMT + V_AMT;
  		  -- GL Interface 테이블에 자료를 생성한다.
					y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 예비비정산',V_DATE,V_DATE,
													  V_SBCR_NAME,V_CUST_CODE,'',V_AMT,C_VATNAME,as_dept_code,
													  C_PROJ,'',V_ACNTCODE,C_CAT_NAME,'자금청구','','',C_FOLDER_ID,
													  '',C_ORG_ID,C_DEPT_NAME,V_CONT,'V',
													  V_FIX_QTY,V_ST_DT,V_END_DT,V_REACNT);
					IF V_RES_TYPE <> 'L' THEN
						y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 예비비정산',V_DATE,V_DATE,
														  V_SBCR_NAME,V_CUST_CODE,'',C_CR_AMT,'',as_dept_code,
														  C_PROJ,'','111114',C_CAT_NAME,'자금청구','','',V_FOLDER_ID,
														  '',C_ORG_ID,C_DEPT_NAME,V_CONT,'V',
														  V_FIX_QTY,V_ST_DT,V_END_DT,V_REACNT);
					END IF;
				END IF;
		-- 수입금테이블에 전표마스터번호를 Setting 한다.
				update f_request
					set invoice_num = C_GROUP_ID
				 where dept_code = as_dept_code
					and rqst_date = V_RQST_DATE
					and slip_seq  = V_SLIP_SEQ
					and slip_spec_unq_num = V_SEQ;
		END LOOP;
		CLOSE DETAIL_CUR1;
		IF V_RES_TYPE = 'L' THEN
			y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,C_DEPT_NAME || ' 예비비정산',V_DATE,V_DATE,
											  V_SBCR_NAME,V_CUST_CODE,'',C_TOT_DR_AMT - C_TOT_CR_AMT,'',as_dept_code,
											  C_PROJ,'','111114',C_CAT_NAME,'자금청구','','',V_FOLDER_ID,
											  '',C_ORG_ID,C_DEPT_NAME,'전도금보통예금','V',
											  V_FIX_QTY,V_ST_DT,V_END_DT,V_REACNT);
		END IF;
	END LOOP;
	CLOSE DETAIL_CUR;

-- 배치화일을 Update 한다.
		y_sp_comm_slip_batch_flag(C_ORG_ID,'Journal');
      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '예비비정산전표생성 실패! [Line No: 159]';
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
END y_sp_f_slip_request;
/

