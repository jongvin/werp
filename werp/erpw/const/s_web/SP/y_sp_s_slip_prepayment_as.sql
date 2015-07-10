 /* ============================================================================ */
/* 함수명 : y_sp_s_slip_prepayment_as (AP)                                       */
/* 기  능 : 선급금 지급 전표 발행(품질안전팀)                                    */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 발주번호               ==> ai_order_number(integer)                  */
/*        : 증빙일                 ==> ad_date(date)                             */
/*        : 순번  	              ==> ai_seq(integer)			                  */
/*        : 결재선번호             ==> ai_unq_num(NUMBER)                        */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2005.04.25                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_slip_prepayment_as (as_dept_code    IN   VARCHAR2,
															 	    ai_order_number IN   INTEGER,
																	 ad_date			  IN   DATE ,
																	 ai_seq          IN   INTEGER,
																	 ai_unq_num      IN   NUMBER) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	C_SLIP_DT           DATE;
	C_GROUP_ID          INTEGER;
	C_SEQ               INTEGER;
	C_DR_AMT            NUMBER(20,5);
	C_CR_AMT            NUMBER(20,5);
	C_SUPPLY_AMT        NUMBER(20,5);
	C_NOTAX_AMT         NUMBER(20,5);
	C_TAX_AMT           NUMBER(20,5);
	C_VAT               NUMBER(20,5);
	C_TEMP_VAT          NUMBER(20,5);
	C_TOTAL_AMT         NUMBER(20,5);
	C_RT                NUMBER(20,5);
   C_CNT               NUMBER(20,5);  --
	C_CASH              NUMBER(20,5);
	C_BILL              NUMBER(20,5);
	C_COMP_CODE         VARCHAR2(10);
	C_ORG_ID            VARCHAR2(10);
	C_ORG_NAME          VARCHAR2(100);
	C_SBCR_CODE         VARCHAR2(20);
	C_CUST_CODE         VARCHAR2(20);
	C_SBCR_NAME         VARCHAR2(50);
	C_CUST_TYPE         VARCHAR2(10);
	C_ZIP               VARCHAR2(10);
	C_ADDR              VARCHAR2(100);
	C_UPTAE             VARCHAR2(20);
	C_UPJONG            VARCHAR2(30);
	C_TREADE            VARCHAR2(20);
	C_INVOICE           VARCHAR2(50);
	C_TEMP              VARCHAR2(50);
	C_DEPT_NAME         VARCHAR2(50);
	C_PROJ              VARCHAR2(10);
	C_ACNTCODE          VARCHAR2(10);
	C_VATNAME           VARCHAR2(50);
	C_TEMP_VATNAME      VARCHAR2(50);
	C_BILL_PAY          VARCHAR2(1);
	C_WORK_DT           VARCHAR2(10);
	C_PRE_VAT           NUMBER(20,5);
	C_PRE_TAX           NUMBER(20,5);
	C_PRE_NOTAX         NUMBER(20,5);
	C_VATCODE           S_CN_LIST.VATCODE%TYPE;
	C_VENDOR_ID         INTEGER;	
	C_VENDOR_SITE_ID    INTEGER;
	C_FOLDER            VARCHAR2(50);
	C_SPEC_UNQ_NUM      NUMBER(20,0);
	C_SPEC_NO_SEQ       NUMBER(20,0);
	C_WBS_CODE          VARCHAR2(10);

BEGIN
 BEGIN
		select min(spec_unq_num)
		  into C_SPEC_UNQ_NUM
		  from s_cn_detail
		 where dept_code = as_dept_code
			and order_number = ai_order_number;

		select spec_no_seq
		  into C_SPEC_NO_SEQ
		  from y_budget_detail
		 where dept_code = as_dept_code
			and spec_unq_num = C_SPEC_UNQ_NUM;

		select wbs_code
		  into C_WBS_CODE
		  from y_budget_parent
		 where dept_code = as_dept_code
			and spec_no_seq = C_SPEC_NO_SEQ;

-- 현장별 사업장코드를 가지고 온다	
		select comp_code ,long_name
		  into C_COMP_CODE,C_DEPT_NAME
 		  from z_code_dept 
		 where dept_code = C_WBS_CODE;
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
		 where a.dept_code =  C_WBS_CODE;  

		SELECT attribute1
		  INTO C_ORG_ID
		  FROM efin_corporations_v
		 WHERE corporation_code = C_COMP_CODE;

