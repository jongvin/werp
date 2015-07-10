/* ============================================================================ */
/* 함수명 : y_sp_s_slip_prgs(CJ개발)                                            */
/* 기  능 : 외주관리-기성전표 발행                                               */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 전표년월               ==> as_date(DATE)        		               */
/*        : 순번                   ==> ai_seq(INTEGER)        		               */
/*        : 작성자사번             ==> as_date(string)        		               */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2006.04.12                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_slip_prgs (as_dept_code    IN   VARCHAR2,
																	  as_date         IN   DATE,
																	  ai_seq          IN   INTEGER,
                                                     as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
select a.tm_prgs,a.tm_vat,a.tm_prgs_notax + a.tm_purchase_vat,a.tm_cash,a.tm_bill,a.tm_pre_tax,a.tm_pre_vat,a.tm_pre_notax,a.pay_dt,a.check_dt,
		 b.sbc_name || ' ' || to_char(a.yymm,'YYYY.MM') || '월 기성',b.sbc_name || ' ' || to_char(a.yymm,'YYYY.MM') || '월 선급금공제',b.acc_tag,b.comm_tag,b.vatcode,b.bill_day,
		 c.businessman_number,c.sbcr_name,c.rep_name1,c.kind_bussinesstype,c.kinditem,c.zip_number1,c.address1,c.tel_number1,c.chrg_name1,c.chrg_email,a.order_number
  from s_pay a,
       s_cn_list b,
       s_sbcr c
 where b.sbcr_code = c.sbcr_code
   and a.dept_code = b.dept_code
   and a.order_number = b.order_number
   and a.dept_code = as_dept_code
   and a.yymm = as_date
   and a.seq = ai_seq
order by c.sbcr_name asc;

-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   Wk_Chk              NUMBER(10,0) DEFAULT 0 ;
   WK_Chk_msg          VARCHAR2(100);

-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_TM_PRGS           NUMBER(20,5);
	V_TM_VAT            NUMBER(20,5);
	V_TM_PRGS_NOTAX     NUMBER(20,5);
	V_CASH              NUMBER(20,5);
	V_BILL              NUMBER(20,5);
	V_TM_PRE_TAX        NUMBER(20,5);
	V_TM_PRE_VAT        NUMBER(20,5);
	V_TM_PRE_NOTAX      NUMBER(20,5);
	V_PAY_DT            DATE;
	V_CHECK_DT          DATE;
	V_CONT              VARCHAR2(100);
	V_CONT1             VARCHAR2(100);
	V_ACC_TAG           VARCHAR2(1);
	V_COMM_TAG          VARCHAR2(1);
	V_VATCODE           VARCHAR2(8);
	V_BILL_DAY          NUMBER(20,0);
	V_CUST_CODE         VARCHAR2(20);
   V_SBCR_NAME         s_sbcr.sbcr_name%type;
   V_REP_NAME          s_sbcr.rep_name1%type;
   V_KIND_TYPE         s_sbcr.kind_bussinesstype%type;
   V_KINDITEM          s_sbcr.kinditem%type;
   V_ZIP_NUM           s_sbcr.zip_number1%type;
   V_ADDR              s_sbcr.address1%type;
   V_TEL_NUM           s_sbcr.tel_number1%type;
   V_CHRG_NAME         s_sbcr.chrg_name1%type;
   V_CHRG_EMAIL        s_sbcr.chrg_email%type;
	V_ORDER_NUMBER      s_pay.order_number%type;
	C_SLIP_DT           DATE;
	C_MAKE_DT           DATE;
   C_COMP_CODE         VARCHAR2(10);
	C_ACNT_CODE         VARCHAR2(10);
	C_VAT_CODE          VARCHAR2(10);
	C_CR_CODE           VARCHAR2(10);
	C_SEQ               INTEGER;
	C_AMT               NUMBER(20,5);
	C_SET_AMT           NUMBER(20,5);
	C_TEMP_AMT          NUMBER(20,5);
   C_CHK         VARCHAR2(10);
	C_SLIP_ID           NUMBER;
	C_SLIP_IDSEQ        NUMBER;
-- 전표관련 변수
   IrBody              T_ACC_SLIP_BODY%RowType;
   IsClassCode         T_CLASS_CODE.CLASS_CODE%Type;
   IrHead              T_ACC_SLIP_HEAD%RowType;
   IsChargePers        T_ACC_SLIP_HEAD.CHARGE_PERS%Type;
   InMakeSlipLine      Number;
	IsCustName          T_ACC_SLIP_BODY.CUST_NAME%Type;
	InCustSeq           T_CUST_CODE.CUST_SEQ%Type;

BEGIN
 BEGIN
-- 사업장코드를 가지고 온다
   	C_COMP_CODE := PKG_MAKE_SLIP.Get_Comp_code(as_dept_code);

-- 회계 확정 담당자를 가지고 온다	
		IsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS('S000000001',C_COMP_CODE);

-- 부문을 구한다.
		IsClassCode := PKG_MAKE_SLIP.Get_Class_code(as_dept_code);
		select slip_dt,sysdate
		  into C_SLIP_DT,C_MAKE_DT
		  from s_prgs_yymm
		 where dept_code = as_dept_code
			and yymm = as_date
			and seq = ai_seq;

-- 전표마스터를 생성한다(사업장코드,현장코드,전표기준일,'1'대체,'E'외주,작성자사번,자동전표코드,회계확정담당,입력자사번)
		IrHead := PKG_MAKE_SLIP.New_Head(C_COMP_CODE,as_dept_code,C_SLIP_DT,'1','E',as_user,'S000000001',IsChargePers,as_user);
--		IrHead.MAKE_DT     := C_MAKE_DT;  -- 작성일자

		PKG_MAKE_SLIP.Insert_Head(IrHead);

-- 테이블에 전표마스터번호를 Setting 한다.
		update s_pay
			set invoice_num = IrHead.Slip_ID
		 where dept_code = as_dept_code
			and yymm = as_date
			and seq  = ai_seq;

		InMakeSlipLine := 0;

-- 전표내역을 만들기 위한 커서
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO V_TM_PRGS,V_TM_VAT,V_TM_PRGS_NOTAX,V_CASH,V_BILL,V_TM_PRE_TAX,V_TM_PRE_VAT,
										 V_TM_PRE_NOTAX,V_PAY_DT,V_CHECK_DT,V_CONT,V_CONT1,V_ACC_TAG,V_COMM_TAG,V_VATCODE,
										 V_BILL_DAY,V_CUST_CODE,V_SBCR_NAME,V_REP_NAME,V_KIND_TYPE,V_KINDITEM,
										 V_ZIP_NUM,V_ADDR,V_TEL_NUM,V_CHRG_NAME,V_CHRG_EMAIL,V_ORDER_NUMBER;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
	
			-- 거래처순번을 구한다.
			InCustSeq := PKG_MAKE_SLIP.Get_Cust_Seq(V_CUST_CODE);
			IF InCustSeq is null THEN       -- 회계거래처에 없을경우 거래처 테이블에 생성한다.
				InCustSeq := F_T_NEW_CUST(V_CUST_CODE,V_SBCR_NAME,V_REP_NAME,'1',V_KIND_TYPE,V_KINDITEM,V_ZIP_NUM,V_ADDR,
												  '',V_TEL_NUM,'ZZ',null,null,V_CHRG_NAME,V_CHRG_EMAIL,as_user);
			END IF;
			-- 거래처명칭을 구한다.
			IsCustName := PKG_MAKE_SLIP.Get_Cust_Name(InCustSeq);

			CASE  V_ACC_TAG 
				WHEN '1' THEN                        -- 토목
         		C_ACNT_CODE := '450010100';
				WHEN '2' THEN                        -- 건축
					C_ACNT_CODE := '450020100';
				WHEN '3' THEN                        -- 기계
					C_ACNT_CODE := '450030100';
				WHEN '4' THEN                        -- 전기
					C_ACNT_CODE := '450040100';
				WHEN '5' THEN                        -- 설계
					C_ACNT_CODE := '450050100';
				WHEN '6' THEN                        -- 감리
					C_ACNT_CODE := '450060100';
				ELSE                                 -- 기타
					C_ACNT_CODE := '450900100';
			END CASE;

     		C_CR_CODE   := '210030100';
-- 외주비처리
--			IF V_COMM_TAG = 'Y' OR V_VATCODE = '3' THEN
			IF V_VATCODE = '3' THEN
				-- 전표라인을 구한다.
				InMakeSlipLine := InMakeSlipLine + 1;
	
				-- 뉴 Body를 구한다(차변).
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_ACNT_CODE,IsClassCode,Null);

				IF V_VATCODE = '3' THEN
					C_VAT_CODE := '111221300';
				ELSE
					C_VAT_CODE := '111220300';
				END IF;
				C_AMT := V_TM_PRGS + V_TM_PRGS_NOTAX;

				-- Body에 내역을 넣어준다.
				IF V_VATCODE = '3' THEN
					IrBody.DB_AMT            := C_AMT + V_TM_VAT;        -- 차변금액
				ELSE
					IrBody.DB_AMT            := C_AMT;        -- 차변금액
				END IF;
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- 세무사업장코드
				IrBody.COMP_CODE         := C_COMP_CODE;  -- 귀속사업장코드
				IrBody.DEPT_CODE         := as_dept_code; -- 귀속부서
				IrBody.VAT_DT            := V_PAY_DT;     -- 증빙일자
				IrBody.SUPAMT            := 0;            -- 공급가(부가세 라인에서만 입력)
				IrBody.VATAMT            := 0;            -- 부가세(부가세 라인에서만 입력)
				IrBody.CUST_SEQ          := InCustSeq;    -- 거래처순번
				IrBody.CUST_NAME         := IsCustName;   -- 거래처명칭
				IrBody.SUMMARY1          := V_CONT;       -- 적요
				IrBody.PAY_CON_CASH      := V_CASH;       -- 현금
				IrBody.PAY_CON_BILL      := V_BILL;       -- 어음
				IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- 어음만기일수
				IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- 지급희망일
		
				-- Body에 저장한다.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
		
				InMakeSlipLine := InMakeSlipLine + 1;
	
				-- 뉴 Body를 구한다(차변:부가세라인)
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_VAT_CODE,IsClassCode,Null);
				
				-- Body에 내역을 넣어준다.
				IF V_VATCODE = '3' THEN
					IrBody.DB_AMT            := 0;        -- 차변금액
				ELSE
					IrBody.DB_AMT            := V_TM_VAT;        -- 차변금액
				END IF;
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- 세무사업장코드
				IrBody.COMP_CODE         := C_COMP_CODE;  -- 귀속사업장코드
				IrBody.DEPT_CODE         := as_dept_code; -- 귀속부서
				IrBody.VAT_DT            := V_PAY_DT;     -- 증빙일자
				IrBody.SUPAMT            := C_AMT;        -- 공급가(부가세 라인에서만 입력)
				IrBody.VATAMT            := V_TM_VAT;        -- 부가세(부가세 라인에서만 입력)
				IrBody.CUST_SEQ          := InCustSeq;    -- 거래처순번
				IrBody.CUST_NAME         := IsCustName;   -- 거래처명칭
				IrBody.SUMMARY1          := V_CONT;       -- 적요
				IrBody.PAY_CON_CASH      := V_CASH;       -- 현금
				IrBody.PAY_CON_BILL      := V_BILL;       -- 어음
				IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- 어음만기일수
				IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- 지급희망일
	
				-- Body에 저장한다.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
	
	
				InMakeSlipLine := InMakeSlipLine + 1;
	
				-- 뉴 Body를 구한다(대변)
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
				
				-- Body에 내역을 넣어준다.
				IrBody.CR_AMT            := C_AMT + V_TM_VAT; -- 대변금액
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- 세무사업장코드
				IrBody.COMP_CODE         := C_COMP_CODE;   -- 귀속사업장코드
				IrBody.DEPT_CODE         := as_dept_code;  -- 귀속부서
				IrBody.VAT_DT            := V_PAY_DT;      -- 증빙일자
				IrBody.SUPAMT            := 0;         -- 공급가(부가세 라인에서만 입력)
				IrBody.VATAMT            := 0;         -- 부가세(부가세 라인에서만 입력)
				IrBody.CUST_SEQ          := InCustSeq;     -- 거래처순번
				IrBody.CUST_NAME         := IsCustName;    -- 거래처명칭
				IrBody.SUMMARY1          := V_CONT;        -- 적요
				IrBody.PAY_CON_CASH      := V_CASH;        -- 현금
				IrBody.PAY_CON_BILL      := V_BILL;        -- 어음
				IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;    -- 어음만기일수
				IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- 지급희망일
				IrBody.MNG_ITEM_DT1      := V_PAY_DT; -- 계산서일자
	
				-- Body에 저장한다.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
			ELSE
				IF V_TM_PRGS <> 0 THEN
					-- 전표라인을 구한다.
					InMakeSlipLine := InMakeSlipLine + 1;
		
					-- 뉴 Body를 구한다(차변).
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_ACNT_CODE,IsClassCode,Null);
	
					C_VAT_CODE := '111220100';
	
					-- Body에 내역을 넣어준다.
					IrBody.DB_AMT            := V_TM_PRGS;        -- 차변금액
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- 세무사업장코드
					IrBody.COMP_CODE         := C_COMP_CODE;  -- 귀속사업장코드
					IrBody.DEPT_CODE         := as_dept_code; -- 귀속부서
					IrBody.VAT_DT            := V_PAY_DT;     -- 증빙일자
					IrBody.SUPAMT            := 0;            -- 공급가(부가세 라인에서만 입력)
					IrBody.VATAMT            := 0;            -- 부가세(부가세 라인에서만 입력)
					IrBody.CUST_SEQ          := InCustSeq;    -- 거래처순번
					IrBody.CUST_NAME         := IsCustName;   -- 거래처명칭
					IrBody.SUMMARY1          := V_CONT;       -- 적요
					IrBody.PAY_CON_CASH      := V_CASH;       -- 현금
					IrBody.PAY_CON_BILL      := V_BILL;       -- 어음
					IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- 어음만기일수
					IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- 지급희망일
			
					-- Body에 저장한다.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
			
					InMakeSlipLine := InMakeSlipLine + 1;
		
					-- 뉴 Body를 구한다(차변:부가세라인)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_VAT_CODE,IsClassCode,Null);
					
					-- Body에 내역을 넣어준다.
					IrBody.DB_AMT            := V_TM_VAT;        -- 차변금액
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- 세무사업장코드
					IrBody.COMP_CODE         := C_COMP_CODE;  -- 귀속사업장코드
					IrBody.DEPT_CODE         := as_dept_code; -- 귀속부서
					IrBody.VAT_DT            := V_PAY_DT;     -- 증빙일자
					IrBody.SUPAMT            := V_TM_PRGS;        -- 공급가(부가세 라인에서만 입력)
					IrBody.VATAMT            := V_TM_VAT;        -- 부가세(부가세 라인에서만 입력)
					IrBody.CUST_SEQ          := InCustSeq;    -- 거래처순번
					IrBody.CUST_NAME         := IsCustName;   -- 거래처명칭
					IrBody.SUMMARY1          := V_CONT;       -- 적요
					IrBody.PAY_CON_CASH      := V_CASH;       -- 현금
					IrBody.PAY_CON_BILL      := V_BILL;       -- 어음
					IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- 어음만기일수
					IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- 지급희망일
		
					-- Body에 저장한다.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
		
					InMakeSlipLine := InMakeSlipLine + 1;
		
					-- 뉴 Body를 구한다(대변)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
					
					-- Body에 내역을 넣어준다.
					IrBody.CR_AMT            := V_TM_PRGS + V_TM_VAT; -- 대변금액
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- 세무사업장코드
					IrBody.COMP_CODE         := C_COMP_CODE;   -- 귀속사업장코드
					IrBody.DEPT_CODE         := as_dept_code;  -- 귀속부서
					IrBody.VAT_DT            := V_PAY_DT;      -- 증빙일자
					IrBody.SUPAMT            := 0;         -- 공급가(부가세 라인에서만 입력)
					IrBody.VATAMT            := 0;         -- 부가세(부가세 라인에서만 입력)
					IrBody.CUST_SEQ          := InCustSeq;     -- 거래처순번
					IrBody.CUST_NAME         := IsCustName;    -- 거래처명칭
					IrBody.SUMMARY1          := V_CONT;        -- 적요
					IrBody.PAY_CON_CASH      := V_CASH;        -- 현금
					IrBody.PAY_CON_BILL      := V_BILL;        -- 어음
					IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;    -- 어음만기일수
					IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- 지급희망일
					IrBody.MNG_ITEM_DT1      := V_PAY_DT; -- 계산서일자
		
					-- Body에 저장한다.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
				END IF;
				IF V_TM_PRGS_NOTAX <> 0 THEN
					-- 전표라인을 구한다.
					InMakeSlipLine := InMakeSlipLine + 1;
		
					-- 뉴 Body를 구한다(차변).
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_ACNT_CODE,IsClassCode,Null);
	
					C_VAT_CODE := '111220200';
	
					-- Body에 내역을 넣어준다.
					IrBody.DB_AMT            := V_TM_PRGS_NOTAX;        -- 차변금액
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- 세무사업장코드
					IrBody.COMP_CODE         := C_COMP_CODE;  -- 귀속사업장코드
					IrBody.DEPT_CODE         := as_dept_code; -- 귀속부서
					IrBody.VAT_DT            := V_PAY_DT;     -- 증빙일자
					IrBody.SUPAMT            := 0;            -- 공급가(부가세 라인에서만 입력)
					IrBody.VATAMT            := 0;            -- 부가세(부가세 라인에서만 입력)
					IrBody.CUST_SEQ          := InCustSeq;    -- 거래처순번
					IrBody.CUST_NAME         := IsCustName;   -- 거래처명칭
					IrBody.SUMMARY1          := V_CONT;       -- 적요
					IrBody.PAY_CON_CASH      := V_CASH;       -- 현금
					IrBody.PAY_CON_BILL      := V_BILL;       -- 어음
					IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- 어음만기일수
					IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- 지급희망일
			
					-- Body에 저장한다.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
			
					InMakeSlipLine := InMakeSlipLine + 1;
		
					-- 뉴 Body를 구한다(차변:부가세라인)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_VAT_CODE,IsClassCode,Null);
					
					-- Body에 내역을 넣어준다.
					IrBody.DB_AMT            := 0;        -- 차변금액
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- 세무사업장코드
					IrBody.COMP_CODE         := C_COMP_CODE;  -- 귀속사업장코드
					IrBody.DEPT_CODE         := as_dept_code; -- 귀속부서
					IrBody.VAT_DT            := V_PAY_DT;     -- 증빙일자
					IrBody.SUPAMT            := V_TM_PRGS_NOTAX;        -- 공급가(부가세 라인에서만 입력)
					IrBody.VATAMT            := 0;        -- 부가세(부가세 라인에서만 입력)
					IrBody.CUST_SEQ          := InCustSeq;    -- 거래처순번
					IrBody.CUST_NAME         := IsCustName;   -- 거래처명칭
					IrBody.SUMMARY1          := V_CONT;       -- 적요
					IrBody.PAY_CON_CASH      := V_CASH;       -- 현금
					IrBody.PAY_CON_BILL      := V_BILL;       -- 어음
					IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- 어음만기일수
					IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- 지급희망일
		
					-- Body에 저장한다.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
		
		
					InMakeSlipLine := InMakeSlipLine + 1;
		
					-- 뉴 Body를 구한다(대변)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
					
					-- Body에 내역을 넣어준다.
					IrBody.CR_AMT            := V_TM_PRGS_NOTAX; -- 대변금액
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- 세무사업장코드
					IrBody.COMP_CODE         := C_COMP_CODE;   -- 귀속사업장코드
					IrBody.DEPT_CODE         := as_dept_code;  -- 귀속부서
					IrBody.VAT_DT            := V_PAY_DT;      -- 증빙일자
					IrBody.SUPAMT            := 0;         -- 공급가(부가세 라인에서만 입력)
					IrBody.VATAMT            := 0;         -- 부가세(부가세 라인에서만 입력)
					IrBody.CUST_SEQ          := InCustSeq;     -- 거래처순번
					IrBody.CUST_NAME         := IsCustName;    -- 거래처명칭
					IrBody.SUMMARY1          := V_CONT;        -- 적요
					IrBody.PAY_CON_CASH      := V_CASH;        -- 현금
					IrBody.PAY_CON_BILL      := V_BILL;        -- 어음
					IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;    -- 어음만기일수
					IrBody.ANTICIPATION_DT   := V_CHECK_DT; -- 지급희망일
					IrBody.MNG_ITEM_DT1      := V_PAY_DT; -- 계산서일자
		
					-- Body에 저장한다.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
				END IF;
			END IF;
