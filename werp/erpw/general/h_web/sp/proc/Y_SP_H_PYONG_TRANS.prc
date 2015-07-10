CREATE OR REPLACE PROCEDURE y_sp_h_pyong_trans(as_dept_code    IN   VARCHAR2,
                                               as_sell_code    IN   VARCHAR2,
															  as_dongho       IN   VARCHAR2,
															  as_seq          IN   INTEGER ) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
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
		SELECT pyong,style,class,option_code
		  INTO V_PYONG,V_STYLE,V_CLASS,V_OPTION_CODE
		  FROM h_sale_master
		 WHERE dept_code = as_dept_code
		   AND sell_code = as_sell_code
			AND dongho    = as_dongho
			AND seq       = as_seq;
		select count(*)
		  into C_CNT
		  from h_base_pyong_master
		 where dept_code   = as_dept_code
			and sell_code   = as_sell_code
			and pyong       = V_PYONG
			and style       = V_STYLE
			and class       = V_CLASS
			and option_code = V_OPTION_CODE;
		IF C_CNT > 0 THEN
			select spec_unq_num
			  into C_SPEC_UNQ_NUM
			  from h_base_pyong_master
			 where dept_code   = as_dept_code
				and sell_code   = as_sell_code
				and pyong       = V_PYONG
				and style       = V_STYLE
				and class       = V_CLASS
				and option_code = V_OPTION_CODE;
			delete from h_sale_agree
					where dept_code = as_dept_code
					  and sell_code = as_sell_code
					  and dongho    = as_dongho
					  and seq       = as_seq;
			INSERT INTO H_SALE_AGREE
				 SELECT DEPT_CODE,SELL_CODE,as_dongho,as_seq,DEGREE_CODE,AGREE_DATE,LAND_AMT,
						  BUILD_AMT,VAT_AMT,SELL_AMT,'N',0,null,0, null, null, null, null, null, NULL
					FROM h_base_pyong_detail
				  WHERE dept_code = as_dept_code
					 AND sell_code = as_sell_code
					 AND spec_unq_num = C_SPEC_UNQ_NUM;
		END IF;
      EXCEPTION
      WHEN others THEN
           IF SQL%NOTFOUND THEN
              e_msg      := '약정사항 이체 실패! [Line No: 2]';
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
END y_sp_h_pyong_trans;
/