-- 계약대장을 읽어 공급가,면세,과세,부가세,부가세코드,협력업체코드,사업자번호를 가지고 온다.
		select NVL(a.SBC_AMT,0),NVL(a.supply_amt_notax,0),NVL(a.supply_amt_tax,0),NVL(a.vat,0),a.vatcode,a.sbcr_code,
				 decode(lengthb(b.businessman_number),13,substrb(b.businessman_number,1,6) || '-' || substrb(b.businessman_number,7,7),substrb(b.businessman_number,1,3) || '-' || substrb(b.businessman_number,4,2) || '-' || substrb(b.businessman_number,6,5)),
				 decode(lengthb(b.businessman_number),13,'개인','사업자'),b.sbcr_name,b.zip_number1,b.address1,
				 b.kind_bussinesstype,b.kinditem,b.rep_name1,a.previous_amt_rt,b.bill_dis_pay,
				 a.previous_vat,a.safety_amt1,a.safety_amt2
		  into C_SUPPLY_AMT,C_NOTAX_AMT,C_TAX_AMT,C_VAT,C_VATCODE,C_SBCR_CODE,
				 C_CUST_CODE,
				 C_CUST_TYPE,C_SBCR_NAME,C_ZIP,C_ADDR,
				 C_UPTAE,C_UPJONG,C_TREADE,C_RT,C_BILL_PAY,
				 C_PRE_VAT,C_PRE_TAX,C_PRE_NOTAX
		  from s_cn_list a,
				 s_sbcr b
		 where a.sbcr_code    = b.sbcr_code (+)
			and a.dept_code    = as_dept_code
			and a.order_number = ai_order_number;

		C_TOTAL_AMT := C_NOTAX_AMT + C_TAX_AMT + C_VAT;
		C_FOLDER := C_COMP_CODE || '99999';

-- 부가세명,부가세계정과목코드를 가지고 온다.
		select acntcode
		  into C_ACNTCODE
		  from z_code_vatclass
		 where vattag = C_VATCODE;

		select tax_id,tax_code_name_alt
		  into C_VATCODE,C_VATNAME
		  from efin_tax_codes_v
		 where org_code = C_COMP_CODE
		   and account_code = C_ACNTCODE;

-- 공급처 테이블에 거래처가 존재하는지 Check하여 미존재시 insert한다.
		IF F_COMM_SLIP_CHECK_SUPPLIER(C_ORG_ID,C_CUST_CODE) = False THEN
-- Interface테이블에 거래처를 생성한다.
	      y_sp_comm_slip_supplier(C_COMP_CODE,C_SBCR_NAME,C_CUST_CODE,C_CUST_TYPE,C_WBS_CODE,'211111',C_ZIP,C_ADDR,C_UPTAE,C_UPJONG,C_TREADE);
		END IF;

-- 공급처테이블에서 vendor_id와 vendor_site_id를 가져온다
--		select nvl(vendor_id,0),nvl(vendor_site_id,0)
--		  into C_VENDOR_ID,C_VENDOR_SITE_ID
--		  from efin_supplier_v
--		 where org_id = C_ORG_ID
--			and vat_registration_num = C_CUST_CODE; 

-- 전표 마스터번호를 구한다.
		select efin_invoice_header_itf_s.nextval
		  into C_GROUP_ID
		  from dual;

-- 결재선 정보를 저장한다.
	y_sp_d_efin_invoice_copy(C_GROUP_ID,ai_unq_num,'A',sysdate);

-- 전표번호를 구하기위한 TEMP

		SELECT ai_order_number || '-외주-' || to_char(ad_date,'yymmdd') || '-'
		  INTO C_TEMP
		  FROM dual;

		SELECT C_TEMP || substrb(C_DEPT_NAME,1, 44 - lengthb(C_TEMP)) || '-'
		  INTO C_TEMP
		  FROM dual;

		C_WORK_DT := to_char(add_months(ad_date,1),'YYYY.MM') || '.10';
-- 면세금액이 존재할 경우 처리
		IF C_NOTAX_AMT <> 0 THEN
			C_DR_AMT := C_PRE_NOTAX; -- 차변금액 (면세금액)
			C_CR_AMT := C_DR_AMT; -- 대변금액
			C_CASH   := C_DR_AMT; -- 현금
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

-- 부가세명를 가지고 온다.(매입면세(계산서)계정으로 부가세명을 가져옴)
			select tax_code_name_alt
			  into C_TEMP_VATNAME
			  from efin_tax_codes_v
			 where org_code = C_COMP_CODE
				and account_code = '112423';

