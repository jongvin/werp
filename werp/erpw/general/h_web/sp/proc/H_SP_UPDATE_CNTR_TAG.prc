CREATE OR REPLACE PROCEDURE H_Sp_Update_Cntr_Tag(as_dept_code     IN   VARCHAR2,
                                                  as_sell_code     IN   VARCHAR2,
																  as_work_date  IN   DATE) IS

--조정대상 태그 업데이트 
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   C_CNT               INTEGER;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error

   sql_stmt            VARCHAR2(100);
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN
	   UPDATE H_SALE_MASTER AA
         SET AA.CNTR_TAG = (SELECT 'Y'
                              FROM (SELECT CONT.dept_code,
                                           CONT.sell_code,
                                           CONT.DONGHO,
                                           CONT.SEQ
                                     FROM ( SELECT MASTER.dept_code,
                                                   MASTER.sell_code,
                                                   MASTER.DONGHO,
                                                   MASTER.SEQ,
                                                   SUM(NVL(agree.sell_amt,0)) agree_sell_amt
                                    			  FROM H_SALE_MASTER MASTER,
                                    			       H_SALE_AGREE agree
                                    			 WHERE MASTER.dept_code LIKE AS_dept_code
                                    				AND MASTER.sell_code LIKE AS_sell_code
                                    				AND MASTER.last_contract_date <= AS_WORK_DATE
                                    				AND MASTER.chg_date > AS_WORK_DATE
                                    				AND MASTER.chg_div <> '00'
                                    				AND MASTER.dept_code = agree.dept_code(+)
                                    			   AND MASTER.sell_code = agree.sell_code(+)
                                    				AND MASTER.dongho    = agree.dongho(+)
                                    				AND MASTER.seq       = agree.seq(+)
                                    			GROUP BY MASTER.dept_code,
                                                    MASTER.sell_code,
                                                    MASTER.DONGHO,
                                                    MASTER.SEQ
                                           ) cont,
                                           ( SELECT MASTER.dept_code,
                                                    MASTER.sell_code,
                                                    MASTER.DONGHO,
                                                    MASTER.SEQ,
                                                    SUM(NVL(income.r_amt,0)) income_r_amt
                                    			  FROM H_SALE_MASTER MASTER,
                                    			       H_SALE_AGREE agree,
                                    					 H_SALE_INCOME income
                                    			 WHERE MASTER.dept_code LIKE AS_dept_code
                                    				AND MASTER.sell_code LIKE AS_sell_code
                                    				AND MASTER.last_contract_date <= AS_WORK_DATE
                                    				AND MASTER.chg_date > AS_WORK_DATE
                                    				AND MASTER.chg_div <> '00'
                                    				AND MASTER.dept_code = agree.dept_code(+)
                                    			   AND MASTER.sell_code = agree.sell_code(+)
                                    				AND MASTER.dongho    = agree.dongho(+)
                                    				AND MASTER.seq       = agree.seq(+)
                                    				AND agree.dept_code = income.dept_code
                                    			   AND agree.sell_code = income.sell_code
                                    				AND agree.dongho    = income.dongho
                                    				AND agree.seq       = income.seq 
                                    				AND agree.degree_code = income.degree_code
                                                AND income.degree_seq < 90
                                                AND INCOME.RECEIPT_DATE <= AS_WORK_DATE
                                    			GROUP BY MASTER.dept_code,
                                                    MASTER.sell_code,
                                                    MASTER.DONGHO,
                                                    MASTER.SEQ
                                           ) cont_income	
                                   WHERE CONT.dept_code = cont_income.dept_code
                                     AND CONT.sell_code = cont_income.sell_code
                                     AND CONT.DONGHO    = cont_income.DONGHO
                                 	 AND CONT.SEQ       = cont_income.SEQ
                                     AND NVL(CONT.AGREE_SELL_AMT, 0) <= NVL(CONT_INCOME.INCOME_R_AMT, 0)
                               ) BB
                      WHERE BB.dept_code = aa.dept_code  
                        AND BB.sell_code = aa.sell_code  
                        AND BB.DONGHO    = AA.DONGHO    
                        AND BB.SEQ       = AA.SEQ         
                     )
      
                       ;
		  
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
END H_Sp_Update_Cntr_Tag;
/

