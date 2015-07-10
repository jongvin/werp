CREATE OR REPLACE PROCEDURE H_Sp_Update_Cntr_Tag_v2(as_dept_code     IN   VARCHAR2,
                                                  as_sell_code       IN   VARCHAR2,
																  as_work_date       IN   DATE,
                                                  as_work_tag        IN   VARCHAR2 --'조정', '삭제'
                                                  ) IS

--조정대상 태그 업데이트 
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   C_CNT               INTEGER;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
   v_dept_code H_SALE_MASTER.dept_code%TYPE;
   v_sell_code H_SALE_MASTER.sell_code%TYPE;
   v_dongho    H_SALE_MASTER.dongho%TYPE;
   v_seq       H_SALE_MASTER.seq%TYPE;
-- User Define Error

   sql_stmt            VARCHAR2(100);
   UserErr         EXCEPTION;                  -- Select Data Not Found
CURSOR DETAIL_CUR(v_dept_code IN VARCHAR2, v_sell_code IN VARCHAR2, v_work_date IN VARCHAR2) IS   
 SELECT CONT.dept_code,
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
  			 WHERE MASTER.dept_code LIKE v_dept_code
  				AND MASTER.sell_code LIKE v_sell_code
  				AND MASTER.last_contract_date <= v_WORK_DATE
  				AND MASTER.chg_date > v_WORK_DATE
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
  			 WHERE MASTER.dept_code LIKE v_dept_code
  				AND MASTER.sell_code LIKE v_sell_code
  				AND MASTER.last_contract_date <= v_WORK_DATE
  				AND MASTER.chg_date > v_WORK_DATE
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
              AND INCOME.RECEIPT_DATE <= v_WORK_DATE
  			GROUP BY MASTER.dept_code,
                  MASTER.sell_code,
                  MASTER.DONGHO,
                  MASTER.SEQ
         ) cont_income	
 WHERE CONT.dept_code = cont_income.dept_code
  AND CONT.sell_code = cont_income.sell_code
  AND CONT.DONGHO    = cont_income.DONGHO
  AND CONT.SEQ       = cont_income.SEQ
  AND NVL(CONT.AGREE_SELL_AMT, 0) <= NVL(CONT_INCOME.INCOME_R_AMT, 0);

  
BEGIN
	BEGIN
   
     IF as_work_tag = '삭제' THEN
        UPDATE H_SALE_MASTER
           SET cntr_tag = NULL
         WHERE dept_code LIKE as_dept_code
           AND sell_code LIKE as_sell_code;
     ELSIF as_work_tag = '조정' THEN
     
     IF as_dept_code = 'ALL' THEN
        v_dept_code :='%';
     END IF;
     
     IF as_sell_code = 'ALL' THEN
        v_sell_code :='%';
     END IF;
     
     OPEN	DETAIL_CUR(as_dept_code, as_sell_code , as_work_date);
		
	  LOOP
		 FETCH DETAIL_CUR INTO v_dept_code, v_sell_code, v_dongho, v_seq;
		 EXIT WHEN DETAIL_CUR%NOTFOUND;
       
       UPDATE H_SALE_MASTER
          SET cntr_tag = 'Y'
        WHERE dept_code = v_dept_code
          AND sell_code = v_sell_code
          AND dongho    = v_dongho
          AND seq       = v_seq;
       
     END LOOP;
     CLOSE detail_cur   
	                    ;
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
END H_Sp_Update_Cntr_Tag_v2;
/

