 /* ============================================================================ */
/* 함수명 : y_sp_f_slip_nopay(ap)                                                */
/* 기  능 : 자금청구-미지급청구전표 발행                                         */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 시작일자               ==> ad_fr_date(DATE)                          */
/*        : 종료일자               ==> ad_to_date(DATE)                          */
/*        : 결재선번호             ==> ai_unq_num(NUMBER)                        */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2005.04.28                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE "Y_SP_F_SLIP_NOPAY" (as_dept_code    IN   VARCHAR2,
																	 ad_fr_date		  IN   DATE ,
																	 ad_to_date		  IN   DATE ,
																	ai_unq_num      IN   NUMBER) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT a.request_date,a.req_spec_unq_num,a.cont,a.acntcode,a.vatcode,
		 a.amt,a.vat,a.cash_amt,a.bill_amt,a.receipt_date,
		 decode(lengthb(a.cust_code),13,substrb(a.cust_code,1,6) || '-' || substrb(a.cust_code,7,7),substrb(a.cust_code,1,3) || '-' || substrb(a.cust_code,4,2) || '-' || substrb(a.cust_code,6,5)),
		 decode(lengthb(a.cust_code),13,'개인','사업자'),a.cust_name,b.zip_number,b.addr,
		 b.business_condition,b.kind_businesstype,b.representative_name,decode(a.dis_class,'1','N','Y')
  FROM f_nopay_request a,
		 z_code_cust_code b,
		 efin_invoice_header_itf c	 
 WHERE a.cust_code = b.cust_code (+)
	AND a.dept_code = as_dept_code
	AND a.request_date >= ad_fr_date
	AND a.request_date <= ad_to_date
	AND a.invoice_num = c.invoice_group_id (+)
	AND decode(c.complete_flag,null,'Y',decode(c.complete_flag,'3','Y',decode(c.complete_flag,'9',decode(c.relation_invoice_group_id,null,'N','Y'),'N'))) = 'Y'
	AND (a.amt <> 0 );
--- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_REQ_DATE          DATE;
	V_SEQ               INTEGER;
	V_CONT              VARCHAR2(50);
	V_ACNTCODE          VARCHAR2(8);
	V_VATCODE           VARCHAR2(8);
	V_AMT               NUMBER(20,5);
	V_VAT               NUMBER(20,5);
	V_CASH              NUMBER(20,5);
	V_BILL              NUMBER(20,5);
	V_DATE              DATE;
	V_CUST_CODE         VARCHAR2(20);
	V_CUST_TYPE         VARCHAR2(10);
	V_SBCR_NAME         VARCHAR2(50);
	V_ZIP               VARCHAR2(10);
	V_ADDR              VARCHAR2(100);
	V_UPTAE             VARCHAR2(20);
	V_UPJONG            VARCHAR2(30);
	V_TREADE            VARCHAR2(20);
	V_BILL_PAY          VARCHAR2(1);
	C_DATE              DATE;
	C_GROUP_ID          INTEGER;
	C_SEQ               INTEGER;
	C_DR_AMT            NUMBER(20,5);
	C_CR_AMT            NUMBER(20,5);
	C_TEMP_VAT          NUMBER(20,5);
   C_CNT               NUMBER(20,5);  --
	C_COMP_CODE         VARCHAR2(10);
	C_ORG_ID            VARCHAR2(10);
	C_ORG_NAME          VARCHAR2(100);
	C_INVOICE           VARCHAR2(50);
	C_TEMP              VARCHAR2(50);
	C_DEPT_NAME         VARCHAR2(50);
	C_PROJ              VARCHAR2(10);
	C_ACNTCODE          VARCHAR2(8);
	C_VATNAME           VARCHAR2(50);
	C_WORK_DT           VARCHAR2(10);
	C_VENDOR_ID         INTEGER;	
	C_VENDOR_SITE_ID    INTEGER;
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
-- 전표 마스터번호를 구한다.
	select efin_invoice_header_itf_s.nextval
	  into C_GROUP_ID
	  from dual;
-- 결재선 정보를 저장한다.
	y_sp_d_efin_invoice_copy(C_GROUP_ID,ai_unq_num,'A',last_day(ad_to_date));
-- 전표일자를 구한다...
	select to_char(last_day(ad_to_date),'yyyy.mm.dd')
	  into C_DATE
	  from dual;
