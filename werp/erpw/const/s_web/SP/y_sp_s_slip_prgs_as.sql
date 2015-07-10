 /* ============================================================================ */
/* 함수명 : y_sp_s_slip_prgs_as (AP,GL)                                          */
/* 기  능 : 외주비기성 전표 발행(품질안전팀)                                     */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 기성년월               ==> ad_yymm(DATE)                             */
/*        : 작업일자               ==> ad_date(DATE)                             */
/*        : 순번  	              ==> ai_seq(integer)			                  */
/*        : 결재선번호             ==> ai_unq_num(NUMBER)                        */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2005.04.27                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_slip_prgs_as (as_dept_code    IN   VARCHAR2,
															 ad_yymm			  IN   DATE ,
															 ad_date			  IN   DATE ,
															 ai_seq          IN   INTEGER,
															 ai_unq_num      IN   NUMBER) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT a.tm_prgs_notax + a.tm_purchase_vat,a.tm_prgs,a.tm_vat,a.tm_advance_deduction,a.tm_cash,a.tm_bill,
		 b.vatcode,b.sbc_amt,b.previous_amt_rt,
		 decode(lengthb(c.businessman_number),13,substrb(c.businessman_number,1,6) || '-' || substrb(c.businessman_number,7,7),substrb(c.businessman_number,1,3) || '-' || substrb(c.businessman_number,4,2) || '-' || substrb(c.businessman_number,6,5)),
		 decode(lengthb(c.businessman_number),13,'개인','사업자'),c.sbcr_name,c.zip_number1,c.address1,
		 c.kind_bussinesstype,c.kinditem,c.rep_name1,b.order_number,c.bill_dis_pay,
		 a.tm_pre_tax,a.tm_pre_notax,a.tm_pre_vat,to_char(a.pay_dt,'yyyy-mm-dd')
  FROM s_pay a,
       s_cn_list b,
		 s_sbcr c
 WHERE b.sbcr_code = c.sbcr_code (+)
	AND a.dept_code = b.dept_code (+)
	AND a.order_number = b.order_number (+)
	AND a.dept_code = as_dept_code
	AND a.yymm      = ad_yymm
	AND a.seq       = ai_seq
	AND a.tm_pay <> 0;
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_PREPAY_AMT        NUMBER(20,5);
	V_NOTAX_AMT         NUMBER(20,5);
	V_TAX_AMT           NUMBER(20,5);
	V_VAT               NUMBER(20,5);
	V_TOTAL_AMT         NUMBER(20,5);
	V_CUST_CODE         VARCHAR2(20);
	V_SBCR_NAME         VARCHAR2(50);
	V_CUST_TYPE         VARCHAR2(10);
	V_ZIP               VARCHAR2(10);
	V_ADDR              VARCHAR2(100);
	V_UPTAE             VARCHAR2(20);
	V_UPJONG            VARCHAR2(30);
	V_TREADE            VARCHAR2(20);
	V_CASH              NUMBER(20,5);
	V_BILL              NUMBER(20,5);
	V_VATCODE           S_CN_LIST.VATCODE%TYPE;
	V_RT                NUMBER(20,5);
	V_ORDER_NUMBER      NUMBER(20,0);
	V_BILL_PAY          VARCHAR2(1);
	V_PRE_TAX           NUMBER(20,5);
	V_PRE_NOTAX         NUMBER(20,5);
	V_PRE_VAT           NUMBER(20,5);
	V_GL_DT             VARCHAR2(10);
	C_GROUP_ID          INTEGER;
	C_SEQ               INTEGER;
	C_CASH_RT           NUMBER(20,5);
	C_DR_AMT            NUMBER(20,5);
	C_CR_AMT            NUMBER(20,5);
	C_PREPAY_NOTAX      NUMBER(20,5);
	C_PREPAY_TAX        NUMBER(20,5);
	C_PREPAY_VAT        NUMBER(20,5);
	C_NOTAX_AMT         NUMBER(20,5);
	C_TAX_AMT           NUMBER(20,5);
	C_VAT               NUMBER(20,5);
	C_TEMP_VAT          NUMBER(20,5);
   C_CNT               NUMBER(20,5);  --
	C_CASH              NUMBER(20,5);
	C_BILL              NUMBER(20,5);
	C_COMP_CODE         VARCHAR2(10);
	C_ORG_ID            VARCHAR2(10);
	C_ORG_NAME          VARCHAR2(100);
	C_SBCR_CODE         VARCHAR2(20);
	C_INVOICE           VARCHAR2(50);
	C_TEMP              VARCHAR2(50);
	C_PREPAY_TEMP       VARCHAR2(50);
	C_PROJ_NAME         VARCHAR2(50);
	C_PROJ              VARCHAR2(10);
	C_ACNTCODE          VARCHAR2(10);
	C_TEMP_ACNTCODE     VARCHAR2(10);
	C_VATNAME           VARCHAR2(50);
	C_TEMP_VATNAME      VARCHAR2(50);
	C_VENDOR_ID         INTEGER;	
	C_VENDOR_SITE_ID    INTEGER;
	C_TAX_SEQ           INTEGER;	
	C_TAX_CNT           INTEGER;
	C_TAX_TAG           VARCHAR2(1);
	C_FOLDER            VARCHAR2(50);
	C_WORK_DT           VARCHAR2(10);
	C_SPEC_UNQ_NUM      NUMBER(20,0);
	C_SPEC_NO_SEQ       NUMBER(20,0);
	C_WBS_CODE          VARCHAR2(10);
	C_AS_CLASS          VARCHAR2(1);
	C_ACNT              VARCHAR2(10);
	C_CLOSE_YN          INTEGER;
