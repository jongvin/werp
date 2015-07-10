CREATE OR REPLACE PROCEDURE "Y_SP_H_GET_V_ACCOUNT_NO" (as_dept_code             IN   VARCHAR2,
																	  as_sell_code              IN   VARCHAR2,
																	  as_dongho                 IN   VARCHAR2,
																	  as_seq                    IN   INTEGER
																	  ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
CURSOR BASE_AGREE_CUR IS
SELECT DEGREE_CODE, AGREE_DATE, AMT_PER
  FROM H_BASE_ONTIME_AGREE
 WHERE DEPT_CODE = AS_DEPT_CODE
ORDER BY DEGREE_CODE;
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   UserErr         EXCEPTION;
   C_CNT           NUMBER(10,0);
	C_SYSDATE       DATE;
	V_AMT           NUMBER(15,0);
	V_AMT_VAT       NUMBER(15,0);
	V_DEGREE_CODE   VARCHAR2(2);
	V_AGREE_DATE    DATE;
	V_AMT_PER       NUMBER(5,2);
	V_AGREE_AMT     NUMBER(15,0);
BEGIN
	BEGIN
		OPEN	BASE_AGREE_CUR;
			SELECT SUM(NVL(AMT,0)), SUM(NVL(AMT_VAT,0))  
		     INTO V_AMT, V_AMT_VAT
			  FROM H_SALE_ONTIME_MASTER
			 WHERE DEPT_CODE = AS_DEPT_CODE
			   AND SELL_CODE = AS_SELL_CODE
				AND DONGHO    = AS_DONGHO
				AND SEQ       = AS_SEQ;
	      IF NOT(V_AMT > 0) THEN 
			   RETURN;
			END IF;
			LOOP
				FETCH BASE_AGREE_CUR INTO V_DEGREE_CODE, V_AGREE_DATE, V_AMT_PER;
				EXIT WHEN BASE_AGREE_CUR%NOTFOUND ;
	         
				V_AGREE_AMT := (V_AMT+V_AMT_VAT) * V_AMT_PER/ 100;
				INSERT INTO H_SALE_ONTIME_AGREE
				 VALUES(AS_DEPT_CODE, AS_SELL_CODE, AS_DONGHO, AS_SEQ, V_DEGREE_CODE, V_AGREE_DATE, V_AGREE_AMT, 'N', 0, NULL, NULL, NULL);
			END LOOP;
		CLOSE BASE_AGREE_CUR;
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
END Y_SP_H_GET_V_ACCOUNT_NO;
/

