/* ============================================================================= */
/* 함수명 : sp_y_bom_process                                                     */
/* 기  능 : EMS자료 변환(EMS -> 실행내역) .                                      */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_proj_code (string)                     */
/*        : 부분                   ==> as_part      (string)                     */
/*        : 번호                   ==> ai_degree    (string)                     */
/*        : EMS단가적용            ==> as_class     (string)                     */
/*        : 도급단가적용           ==> as_cnt       (string)                     */
/*        : 실행단가적용           ==> as_exe       (string)                     */
/*        : 사용자                 ==> as_user      (string)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2001.08.14                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_bom_process(as_proj_code    IN   VARCHAR2,
                                             as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
  CURSOR DETAIL_CUR IS
  SELECT max(mat_code),sum(nvl(qty,0)),sum(nvl(mat_amt,0))
    FROM y_budget_detail
   WHERE proj_code = as_proj_code
     AND mat_code IS NOT NULL
     AND mat_amt <> 0
GROUP BY mat_code
ORDER BY mat_code asc;

-- 공통 변수 
   V_MAT_CODE          Y_BUDGET_DETAIL.MAT_CODE%TYPE;
   V_QTY               Y_BUDGET_DETAIL.QTY%TYPE;
   V_AMT               Y_BUDGET_DETAIL.MAT_AMT%TYPE;
   C_DITAG             M_CODE_MATERIAL.DITAG%TYPE;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
   C_CNT           NUMBER(10,3);
   C_SEQ           INTEGER        DEFAULT 0;

BEGIN

 BEGIN
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_MAT_CODE,V_QTY,V_AMT;
		EXIT WHEN DETAIL_CUR%NOTFOUND;

      SELECT COUNT(*)
        INTO C_SEQ
        FROM M_CODE_MATERIAL
       WHERE MTRCODE = V_MAT_CODE;

      IF C_SEQ > 0 THEN
         SELECT DITAG
           INTO C_DITAG
           FROM M_CODE_MATERIAL
          WHERE MTRCODE = V_MAT_CODE;

         SELECT COUNT(*)
           INTO C_CNT
           FROM M_PLAN
          WHERE PROJ_CODE = as_proj_code
            AND MTRCODE   = V_MAT_CODE;

         IF C_CNT > 0 THEN
            UPDATE M_PLAN
               SET BD_QTY = V_QTY,
                   BD_AMT = V_AMT
             WHERE PROJ_CODE = as_proj_code
               AND MTRCODE   = V_MAT_CODE
               AND DITAG     = C_DITAG;
         ELSE
            INSERT INTO M_PLAN  
                 VALUES ( as_proj_code,V_MAT_CODE,C_DITAG,V_QTY,V_AMT ) ;   
         END IF;
      END IF;
	END LOOP;
	CLOSE DETAIL_CUR;

        
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'BOM 자료집계 실패! [Line No: 159]';
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
END sp_y_bom_process;

/