BEGIN
 BEGIN
	C_WORK_DT := to_char(add_months(ad_yymm,1),'YYYY.MM') || '.10';
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_NOTAX_AMT,V_TAX_AMT,V_VAT,V_PREPAY_AMT,V_CASH,V_BILL,V_VATCODE,
									 V_TOTAL_AMT,V_RT,V_CUST_CODE,V_CUST_TYPE,V_SBCR_NAME,V_ZIP,V_ADDR,V_UPTAE,V_UPJONG,
									 V_TREADE,V_ORDER_NUMBER,V_BILL_PAY,V_PRE_TAX,V_PRE_NOTAX,V_PRE_VAT,V_GL_DT;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
			select min(spec_unq_num)
			  into C_SPEC_UNQ_NUM
			  from s_cn_detail
			 where dept_code = as_dept_code
				and order_number = V_ORDER_NUMBER;
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
			select as_class
			  into C_AS_CLASS
			  from f_dept_account
			 where dept_code = as_dept_code
				and wbs_code  = C_WBS_CODE;
			if C_AS_CLASS = '1' THEN
				C_TEMP_ACNTCODE := '251413';
			else
				C_TEMP_ACNTCODE := '442412';
			end if;
		-- 현장별 사업장코드를 가지고 온다	
			select comp_code ,long_name
			  into C_COMP_CODE,C_PROJ_NAME
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
		-- 전표 마스터번호를 구한다.
			select efin_invoice_header_itf_s.nextval
			  into C_GROUP_ID
			  from dual; 
		-- 결재선 정보를 저장한다.
			y_sp_d_efin_invoice_copy(C_GROUP_ID,ai_unq_num,'A',V_GL_DT);
			C_FOLDER := C_COMP_CODE || '99999';
				C_CASH := 0;
				C_BILL := 0;
-- 전표번호를 구하기위한 TEMP
				SELECT V_ORDER_NUMBER || '-외주-' || replace(V_GL_DT,'-','') || '-'
				  INTO C_TEMP
				  FROM dual;
				SELECT C_TEMP || substrb(C_PROJ_NAME,1, 44 - lengthb(C_TEMP)) || '-'
				  INTO C_TEMP
				  FROM dual;
		-- 부가세명,부가세계정과목코드를 가지고 온다.
				select acntcode
				  into C_ACNTCODE
				  from z_code_vatclass
				 where vattag = V_VATCODE;
				select tax_id,tax_code_name_alt
				  into V_VATCODE,C_VATNAME
				  from efin_tax_codes_v
				 where org_code = C_COMP_CODE
					and account_code = C_ACNTCODE;
		-- 공급처 테이블에 거래처가 존재하는지 Check하여 미존재시 insert한다.
				IF F_COMM_SLIP_CHECK_SUPPLIER(C_ORG_ID,V_CUST_CODE) = False THEN
		-- Interface테이블에 거래처를 생성한다.
					y_sp_comm_slip_supplier(C_COMP_CODE,V_SBCR_NAME,V_CUST_CODE,V_CUST_TYPE,C_WBS_CODE,'211111',V_ZIP,V_ADDR,V_UPTAE,V_UPJONG,V_TREADE);
				END IF;
		-- 공급처테이블에서 vendor_id와 vendor_site_id를 가져온다
		--		select nvl(vendor_id,0),nvl(vendor_site_id,0)
		--		  into C_VENDOR_ID,C_VENDOR_SITE_ID
		--		  from efin_supplier_v
		--		 where org_id = C_ORG_ID
		--			and vat_registration_num = V_CUST_CODE; 
