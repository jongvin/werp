/* ============================================================================= */
/* 함수명 : sp_y_chgdegree_cmpt                                                  */
/* 기  능 : 변경실행내역 입력시 상위조 재계산한다.                               */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_proj_code (string)                     */
/*        : 번호(TO  )             ==> ai_no        (Integer)                    */
/*        : 집계코드               ==> as_sum_code  (string)                     */
/*        : 사용자                 ==> as_user      (string)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2001.08.22                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_chgdegree_cmpt(as_proj_code    IN   VARCHAR2,
                                                ai_no           IN   INTEGER,
                                                as_sum_code     IN   VARCHAR2,
                                                as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   C_PARENT_SUM_CODE   Y_CHG_BUDGET_SUMMARY.PARENT_SUM_CODE%TYPE;    -- 상위코드
   C_CNT_QTY           Y_CHG_BUDGET_SUMMARY.CNT_QTY%TYPE;            -- 도급수량
   C_CNT_AMT           Y_CHG_BUDGET_SUMMARY.CNT_AMT%TYPE;            -- 도급금액
   C_CNT_MAT_AMT       Y_CHG_BUDGET_SUMMARY.CNT_MAT_AMT%TYPE;        -- 도급자재비
   C_CNT_LAB_AMT       Y_CHG_BUDGET_SUMMARY.CNT_LAB_AMT%TYPE;        -- 도급노무비
   C_CNT_EXP_AMT       Y_CHG_BUDGET_SUMMARY.CNT_EXP_AMT%TYPE;        -- 도급경비
   C_QTY               Y_CHG_BUDGET_SUMMARY.QTY%TYPE;                -- 수량
   C_AMT               Y_CHG_BUDGET_SUMMARY.AMT%TYPE;                -- 금액
   C_MAT_AMT           Y_CHG_BUDGET_SUMMARY.MAT_AMT%TYPE;            -- 자재비
   C_LAB_AMT           Y_CHG_BUDGET_SUMMARY.LAB_AMT%TYPE;            -- 노무비
   C_EXP_AMT           Y_CHG_BUDGET_SUMMARY.EXP_AMT%TYPE;            -- 경비
   C_EQU_AMT           Y_CHG_BUDGET_SUMMARY.EQU_AMT%TYPE;            -- 중기비
   C_SUB_AMT           Y_CHG_BUDGET_SUMMARY.SUB_AMT%TYPE;            -- 외주비
   C_COST_AMT          Y_CHG_BUDGET_SUMMARY.COST_AMT%TYPE;           -- 예상원가
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
      SELECT NVL(SUM(CNT_AMT),0),NVL(SUM(CNT_MAT_AMT),0),NVL(SUM(CNT_LAB_AMT),0),
             NVL(SUM(CNT_EXP_AMT),0),NVL(SUM(AMT),0),NVL(SUM(MAT_AMT),0),NVL(SUM(LAB_AMT),0),
             NVL(SUM(EXP_AMT),0),NVL(SUM(EQU_AMT),0),NVL(SUM(SUB_AMT),0),NVL(SUM(COST_AMT),0)
        INTO C_CNT_AMT,C_CNT_MAT_AMT,C_CNT_LAB_AMT,C_CNT_EXP_AMT,C_AMT,C_MAT_AMT,
             C_LAB_AMT,C_EXP_AMT,C_EQU_AMT,C_SUB_AMT,C_COST_AMT
        FROM Y_CHG_BUDGET_DETAIL
       WHERE proj_code = as_proj_code  AND
             no        = ai_no AND
             sum_code  = as_sum_code;

      UPDATE Y_CHG_BUDGET_SUMMARY
         SET CNT_AMT = NVL(C_CNT_AMT,0),
             CNT_MAT_AMT = NVL(C_CNT_MAT_AMT,0),
             CNT_LAB_AMT = NVL(C_CNT_LAB_AMT,0),
             CNT_EXP_AMT = NVL(C_CNT_EXP_AMT,0),
             AMT         = NVL(C_AMT,0),
             MAT_AMT     = NVL(C_MAT_AMT,0),
             LAB_AMT     = NVL(C_LAB_AMT,0),
             EXP_AMT     = NVL(C_EXP_AMT,0),
             EQU_AMT     = NVL(C_EQU_AMT,0),
             SUB_AMT     = NVL(C_SUB_AMT,0),
             COST_AMT    = NVL(C_COST_AMT,0)
       WHERE proj_code = as_proj_code  AND
             no        = ai_no         AND
             sum_code  = as_sum_code;
 
   C_PARENT_SUM_CODE := as_sum_code;	
   SELECT LLEVEL,PARENT_SUM_CODE
     INTO C_LEVEL,C_PARENT_SUM_CODE
     FROM Y_CHG_BUDGET_SUMMARY
    WHERE proj_code       = as_proj_code  AND
          no              = ai_no         AND
          sum_code = C_PARENT_SUM_CODE;
   IF C_LEVEL <> 1 THEN
   	LOOP
         SELECT NVL(SUM(CNT_AMT),0),NVL(SUM(CNT_MAT_AMT),0),NVL(SUM(CNT_LAB_AMT),0),
                NVL(SUM(CNT_EXP_AMT),0),NVL(SUM(AMT),0),NVL(SUM(MAT_AMT),0),NVL(SUM(LAB_AMT),0),
                NVL(SUM(EXP_AMT),0),NVL(SUM(EQU_AMT),0),NVL(SUM(SUB_AMT),0),NVL(SUM(COST_AMT),0)
           INTO C_CNT_AMT,C_CNT_MAT_AMT,C_CNT_LAB_AMT,C_CNT_EXP_AMT,C_AMT,C_MAT_AMT,
                C_LAB_AMT,C_EXP_AMT,C_EQU_AMT,C_SUB_AMT,C_COST_AMT
           FROM Y_CHG_BUDGET_SUMMARY
          WHERE proj_code       = as_proj_code  AND
                no              = ai_no         AND
                parent_sum_code = C_PARENT_SUM_CODE;


         UPDATE Y_CHG_BUDGET_SUMMARY
            SET CNT_AMT = NVL(C_CNT_AMT,0),
                CNT_MAT_AMT = NVL(C_CNT_MAT_AMT,0),
                CNT_LAB_AMT = NVL(C_CNT_LAB_AMT,0),
                CNT_EXP_AMT = NVL(C_CNT_EXP_AMT,0),
                AMT         = NVL(C_AMT,0),
                MAT_AMT     = NVL(C_MAT_AMT,0),
                LAB_AMT     = NVL(C_LAB_AMT,0),
                EXP_AMT     = NVL(C_EXP_AMT,0),
                EQU_AMT     = NVL(C_EQU_AMT,0),
                SUB_AMT     = NVL(C_SUB_AMT,0),
                COST_AMT    = NVL(C_COST_AMT,0)
          WHERE proj_code       = as_proj_code  AND
                no              = ai_no         AND
                sum_code = C_PARENT_SUM_CODE;


         SELECT LLEVEL,PARENT_SUM_CODE
           INTO C_LEVEL,C_PARENT_SUM_CODE
           FROM Y_CHG_BUDGET_SUMMARY
          WHERE proj_code       = as_proj_code  AND
                no              = ai_no         AND
                sum_code = C_PARENT_SUM_CODE;
         IF C_LEVEL = 1 THEN
            EXIT;
         END IF;

  	   END LOOP;
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
END sp_y_chgdegree_cmpt;

/
