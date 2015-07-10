/* ============================================================================= */
/* 함수명 : y_sp_y_outside_approve                                            */
/* 기  능 : 실행외 내역 승인 .                               */
/* ----------------------------------------------------------------------------- */
/* 인  수 : 현장코드               ==> as_dept_code (string)                     */
/* ===========================[ 변   경   이   력 ]============================= */
/* 작성자 : 박두현                                                                */
/* 작성일 : 2003.10.09                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE y_sp_y_outside_approve(as_dept_code    IN   VARCHAR2,
                                                   as_name         IN   VARCHAR2) IS
CURSOR DETAIL_CUR IS
 select  SPEC_UNQ_NUM,   
         SPEC_NO_SEQ,   
         DETAIL_CODE,   
         NAME,   
         SSIZE,   
         UNIT,   
         MAT_CODE,   
         CNT_QTY,   
         QTY,   
         NAME_KEY  
    FROM Y_OUTSIDE 
    WHERE DEPT_CODE  = as_dept_code
      and APPROVE_CLASS = '2' 
      AND APPROVE_CHK = 'T';
      
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
  V_SPEC_UNQ_NUM       Y_OUTSIDE.SPEC_UNQ_NUM%TYPE;
  V_SPEC_NO_SEQ        Y_OUTSIDE.SPEC_NO_SEQ%TYPE;
  V_DETAIL_CODE        Y_OUTSIDE.DETAIL_CODE%TYPE;   
  V_NAME               Y_OUTSIDE.NAME%TYPE;   
  V_SSIZE              Y_OUTSIDE.SSIZE%TYPE;    
  V_UNIT               Y_OUTSIDE.UNIT%TYPE;   
  V_MAT_CODE           Y_OUTSIDE.MAT_CODE%TYPE;   
  V_CNT_QTY            Y_OUTSIDE.CNT_QTY%TYPE;   
  V_QTY                Y_OUTSIDE.QTY%TYPE;   
  V_NAME_KEY           Y_OUTSIDE.NAME_KEY%TYPE;
   C_CHG_NO_SEQ         NUMBER(10,0);
   C_NO_SEQ            NUMBER(18,0);
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
   UserErr         EXCEPTION;                  -- Select Data Not Found

BEGIN
  BEGIN
   SELECT MAX(CHG_NO_SEQ) INTO C_CHG_NO_SEQ 
       FROM Y_CHG_DEGREE 
       WHERE DEPT_CODE = as_dept_code;
	OPEN	DETAIL_CUR;
	LOOP
		FETCH DETAIL_CUR INTO V_SPEC_UNQ_NUM,
		                      V_SPEC_NO_SEQ,
		                      V_DETAIL_CODE,             
		                      V_NAME,                    
		                      V_SSIZE,                   
		                      V_UNIT,                    
		                      V_MAT_CODE,                
		                      V_CNT_QTY,                 
		                      V_QTY,
		                      V_NAME_KEY  ;
		EXIT WHEN DETAIL_CUR%NOTFOUND;
		
		SELECT NVL(MAX(NO_SEQ),0) 
		  INTO C_NO_SEQ
		  FROM Y_CHG_BUDGET_DETAIL
		 WHERE dept_code  = as_dept_code  
			AND chg_no_seq = C_CHG_NO_SEQ  
			AND spec_no_seq   = V_SPEC_NO_SEQ;
	   C_NO_SEQ := C_NO_SEQ + 100;
	   
		INSERT INTO Y_CHG_BUDGET_DETAIL ( 
		           DEPT_CODE,CHG_NO_SEQ,SPEC_NO_SEQ,SPEC_UNQ_NUM,NO_SEQ,DETAIL_CODE,RES_CLASS,MAT_CODE,NAME,SSIZE,UNIT,APPROVE_YN,OUTSIDE_YN,   
					  CNT_QTY,CNT_PRICE,CNT_AMT,CNT_MAT_PRICE,CNT_MAT_AMT,CNT_LAB_PRICE,CNT_LAB_AMT,CNT_EXP_PRICE,CNT_EXP_AMT,   
					  QTY,PRICE,AMT,MAT_PRICE,MAT_AMT,LAB_PRICE,LAB_AMT,EXP_PRICE,EXP_AMT,EQU_PRICE,EQU_AMT,SUB_PRICE,SUB_AMT,   
					  REMARK,NAME_KEY,INPUT_DT,INPUT_NAME) 
				 VALUES (as_dept_code,C_CHG_NO_SEQ,V_SPEC_NO_SEQ,V_SPEC_UNQ_NUM,C_NO_SEQ,V_DETAIL_CODE,'U',V_MAT_CODE,V_NAME,V_SSIZE,V_UNIT,'Y','Y', 	
	               V_CNT_QTY,0,0,0,0,0,0,0,0,
	               V_QTY,0,0,0,0,0,0,0,0,0,0,0,0,
	               '',V_NAME_KEY,'','');

		INSERT INTO Y_BUDGET_DETAIL (  
		         DEPT_CODE,CHG_NO_SEQ,SPEC_NO_SEQ,SPEC_UNQ_NUM,NO_SEQ,DETAIL_CODE,RES_CLASS,MAT_CODE,NAME,SSIZE,UNIT,OUTSIDE_YN,   
					CNT_QTY,CNT_PRICE,CNT_AMT,CNT_MAT_PRICE,CNT_MAT_AMT,CNT_LAB_PRICE,CNT_LAB_AMT,CNT_EXP_PRICE,CNT_EXP_AMT,   
					QTY,PRICE,AMT,MAT_PRICE,MAT_AMT,LAB_PRICE,LAB_AMT,EXP_PRICE,EXP_AMT,EQU_PRICE,EQU_AMT,SUB_PRICE,SUB_AMT,   
					REMARK,NAME_KEY,INPUT_DT,INPUT_NAME)
             VALUES (as_dept_code,0,V_SPEC_NO_SEQ,V_SPEC_UNQ_NUM,C_NO_SEQ,V_DETAIL_CODE,'U',V_MAT_CODE,V_NAME,V_SSIZE,V_UNIT,'Y',	               
	               V_CNT_QTY,0,0,0,0,0,0,0,0,
	               V_QTY,0,0,0,0,0,0,0,0,0,0,0,0,
	               '',V_NAME_KEY,'','');
	END LOOP;
	CLOSE DETAIL_CUR;
    UPDATE Y_OUTSIDE
		SET APPROVE_CLASS = '4',   
			 APPROVE_DT  = sysdate,
			 approval_name = as_name
			WHERE ( DEPT_CODE  = as_dept_code ) AND  
					( APPROVE_CLASS = '2') AND 
               ( APPROVE_CHK = 'T');


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
END y_sp_y_outside_approve;
/