-- 선급금공제처리
     		C_CR_CODE   := '111250100';
			IF V_TM_PRE_TAX <> 0 THEN -- 과세처리
				IF V_VATCODE = '3' THEN
					C_VAT_CODE := '111221300';
				ELSE
					C_VAT_CODE := '111220100';
				END IF;

				-- 전표라인을 구한다.
				InMakeSlipLine := InMakeSlipLine + 1;
	
				-- 뉴 Body를 구한다(차변).
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_ACNT_CODE,IsClassCode,Null);

				-- Body에 내역을 넣어준다.
				IF V_VATCODE = '3' THEN
					C_AMT            := V_TM_PRE_TAX + V_TM_PRE_VAT;        -- 차변금액
				ELSE
					C_AMT            := V_TM_PRE_TAX;        -- 차변금액
				END IF;
				IrBody.DB_AMT            := C_AMT;        -- 차변금액
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- 세무사업장코드
				IrBody.COMP_CODE         := C_COMP_CODE;  -- 귀속사업장코드
				IrBody.DEPT_CODE         := as_dept_code; -- 귀속부서
				IrBody.VAT_DT            := V_PAY_DT;     -- 증빙일자
				IrBody.SUPAMT            := 0;            -- 공급가(부가세 라인에서만 입력)
				IrBody.VATAMT            := 0;            -- 부가세(부가세 라인에서만 입력)
				IrBody.CUST_SEQ          := InCustSeq;    -- 거래처순번
				IrBody.CUST_NAME         := IsCustName;   -- 거래처명칭
				IrBody.SUMMARY1          := V_CONT1;       -- 적요
		
				-- Body에 저장한다.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
		
				InMakeSlipLine := InMakeSlipLine + 1;
				-- 뉴 Body를 구한다(대변)
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);

				LOOP 
					select a.invoice_num,a.invoice_num1,a.rem_amt
					  into C_SLIP_ID,C_SLIP_IDSEQ,C_SET_AMT
					  from ( select a.invoice_num,a.invoice_num1,a.rem_amt,rownum ll_seq
								  from ( select max(a.invoice_num) invoice_num,max(a.invoice_num1) invoice_num1,nvl(sum(db_amt),0) - nvl(sum(cr_amt),0) rem_amt
											  from s_guarantee_accept a,
													 t_acc_slip_body1 b
											 where a.invoice_num = b.reset_slip_id (+)
												and a.invoice_num1 = b.reset_slip_idseq (+)
												and a.dept_code = as_dept_code
												and a.order_number = V_ORDER_NUMBER
												and a.guarantee_class = '2'
												and a.invoice_num is not null
										group by a.invoice_num,a.invoice_num1 ) a
								 where a.rem_amt <> 0
								 order by a.invoice_num,a.invoice_num1 ) a
					 where a.ll_seq = 1;
					IF C_AMT <= C_SET_AMT THEN
						EXIT;
					END IF;
					C_TEMP_AMT := C_AMT - C_SET_AMT;

					IrBody.CR_AMT            := C_SET_AMT;     -- 대변금액
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- 세무사업장코드
					IrBody.COMP_CODE         := C_COMP_CODE;   -- 귀속사업장코드
					IrBody.DEPT_CODE         := as_dept_code;  -- 귀속부서
					IrBody.VAT_DT            := V_PAY_DT;      -- 증빙일자
					IrBody.SUPAMT            := 0;             -- 공급가(부가세 라인에서만 입력)
					IrBody.VATAMT            := 0;             -- 부가세(부가세 라인에서만 입력)
					IrBody.CUST_SEQ          := InCustSeq;     -- 거래처순번
					IrBody.CUST_NAME         := IsCustName;    -- 거래처명칭
					IrBody.SUMMARY1          := V_CONT1;       -- 적요
					IrBody.RESET_SLIP_ID     := C_SLIP_ID;
					IrBody.RESET_SLIP_IDSEQ  := C_SLIP_IDSEQ;
		
					-- Body에 저장한다.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
					C_AMT := C_TEMP_AMT;
	
					-- 전표라인을 구한다.
					InMakeSlipLine := InMakeSlipLine + 1;
					-- 뉴 Body를 구한다(대변)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
				END LOOP;

				-- Body에 내역을 넣어준다.
				IrBody.CR_AMT            := C_AMT; -- 대변금액
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- 세무사업장코드
				IrBody.COMP_CODE         := C_COMP_CODE;   -- 귀속사업장코드
				IrBody.DEPT_CODE         := as_dept_code;  -- 귀속부서
				IrBody.VAT_DT            := V_PAY_DT;      -- 증빙일자
				IrBody.SUPAMT            := 0;         -- 공급가(부가세 라인에서만 입력)
				IrBody.VATAMT            := 0;         -- 부가세(부가세 라인에서만 입력)
				IrBody.CUST_SEQ          := InCustSeq;     -- 거래처순번
				IrBody.CUST_NAME         := IsCustName;    -- 거래처명칭
				IrBody.SUMMARY1          := V_CONT1;        -- 적요
				IrBody.RESET_SLIP_ID     := C_SLIP_ID;
				IrBody.RESET_SLIP_IDSEQ  := C_SLIP_IDSEQ;
	
				-- Body에 저장한다.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
					
			END IF;

			IF V_TM_PRE_NOTAX <> 0 THEN -- 면세처리
				C_VAT_CODE := '111220200';

				C_AMT := V_TM_PRE_NOTAX;

					-- 전표라인을 구한다.
				InMakeSlipLine := InMakeSlipLine + 1;
	
				-- 뉴 Body를 구한다(차변).
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_ACNT_CODE,IsClassCode,Null);

				IrBody.DB_AMT            := C_AMT;        -- 차변금액
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- 세무사업장코드
				IrBody.COMP_CODE         := C_COMP_CODE;  -- 귀속사업장코드
				IrBody.DEPT_CODE         := as_dept_code; -- 귀속부서
				IrBody.VAT_DT            := V_PAY_DT;     -- 증빙일자
				IrBody.SUPAMT            := 0;            -- 공급가(부가세 라인에서만 입력)
				IrBody.VATAMT            := 0;            -- 부가세(부가세 라인에서만 입력)
				IrBody.CUST_SEQ          := InCustSeq;    -- 거래처순번
				IrBody.CUST_NAME         := IsCustName;   -- 거래처명칭
				IrBody.SUMMARY1          := V_CONT1;       -- 적요
		
				-- Body에 저장한다.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
		
				InMakeSlipLine := InMakeSlipLine + 1;
	
				-- 뉴 Body를 구한다(대변)
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
				LOOP 
					select a.invoice_num,a.invoice_num1,a.rem_amt
					  into C_SLIP_ID,C_SLIP_IDSEQ,C_SET_AMT
					  from ( select a.invoice_num,a.invoice_num1,a.rem_amt,rownum ll_seq
								  from ( select max(a.invoice_num) invoice_num,max(a.invoice_num1) invoice_num1,nvl(sum(db_amt),0) - nvl(sum(cr_amt),0) rem_amt
											  from s_guarantee_accept a,
													 t_acc_slip_body1 b
											 where a.invoice_num = b.reset_slip_id (+)
												and a.invoice_num1 = b.reset_slip_idseq (+)
												and a.dept_code = as_dept_code
												and a.order_number = V_ORDER_NUMBER
												and a.guarantee_class = '2'
												and a.invoice_num is not null
										group by a.invoice_num,a.invoice_num1 ) a
								 where a.rem_amt <> 0
								 order by a.invoice_num,a.invoice_num1 ) a
					 where a.ll_seq = 1;
					IF C_AMT <= C_SET_AMT THEN
						EXIT;
					END IF;
					C_TEMP_AMT := C_AMT - C_SET_AMT;

					IrBody.CR_AMT            := C_SET_AMT;     -- 대변금액
					IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- 세무사업장코드
					IrBody.COMP_CODE         := C_COMP_CODE;   -- 귀속사업장코드
					IrBody.DEPT_CODE         := as_dept_code;  -- 귀속부서
					IrBody.VAT_DT            := V_PAY_DT;      -- 증빙일자
					IrBody.SUPAMT            := 0;             -- 공급가(부가세 라인에서만 입력)
					IrBody.VATAMT            := 0;             -- 부가세(부가세 라인에서만 입력)
					IrBody.CUST_SEQ          := InCustSeq;     -- 거래처순번
					IrBody.CUST_NAME         := IsCustName;    -- 거래처명칭
					IrBody.SUMMARY1          := V_CONT1;       -- 적요
					IrBody.RESET_SLIP_ID     := C_SLIP_ID;
					IrBody.RESET_SLIP_IDSEQ  := C_SLIP_IDSEQ;
		
					-- Body에 저장한다.
					PKG_MAKE_SLIP.Insert_Body(IrBody);
					C_AMT := C_TEMP_AMT;
	
					-- 전표라인을 구한다.
					InMakeSlipLine := InMakeSlipLine + 1;
					-- 뉴 Body를 구한다(대변)
					IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
				END LOOP;
				
				-- Body에 내역을 넣어준다.
				IrBody.CR_AMT            := C_AMT ; -- 대변금액
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- 세무사업장코드
				IrBody.COMP_CODE         := C_COMP_CODE;   -- 귀속사업장코드
				IrBody.DEPT_CODE         := as_dept_code;  -- 귀속부서
				IrBody.VAT_DT            := V_PAY_DT;      -- 증빙일자
				IrBody.SUPAMT            := 0;         -- 공급가(부가세 라인에서만 입력)
				IrBody.VATAMT            := 0;         -- 부가세(부가세 라인에서만 입력)
				IrBody.CUST_SEQ          := InCustSeq;     -- 거래처순번
				IrBody.CUST_NAME         := IsCustName;    -- 거래처명칭
				IrBody.SUMMARY1          := V_CONT1;        -- 적요
				IrBody.RESET_SLIP_ID     := C_SLIP_ID;
				IrBody.RESET_SLIP_IDSEQ  := C_SLIP_IDSEQ;
	
				-- Body에 저장한다.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
					
			END IF;
		END LOOP;
		CLOSE DETAIL_CUR;

-- 전표를 검증한다.
		PKG_MAKE_SLIP.Check_Slip(IrHead.Slip_ID);

--    EXCEPTION
--      WHEN others THEN 
--           IF SQL%NOTFOUND THEN
--              e_msg      := '외주기성전표생성 실패! [Line No: 2]' || C_TEMP_AMT || '-' || C_SET_AMT || '-'  ;
--              Wk_errflag := -20020;
         
--              GOTO EXIT_ROUTINE;
--           END IF;   
--				Raise;
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
END y_sp_s_slip_prgs;
