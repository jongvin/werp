 /* ============================================================================ */
/* 함수명 : y_sp_m_slip_tmat_rent(CJ개발)                                        */
/* 기  능 : 자재관리-손료전표 발행                                               */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 전표년월               ==> as_date(DATE)        		               */
/*        : 작성자사번             ==> as_date(string)        		               */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2006.04.12                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_m_slip_tmat_rent (as_dept_code    IN   VARCHAR2,
																	  as_date         IN   DATE,
                                                     as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT nvl(sum(a.amt),0),max(a.month),to_char(max(a.month),'YYYY.MM') || '월 손료'
  FROM m_tmat_proj_rent a
 WHERE a.dept_code = as_dept_code
	AND trunc(a.month,'MM')= as_date
group by a.dept_code,a.month;

-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   Wk_Chk              NUMBER(10,0) DEFAULT 0 ;
   WK_Chk_msg          VARCHAR2(100);

-- User Define Error
   UserErr         EXCEPTION;                  -- Select Data Not Found
	V_AMT               NUMBER(20,5);
	V_YYMMDD            DATE;
	V_CONT              VARCHAR2(100);
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
		IsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS('MATR000002',C_COMP_CODE);

-- 부문을 구한다.
		IsClassCode := PKG_MAKE_SLIP.Get_Class_code(as_dept_code);

-- 전표마스터를 생성한다(사업장코드,현장코드,전표기준일,'1'대체,'F'자재,작성자사번,자동전표코드,회계확정담당,입력자사번)
		IrHead := PKG_MAKE_SLIP.New_Head(C_COMP_CODE,as_dept_code,as_date,'1','F',as_user,'MATR000002',IsChargePers,as_user);

		PKG_MAKE_SLIP.Insert_Head(IrHead);

-- 테이블에 전표마스터번호를 Setting 한다.
		update m_tmat_proj_rent
			set invoice_num = IrHead.Slip_ID
		 where dept_code = as_dept_code
			AND trunc(month,'MM')= as_date;

		InMakeSlipLine := 0;

-- 전표내역을 만들기 위한 커서
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO V_AMT,V_YYMMDD,V_CONT;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
	
			C_ACNT_CODE := '420030100';
			C_CR_CODE   := '112090100';

			-- 전표라인을 구한다.
			InMakeSlipLine := InMakeSlipLine + 1;

			-- 뉴 Body를 구한다(차변).
			IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_ACNT_CODE,IsClassCode,Null);
			
			-- Body에 내역을 넣어준다.
			IrBody.DB_AMT            := V_AMT;        -- 차변금액
			IrBody.TAX_COMP_CODE     := C_COMP_CODE;  -- 세무사업장코드
			IrBody.COMP_CODE         := C_COMP_CODE;  -- 귀속사업장코드
			IrBody.DEPT_CODE         := as_dept_code; -- 귀속부서
			IrBody.VAT_DT            := V_YYMMDD;     -- 증빙일자
			IrBody.SUPAMT            := 0;            -- 공급가(부가세 라인에서만 입력)
			IrBody.VATAMT            := 0;            -- 부가세(부가세 라인에서만 입력)
			IrBody.SUMMARY1          := V_CONT;       -- 적요
	
			-- Body에 저장한다.
			PKG_MAKE_SLIP.Insert_Body(IrBody);
	
			InMakeSlipLine := InMakeSlipLine + 1;


			-- 뉴 Body를 구한다(대변)
			IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
			
			-- Body에 내역을 넣어준다.
			IrBody.CR_AMT            := V_AMT; -- 대변금액
			IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- 세무사업장코드
			IrBody.COMP_CODE         := C_COMP_CODE;   -- 귀속사업장코드
			IrBody.DEPT_CODE         := as_dept_code;  -- 귀속부서
			IrBody.VAT_DT            := V_YYMMDD;      -- 증빙일자
			IrBody.SUPAMT            := 0;         -- 공급가(부가세 라인에서만 입력)
			IrBody.VATAMT            := 0;         -- 부가세(부가세 라인에서만 입력)
			IrBody.SUMMARY1          := V_CONT;        -- 적요

			-- Body에 저장한다.
			PKG_MAKE_SLIP.Insert_Body(IrBody);

		END LOOP;
		CLOSE DETAIL_CUR;

-- 전표를 검증한다.
		PKG_MAKE_SLIP.Check_Slip(IrHead.Slip_ID);

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '손료전표생성 실패! [Line No: 2]';
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
END y_sp_m_slip_tmat_rent;
