/* ============================================================================= */
/* 함수명 : y_sp_y_approve                                                       */
/* 기  능 : 실행내역승인프로세스.                               */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 승인/확정구분          ==> as_app_fix   (string)                     */
/*                                     A:실행예산 승인     F:실행예산 확정       */
/*        : 현장코드               ==> as_dept_code (string)                     */
/*        : 변경순번               ==> ai_chg_no_seq(Integer)                    */
/*        : 사용자                 ==> as_user      (string)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2003.04.22                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_y_approve(as_app_fix      IN   VARCHAR2, 
                                           as_dept_code    IN   VARCHAR2,
                                           ai_chg_no_seq   IN   INTEGER,
                                           as_user         IN   VARCHAR2, 
                                           as_user_name    IN   VARCHAR2) IS
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
		delete from y_budget_detail
				where dept_code = as_dept_code ;

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'delete detail 자료변환 실패! [Line No: 157]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
	END;
	BEGIN
		delete from y_budget_parent
				where dept_code = as_dept_code ;

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'delete parent 자료변환 실패! [Line No: 157]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
	END;
	BEGIN

		INSERT INTO Y_BUDGET_PARENT  
		  SELECT DEPT_CODE,0,SPEC_NO_SEQ,NO_SEQ,SUM_CODE,PARENT_SUM_CODE,DIRECT_CLASS,WBS_CODE,LLEVEL,INVEST_CLASS,   
					NAME,SSIZE,UNIT,CNT_AMT,CNT_MAT_AMT,CNT_LAB_AMT,CNT_EXP_AMT,AMT,MAT_AMT,LAB_AMT,EXP_AMT,
					EQU_AMT,SUB_AMT,REMARK,division,sysdate,as_user_name
			 FROM Y_CHG_BUDGET_PARENT  
			WHERE ( DEPT_CODE = as_dept_code ) AND  
					( CHG_NO_SEQ = ai_chg_no_seq );

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'insert parent 자료변환 실패! [Line No: 157]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
	END;
	BEGIN
		INSERT INTO Y_BUDGET_DETAIL  
		  SELECT DEPT_CODE,0,SPEC_NO_SEQ,SPEC_UNQ_NUM,NO_SEQ,DETAIL_CODE,RES_CLASS,MAT_CODE,NAME,SSIZE,UNIT,DECODE(OUTSIDE_YN,'Y',DECODE(AMT,0,'Y','N'),'N'),   
					CNT_QTY,CNT_PRICE,CNT_AMT,CNT_MAT_PRICE,CNT_MAT_AMT,CNT_LAB_PRICE,CNT_LAB_AMT,CNT_EXP_PRICE,CNT_EXP_AMT,   
					QTY,PRICE,AMT,MAT_PRICE,MAT_AMT,LAB_PRICE,LAB_AMT,EXP_PRICE,EXP_AMT,EQU_PRICE,EQU_AMT,SUB_PRICE,SUB_AMT,   
					REMARK,NAME_KEY,sysdate,as_user_name  
			 FROM Y_CHG_BUDGET_DETAIL  
			WHERE ( DEPT_CODE = as_dept_code ) AND  
					( CHG_NO_SEQ = ai_chg_no_seq );

      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := 'insert detail 자료변환 실패! [Line No: 157]';
              Wk_errflag := -20020;
         
              GOTO EXIT_ROUTINE;
           END IF;   
	END;
	BEGIN
      -- 실행예산 입력 화면에서 확정 버튼을 클릭한 경우에는 변경차수 TABLE 을 수정하지 않는다.

      -- as_app_fix = 'A' : 실행예산 승인    'F':실행예산 확정
		IF as_app_fix = 'F' THEN  
			UPDATE Y_CHG_DEGREE  
			  SET APPROVE_CLASS = '6',   
					WORK_DT  = sysdate,  
	            CHARGE_NAME = as_user_name 
			WHERE ( DEPT_CODE  = as_dept_code ) AND  
					( CHG_NO_SEQ = ai_chg_no_seq );
      ELSE
			UPDATE Y_CHG_DEGREE  
			  SET APPROVE_CLASS = '4',   
					APPROVE_DT  = sysdate,  
	            CHARGE_NAME = as_user_name 
			WHERE ( DEPT_CODE  = as_dept_code ) AND  
					( CHG_NO_SEQ = ai_chg_no_seq );
      END IF;

			UPDATE Y_CHG_BUDGET_DETAIL  
			  SET OUTSIDE_YN = 'N'   
			WHERE ( DEPT_CODE  = as_dept_code ) AND  
					( CHG_NO_SEQ = ai_chg_no_seq ) AND
					( OUTSIDE_YN = 'Y') AND
					( AMT <> 0) ;
      
      
		EXCEPTION
		WHEN others THEN 
			  IF SQL%NOTFOUND THEN
				  e_msg      := 'update 자료변환 실패! [Line No: 157]';
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
END y_sp_y_approve;

/
