 /* ============================================================================ */
/* 함수명 : y_sp_q_slip(CJ개발)                                      */
/* 기  능 : 자재관리-입고전표 발행                                               */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 전표년월               ==> as_date(DATE)        		               */
/*        : 작성자사번             ==> as_date(string)        		               */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2006.04.12                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_q_slip (as_dept_code    IN   VARCHAR2,
																	  as_date         IN   DATE,
                                                     as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR DETAIL_CUR IS
SELECT a.monthly_amt,a.vat,a.yymm,b.eqp_vender_name || to_char(a.yymm,'YYYY.MM') || '월 장비비',a.pay_cash,a.pay_bill,a.bill_day,
		 b.regist_no,b.eqp_vender_name,b.pregident_name,'' kind_bussinesstype,'' kinditem,'' zip_number1,b.address,b.tel_no,'' chrg_name1,'' chrg_email,cust_type
  FROM q_monthly_payment a,
		 q_code_eqp_vender b
 WHERE a.regist_no = b.regist_no
	AND a.dept_code = as_dept_code
	AND trunc(a.yymm,'MM')= as_date
ORDER BY a.regist_no;

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
   V_CUST_TYPE         q_code_eqp_vender.cust_type%type;
	C_COMP_CODE         VARCHAR2(10);
	C_ACNT_CODE         VARCHAR2(10);
	C_VAT_CODE          VARCHAR2(10);
	C_CR_CODE           VARCHAR2(10);
	C_AMT               NUMBER(20,5);
	C_SET_AMT           NUMBER(20,5);
	C_TEMP_AMT          NUMBER(20,5);
	C_SLIP_ID           NUMBER;
	C_SLIP_IDSEQ        NUMBER;
	C_SEQ               INTEGER;
	C_CUST_SEQ          NUMBER;
	C_CUST_NAME         VARCHAR2(60);
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
		IsChargePers := PKG_MAKE_SLIP.Get_CHARGE_PERS('Q000000001',C_COMP_CODE);

-- 부문을 구한다.
		IsClassCode := PKG_MAKE_SLIP.Get_Class_code(as_dept_code);

-- 전표마스터를 생성한다(사업장코드,현장코드,전표기준일,'1'대체,'C'경비,작성자사번,자동전표코드,회계확정담당,입력자사번)
		IrHead := PKG_MAKE_SLIP.New_Head(C_COMP_CODE,as_dept_code,as_date,'1','C',as_user,'Q000000001',IsChargePers,as_user);

		PKG_MAKE_SLIP.Insert_Head(IrHead);

-- 테이블에 전표마스터번호를 Setting 한다.
		update q_monthly_payment
			set invoice_num = IrHead.Slip_ID
		 where dept_code = as_dept_code
			AND trunc(yymm,'MM')= as_date;

		InMakeSlipLine := 0;

-- 전표내역을 만들기 위한 커서
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO V_AMT,V_VAT,V_YYMMDD,V_CONT,V_CASH,V_BILL,V_BILL_DAY,V_CUST_CODE,V_SBCR_NAME,
										 V_REP_NAME,V_KIND_TYPE,V_KINDITEM,V_ZIP_NUM,V_ADDR,V_TEL_NUM,V_CHRG_NAME,V_CHRG_EMAIL,V_CUST_TYPE;
			EXIT WHEN DETAIL_CUR%NOTFOUND;
	
			C_ACNT_CODE := '432270100';
			C_CR_CODE   := '111210200';
			C_VAT_CODE  := '111220100';

			-- 거래처순번을 구한다.
			InCustSeq := PKG_MAKE_SLIP.Get_Cust_Seq(V_CUST_CODE);
			IF InCustSeq is null THEN       -- 회계거래처에 없을경우 거래처 테이블에 생성한다.
				InCustSeq := F_T_NEW_CUST(V_CUST_CODE,V_SBCR_NAME,V_REP_NAME,V_CUST_TYPE,V_KIND_TYPE,V_KINDITEM,V_ZIP_NUM,V_ADDR,
												  '',V_TEL_NUM,'ZZ',null,null,V_CHRG_NAME,V_CHRG_EMAIL,as_user);
			END IF;
			-- 거래처명칭을 구한다.
			IsCustName := PKG_MAKE_SLIP.Get_Cust_Name(InCustSeq);

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
			IrBody.CUST_SEQ          := InCustSeq;    -- 거래처순번
			IrBody.CUST_NAME         := IsCustName;   -- 거래처명칭
			IrBody.SUMMARY1          := V_CONT;       -- 적요
			IrBody.PAY_CON_CASH      := V_CASH;       -- 현금
			IrBody.PAY_CON_BILL      := V_BILL;       -- 어음
			IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;   -- 어음만기일수
	
			-- Body에 저장한다.
			PKG_MAKE_SLIP.Insert_Body(IrBody);
	
			InMakeSlipLine := InMakeSlipLine + 1;

			-- 뉴 Body를 구한다(차변:부가세라인)
			IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_VAT_CODE,IsClassCode,Null);
			
			-- Body에 내역을 넣어준다.
			IrBody.DB_AMT            := V_VAT;        -- 차변금액
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

			-- Body에 저장한다.
			PKG_MAKE_SLIP.Insert_Body(IrBody);


			InMakeSlipLine := InMakeSlipLine + 1;

			-- 뉴 Body를 구한다(대변)
			IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
			C_AMT := V_AMT + V_VAT;
			LOOP
				select a.slip_id,a.slip_idseq,a.SET_AMT - (a.RESET_AMT+a.NOT_RESET_AMT),a.cust_seq,a.cust_name
				  into C_SLIP_ID,C_SLIP_IDSEQ,C_SET_AMT,C_CUST_SEQ,C_CUST_NAME
					from ( SELECT X.ACC_CODE,X.COMP_CODE,X.DEPT_CODE,X.SLIP_ID,X.SLIP_IDSEQ,X.SET_AMT SET_AMT,X.RESET_AMT RESET_AMT,    
									  X.NOT_RESET_AMT NOT_RESET_AMT,X.RESET_AMT+X.NOT_RESET_AMT TOTAL_RESET_AMT,rownum aa,X.CUST_SEQ,X.CUST_NAME
								FROM ( SELECT A.ACC_CODE,A.COMP_CODE,A.DEPT_CODE,A.SLIP_ID,A.SLIP_IDSEQ,D.ACC_REMAIN_POSITION,A.CUST_SEQ,A.CUST_NAME,
												  DECODE(D.ACC_REMAIN_POSITION, 'D', 1, 0)*NVL(A.DB_AMT,0) + DECODE(D.ACC_REMAIN_POSITION, 'C', 1, 0)*NVL(A.CR_AMT,0) SET_AMT, 
												  DECODE(D.ACC_REMAIN_POSITION, 'D', -1, 1)*NVL(B1.DB_AMT,0) + DECODE(D.ACC_REMAIN_POSITION, 'C', -1, 1)*NVL(B1.CR_AMT,0) RESET_AMT,  
												  DECODE(D.ACC_REMAIN_POSITION, 'D', -1, 1)*NVL(B2.DB_AMT,0) + DECODE(D.ACC_REMAIN_POSITION, 'C', -1, 1)*NVL(B2.CR_AMT,0) NOT_RESET_AMT   
											FROM T_ACC_SLIP_BODY1 A,    
												 ( SELECT A.RESET_SLIP_ID,A.RESET_SLIP_IDSEQ,NVL(SUM(A.DB_AMT),0) DB_AMT,NVL(SUM(A.CR_AMT),0) CR_AMT 
													  FROM T_ACC_SLIP_BODY1 A
													 WHERE A.COMP_CODE = C_COMP_CODE
														AND A.DEPT_CODE = as_dept_code
														AND A.ACC_CODE  = C_CR_CODE
														AND A.SLIP_IDSEQ <> A.RESET_SLIP_IDSEQ    
														AND A.TRANSFER_TAG <> 'T'
														AND A.IGNORE_SET_RESET_TAG <> 'T'
														AND A.KEEP_DT IS NOT NULL 
												 GROUP BY A.RESET_SLIP_ID,A.RESET_SLIP_IDSEQ) B1,   
												 ( SELECT A.RESET_SLIP_ID,A.RESET_SLIP_IDSEQ,NVL(SUM(A.DB_AMT),0) DB_AMT,NVL(SUM(A.CR_AMT),0) CR_AMT 
													  FROM T_ACC_SLIP_BODY1 A
													 WHERE A.COMP_CODE = C_COMP_CODE
														AND A.DEPT_CODE = as_dept_code
														AND A.ACC_CODE  = C_CR_CODE
														AND A.SLIP_IDSEQ <> A.RESET_SLIP_IDSEQ    
														AND A.KEEP_DT IS NULL 
														AND A.TRANSFER_TAG <> 'T'
														AND A.IGNORE_SET_RESET_TAG <> 'T'
												 GROUP BY A.RESET_SLIP_ID,A.RESET_SLIP_IDSEQ) B2,   
											T_ACC_CODE D 
							  WHERE A.SLIP_ID = A.RESET_SLIP_ID    
								 AND A.SLIP_IDSEQ = A.RESET_SLIP_IDSEQ    
								 AND A.SLIP_ID = B1.RESET_SLIP_ID (+) 
								 AND A.SLIP_IDSEQ = B1.RESET_SLIP_IDSEQ (+)   
								 AND A.SLIP_ID = B2.RESET_SLIP_ID (+) 
								 AND A.SLIP_IDSEQ = B2.RESET_SLIP_IDSEQ (+)   
								 AND A.ACC_CODE = D.ACC_CODE   
								 AND A.KEEP_DT IS NOT NULL   
								 AND A.COMP_CODE = C_COMP_CODE
								 AND A.DEPT_CODE = as_dept_code
								 AND A.ACC_CODE  = C_CR_CODE
								 AND A.TRANSFER_TAG <> 'T'
								 AND A.IGNORE_SET_RESET_TAG <> 'T'
								 AND D.Acc_REMAIN_MNG = 'T' ) X	  
						 WHERE X.SET_AMT - (X.RESET_AMT+X.NOT_RESET_AMT) > 0
						order by X.SLIP_ID asc) a
					where a.aa = 1;
				IF C_AMT <= C_SET_AMT THEN
					EXIT;
				END IF;
				C_TEMP_AMT := C_AMT - C_SET_AMT;

				IrBody.CR_AMT            := C_SET_AMT; -- 대변금액
				IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- 세무사업장코드
				IrBody.COMP_CODE         := C_COMP_CODE;   -- 귀속사업장코드
				IrBody.DEPT_CODE         := as_dept_code;  -- 귀속부서
				IrBody.VAT_DT            := V_YYMMDD;      -- 증빙일자
				IrBody.SUPAMT            := 0;         -- 공급가(부가세 라인에서만 입력)
				IrBody.VATAMT            := 0;         -- 부가세(부가세 라인에서만 입력)
				IrBody.CUST_SEQ          := C_CUST_SEQ;     -- 거래처순번
				IrBody.CUST_NAME         := C_CUST_NAME;    -- 거래처명칭
				IrBody.SUMMARY1          := V_CONT;        -- 적요
				IrBody.RESET_SLIP_ID     := C_SLIP_ID;
				IrBody.RESET_SLIP_IDSEQ  := C_SLIP_IDSEQ;
	
				-- Body에 저장한다.
				PKG_MAKE_SLIP.Insert_Body(IrBody);
				C_AMT := C_TEMP_AMT;

				-- 뉴 Body를 구한다(대변)
				IrBody := PKG_MAKE_SLIP.New_Body(IrHead,InMakeSlipLine,C_CR_CODE,IsClassCode,Null);
			END LOOP;
			
			-- Body에 내역을 넣어준다.
			IrBody.CR_AMT            := C_AMT; -- 대변금액
			IrBody.TAX_COMP_CODE     := C_COMP_CODE;   -- 세무사업장코드
			IrBody.COMP_CODE         := C_COMP_CODE;   -- 귀속사업장코드
			IrBody.DEPT_CODE         := as_dept_code;  -- 귀속부서
			IrBody.VAT_DT            := V_YYMMDD;      -- 증빙일자
			IrBody.SUPAMT            := 0;         -- 공급가(부가세 라인에서만 입력)
			IrBody.VATAMT            := 0;         -- 부가세(부가세 라인에서만 입력)
			IrBody.CUST_SEQ          := C_CUST_SEQ;     -- 거래처순번
			IrBody.CUST_NAME         := C_CUST_NAME;    -- 거래처명칭
			IrBody.SUMMARY1          := V_CONT;        -- 적요
			IrBody.PAY_CON_CASH      := V_CASH;        -- 현금
			IrBody.PAY_CON_BILL      := V_BILL;        -- 어음
			IrBody.PAY_CON_BILL_DAYS := V_BILL_DAY;    -- 어음만기일수
			IrBody.RESET_SLIP_ID     := C_SLIP_ID;
			IrBody.RESET_SLIP_IDSEQ  := C_SLIP_IDSEQ;

			-- Body에 저장한다.
			PKG_MAKE_SLIP.Insert_Body(IrBody);

		END LOOP;
		CLOSE DETAIL_CUR;

-- 전표를 검증한다.
		PKG_MAKE_SLIP.Check_Slip(IrHead.Slip_ID);

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '장비전표생성 실패! [Line No: 2]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
				Raise;
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
END y_sp_q_slip;
