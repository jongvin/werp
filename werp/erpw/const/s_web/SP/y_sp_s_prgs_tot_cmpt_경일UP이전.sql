/* ============================================================================= */
/* 함수명 : y_sp_s_prgs_cmpt                                                     */
/* 기  능 : 외주기성내역 입력시 상위로 재계산한다.                               */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 기성년월               ==> adt_yymm(datetime)                        */
/*        : 기성순번               ==> ai_seq(Integer)                           */
/*        : 발주번호               ==> ai_order_number(Integer)                  */
/*        : 집계코드               ==> ai_spec_no_seq(Integer)                   */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.04.28                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_prgs_tot_cmpt(as_dept_code    IN   VARCHAR2,
                                             adt_yymm        IN   DATE,
                                             ai_seq          IN   INTEGER,
                                             ai_order_number IN   INTEGER ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
--계약집계구조중 최하위 내역
CURSOR DETAIL_CUR IS
	SELECT SUM_CODE,SPEC_NO_SEQ FROM S_CN_PARENT WHERE dept_code = as_dept_code AND ORDER_NUMBER = ai_order_number AND INVEST_CLASS = 'Y';
-- 공통 변수 
    Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
    Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
    e_msg               VARCHAR2(100);
-- User Define Error
    V_SPEC_NO_SEQ       S_CN_PARENT.SPEC_NO_SEQ%TYPE;              -- 집계코드
    V_SUM_CODE          S_CN_PARENT.SUM_CODE%TYPE;              -- 집계코드
    C_PARENT_SUM_CODE   S_CN_PARENT.PARENT_SUM_CODE%TYPE;       -- 상위코드
    C_SPEC_NO_SEQ       S_CN_PARENT.SPEC_NO_SEQ%TYPE;              -- 집계코드
    C_SUM_CODE          S_CN_PARENT.SUM_CODE%TYPE;              -- 집계코드
    C_SUB_QTY           S_CN_PARENT.SUB_QTY%TYPE;               -- 계약수량
    C_SUB_AMT           S_CN_PARENT.SUB_AMT%TYPE;               -- 계약금액
    C_TM_PRGS_QTY       S_PRGS_PARENT.TM_PRGS_QTY%TYPE;         -- 금회기성수량
    C_TM_PRGS_AMT       S_PRGS_PARENT.TM_PRGS_AMT%TYPE;         -- 금회기성금액
    C_TM_PRGS_RT        S_PRGS_PARENT.TM_PRGS_RT%TYPE;          -- 금회기성율
    C_TOT_PRGS_QTY      S_PRGS_PARENT.TOT_PRGS_QTY%TYPE;        -- 누계기성수량
    C_TOT_PRGS_AMT      S_PRGS_PARENT.TOT_PRGS_AMT%TYPE;        -- 누계기성금액
    C_TOT_PRGS_RT       S_PRGS_PARENT.TOT_PRGS_RT%TYPE;         -- 누계기성율
    C_LEVEL             NUMBER(20,5);  -- 
    C_CNT               NUMBER(20,5);  -- 
    C_TMP_PRGS              NUMBER(20,5);
    C_TMP_PRGS_NOTAX        NUMBER(20,5);
    C_TMP_VAT               NUMBER(20,5);
    C_TMP_PURCHASE_VAT      NUMBER(20,5);
    C_TMP_PREVIOUS_AMT      NUMBER(20,5);
    C_TMP_SBC_AMT           NUMBER(20,5);
    C_PRE_PRGS              NUMBER(20,5);
    C_PRE_PRGS_NOTAX        NUMBER(20,5);
    C_PRE_VAT               NUMBER(20,5);
    C_PRE_PURCHASE_VAT      NUMBER(20,5);
    C_PRE_PREVIOUS_AMT      NUMBER(20,5);
    C_PRE_SBC_AMT           NUMBER(20,5);
    C_TMP_CASH_RT           NUMBER(20,5);
    C_TMP_CASH_AMT          NUMBER(20,5);
    C_TMP_TOT_PRGS_AMT      NUMBER(20,5);
    C_TMP_PRGS_RT           NUMBER(20,5);
    C_NETPAY_AMT            NUMBER(20,5);
    C_PAY_AMT               NUMBER(20,5);
    C_CHK_AMT1              NUMBER(20,5);
    C_CHK_AMT2              NUMBER(20,5);
    C_TMP_PRE_NOTAX         NUMBER(20,5);
    C_TMP_PRE_TAX           NUMBER(20,5);
    C_TMP_PRE_VAT           NUMBER(20,5);
    C_PRE_PRE_NOTAX         NUMBER(20,5);
    C_PRE_PRE_TAX           NUMBER(20,5);
    C_PRE_PRE_VAT           NUMBER(20,5);
    UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_SUM_CODE,V_SPEC_NO_SEQ;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
		--당회기성 최하위집계내역의 합계 구하기(C_TM_PRGS_AMT)
		SELECT NVL(SUM(TM_PRGS_AMT),0) INTO C_TM_PRGS_AMT FROM S_PRGS_DETAIL
		WHERE dept_code = as_dept_code AND yymm = adt_yymm AND seq = ai_seq AND order_number = ai_order_number AND spec_no_seq  = V_SPEC_NO_SEQ;

		--계약내역 최하위집계내역의 수량과 금액 합계 구하기(C_SUB_QTY,C_SUB_AMT)
		SELECT nvl(sub_qty,0),nvl(sub_amt,0) INTO C_SUB_QTY,C_SUB_AMT FROM S_CN_PARENT
		WHERE dept_code = as_dept_code AND order_number = ai_order_number AND spec_no_seq  = V_SPEC_NO_SEQ;

		--계약금액 대비 최하위집계내역의 당회기성율 구하기
		IF C_SUB_AMT <> 0 THEN
			C_TM_PRGS_RT := TRUNC(ROUND(C_TM_PRGS_AMT / C_SUB_AMT * 100,6) , 2);
		ELSE
			C_TM_PRGS_RT := 0;
		END IF;

		--계약금액 대비 최하위집계내역의 당회기성수량 구하기
		C_TM_PRGS_QTY := TRUNC( ROUND(C_SUB_QTY * C_TM_PRGS_RT / 100,6) , 2);

		UPDATE S_PRGS_PARENT
			SET tm_prgs_amt  = NVL(C_TM_PRGS_AMT,0),                --당회기성금액
				tm_prgs_rt   = NVL(C_TM_PRGS_RT,0),                 --당회기성율
				tm_prgs_qty  = NVL(C_TM_PRGS_QTY,0),                --당회기성수량
				tot_prgs_amt = NVL(C_TM_PRGS_AMT,0) + pre_prgs_amt, --총기성금액
				tot_prgs_rt  = NVL(C_TM_PRGS_RT,0)  + pre_prgs_rt,  --총기성율(수정필요)
				tot_prgs_qty = NVL(C_TM_PRGS_QTY,0) + pre_prgs_qty  --총기성수량(수정필요)
		WHERE dept_code = as_dept_code AND yymm = adt_yymm AND seq = ai_seq AND order_number = ai_order_number AND spec_no_seq  = V_SPEC_NO_SEQ;

		--상위레벨 합계구하기 시작
		--현재레벨 레벨번호와 상위코드 (C_LEVEL,C_PARENT_SUM_CODE)
		SELECT LLEVEL,PARENT_SUM_CODE INTO C_LEVEL,C_PARENT_SUM_CODE FROM S_CN_PARENT
		WHERE dept_code = as_dept_code  AND order_number = ai_order_number AND spec_no_seq  = V_SPEC_NO_SEQ;
		IF C_LEVEL <> 1 THEN
			LOOP
				--
				SELECT NVL(SUM(b.TM_PRGS_AMT),0) INTO C_TM_PRGS_AMT FROM S_CN_PARENT a, S_PRGS_PARENT b
				WHERE a.dept_code = b.dept_code AND a.order_number = b.order_number AND a.spec_no_seq = b.spec_no_seq
				AND b.yymm            = adt_yymm
				AND b.seq             = ai_seq 
				AND a.dept_code       = as_dept_code  
				AND a.order_number    = ai_order_number
				AND a.parent_sum_code = C_PARENT_SUM_CODE;

				SELECT nvl(sub_qty,0),nvl(sub_amt,0),spec_no_seq INTO C_SUB_QTY,C_SUB_AMT,C_SPEC_NO_SEQ FROM S_CN_PARENT
				WHERE dept_code = as_dept_code AND order_number = ai_order_number AND sum_code = C_PARENT_SUM_CODE;

				IF C_SUB_AMT <> 0 THEN
					C_TM_PRGS_RT  := TRUNC( ROUND(C_TM_PRGS_AMT / C_SUB_AMT * 100,6) , 2);
				ELSE
					C_TM_PRGS_RT := 0;
				END IF;

				C_TM_PRGS_QTY := TRUNC( ROUND(C_SUB_QTY * C_TM_PRGS_RT / 100 ,6), 2);

				UPDATE S_PRGS_PARENT
					SET tm_prgs_amt  = NVL(C_TM_PRGS_AMT,0),
						 tm_prgs_rt   = NVL(C_TM_PRGS_RT,0),
						 tm_prgs_qty  = NVL(C_TM_PRGS_QTY,0),
						 tot_prgs_amt = NVL(C_TM_PRGS_AMT,0) + pre_prgs_amt,
						 tot_prgs_rt  = NVL(C_TM_PRGS_RT,0)  + pre_prgs_rt,
						 tot_prgs_qty = NVL(C_TM_PRGS_QTY,0) + pre_prgs_qty
				WHERE dept_code = as_dept_code AND yymm = adt_yymm AND seq = ai_seq AND order_number = ai_order_number AND spec_no_seq  = C_SPEC_NO_SEQ;

				SELECT LLEVEL,PARENT_SUM_CODE INTO C_LEVEL,C_PARENT_SUM_CODE FROM S_CN_PARENT
				WHERE dept_code = as_dept_code AND order_number = ai_order_number AND sum_code = C_PARENT_SUM_CODE;
				IF C_LEVEL = 1 THEN
					EXIT;
				END IF;
			END LOOP;
		END IF;
	END LOOP;
	--상위레벨 합계구하기 종료
	CLOSE DETAIL_CUR;


	--계약금액가져오기
	select nvl(supply_amt_tax,0),nvl(supply_amt_notax,0),nvl(sbc_amt,0),nvl(prgs_cash_rt,0),
			nvl(previous_amt,0),nvl(previous_vat,0),nvl(safety_amt1,0),nvl(safety_amt2,0)
	into C_TMP_PRGS,C_TMP_PRGS_NOTAX,C_TMP_SBC_AMT,C_TMP_CASH_RT,
			C_TMP_PREVIOUS_AMT,C_TMP_PRE_VAT,C_TMP_PRE_TAX,C_TMP_PRE_NOTAX
	from s_cn_list
	where dept_code = as_dept_code and order_number = ai_order_number;

	--기성총누계
	SELECT nvl(sum(b.tot_prgs_amt),0) INTO C_TMP_TOT_PRGS_AMT FROM s_cn_parent a, s_prgs_parent b
	WHERE a.dept_code = b.dept_code AND a.order_number = b.order_number AND a.spec_no_seq  = b.spec_no_seq
	AND b.yymm         = adt_yymm
	AND b.seq          = ai_seq
	AND a.dept_code    = as_dept_code
	AND a.order_number = ai_order_number
	AND a.llevel       = 1;

	--기성매입세
	SELECT nvl(sum(b.tot_prgs_amt),0),nvl(sum(b.tm_prgs_amt),0) INTO C_PRE_PURCHASE_VAT,C_TMP_PURCHASE_VAT
	FROM s_cn_parent a, s_prgs_parent b
	WHERE a.dept_code = b.dept_code AND a.order_number = b.order_number AND a.spec_no_seq = b.spec_no_seq
	AND b.yymm         = adt_yymm
	AND b.seq          = ai_seq
	AND a.dept_code    = as_dept_code
	AND a.order_number = ai_order_number
	--AND a.llevel       = 2
	AND a.invest_class = 'Y'
	AND a.direct_class = '3';

	--기성률을 구할때 매입세는 제외한다.
	C_TMP_TOT_PRGS_AMT := C_TMP_TOT_PRGS_AMT - C_PRE_PURCHASE_VAT;

	-- 공제계
	SELECT nvl(pre_prgs,0),nvl(pre_prgs_notax,0),nvl(pre_advance_deduction,0),
			nvl(pre_pre_tax,0),nvl(pre_pre_notax,0),nvl(pre_pre_vat,0)
	INTO C_PRE_PRGS,C_PRE_PRGS_NOTAX,C_PRE_PREVIOUS_AMT,
			C_PRE_PRE_TAX,C_PRE_PRE_NOTAX,C_PRE_PRE_VAT
	FROM s_pay
	WHERE dept_code = as_dept_code AND yymm = adt_yymm AND seq = ai_seq AND order_number = ai_order_number;

	--기성율
	IF C_TMP_PRGS = 0 and  C_TMP_PRGS_NOTAX = 0 THEN
		C_TMP_PRGS_RT := 0;
	ELSE
		C_TMP_PRGS_RT := Trunc( C_TMP_TOT_PRGS_AMT / (C_TMP_PRGS + C_TMP_PRGS_NOTAX) , 4);
	END IF;
	IF C_TMP_PRGS <> 0 THEN
		C_CHK_AMT2 := C_TMP_TOT_PRGS_AMT * ( C_TMP_PRGS_NOTAX / (C_TMP_PRGS + C_TMP_PRGS_NOTAX));
	ELSE
		C_CHK_AMT2 := C_TMP_TOT_PRGS_AMT;
	END IF;
	C_CHK_AMT1 := C_TMP_TOT_PRGS_AMT - C_CHK_AMT2;
	-- 지불액
	C_TMP_VAT := TRUNC((C_CHK_AMT1 - C_PRE_PRGS) * 0.1,0);
	-- 차인지불액
	C_NETPAY_AMT :=  C_CHK_AMT1 - C_PRE_PRGS + C_CHK_AMT2 - C_PRE_PRGS_NOTAX + C_TMP_PURCHASE_VAT + C_TMP_VAT - TRUNC((C_TMP_PREVIOUS_AMT * C_TMP_PRGS_RT) - C_PRE_PREVIOUS_AMT,0);
	C_PAY_AMT :=  C_NETPAY_AMT - C_TMP_VAT;
	--IF C_TMP_PRGS <> 0 THEN
	UPDATE s_pay
		SET tm_prgs              = C_CHK_AMT1 - C_PRE_PRGS,                    --과세
			tm_prgs_notax        = C_CHK_AMT2 - C_PRE_PRGS_NOTAX,        --면세
			tm_advance_deduction = TRUNC((C_TMP_PREVIOUS_AMT * C_TMP_PRGS_RT) - C_PRE_PREVIOUS_AMT,0),       --선급공제액
			tm_pre_tax           = TRUNC((C_TMP_PRE_TAX * C_TMP_PRGS_RT) - C_PRE_PRE_TAX,0),       --선급공제액
			tm_pre_notax         = TRUNC((C_TMP_PRE_NOTAX * C_TMP_PRGS_RT) - C_PRE_PRE_NOTAX,0),       --선급공제액
			tm_pre_vat           = TRUNC((C_TMP_PRE_VAT * C_TMP_PRGS_RT) - C_PRE_PRE_VAT,0),       --선급공제액
			tm_purchase_vat      = C_TMP_PURCHASE_VAT,    --매입부가세
			tm_vat               = C_TMP_VAT,            --부가세
			tm_pay               = C_PAY_AMT,              --지불액
			tm_netpay_amt        = C_NETPAY_AMT, --차인지불액
			tm_cash              = TRUNC(C_NETPAY_AMT * C_TMP_CASH_RT * 0.01,0),            --현금
			tm_bill              = C_NETPAY_AMT - TRUNC(C_NETPAY_AMT * C_TMP_CASH_RT * 0.01,0) --어음
	WHERE dept_code = as_dept_code AND yymm = adt_yymm AND seq = ai_seq AND order_number = ai_order_number;
	EXCEPTION
	WHEN others THEN
		IF SQL%NOTFOUND THEN
			e_msg      := '기성재계산 실패! [Line No: 159]';
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
END y_sp_s_prgs_tot_cmpt;