-- 전표번호를 구하기위한 TEMP
		SELECT '자금청구-' || to_char(C_DATE,'yymmdd') || '-'
		  INTO C_TEMP
		  FROM dual;
		SELECT C_TEMP || substrb(C_DEPT_NAME,1, 44 - lengthb(C_TEMP)) || '-'
		  INTO C_TEMP
		  FROM dual;
		C_WORK_DT := to_char(add_months(C_DATE,1),'YYYY.MM') || '.10';
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_REQ_DATE,V_SEQ,V_CONT,V_ACNTCODE,V_VATCODE,V_AMT,V_VAT,V_CASH,V_BILL,V_DATE,
									 V_CUST_CODE,V_CUST_TYPE,V_SBCR_NAME,V_ZIP,V_ADDR,V_UPTAE,V_UPJONG,V_TREADE,V_BILL_PAY;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
		-- 부가세명,부가세계정과목코드를 가지고 온다.
				select account_code,tax_code_name_alt
				  into C_ACNTCODE,C_VATNAME
				  from efin_tax_codes_v
				 where org_code = C_COMP_CODE
				   and tax_id = V_VATCODE;
		-- 공급처 테이블에 거래처가 존재하는지 Check하여 미존재시 insert한다.
				IF F_COMM_SLIP_CHECK_SUPPLIER(C_ORG_ID,V_CUST_CODE) = False THEN
		-- Interface테이블에 거래처를 생성한다.
					y_sp_comm_slip_supplier(C_COMP_CODE,V_SBCR_NAME,V_CUST_CODE,V_CUST_TYPE,as_dept_code,'211111',V_ZIP,V_ADDR,V_UPTAE,V_UPJONG,V_TREADE);
				END IF;
		-- 공급처테이블에서 vendor_id와 vendor_site_id를 가져온다
		--		select nvl(vendor_id,0),nvl(vendor_site_id,0)
		--		  into C_VENDOR_ID,C_VENDOR_SITE_ID
		--		  from efin_supplier_v
		--		 where org_id = C_ORG_ID
		--			and vat_registration_num = V_CUST_CODE; 
				C_DR_AMT   := V_AMT; -- 차변금액
				C_CR_AMT   := V_AMT + V_VAT ; -- 대변금액(과세+부가세)
	-- 전표번호구하기
				select nvl(substrb(max(invoice_num),lengthb(max(invoice_num)) - 2,3),0) + 1
				  into C_SEQ
				  from efin_invoice_lines_itf
				 where invoice_num like C_TEMP || '%';
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
				y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,to_char(C_DATE,'yyyy-mm') || '월 미지급청구',C_INVOICE,V_DATE,V_DATE,
												  V_SBCR_NAME,V_CUST_CODE,C_DR_AMT,C_CR_AMT,V_CONT,C_VATNAME,as_dept_code,
												  C_PROJ,1,V_ACNTCODE,'211511',C_VENDOR_ID,C_VENDOR_SITE_ID,V_CASH,V_BILL,'ITEM','자금청구',
												  C_ORG_ID,'V','',V_BILL_PAY,C_WORK_DT,C_COMP_CODE || '99999',V_CONT);
		-- 매입과세OR매입공통OR매입불공제(선택된 부가세코드와 연계된계정과목을 가지고 간다)
				IF C_ACNTCODE = '112421' THEN
					--y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,to_char(C_DATE,'yyyy-mm') || '월 미지급청구',C_INVOICE,V_DATE,V_DATE,
					--								  V_SBCR_NAME,V_CUST_CODE,V_VAT,C_CR_AMT,V_CONT,C_VATNAME,as_dept_code,
					--								  C_PROJ,1,V_ACNTCODE,'211511',C_VENDOR_ID,C_VENDOR_SITE_ID,V_CASH,V_BILL,'TAX','자금청구',
					--								  C_ORG_ID,'V','',V_BILL_PAY,C_WORK_DT,C_COMP_CODE || '99999',C_VATNAME);
					--적요수정 경일
					y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,to_char(C_DATE,'yyyy-mm') || '월 미지급청구',C_INVOICE,V_DATE,V_DATE,
													  V_SBCR_NAME,V_CUST_CODE,V_VAT,C_CR_AMT,V_CONT,C_VATNAME,as_dept_code,
													  C_PROJ,1,V_ACNTCODE,'211511',C_VENDOR_ID,C_VENDOR_SITE_ID,V_CASH,V_BILL,'TAX','자금청구',
													  C_ORG_ID,'V','',V_BILL_PAY,C_WORK_DT,C_COMP_CODE || '99999',V_CONT);
				ELSE
					--y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,to_char(C_DATE,'yyyy-mm') || '월 미지급청구',C_INVOICE,V_DATE,V_DATE,
					--								  V_SBCR_NAME,V_CUST_CODE,V_VAT,C_CR_AMT,V_CONT,C_VATNAME,as_dept_code,
					--								  C_PROJ,1,C_ACNTCODE,'211511',C_VENDOR_ID,C_VENDOR_SITE_ID,V_CASH,V_BILL,'TAX','자금청구',
					--								  C_ORG_ID,'V','',V_BILL_PAY,C_WORK_DT,C_COMP_CODE || '99999',C_VATNAME);
					--적요수정 경일
					y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,to_char(C_DATE,'yyyy-mm') || '월 미지급청구',C_INVOICE,V_DATE,V_DATE,
													  V_SBCR_NAME,V_CUST_CODE,V_VAT,C_CR_AMT,V_CONT,C_VATNAME,as_dept_code,
													  C_PROJ,1,C_ACNTCODE,'211511',C_VENDOR_ID,C_VENDOR_SITE_ID,V_CASH,V_BILL,'TAX','자금청구',
													  C_ORG_ID,'V','',V_BILL_PAY,C_WORK_DT,C_COMP_CODE || '99999',V_CONT);
				END IF;
	-- 보증서접수현황테이블에 전표마스터번호를 Setting 한다.
			update f_nopay_request
				set invoice_num = C_GROUP_ID
			 where dept_code = as_dept_code
				and request_date = V_REQ_DATE
				and req_spec_unq_num = V_SEQ;
	END LOOP;
	CLOSE DETAIL_CUR;
-- 배치화일을 Update 한다.
		y_sp_comm_slip_batch_flag(C_ORG_ID,'AP Invoice');
      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '외주비전표생성 실패! [Line No: 159]';
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
END y_sp_f_slip_nopay;
