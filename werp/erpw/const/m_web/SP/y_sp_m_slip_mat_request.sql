 /* ============================================================================ */
/* 함수명 : y_sp_m_slip_mat_request(CJ개발)                                      */
/* 기  능 : 자재관리-입고전표 발행                                               */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 전표년월               ==> as_date(DATE)        		               */
/*        : 작성자사번             ==> as_date(string)        		               */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2006.04.12                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_slip_mat_request (as_dept_code    IN   VARCHAR2,
																	  as_date         IN   DATE,
                                                     as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT a.amt,a.vatamount,a.yyyymmdd,a.cont,a.cash_amt,a.bill_amt,a.bill_day,a.ditag,a.vatcode,
		 b.businessman_number,b.sbcr_name,b.rep_name1,b.kind_bussinesstype,b.kinditem,b.zip_number1,b.address1,b.tel_number1,b.chrg_name1,b.chrg_email,a.work_dt
  FROM m_vat a,
		 s_sbcr b
 WHERE a.sbcr_code = b.sbcr_code
	AND a.dept_code = as_dept_code
	AND trunc(a.yyyymmdd,'MM')= as_date
ORDER BY a.sbcr_code,a.ditag;

-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   Wk_Chk              NUMBER(10,0) DEFAULT 0 ;
   WK_Chk_msg          VARCHAR2(100);

-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_AMT               NUMBER(20,5);
	V_VAT               NUMBER(20,5);
	V_YYMMDD            DATE;
	V_CONT              VARCHAR2(100);
	V_CASH              NUMBER(20,5);
	V_BILL              NUMBER(20,5);
	V_BILL_DAY          NUMBER(20,0);
	V_DITAG             VARCHAR2(2);
	V_VAT_CLASS         VARCHAR2(2);
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
	V_WORK_DT           DATE;
	C_COMP_CODE         VARCHAR2(10);
	C_ACNT_CODE         VARCHAR2(10);
	C_VAT_CODE          VARCHAR2(10);
	C_CR_CODE           VARCHAR2(10);
	C_SEQ               INTEGER;
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
		IsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS('MATR000001',C_COMP_CODE);

-- 부문을 구한다.
		IsClassCode := PKG_MAKE_SLIP.Get_Class_code(as_dept_code);

-- 전표마스터를 생성한다(사업장코드,현장코드,전표기준일,'1'대체,'F'자재,작성자사번,자동전표코드,회계확정담당,입력자사번)
		IrHead := PKG_MAKE_SLIP.New_Head(C_COMP_CODE,as_dept_code,as_date,'1','F',as_user,'MATR000001',IsChargePers,as_user);

		PKG_MAKE_SLIP.Insert_Head(IrHead);

-- 테이블에 전표마스터번호를 Setting 한다.
		update m_vat
			set invoice_num = IrHead.Slip_ID
		 where dept_code = as_dept_code
			AND trunc(yyyymmdd,'MM')= as_date;

		InMakeSlipLine := 0;

-- 전표내역을 만들기 위한 커서
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO V_AMT,V_VAT,V_YYMMDD,V_CONT,V_CASH,V_BILL,V_BILL_DAY,V_DITAG,V_VAT_CLASS,V_CUST_CODE,V_SBCR_NAME,
										 V_REP_NAME,V_KIND_TYPE,V_KINDITEM,V_ZIP_NUM,V_ADDR,V_TEL_NUM,V_CHRG_NAME,V_CHRG_EMAIL,V_WORK_DT;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
	
			CASE  V_DITAG 
				WHEN '1' THEN                        -- 원재료
         		C_ACNT_CODE := '112080100';
         		C_CR_CODE   := '210010101';
				WHEN '2' THEN                        -- 손료가설재
					C_ACNT_CODE := '112090100';
         		C_CR_CODE   := '210010102';
				WHEN '3' THEN                        -- 안전용품
					C_ACNT_CODE := '432200300';
         		C_CR_CODE   := '210010103';
				WHEN '4' THEN                        -- 단기투입
					C_ACNT_CODE := '432250100';
         		C_CR_CODE   := '210010103';
				ELSE                                 -- 지급임차료
					C_ACNT_CODE := '432080800';
         		C_CR_CODE   := '210010103';
			END CASE;
			IF V_VAT_CLASS = '1' THEN      -- 과세
				C_VAT_CODE := '111220100';
			END IF;
			IF V_VAT_CLASS = '2' THEN      -- 면세
				C_VAT_CODE := '111220200';
			END IF;
			IF V_VAT_CLASS = '3' THEN      -- 불공제
				C_VAT_CODE := '111221300';
			END IF;
			IF V_VAT_CLASS = '4' THEN      -- 공통
				C_VAT_CODE := '111220100';
			END IF;

			-- 거래처순번을 구한다.
			InCustSeq := PKG_MAKE_SLIP.Get_Cust_Seq(V_CUST_CODE);
			IF InCustSeq is null THEN       -- 회계거래처에 없을경우 거래처 테이블에 생성한다.
				InCustSeq := F_T_NEW_CUST(V_CUST_CODE,V_SBCR_NAME,V_REP_NAME,'1',V_KIND_TYPE,V_KINDITEM,V_ZIP_NUM,V_ADDR,
												  '',V_TEL_NUM,'ZZ',null,null,V_CHRG_NAME,V_CHRG_EMAIL,as_user);
			END IF;
			-- 거래처명칭을 구한다.
			IsCustName := PKG_MAKE_SLIP.Get_Cust_Name(InCustSeq);

			-- 전표라인을 구한다.
			InMakeSlipLine := InMakeSlipLine + 1;

			-- 뉴 Body를 구한다(차변).
			IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_ACNT_CODE,IsClassCode,Null);
			
			-- Body에 내역을 넣어준다.
			IF V_VAT_CLASS = '3' THEN      -- 불공제
				IrBody.DB_AMT            := V_AMT + V_VAT;        -- 차변금액
			ELSE
				IrBody.DB_AMT            := V_AMT;        -- 차변금액
			END IF;
			IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- 세무사업장코드
			IrBody.COMP_CODE         := C_COMP_CODE;  -- 귀속사업장코드
			IrBody.DEPT_CODE         := as_dept_code; -- 귀속부서
			IrBody.VAT_DT            := V_YYMMDD;     -- 증빙일자
			IrBody.SUPAMT            := 0;            -- 공급가(부가세 라인에서만 입력)
			IrBody.VATAMT            := 0;            -- 부가세(부가세 라인에서만 입력)
			IrBody.CUST_SEQ          := InCustSeq;    -- 거래처순번
			IrBody.CUST_NAME         := IsCustName;   -- 거래처명칭
			IrBody.SUMMARY1          := V_CONT;       -- 적요
			IrBody.PAY_CON_CASH      := V_CASH;       -- 현금
			IrBody.PAY_CON_BILL      := V_BILL;       -- 어음
			IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- 어음만기일수
			IrBody.ANTICIPATION_DT   := V_WORK_DT; -- 지급희망일
	
			-- Body에 저장한다.
			PKG_MAKE_SLIP.Insert_Body(IrBody);
	
			InMakeSlipLine := InMakeSlipLine + 1;

			-- 뉴 Body를 구한다(차변:부가세라인)
			IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_VAT_CODE,IsClassCode,Null);
			
			-- Body에 내역을 넣어준다.
			IF V_VAT_CLASS = '3' THEN      -- 불공제
				IrBody.DB_AMT            := 0;        -- 차변금액
			ELSE
				IrBody.DB_AMT            := V_VAT;        -- 차변금액
			END IF;
			IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- 세무사업장코드
			IrBody.COMP_CODE         := C_COMP_CODE;  -- 귀속사업장코드
			IrBody.DEPT_CODE         := as_dept_code; -- 귀속부서
			IrBody.VAT_DT            := V_YYMMDD;     -- 증빙일자
			IrBody.SUPAMT            := V_AMT;        -- 공급가(부가세 라인에서만 입력)
			IrBody.VATAMT            := V_VAT;        -- 부가세(부가세 라인에서만 입력)
			IrBody.CUST_SEQ          := InCustSeq;    -- 거래처순번
			IrBody.CUST_NAME         := IsCustName;   -- 거래처명칭
			IrBody.SUMMARY1          := V_CONT;       -- 적요
			IrBody.PAY_CON_CASH      := V_CASH;       -- 현금
			IrBody.PAY_CON_BILL      := V_BILL;       -- 어음
			IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- 어음만기일수
			IrBody.ANTICIPATION_DT   := V_WORK_DT; -- 지급희망일

			-- Body에 저장한다.
			PKG_MAKE_SLIP.Insert_Body(IrBody);


			InMakeSlipLine := InMakeSlipLine + 1;

			-- 뉴 Body를 구한다(대변)
			IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
			
			-- Body에 내역을 넣어준다.
			IrBody.CR_AMT            := V_AMT + V_VAT; -- 대변금액
			IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- 세무사업장코드
			IrBody.COMP_CODE         := C_COMP_CODE;   -- 귀속사업장코드
			IrBody.DEPT_CODE         := as_dept_code;  -- 귀속부서
			IrBody.VAT_DT            := V_YYMMDD;      -- 증빙일자
			IrBody.SUPAMT            := 0;         -- 공급가(부가세 라인에서만 입력)
			IrBody.VATAMT            := 0;         -- 부가세(부가세 라인에서만 입력)
			IrBody.CUST_SEQ          := InCustSeq;     -- 거래처순번
			IrBody.CUST_NAME         := IsCustName;    -- 거래처명칭
			IrBody.SUMMARY1          := V_CONT;        -- 적요
			IrBody.PAY_CON_CASH      := V_CASH;        -- 현금
			IrBody.PAY_CON_BILL      := V_BILL;        -- 어음
			IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;    -- 어음만기일수
			IrBody.ANTICIPATION_DT   := V_WORK_DT; -- 지급희망일
			IrBody.MNG_ITEM_DT1      := V_YYMMDD; -- 계산서일자

			-- Body에 저장한다.
			PKG_MAKE_SLIP.Insert_Body(IrBody);

		END LOOP;
		CLOSE DETAIL_CUR;

-- 전표를 검증한다.
		PKG_MAKE_SLIP.Check_Slip(IrHead.Slip_ID);

--      EXCEPTION
 --    WHEN others THEN 
 --          IF SQL%NOTFOUND THEN
--              e_msg      := '입고전표생성 실패! [Line No: 2]';
--              Wk_errflag := -20020;
         
--              GOTO EXIT_ROUTINE;
--          END IF;   
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
END y_sp_m_slip_mat_request;