-- AP Interface 테이블에 자료를 생성한다.
	-- 선급금(면세)
	      y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,C_SBCR_NAME || ' 선급금 전표',C_INVOICE,ad_date,ad_date,
				  							  C_SBCR_NAME,C_CUST_CODE,C_DR_AMT,C_CR_AMT,'선급비용',C_TEMP_VATNAME,C_WBS_CODE,
											  C_PROJ,1,'112211','211111',C_VENDOR_ID,C_VENDOR_SITE_ID,C_CASH,C_BILL,'ITEM','외주',
											  C_ORG_ID,'V',ai_order_number,C_BILL_PAY,C_WORK_DT,C_FOLDER,'',0);
	-- 매입면세(계산서)		
	      y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,C_SBCR_NAME || ' 선급금 전표',C_INVOICE,ad_date,ad_date,
											  C_SBCR_NAME,C_CUST_CODE,0,C_CR_AMT,'선급비용',C_TEMP_VATNAME,C_WBS_CODE,
											  C_PROJ,1,'112423','211111',C_VENDOR_ID,C_VENDOR_SITE_ID,C_CASH,C_BILL,'TAX','외주',
											  C_ORG_ID,'V',ai_order_number,C_BILL_PAY,C_WORK_DT,C_FOLDER,'',0);
		END IF;

-- 과세금액이 존재할 경우 처리
		IF C_TAX_AMT <> 0 THEN
			C_DR_AMT   := C_PRE_TAX; -- 차변금액 (과세금액)
			C_TEMP_VAT := C_PRE_VAT;   -- 선급부가세금액
			C_CR_AMT   := C_DR_AMT + C_TEMP_VAT ; -- 대변금액(선급과세+선급부가세)
			C_CASH     := C_DR_AMT + C_TEMP_VAT ; -- 현금

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
	-- 선급금(과세)
	      y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,C_SBCR_NAME || ' 선급금 전표',C_INVOICE,ad_date,ad_date,
											  C_SBCR_NAME,C_CUST_CODE,C_DR_AMT,C_CR_AMT,'선급비용',C_VATNAME,C_WBS_CODE,
											  C_PROJ,1,'112212','211111',C_VENDOR_ID,C_VENDOR_SITE_ID,C_CASH,C_BILL,'ITEM','외주',
											  C_ORG_ID,'V',ai_order_number,C_BILL_PAY,C_WORK_DT,C_FOLDER,'',0);
	-- 매입과세OR매입공통OR매입불공제(선택된 부가세코드와 연계된계정과목을 가지고 간다)
			IF C_ACNTCODE = '112421' THEN
				y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,C_SBCR_NAME || ' 선급금 전표',C_INVOICE,ad_date,ad_date,
												  C_SBCR_NAME,C_CUST_CODE,C_TEMP_VAT,C_CR_AMT,'선급비용',C_VATNAME,C_WBS_CODE,
												  C_PROJ,1,'112212','211111',C_VENDOR_ID,C_VENDOR_SITE_ID,C_CASH,C_BILL,'TAX','외주',
												  C_ORG_ID,'V',ai_order_number,C_BILL_PAY,C_WORK_DT,C_FOLDER,'',0);
			ELSE
				y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,C_SBCR_NAME || ' 선급금 전표',C_INVOICE,ad_date,ad_date,
												  C_SBCR_NAME,C_CUST_CODE,C_TEMP_VAT,C_CR_AMT,'선급비용',C_VATNAME,C_WBS_CODE,
												  C_PROJ,1,C_ACNTCODE,'211111',C_VENDOR_ID,C_VENDOR_SITE_ID,C_CASH,C_BILL,'TAX','외주',
												  C_ORG_ID,'V',ai_order_number,C_BILL_PAY,C_WORK_DT,C_FOLDER,'',0);
			END IF;
		END IF;

-- 배치화일을 Update 한다.
		y_sp_comm_slip_batch_flag(C_ORG_ID,'AP Invoice');

-- 보증서접수현황테이블에 전표마스터번호를 Setting 한다.
		update s_guarantee_accept
			set invoice_num = C_GROUP_ID
	    where dept_code = as_dept_code
			and order_number = ai_order_number
			and seq = ai_seq;

      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '선급금전표생성 실패! [Line No: 159]';
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
END y_sp_s_slip_prepayment_as;
/

