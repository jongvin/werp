/* ============================================================================= */
/* 함수명 : y_sp_s_chgcn_cmpt                                                    */
/* 기  능 : 외주계약내역 입력시 상위로 재계산한다.                               */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 발주번호               ==> ai_order_number(Integer)                  */
/*        : 계약차수               ==> ai_chg_degree(Integer)                  */
/*        : 분류코드               ==> ai_spec_no_seq  (Integer)                 */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.04.24                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_s_chgcn_cmpt(as_dept_code    IN   VARCHAR2,
                                            ai_order_number IN   INTEGER,
                                            ai_chg_degree   IN   INTEGER,
                                            ai_spec_no_seq     IN   INTEGER) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   C_PARENT_SUM_CODE   S_CHG_CN_PARENT.PARENT_SUM_CODE%TYPE;    -- 상위코드
   C_CNT_QTY           S_CHG_CN_PARENT.CNT_QTY%TYPE;            -- 도급수량
   C_CNT_AMT           S_CHG_CN_PARENT.CNT_AMT%TYPE;            -- 도급금액
   C_EXE_QTY           S_CHG_CN_PARENT.EXE_QTY%TYPE;            -- 실행수량
   C_EXE_AMT           S_CHG_CN_PARENT.EXE_AMT%TYPE;            -- 실행금액
   C_SUB_QTY           S_CHG_CN_PARENT.SUB_QTY%TYPE;            -- 외주수량
   C_SUB_AMT           S_CHG_CN_PARENT.SUB_AMT%TYPE;            -- 외주비
   C_MAT_AMT           S_CHG_CN_PARENT.MAT_AMT%TYPE;            -- 자재비
   C_LAB_AMT           S_CHG_CN_PARENT.LAB_AMT%TYPE;            -- 노무비
   C_EXP_AMT           S_CHG_CN_PARENT.EXP_AMT%TYPE;            -- 경비
   C_TAXAMT            S_CHG_CN_PARENT.SUB_AMT%TYPE;            -- 외주비
   C_NOTAX             S_CHG_CN_PARENT.SUB_AMT%TYPE;            -- 외주비
   C_TOT_AMT           S_CHG_CN_PARENT.SUB_AMT%TYPE;            -- 외주비
   C_AMT               S_CHG_CN_PARENT.SUB_AMT%TYPE;            -- 외주비
   C_BUY_AMT           S_CHG_CN_PARENT.SUB_AMT%TYPE;            -- 외주비
   C_LEVEL             NUMBER(20,5);  --
   C_CNT               NUMBER(20,5);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
      SELECT NVL(SUM(CNT_AMT),0),NVL(SUM(EXE_AMT),0),NVL(SUM(SUB_AMT),0),NVL(SUM(MAT_AMT),0),NVL(SUM(LAB_AMT),0),NVL(SUM(EXP_AMT),0)
        INTO C_CNT_AMT,C_EXE_AMT,C_SUB_AMT,C_MAT_AMT,C_LAB_AMT,C_EXP_AMT
        FROM S_CHG_CN_DETAIL
       WHERE dept_code    = as_dept_code  AND
             order_number = ai_order_number AND
             chg_degree   = ai_chg_degree AND
             spec_no_seq     = ai_spec_no_seq;
      UPDATE S_CHG_CN_PARENT
         SET CNT_AMT = NVL(C_CNT_AMT,0),
             EXE_AMT = NVL(C_EXE_AMT,0),
             SUB_AMT = NVL(C_SUB_AMT,0),
				 MAT_AMT = NVL(C_MAT_AMT,0),
				 LAB_AMT = NVL(C_LAB_AMT,0),
				 EXP_AMT = NVL(C_EXP_AMT,0)
       WHERE dept_code    = as_dept_code  AND
             order_number = ai_order_number AND
             chg_degree   = ai_chg_degree AND
             spec_no_seq     = ai_spec_no_seq;
		SELECT LLEVEL,PARENT_SUM_CODE
		  INTO C_LEVEL,C_PARENT_SUM_CODE
		  FROM S_CHG_CN_PARENT
		 WHERE dept_code    = as_dept_code  AND
				 order_number = ai_order_number AND
				 chg_degree   = ai_chg_degree AND
				 spec_no_seq  = ai_spec_no_seq;
		IF C_LEVEL <> 1 THEN
			LOOP
				SELECT NVL(SUM(CNT_AMT),0),NVL(SUM(EXE_AMT),0),NVL(SUM(SUB_AMT),0),NVL(SUM(MAT_AMT),0),NVL(SUM(LAB_AMT),0),NVL(SUM(EXP_AMT),0)
				  INTO C_CNT_AMT,C_EXE_AMT,C_SUB_AMT,C_MAT_AMT,C_LAB_AMT,C_EXP_AMT
				  FROM S_CHG_CN_PARENT
				 WHERE dept_code       = as_dept_code  AND
						 order_number    = ai_order_number AND
						 chg_degree      = ai_chg_degree AND
						 parent_sum_code = C_PARENT_SUM_CODE;
				UPDATE S_CHG_CN_PARENT
					SET CNT_AMT = NVL(C_CNT_AMT,0),
						 EXE_AMT = NVL(C_EXE_AMT,0),
						 SUB_AMT = NVL(C_SUB_AMT,0),
					MAT_AMT = NVL(C_MAT_AMT,0),
					LAB_AMT = NVL(C_LAB_AMT,0),
					EXP_AMT = NVL(C_EXP_AMT,0)
				 WHERE dept_code    = as_dept_code  AND
						 order_number = ai_order_number AND
						 chg_degree   = ai_chg_degree AND
						 sum_code     = C_PARENT_SUM_CODE;
				SELECT LLEVEL,PARENT_SUM_CODE
				  INTO C_LEVEL,C_PARENT_SUM_CODE
				  FROM S_CHG_CN_PARENT
				 WHERE dept_code    = as_dept_code  AND
						 order_number = ai_order_number AND
						 chg_degree   = ai_chg_degree AND
						 sum_code     = C_PARENT_SUM_CODE;
				IF C_LEVEL = 1 THEN
					EXIT;
				END IF;
			END LOOP;
		 END IF;
		select nvl(sum(sub_amt),0),nvl(sum(cnt_amt),0),nvl(sum(exe_amt),0)
		  into C_TOT_AMT,C_CNT_AMT,C_EXE_AMT
		  from s_chg_cn_parent
		 where dept_code = as_dept_code
			and order_number = ai_order_number
			and chg_degree = ai_chg_degree
			and llevel = 1;

		select  nvl(sum(a.sub_amt),0)
		  into C_BUY_AMT
		  from s_chg_cn_detail a,
             y_budget_detail b
		 where a.dept_code = b.dept_code (+)
			and a.spec_unq_num = b.spec_unq_num (+)
			and a.dept_code = as_dept_code
			and a.order_number = ai_order_number
			and a.chg_degree = ai_chg_degree
         and b.detail_code = 'V0101AA0110';

		C_AMT := C_TOT_AMT - C_BUY_AMT;
	IF ai_chg_degree = 1 THEN
		update s_chg_cn_list
			set cnt_amt               = nvl(C_CNT_AMT,0),
				 exe_amt               = nvl(C_EXE_AMT,0),
				 supply_amt_tax   = TRUNC(C_AMT * (100 - buy_rt) * 0.01,0),
				 vat              = TRUNC(C_AMT * (100 - buy_rt) * 0.001,0),
				 supply_amt_notax = C_AMT - TRUNC(C_AMT * (100 - buy_rt) * 0.01,0),
				 purchase_vat     = C_BUY_AMT,
				 sbc_amt          = C_TOT_AMT + TRUNC(C_AMT * (100 - buy_rt) * 0.001,0) ,
				 previous_amt     = TRUNC((C_TOT_AMT + TRUNC(C_AMT * (100 - buy_rt) * 0.001,0)) * previous_amt_rt * 0.01,0),
				 previous_vat     = TRUNC(C_AMT * (100 - buy_rt) * previous_amt_rt * 0.00001,0)
		 where dept_code    = as_dept_code
			and order_number = ai_order_number
			and chg_degree   = ai_chg_degree;
	ELSE
		update s_chg_cn_list
			set cnt_amt               = nvl(C_CNT_AMT,0),
				 exe_amt               = nvl(C_EXE_AMT,0),
				 supply_amt_tax   = TRUNC(C_AMT * (100 - buy_rt) * 0.01,0),
				 vat              = TRUNC(C_AMT * (100 - buy_rt) * 0.001,0),
				 supply_amt_notax = C_AMT - TRUNC(C_AMT * (100 - buy_rt) * 0.01,0),
				 purchase_vat     = C_BUY_AMT,
				 sbc_amt          = C_TOT_AMT + TRUNC(C_AMT * (100 - buy_rt) * 0.001,0)
		 where dept_code    = as_dept_code
			and order_number = ai_order_number
			and chg_degree   = ai_chg_degree;
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
END y_sp_s_chgcn_cmpt;
