/* ============================================================================= */
/* 함수명 : sp_y_subbudget_seq_creation                                          */
/* 기  능 : 집계구조의순번을 TEMP에저장한다.                                     */
/* 작성자 : 김동우                                                               */
/* 작성일 : 2001.10.31                                                           */
/* ============================================================================= */
CREATE OR REPLACE PROCEDURE sp_y_subbudget_seq_creation(as_proj_code    IN   VARCHAR2,
                                                ai_no            IN   INTEGER,
                                                ai_estimate_no   IN   INTEGER,
                                                ai_unq_num       IN   NUMBER) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR PARENT_CUR IS
SELECT SUM_CODE,
       PARENT_SUM_CODE,
       SEQ,
       INVEST_CLASS,
       DETAIL_YN
  FROM Y_SUB_BUDGET_SUMMARY 
 WHERE PROJ_CODE    = as_proj_code    AND
       NO           = ai_no AND
       ESTIMATE_NO  = ai_estimate_no AND
       LLEVEL = 1
ORDER BY PROJ_CODE ASC,
         NO ASC,
         ESTIMATE_NO ASC,
         SEQ ASC;

-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);

-- User Define Error 
   V_SUM_CODE          Y_SUB_BUDGET_SUMMARY.SUM_CODE%TYPE;
   V_PARENT_SUM_CODE   Y_SUB_BUDGET_SUMMARY.PARENT_SUM_CODE%TYPE;
   V_SEQ               Y_SUB_BUDGET_SUMMARY.SEQ%TYPE;
   V_INVEST_CLASS      Y_SUB_BUDGET_SUMMARY.INVEST_CLASS%TYPE;
   V_DETAIL_YN         Y_SUB_BUDGET_SUMMARY.DETAIL_YN%TYPE;
   C_SA_CODE           Y_SUB_BUDGET_SUMMARY.SUM_CODE%TYPE;
   C_KA_CODE           Y_SUB_BUDGET_SUMMARY.SUM_CODE%TYPE;
   C_INVEST_CLASS      Y_SUB_BUDGET_SUMMARY.INVEST_CLASS%TYPE;
   C_DETAIL_YN         Y_SUB_BUDGET_SUMMARY.DETAIL_YN%TYPE;
   C_PARENT_SUM_CODE   Y_SUB_BUDGET_SUMMARY.PARENT_SUM_CODE%TYPE;    -- 상위코드
   C_SEQ               Y_SUB_BUDGET_SUMMARY.SEQ%TYPE; 
   C_NUMBER            NUMBER(20,5);  -- 
   C_LEVEL             NUMBER(20,5);  -- 
   C_CNT               NUMBER(20,5);  -- 
 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
   C_NUMBER := 0;
	OPEN	PARENT_CUR;
	LOOP
		FETCH PARENT_CUR INTO V_SUM_CODE,V_PARENT_SUM_CODE,V_SEQ,V_INVEST_CLASS,V_DETAIL_YN;
		EXIT WHEN PARENT_CUR%NOTFOUND;
			C_NUMBER := C_NUMBER + 1;
			INSERT INTO Y_SUMCODESEQ_TEMP  
				  VALUES ( ai_unq_num,C_NUMBER,V_SUM_CODE,V_PARENT_SUM_CODE,V_SEQ,V_INVEST_CLASS )  ;
	      IF V_INVEST_CLASS <> 'Y' AND V_DETAIL_YN = 'Y' THEN
            C_SA_CODE := V_SUM_CODE;
            C_SEQ := 0;
	         LOOP
              	begin
						SELECT COUNT(*),NVL(MIN(SEQ),0)
	                 INTO C_CNT,C_SEQ
   	              FROM Y_SUB_BUDGET_SUMMARY
						 WHERE PROJ_CODE    = as_proj_code
						   AND NO           = ai_no
						   AND ESTIMATE_NO  = ai_estimate_no
            	      AND parent_sum_code = C_SA_CODE
               	   AND SEQ > C_SEQ;
				   EXCEPTION
				   WHEN others THEN 
			        IF SQL%NOTFOUND THEN
         			  e_msg      := 'kkk1';
			           Wk_errflag := -20020;
        
			           GOTO EXIT_ROUTINE;
			        END IF;   
					end;
               IF C_CNT > 0 THEN
						begin
							SELECT SUM_CODE,PARENT_SUM_CODE,SEQ,INVEST_CLASS,DETAIL_YN
   		              INTO C_SA_CODE,C_PARENT_SUM_CODE,C_SEQ,C_INVEST_CLASS,C_DETAIL_YN
      		           FROM Y_SUB_BUDGET_SUMMARY
							 WHERE PROJ_CODE    = as_proj_code
							   AND NO           = ai_no
							   AND ESTIMATE_NO  = ai_estimate_no
               		   AND parent_sum_code = C_SA_CODE
                  		AND SEQ = C_SEQ;
						   EXCEPTION
						   WHEN others THEN 
						        IF SQL%NOTFOUND THEN
						           e_msg      := 'kkk2';
						           Wk_errflag := -20020;
        
						           GOTO EXIT_ROUTINE;
						        END IF;   
						end;
						begin
                     IF C_PARENT_SUM_CODE = '00' THEN
                        EXIT;
                     END IF;
							C_NUMBER := C_NUMBER + 1;
							INSERT INTO Y_SUMCODESEQ_TEMP  
								  VALUES ( ai_unq_num,C_NUMBER,C_SA_CODE,C_PARENT_SUM_CODE,C_SEQ,C_INVEST_CLASS )  ;
						   EXCEPTION
						   WHEN others THEN 
						        IF SQL%NOTFOUND THEN
						           e_msg      := 'kkk3';
						           Wk_errflag := -20020;
        
						           GOTO EXIT_ROUTINE;
						        END IF;   
						end;
						IF C_INVEST_CLASS <> 'Y' AND C_DETAIL_YN = 'Y' THEN
                     C_SEQ := 0;
                  END IF;
               ELSE
						begin
                     IF C_SA_CODE = '00' THEN
                        EXIT;
                     END IF;
							SELECT parent_sum_code,seq
   	                 INTO C_KA_CODE,C_LEVEL
      	              FROM Y_SUMCODESEQ_TEMP
      		          WHERE unq_num  = ai_unq_num
            		      AND sum_code = C_SA_CODE;
						   EXCEPTION
						   WHEN others THEN 
						        IF SQL%NOTFOUND THEN
					   	        e_msg      := 'kkk100-' || C_SA_CODE;
					      	     Wk_errflag := -20020;
        
						           GOTO EXIT_ROUTINE;
						        END IF;   
							end;

						begin
							SELECT COUNT(*),NVL(MIN(SEQ),0)
	   	              INTO C_CNT,C_SEQ
   	   	           FROM Y_SUB_BUDGET_SUMMARY
							 WHERE PROJ_CODE    = as_proj_code
							   AND NO           = ai_no
							   AND ESTIMATE_NO  = ai_estimate_no
            	      	AND parent_sum_code = C_KA_CODE
	               	   AND SEQ > C_LEVEL;
							   EXCEPTION
							   WHEN others THEN 
							        IF SQL%NOTFOUND THEN
						   	        e_msg      := 'kkk101';
						      	     Wk_errflag := -20020;
        
							           GOTO EXIT_ROUTINE;
							        END IF;   
						end;
                  IF C_CNT > 0 THEN
                     IF C_KA_CODE = '00' THEN
                        EXIT;
                     END IF;
                     C_SA_CODE := C_KA_CODE;
                     C_SEQ     := C_LEVEL;
                  ELSE
	                  IF LENGTH(RTRIM(C_SA_CODE)) = 2 THEN
   	                  EXIT;
      	            END IF;
         	         C_SA_CODE := SUBSTR(C_SA_CODE,1,length(RTRIM(C_SA_CODE)) - 2);
							begin
  		               	SELECT PARENT_SUM_CODE,SEQ
	   	 	              INTO C_SA_CODE,C_SEQ
   	   	  	           FROM Y_SUMCODESEQ_TEMP
      	   	  	       WHERE unq_num  = ai_unq_num
                           and SUM_CODE = C_SA_CODE;
  							   EXCEPTION
							   WHEN others THEN 
						   	     IF SQL%NOTFOUND THEN
						      	     e_msg      := C_KA_CODE || '-kkk4-' || to_char(c_number);
						         	  Wk_errflag := -20020;
        
							           GOTO EXIT_ROUTINE;
							        END IF;   
							end;
						END IF;
         	   END IF;
  		   	END LOOP;
	      END IF;
	END LOOP;
	CLOSE PARENT_CUR;

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
END sp_y_subbudget_seq_creation;

/
