/* ============================================================================= */
/* 함수명 : y_sp_c_summary_cmpt                                                  */
/* 기  능 : 원가 및 기성 금액을 상위로 재계산한다.(Total)                        */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 년월                   ==> adt_date(Date) 			                  */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.05.27                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_c_summary_cmpt(as_dept_code    IN   VARCHAR2,
                                                adt_date        IN   DATE) IS

CURSOR DETAIL_CUR IS
SELECT max(spec_no_seq)
  FROM y_budget_detail 
 WHERE dept_code    = as_dept_code AND
       chg_no_seq = 0
group by dept_code,spec_no_seq;
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   V_SPEC_NO_SEQ           Y_BUDGET_DETAIL.SPEC_NO_SEQ%TYPE;    -- 
   C_SPEC_NO_SEQ           Y_BUDGET_PARENT.SPEC_NO_SEQ%TYPE;    -- 
   C_PARENT_SUM_CODE       Y_BUDGET_PARENT.PARENT_SUM_CODE%TYPE;    -- 상위코드
   C_CNT_RESULT_AMT        C_SPEC_CONST_DETAIL.CNT_RESULT_AMT%TYPE;            -- 도급금액
   C_CNT_RESULT_MAT_AMT    C_SPEC_CONST_DETAIL.CNT_RESULT_MAT_AMT%TYPE;        -- 도급자재비
   C_CNT_RESULT_LAB_AMT    C_SPEC_CONST_DETAIL.CNT_RESULT_LAB_AMT%TYPE;        -- 도급노무비
   C_CNT_RESULT_EXP_AMT    C_SPEC_CONST_DETAIL.CNT_RESULT_EXP_AMT%TYPE;        -- 도급경비
   C_RESULT_AMT            C_SPEC_CONST_DETAIL.RESULT_AMT%TYPE;                -- 금액
   C_RESULT_MAT_AMT        C_SPEC_CONST_DETAIL.RESULT_MAT_AMT%TYPE;            -- 자재비
   C_RESULT_LAB_AMT        C_SPEC_CONST_DETAIL.RESULT_LAB_AMT%TYPE;            -- 노무비
   C_RESULT_EXP_AMT        C_SPEC_CONST_DETAIL.RESULT_EXP_AMT%TYPE;            -- 경비
   C_RESULT_EQU_AMT        C_SPEC_CONST_DETAIL.RESULT_EQU_AMT%TYPE;            -- 중기비
   C_RESULT_SUB_AMT        C_SPEC_CONST_DETAIL.RESULT_SUB_AMT%TYPE;            -- 외주비
   C_COST_AMT              C_SPEC_CONST_DETAIL.COST_AMT%TYPE;                -- 금액
   C_COST_MAT_AMT          C_SPEC_CONST_DETAIL.COST_MAT_AMT%TYPE;            -- 자재비
   C_COST_LAB_AMT          C_SPEC_CONST_DETAIL.COST_LAB_AMT%TYPE;            -- 노무비
   C_COST_EXP_AMT          C_SPEC_CONST_DETAIL.COST_EXP_AMT%TYPE;            -- 경비
   C_COST_EQU_AMT          C_SPEC_CONST_DETAIL.COST_EQU_AMT%TYPE;            -- 중기비
   C_COST_SUB_AMT          C_SPEC_CONST_DETAIL.COST_SUB_AMT%TYPE;            -- 외주비
   C_LS_CNT_RESULT_AMT     C_SPEC_CONST_DETAIL.LS_CNT_RESULT_AMT%TYPE;            -- 도급금액
   C_LS_CNT_RESULT_MAT_AMT C_SPEC_CONST_DETAIL.LS_CNT_RESULT_MAT_AMT%TYPE;        -- 도급자재비
   C_LS_CNT_RESULT_LAB_AMT C_SPEC_CONST_DETAIL.LS_CNT_RESULT_LAB_AMT%TYPE;        -- 도급노무비
   C_LS_CNT_RESULT_EXP_AMT C_SPEC_CONST_DETAIL.LS_CNT_RESULT_EXP_AMT%TYPE;        -- 도급경비
   C_LS_RESULT_AMT         C_SPEC_CONST_DETAIL.LS_RESULT_AMT%TYPE;                -- 금액
   C_LS_RESULT_MAT_AMT     C_SPEC_CONST_DETAIL.LS_RESULT_MAT_AMT%TYPE;            -- 자재비
   C_LS_RESULT_LAB_AMT     C_SPEC_CONST_DETAIL.LS_RESULT_LAB_AMT%TYPE;            -- 노무비
   C_LS_RESULT_EXP_AMT     C_SPEC_CONST_DETAIL.LS_RESULT_EXP_AMT%TYPE;            -- 경비
   C_LS_RESULT_EQU_AMT     C_SPEC_CONST_DETAIL.LS_RESULT_EQU_AMT%TYPE;            -- 중기비
   C_LS_RESULT_SUB_AMT     C_SPEC_CONST_DETAIL.LS_RESULT_SUB_AMT%TYPE;            -- 외주비
   C_LS_COST_AMT           C_SPEC_CONST_DETAIL.LS_COST_AMT%TYPE;                -- 금액
   C_LS_COST_MAT_AMT       C_SPEC_CONST_DETAIL.LS_COST_MAT_AMT%TYPE;            -- 자재비
   C_LS_COST_LAB_AMT       C_SPEC_CONST_DETAIL.LS_COST_LAB_AMT%TYPE;            -- 노무비
   C_LS_COST_EXP_AMT       C_SPEC_CONST_DETAIL.LS_COST_EXP_AMT%TYPE;            -- 경비
   C_LS_COST_EQU_AMT       C_SPEC_CONST_DETAIL.LS_COST_EQU_AMT%TYPE;            -- 중기비
   C_LS_COST_SUB_AMT       C_SPEC_CONST_DETAIL.LS_COST_SUB_AMT%TYPE;            -- 외주비
   C_PRE_RESULT_AMT        C_SPEC_CONST_DETAIL.PRE_RESULT_AMT%TYPE;          -- 추정완성금액
   C_AMT                   C_SPEC_CONST_DETAIL.AMT%TYPE;                    -- 실행금액
   C_LEVEL              NUMBER(20,5);  -- 
   C_CNT                NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO V_SPEC_NO_SEQ;
			EXIT WHEN DETAIL_CUR%NOTFOUND;

			SELECT NVL(SUM(cnt_result_amt),0),NVL(SUM(cnt_result_mat_amt),0),
					 NVL(SUM(cnt_result_lab_amt),0),NVL(SUM(cnt_result_exp_amt),0),
					 NVL(SUM(result_amt),0),NVL(SUM(result_mat_amt),0),NVL(SUM(result_sub_amt),0),
					 NVL(SUM(result_lab_amt),0),NVL(SUM(result_equ_amt),0),NVL(SUM(result_exp_amt),0),
					 NVL(SUM(cost_amt),0),NVL(SUM(cost_mat_amt),0),NVL(SUM(cost_sub_amt),0),
					 NVL(SUM(cost_lab_amt),0),NVL(SUM(cost_equ_amt),0),NVL(SUM(cost_exp_amt),0),
					 NVL(SUM(ls_cnt_result_amt),0),NVL(SUM(ls_cnt_result_mat_amt),0),
					 NVL(SUM(ls_cnt_result_lab_amt),0),NVL(SUM(ls_cnt_result_exp_amt),0),
					 NVL(SUM(ls_result_amt),0),NVL(SUM(ls_result_mat_amt),0),NVL(SUM(ls_result_sub_amt),0),
					 NVL(SUM(ls_result_lab_amt),0),NVL(SUM(ls_result_equ_amt),0),NVL(SUM(ls_result_exp_amt),0),
					 NVL(SUM(ls_cost_amt),0),NVL(SUM(ls_cost_mat_amt),0),NVL(SUM(ls_cost_sub_amt),0),
					 NVL(SUM(ls_cost_lab_amt),0),NVL(SUM(ls_cost_equ_amt),0),NVL(SUM(ls_cost_exp_amt),0),
					 nvl(sum(pre_result_amt),0),nvl(sum(amt),0)
			  INTO C_CNT_RESULT_AMT,C_CNT_RESULT_MAT_AMT,C_CNT_RESULT_LAB_AMT,C_CNT_RESULT_EXP_AMT,
					 C_RESULT_AMT,C_RESULT_MAT_AMT,C_RESULT_SUB_AMT,C_RESULT_LAB_AMT,C_RESULT_EQU_AMT,C_RESULT_EXP_AMT,
					 C_COST_AMT,C_COST_MAT_AMT,C_COST_SUB_AMT,C_COST_LAB_AMT,C_COST_EQU_AMT,C_COST_EXP_AMT,
					 C_LS_CNT_RESULT_AMT,C_LS_CNT_RESULT_MAT_AMT,C_LS_CNT_RESULT_LAB_AMT,C_LS_CNT_RESULT_EXP_AMT,
					 C_LS_RESULT_AMT,C_LS_RESULT_MAT_AMT,C_LS_RESULT_SUB_AMT,C_LS_RESULT_LAB_AMT,C_LS_RESULT_EQU_AMT,C_LS_RESULT_EXP_AMT,
					 C_LS_COST_AMT,C_LS_COST_MAT_AMT,C_LS_COST_SUB_AMT,C_LS_COST_LAB_AMT,C_LS_COST_EQU_AMT,C_LS_COST_EXP_AMT,
					 C_PRE_RESULT_AMT,C_AMT
			  FROM C_SPEC_CONST_DETAIL
			 WHERE dept_code   = as_dept_code
				and yymm        = adt_date
				and spec_no_seq = V_SPEC_NO_SEQ;

			
			UPDATE C_SPEC_CONST_PARENT
				SET CNT_RESULT_AMT        = NVL(C_CNT_RESULT_AMT,0),
					 CNT_RESULT_MAT_AMT    = NVL(C_CNT_RESULT_MAT_AMT,0),
					 CNT_RESULT_LAB_AMT    = NVL(C_CNT_RESULT_LAB_AMT,0),
					 CNT_RESULT_EXP_AMT    = NVL(C_CNT_RESULT_EXP_AMT,0),
					 RESULT_AMT            = NVL(C_RESULT_AMT,0),
					 RESULT_MAT_AMT        = NVL(C_RESULT_MAT_AMT,0),
					 RESULT_LAB_AMT        = NVL(C_RESULT_LAB_AMT,0),
					 RESULT_EXP_AMT        = NVL(C_RESULT_EXP_AMT,0),
					 RESULT_EQU_AMT        = NVL(C_RESULT_EQU_AMT,0),
					 RESULT_SUB_AMT        = NVL(C_RESULT_SUB_AMT,0),
					 COST_AMT              = NVL(C_COST_AMT,0),
					 COST_MAT_AMT          = NVL(C_COST_MAT_AMT,0),
					 COST_LAB_AMT          = NVL(C_COST_LAB_AMT,0),
					 COST_EXP_AMT          = NVL(C_COST_EXP_AMT,0),
					 COST_EQU_AMT          = NVL(C_COST_EQU_AMT,0),
					 COST_SUB_AMT          = NVL(C_COST_SUB_AMT,0),
					 LS_CNT_RESULT_AMT     = NVL(C_LS_CNT_RESULT_AMT,0),
					 LS_CNT_RESULT_MAT_AMT = NVL(C_LS_CNT_RESULT_MAT_AMT,0),
					 LS_CNT_RESULT_LAB_AMT = NVL(C_LS_CNT_RESULT_LAB_AMT,0),
					 LS_CNT_RESULT_EXP_AMT = NVL(C_LS_CNT_RESULT_EXP_AMT,0),
					 LS_RESULT_AMT         = NVL(C_LS_RESULT_AMT,0),
					 LS_RESULT_MAT_AMT     = NVL(C_LS_RESULT_MAT_AMT,0),
					 LS_RESULT_LAB_AMT     = NVL(C_LS_RESULT_LAB_AMT,0),
					 LS_RESULT_EXP_AMT     = NVL(C_LS_RESULT_EXP_AMT,0),
					 LS_RESULT_EQU_AMT     = NVL(C_LS_RESULT_EQU_AMT,0),
					 LS_RESULT_SUB_AMT     = NVL(C_LS_RESULT_SUB_AMT,0),
					 LS_COST_AMT           = NVL(C_LS_COST_AMT,0),
					 LS_COST_MAT_AMT       = NVL(C_LS_COST_MAT_AMT,0),
					 LS_COST_LAB_AMT       = NVL(C_LS_COST_LAB_AMT,0),
					 LS_COST_EXP_AMT       = NVL(C_LS_COST_EXP_AMT,0),
					 LS_COST_EQU_AMT       = NVL(C_LS_COST_EQU_AMT,0),
					 LS_COST_SUB_AMT       = NVL(C_LS_COST_SUB_AMT,0),
					 PRE_RESULT_AMT        = NVL(C_PRE_RESULT_AMT,0),
					 AMT                   = NVL(C_AMT,0)
			 WHERE dept_code   = as_dept_code 
				and yymm        = adt_date
				and spec_no_seq = V_SPEC_NO_SEQ;
			
			SELECT LLEVEL,PARENT_SUM_CODE
			  INTO C_LEVEL,C_PARENT_SUM_CODE
			  FROM Y_BUDGET_PARENT
			 WHERE dept_code  = as_dept_code  AND
					 chg_no_seq = 0 AND
					 spec_no_seq   = V_SPEC_NO_SEQ;

			IF C_LEVEL <> 1 THEN
				LOOP
					SELECT NVL(SUM(b.cnt_result_amt),0),NVL(SUM(b.cnt_result_mat_amt),0),
							 NVL(SUM(b.cnt_result_lab_amt),0),NVL(SUM(b.cnt_result_exp_amt),0),
							 NVL(SUM(b.result_amt),0),NVL(SUM(b.result_mat_amt),0),NVL(SUM(b.result_sub_amt),0),
							 NVL(SUM(b.result_lab_amt),0),NVL(SUM(b.result_equ_amt),0),NVL(SUM(b.result_exp_amt),0),
							 NVL(SUM(b.cost_amt),0),NVL(SUM(b.cost_mat_amt),0),NVL(SUM(b.cost_sub_amt),0),
							 NVL(SUM(b.cost_lab_amt),0),NVL(SUM(b.cost_equ_amt),0),NVL(SUM(b.cost_exp_amt),0),
							 NVL(SUM(b.ls_cnt_result_amt),0),NVL(SUM(b.ls_cnt_result_mat_amt),0),
							 NVL(SUM(b.ls_cnt_result_lab_amt),0),NVL(SUM(b.ls_cnt_result_exp_amt),0),
							 NVL(SUM(b.ls_result_amt),0),NVL(SUM(b.ls_result_mat_amt),0),NVL(SUM(b.ls_result_sub_amt),0),
							 NVL(SUM(b.ls_result_lab_amt),0),NVL(SUM(b.ls_result_equ_amt),0),NVL(SUM(b.ls_result_exp_amt),0),
							 NVL(SUM(b.ls_cost_amt),0),NVL(SUM(b.ls_cost_mat_amt),0),NVL(SUM(b.ls_cost_sub_amt),0),
							 NVL(SUM(b.ls_cost_lab_amt),0),NVL(SUM(b.ls_cost_equ_amt),0),NVL(SUM(b.ls_cost_exp_amt),0),
							 NVL(SUM(b.pre_result_amt),0),NVL(SUM(b.amt),0)
					  INTO C_CNT_RESULT_AMT,C_CNT_RESULT_MAT_AMT,C_CNT_RESULT_LAB_AMT,C_CNT_RESULT_EXP_AMT,
							 C_RESULT_AMT,C_RESULT_MAT_AMT,C_RESULT_SUB_AMT,C_RESULT_LAB_AMT,C_RESULT_EQU_AMT,C_RESULT_EXP_AMT,
							 C_COST_AMT,C_COST_MAT_AMT,C_COST_SUB_AMT,C_COST_LAB_AMT,C_COST_EQU_AMT,C_COST_EXP_AMT,
							 C_LS_CNT_RESULT_AMT,C_LS_CNT_RESULT_MAT_AMT,C_LS_CNT_RESULT_LAB_AMT,C_LS_CNT_RESULT_EXP_AMT,
							 C_LS_RESULT_AMT,C_LS_RESULT_MAT_AMT,C_LS_RESULT_SUB_AMT,C_LS_RESULT_LAB_AMT,C_LS_RESULT_EQU_AMT,C_LS_RESULT_EXP_AMT,
							 C_LS_COST_AMT,C_LS_COST_MAT_AMT,C_LS_COST_SUB_AMT,C_LS_COST_LAB_AMT,C_LS_COST_EQU_AMT,C_LS_COST_EXP_AMT,
							 C_PRE_RESULT_AMT,C_AMT
					  FROM Y_BUDGET_PARENT a,
							 C_SPEC_CONST_PARENT b
					 WHERE a.dept_code       = b.dept_code
						and a.spec_no_seq     = b.spec_no_seq
						and b.yymm            = adt_date
						and a.dept_code       = as_dept_code  
						and a.chg_no_seq      = 0 
						and a.parent_sum_code = C_PARENT_SUM_CODE;
				
					select spec_no_seq
					  into C_SPEC_NO_SEQ
					  from y_budget_parent				
					 WHERE dept_code       = as_dept_code  AND
							 chg_no_seq      = 0 AND
							 sum_code = C_PARENT_SUM_CODE;

					UPDATE C_SPEC_CONST_PARENT
						SET CNT_RESULT_AMT        = NVL(C_CNT_RESULT_AMT,0),
							 CNT_RESULT_MAT_AMT    = NVL(C_CNT_RESULT_MAT_AMT,0),
							 CNT_RESULT_LAB_AMT    = NVL(C_CNT_RESULT_LAB_AMT,0),
							 CNT_RESULT_EXP_AMT    = NVL(C_CNT_RESULT_EXP_AMT,0),
							 RESULT_AMT            = NVL(C_RESULT_AMT,0),
							 RESULT_MAT_AMT        = NVL(C_RESULT_MAT_AMT,0),
							 RESULT_LAB_AMT        = NVL(C_RESULT_LAB_AMT,0),
							 RESULT_EXP_AMT        = NVL(C_RESULT_EXP_AMT,0),
							 RESULT_EQU_AMT        = NVL(C_RESULT_EQU_AMT,0),
							 RESULT_SUB_AMT        = NVL(C_RESULT_SUB_AMT,0),
							 COST_AMT              = NVL(C_COST_AMT,0),
							 COST_MAT_AMT          = NVL(C_COST_MAT_AMT,0),
							 COST_LAB_AMT          = NVL(C_COST_LAB_AMT,0),
							 COST_EXP_AMT          = NVL(C_COST_EXP_AMT,0),
							 COST_EQU_AMT          = NVL(C_COST_EQU_AMT,0),
							 COST_SUB_AMT          = NVL(C_COST_SUB_AMT,0),
							 LS_CNT_RESULT_AMT     = NVL(C_LS_CNT_RESULT_AMT,0),
							 LS_CNT_RESULT_MAT_AMT = NVL(C_LS_CNT_RESULT_MAT_AMT,0),
							 LS_CNT_RESULT_LAB_AMT = NVL(C_LS_CNT_RESULT_LAB_AMT,0),
							 LS_CNT_RESULT_EXP_AMT = NVL(C_LS_CNT_RESULT_EXP_AMT,0),
							 LS_RESULT_AMT         = NVL(C_LS_RESULT_AMT,0),
							 LS_RESULT_MAT_AMT     = NVL(C_LS_RESULT_MAT_AMT,0),
							 LS_RESULT_LAB_AMT     = NVL(C_LS_RESULT_LAB_AMT,0),
							 LS_RESULT_EXP_AMT     = NVL(C_LS_RESULT_EXP_AMT,0),
							 LS_RESULT_EQU_AMT     = NVL(C_LS_RESULT_EQU_AMT,0),
							 LS_RESULT_SUB_AMT     = NVL(C_LS_RESULT_SUB_AMT,0),
							 LS_COST_AMT           = NVL(C_LS_COST_AMT,0),
							 LS_COST_MAT_AMT       = NVL(C_LS_COST_MAT_AMT,0),
							 LS_COST_LAB_AMT       = NVL(C_LS_COST_LAB_AMT,0),
							 LS_COST_EXP_AMT       = NVL(C_LS_COST_EXP_AMT,0),
							 LS_COST_EQU_AMT       = NVL(C_LS_COST_EQU_AMT,0),
							 LS_COST_SUB_AMT       = NVL(C_LS_COST_SUB_AMT,0),
							 PRE_RESULT_AMT        = NVL(C_PRE_RESULT_AMT,0),
							 AMT                   = NVL(C_AMT,0)
					 WHERE dept_code   = as_dept_code 
						and yymm        = adt_date
						and spec_no_seq = C_SPEC_NO_SEQ;

					SELECT LLEVEL,PARENT_SUM_CODE
					  INTO C_LEVEL,C_PARENT_SUM_CODE
					  FROM Y_BUDGET_PARENT
					 WHERE dept_code  = as_dept_code  AND
							 chg_no_seq = 0 AND
							 sum_code   = C_PARENT_SUM_CODE;
					IF C_LEVEL = 1 THEN
						EXIT;
					END IF;
				
				END LOOP;
			END IF;
		END LOOP;
		CLOSE DETAIL_CUR;
		UPDATE c_spec_const_parent
		  SET  result_rate = decode(amt,0,0,decode(sign(trunc((result_amt + ls_result_amt) / amt * 100,2) - 100),
									1,100 - ls_result_rate,trunc((result_amt + ls_result_amt) / amt * 100,2) - ls_result_rate )),
		       cnt_result_rate = decode(cnt_amt,0,0,decode(sign(trunc((cnt_result_amt + ls_cnt_result_amt) / cnt_amt * 100,2) - 100),
									1,100 - ls_cnt_result_rate,trunc((cnt_result_amt + ls_cnt_result_amt) / cnt_amt * 100,2) - ls_cnt_result_rate )),
		       cost_rate = decode((result_amt + ls_result_amt),0,0,decode(sign(trunc((cost_amt + ls_cost_amt) / (result_amt + ls_result_amt) * 100,2) - 999),
									1,999,trunc((cost_amt + ls_cost_amt) / (result_amt + ls_result_amt) * 100,2) - ls_cost_rate ))
		 WHERE dept_code = as_dept_code
		   AND yymm      = adt_date;
		UPDATE c_spec_const_detail  
		  SET  result_rate = decode(amt,0,0,decode(sign(trunc((result_amt + ls_result_amt) / amt * 100,2) - 100),
									1,100 - ls_result_rate,trunc((result_amt + ls_result_amt) / amt * 100,2) - ls_result_rate )),
		       cnt_result_rate = decode(cnt_amt,0,0,decode(sign(trunc((cnt_result_amt + ls_cnt_result_amt) / cnt_amt * 100,2) - 100),
									1,100 - ls_cnt_result_rate,trunc((cnt_result_amt + ls_cnt_result_amt) / cnt_amt * 100,2) - ls_cnt_result_rate )),
		       cost_rate = decode((result_amt + ls_result_amt),0,0,decode(sign(trunc((cost_amt + ls_cost_amt) / (result_amt + ls_result_amt) * 100,2) - 999),
									1,999,trunc((cost_amt + ls_cost_amt) / (result_amt + ls_result_amt) * 100,2) - ls_cost_rate ))
		 WHERE dept_code = as_dept_code
		   AND yymm      = adt_date; 
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '원가내역 재계산작업 실패! [Line No: 2]';
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
END y_sp_c_summary_cmpt;

/
