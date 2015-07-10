CREATE OR REPLACE PROCEDURE Y_Sp_H_Pyong_Trans_tmp IS
CURSOR MASTER IS
 SELECT m.dept_code, m.sell_code, m.dongho, m.seq
         FROM H_SALE_MASTER m,
              (SELECT MAX(seq) seq,
                      dept_code,sell_code,dongho
                 FROM H_SALE_MASTER
                WHERE seq <> 1
               GROUP BY dept_code,sell_code,dongho) aa
              
        WHERE m.chg_div = '00'
          AND m.dept_code = aa.dept_code
          AND m.sell_code = aa.sell_code
          AND m.dongho    = aa.dongho
          AND m.seq       = aa.seq
          AND m.dept_code <> '120301'; 
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   c_dept_code          H_SALE_MASTER.dept_code%TYPE;    --
   c_sell_code          H_SALE_MASTER.sell_code%TYPE;    --
   c_dongho             H_SALE_MASTER.DONGHO%TYPE;    --
   c_seq                H_SALE_MASTER.seq%TYPE;    -- 
   V_DONGHO             H_SALE_MASTER.DONGHO%TYPE;    --
   V_SEQ                H_SALE_MASTER.SEQ%TYPE;    --
   V_PYONG              H_SALE_MASTER.PYONG%TYPE;    --
   V_STYLE              H_SALE_MASTER.STYLE%TYPE;    --
   V_CLASS              H_SALE_MASTER.CLASS%TYPE;    --
   V_OPTION_CODE        H_SALE_MASTER.OPTION_CODE%TYPE;    --
   C_SPEC_UNQ_NUM       H_BASE_PYONG_MASTER.SPEC_UNQ_NUM%TYPE;    --
   C_LEVEL              NUMBER(20,5);  --
   C_CNT                NUMBER(20,5);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN
  
     OPEN	MASTER;
		LOOP
			FETCH MASTER INTO c_dept_code, c_sell_code, c_dongho, c_seq;
			EXIT WHEN MASTER%NOTFOUND;
         
		SELECT pyong,style,CLASS,option_code
		  INTO V_PYONG,V_STYLE,V_CLASS,V_OPTION_CODE
		  FROM H_SALE_MASTER
		 WHERE dept_code = c_dept_code
		   AND sell_code = c_sell_code
			AND dongho    = c_dongho
			AND seq       = c_seq;
		SELECT COUNT(*)
		  INTO C_CNT
		  FROM H_BASE_PYONG_MASTER
		 WHERE dept_code   = c_dept_code
			AND sell_code   = c_sell_code
			AND pyong       = V_PYONG
			AND style       = V_STYLE
			AND CLASS       = V_CLASS
			AND option_code = V_OPTION_CODE;
		IF C_CNT > 0 THEN
			SELECT spec_unq_num
			  INTO C_SPEC_UNQ_NUM
			  FROM H_BASE_PYONG_MASTER
			 WHERE dept_code   = c_dept_code
				AND sell_code   = c_sell_code
				AND pyong       = V_PYONG
				AND style       = V_STYLE
				AND CLASS       = V_CLASS
				AND option_code = V_OPTION_CODE;
			DELETE FROM H_SALE_AGREE
					WHERE dept_code = c_dept_code
					  AND sell_code = c_sell_code
					  AND dongho    = c_dongho
					  AND seq       = c_seq;
			INSERT INTO H_SALE_AGREE
				 SELECT DEPT_CODE,SELL_CODE,c_dongho,c_seq,DEGREE_CODE,AGREE_DATE,LAND_AMT,
						  BUILD_AMT,VAT_AMT,SELL_AMT,'N',0,NULL,0, NULL, NULL, NULL, NULL, NULL, NULL
					FROM H_BASE_PYONG_DETAIL
				  WHERE dept_code = c_dept_code
					 AND sell_code = c_sell_code
					 AND spec_unq_num = C_SPEC_UNQ_NUM;
		END IF;
      
      
      END LOOP;
		CLOSE MASTER;
      EXCEPTION
      WHEN OTHERS THEN
           RAISE;
           /*IF SQL%NOTFOUND THEN
              e_msg      := '약정사항 이체 실패! [Line No: 2]';
              Wk_errflag := -20020;
              GOTO EXIT_ROUTINE;
           END IF;*/
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
END Y_Sp_H_Pyong_Trans_tmp;
/

