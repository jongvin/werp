/* ============================================================================= */
/* 함수명 : y_sp_y_degree_insert                                                 */
/* 기  능 : 실행차수등록                                                         */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/*        : 변경순번               ==> ai_chg_no_seq(Integer)                    */
/*        : 사용자                 ==> as_user      (string)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.04.22                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_y_degree_insert(as_dept_code    IN   VARCHAR2,
                                           ai_chg_no_seq   IN   INTEGER,
                                           as_user         IN   VARCHAR2) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
		INSERT INTO Y_CHG_BUDGET_PARENT  
		  SELECT DEPT_CODE,ai_chg_no_seq,SPEC_NO_SEQ,NO_SEQ,SUM_CODE,PARENT_SUM_CODE,DIRECT_CLASS,WBS_CODE,LLEVEL,INVEST_CLASS,   
					NAME,SSIZE,UNIT,CNT_AMT,CNT_MAT_AMT,CNT_LAB_AMT,CNT_EXP_AMT,AMT,MAT_AMT,LAB_AMT,EXP_AMT,
					EQU_AMT,SUB_AMT,REMARK,division,sysdate,as_user
			 FROM Y_BUDGET_PARENT  
			WHERE ( DEPT_CODE = as_dept_code ) AND  
					( CHG_NO_SEQ = 0 );

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'insert parent 자료변환 실패! [Line No: 157]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
	END;
	BEGIN
		INSERT INTO Y_CHG_BUDGET_DETAIL  
		  SELECT DEPT_CODE,ai_chg_no_seq,SPEC_NO_SEQ,SPEC_UNQ_NUM,NO_SEQ,DETAIL_CODE,RES_CLASS,MAT_CODE,NAME,SSIZE,UNIT,'Y',OUTSIDE_YN,   
					CNT_QTY,CNT_PRICE,CNT_AMT,CNT_MAT_PRICE,CNT_MAT_AMT,CNT_LAB_PRICE,CNT_LAB_AMT,CNT_EXP_PRICE,CNT_EXP_AMT,   
					QTY,PRICE,AMT,MAT_PRICE,MAT_AMT,LAB_PRICE,LAB_AMT,EXP_PRICE,EXP_AMT,EQU_PRICE,EQU_AMT,SUB_PRICE,SUB_AMT,   
					REMARK,NAME_KEY,sysdate,as_user
			 FROM Y_BUDGET_DETAIL  
			WHERE ( DEPT_CODE = as_dept_code ) AND  
					( CHG_NO_SEQ = 0 );

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'insert detail 자료변환 실패! [Line No: 157]';
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
END y_sp_y_degree_insert;

/