-- 선급금 공제 처리.		
		-- 선급금공제 금액이 존재할 경우 처리..
				IF V_PREPAY_AMT <> 0 THEN
					C_PREPAY_NOTAX := V_PRE_NOTAX;
					C_PREPAY_TAX   := V_PRE_TAX;
					C_PREPAY_VAT   := V_PRE_VAT;
					C_NOTAX_AMT    := V_NOTAX_AMT - C_PREPAY_NOTAX;
					C_TAX_AMT      := V_TAX_AMT - C_PREPAY_TAX;
					C_VAT          := V_VAT - C_PREPAY_VAT;
		--선급금 면세금액이 존재할 경우 처리
					IF C_PREPAY_NOTAX <> 0 THEN
			-- GL Interface 테이블에 자료를 생성한다.
				-- 선급금(면세)
						y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,V_SBCR_NAME || ' 선급금 정산',V_GL_DT,V_GL_DT,
														  V_SBCR_NAME,V_CUST_CODE,C_PREPAY_NOTAX,'','',C_WBS_CODE,
														  C_PROJ,'',C_TEMP_ACNTCODE,'선급금정산','외주','','',C_FOLDER,'',C_ORG_ID,C_PROJ_NAME,
														  V_SBCR_NAME || ' 선급금 정산','V','','','','');
						y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,V_SBCR_NAME || ' 선급금 정산',V_GL_DT,V_GL_DT,
														  V_SBCR_NAME,V_CUST_CODE,'',C_PREPAY_NOTAX,'',C_WBS_CODE,
														  C_PROJ,'','112211','선급금정산','외주','','',C_FOLDER,'',C_ORG_ID,C_PROJ_NAME,
														  V_SBCR_NAME || ' 선급금 정산','V','','','','');
					END IF;
		--선급금 과세금액이 존재할 경우 처리
					IF C_PREPAY_TAX <> 0 THEN
						IF C_ACNTCODE = '112421' THEN  -- 불공제일 경우
							select gl_je_lines_s.nextval -- 부가세연결고리를 만든다
							  into C_TAX_SEQ
							  from dual;
							C_TAX_TAG := 'T';
							C_TAX_CNT := 1;
							C_DR_AMT := C_PREPAY_TAX + C_PREPAY_VAT; -- 불공제일 경우 차변금액에 부가세를 포함.
						ELSE
							C_TAX_SEQ := '';
							C_TAX_TAG := '';
							C_TAX_CNT := '';
							C_DR_AMT := C_PREPAY_TAX;
						END IF;
			-- GL Interface 테이블에 자료를 생성한다.
				-- 선급금(면세)
						y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,V_SBCR_NAME || ' 선급금 정산',V_GL_DT,V_GL_DT,
														  V_SBCR_NAME,V_CUST_CODE,C_DR_AMT,'',C_TEMP_VATNAME,C_WBS_CODE,
														  C_PROJ,C_TAX_CNT,C_TEMP_ACNTCODE,'선급금정산','외주',C_TAX_SEQ,C_TAX_TAG,C_FOLDER,'',
														  C_ORG_ID,C_PROJ_NAME,V_SBCR_NAME || ' 선급금 정산','V','','','','');
						y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,V_SBCR_NAME || ' 선급금 정산',V_GL_DT,V_GL_DT,
														  V_SBCR_NAME,V_CUST_CODE,'',C_PREPAY_TAX,'',C_WBS_CODE,
														  C_PROJ,'','112212','선급금정산','외주','','',C_FOLDER,'',C_ORG_ID,C_PROJ_NAME,
														  V_SBCR_NAME || ' 선급금 정산','V','','','','');
						IF C_ACNTCODE = '112421' THEN  -- 불공제일경우 하나 더 생성.
							y_sp_const_slip_gl_invoice(C_COMP_CODE,C_GROUP_ID,V_SBCR_NAME || ' 선급금 정산',V_GL_DT,V_GL_DT,
															  V_SBCR_NAME,V_CUST_CODE,'',C_PREPAY_VAT,'',C_WBS_CODE,
															  C_PROJ,'',C_TEMP_ACNTCODE,'선급금정산','외주',C_TAX_SEQ,C_TAX_TAG,C_FOLDER,'',
															  C_ORG_ID,C_PROJ_NAME,V_SBCR_NAME || ' 선급금 정산','V','','','','');
						END IF;
					END IF;
			-- 배치화일을 Update 한다.
					y_sp_comm_slip_batch_flag(C_ORG_ID,'Journal');
				ELSE
					C_NOTAX_AMT := V_NOTAX_AMT;
					C_TAX_AMT   := V_TAX_AMT;
					C_VAT       := V_VAT;
				END IF;
-- 외주기성처리
				IF (V_CASH + V_BILL) <> 0 THEN		
					C_CASH_RT := trunc(V_CASH / (V_CASH + V_BILL),4); -- 현금지급율를 구한다.
				ELSE
					C_CASH_RT := 1;
				END IF;
		-- 면세금액이 존재할 경우 처리
				IF C_NOTAX_AMT <> 0 THEN
					C_DR_AMT := C_NOTAX_AMT; -- 차변금액
					C_CR_AMT := C_DR_AMT; -- 대변금액
					C_CASH   := TRUNC(C_DR_AMT * C_CASH_RT,0); -- 현금
					C_BILL   := C_DR_AMT - C_CASH;
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
			-- 외주비(면세)
					y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,to_char(ad_date,'yyyy-mm') || '월 외주기성',C_INVOICE,V_GL_DT,V_GL_DT,
													  V_SBCR_NAME,V_CUST_CODE,C_DR_AMT,C_CR_AMT,'외주기성',C_TEMP_VATNAME,C_WBS_CODE,
													  C_PROJ,1,C_TEMP_ACNTCODE,'211111',C_VENDOR_ID,C_VENDOR_SITE_ID,C_CASH,C_BILL,'ITEM','외주',C_ORG_ID,'V',
													  V_ORDER_NUMBER,V_BILL_PAY,C_WORK_DT,C_FOLDER,'',0);
			-- 매입면세(계산서)		
					y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,to_char(ad_date,'yyyy-mm') || '월 외주기성',C_INVOICE,V_GL_DT,V_GL_DT,
													  V_SBCR_NAME,V_CUST_CODE,0,C_CR_AMT,'외주기성',C_TEMP_VATNAME,C_WBS_CODE,
													  C_PROJ,1,'112423','211111',C_VENDOR_ID,C_VENDOR_SITE_ID,C_CASH,C_BILL,'TAX','외주',C_ORG_ID,'V',
											        V_ORDER_NUMBER,V_BILL_PAY,C_WORK_DT,C_FOLDER,'',0);
				END IF;
		-- 과세금액이 존재할 경우 처리
				IF C_TAX_AMT <> 0 THEN
					C_DR_AMT   := C_TAX_AMT; -- 차변금액
					C_TEMP_VAT := C_VAT;     -- 부가세금액
					C_CR_AMT   := C_DR_AMT + C_TEMP_VAT ; -- 대변금액(과세+부가세)
					C_CASH     := V_CASH - C_CASH; -- 현금
					C_BILL     := V_BILL - C_BILL; -- 어음
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
					y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,to_char(ad_date,'yyyy-mm') || '월 외주기성',C_INVOICE,V_GL_DT,V_GL_DT,
													  V_SBCR_NAME,V_CUST_CODE,C_DR_AMT,C_CR_AMT,'외주기성',C_VATNAME,C_WBS_CODE,
													  C_PROJ,1,C_TEMP_ACNTCODE,'211111',C_VENDOR_ID,C_VENDOR_SITE_ID,C_CASH,C_BILL,'ITEM','외주',
														C_ORG_ID,'V',V_ORDER_NUMBER,V_BILL_PAY,C_WORK_DT,C_FOLDER,'',0);
			-- 매입과세OR매입공통OR매입불공제(선택된 부가세코드와 연계된계정과목을 가지고 간다)
					IF C_ACNTCODE = '112421' THEN  --불공제일경우
						y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,to_char(ad_date,'yyyy-mm') || '월 외주기성',C_INVOICE,V_GL_DT,V_GL_DT,
														  V_SBCR_NAME,V_CUST_CODE,C_TEMP_VAT,C_CR_AMT,'외주기성',C_VATNAME,C_WBS_CODE,
														  C_PROJ,1,C_TEMP_ACNTCODE,'211111',C_VENDOR_ID,C_VENDOR_SITE_ID,C_CASH,C_BILL,'TAX','외주',
															C_ORG_ID,'V',V_ORDER_NUMBER,V_BILL_PAY,C_WORK_DT,C_FOLDER,'',0);
					ELSE
						y_sp_comm_slip_ap_invoice(C_COMP_CODE,C_GROUP_ID,to_char(ad_date,'yyyy-mm') || '월 외주기성',C_INVOICE,V_GL_DT,V_GL_DT,
														  V_SBCR_NAME,V_CUST_CODE,C_TEMP_VAT,C_CR_AMT,'외주기성',C_VATNAME,C_WBS_CODE,
														  C_PROJ,1,C_ACNTCODE,'211111',C_VENDOR_ID,C_VENDOR_SITE_ID,C_CASH,C_BILL,'TAX','외주',
															C_ORG_ID,'V',V_ORDER_NUMBER,V_BILL_PAY,C_WORK_DT,C_FOLDER,'',0);
					END IF;
				END IF;
	-- 보증서접수현황테이블에 전표마스터번호를 Setting 한다.
			update s_pay
				set invoice_num = C_GROUP_ID
			 where dept_code = as_dept_code
				and yymm = ad_yymm
				and seq = ai_seq
				and order_number = V_ORDER_NUMBER;

		--정산기성의 경우 정산여부 변경한다 시작
		SELECT
			nvl(COUNT(*),0)
		INTO
			C_CLOSE_YN
		FROM
			s_cn_list a,
        	(
        	SELECT
        		B.DEPT_CODE, B.ORDER_NUMBER,
        		SUM(nvl(B.TM_PRGS,0)) TM_PRGS,
        		SUM(nvl(B.TM_PRGS_NOTAX,0)) TM_PRGS_NOTAX,
        		SUM(nvl(B.TM_PURCHASE_VAT,0)) TM_PURCHASE_VAT,
        		SUM(nvl(B.TM_VAT,0)) TM_VAT,
        		SUM(nvl(B.TM_PRE_TAX,0)) TM_PRE_TAX,
        		SUM(nvl(B.TM_PRE_NOTAX,0)) TM_PRE_NOTAX,
        		SUM(nvl(B.TM_PRE_VAT,0)) TM_PRE_VAT
        	FROM
        		S_PAY B
			WHERE
				B.DEPT_CODE = as_dept_code AND B.ORDER_NUMBER = V_ORDER_NUMBER
        	GROUP BY
        		B.DEPT_CODE, B.ORDER_NUMBER
        	) C
		WHERE
			A.DEPT_CODE = C.DEPT_CODE(+) AND A.ORDER_NUMBER = C.ORDER_NUMBER(+)
		AND A.DEPT_CODE = as_dept_code AND A.ORDER_NUMBER = V_ORDER_NUMBER
        AND 
        (
        	A.SUPPLY_AMT_TAX = nvl(C.TM_PRGS,0)
        AND A.SUPPLY_AMT_NOTAX = nvl(C.TM_PRGS_NOTAX,0)
        AND A.purchase_vat = nvl(C.TM_PURCHASE_VAT,0)
        AND A.vat = nvl(C.TM_VAT,0)
        AND A.safety_amt1 = nvl(C.TM_PRE_TAX,0)
        AND A.safety_amt2 = nvl(C.TM_PRE_NOTAX,0)
        AND A.previous_vat = nvl(C.TM_PRE_VAT,0)
        );
		IF C_CLOSE_YN > 0 THEN
			SELECT nvl(MAX(CHG_DEGREE),1) INTO C_CNT FROM S_CHG_CN_LIST WHERE DEPT_CODE = as_dept_code AND ORDER_NUMBER = V_ORDER_NUMBER;
			UPDATE S_CN_LIST SET close_tag  = 'Y' WHERE dept_code = as_dept_code AND order_number = V_ORDER_NUMBER;
			UPDATE S_CHG_CN_LIST SET close_tag  = 'Y' WHERE dept_code = as_dept_code AND order_number = V_ORDER_NUMBER AND chg_degree = C_CNT;
		END IF;
		--정산기성의 경우 정산여부 변경한다 종료

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
END y_sp_s_slip_prgs_as;
