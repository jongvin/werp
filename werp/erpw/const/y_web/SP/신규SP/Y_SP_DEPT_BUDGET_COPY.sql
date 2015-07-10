CREATE OR REPLACE PROCEDURE "Y_SP_DEPT_BUDGET_COPY"  (as_from_dept_code    IN   VARCHAR2,
                                                      al_from_chg_no_seq   IN   NUMBER,
												      al_from_spec_no_seq  IN   NUMBER,
													  as_to_dept_code    IN   VARCHAR2,
                                                      al_to_chg_no_seq   IN   NUMBER,
												      al_to_spec_no_seq  IN   NUMBER) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수 
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error 
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN
		INSERT INTO Y_CHG_BUDGET_DETAIL
		       ( SELECT as_to_dept_code, al_to_chg_no_seq, al_to_spec_no_seq, y_spec_unq_no.nextval,
			     		no_seq, detail_code, res_class, mat_code, name, ssize, unit, 'N','N', 
						cnt_qty, cnt_price, cnt_amt, cnt_mat_price, cnt_mat_amt, cnt_lab_price, cnt_lab_amt,cnt_exp_price, cnt_exp_amt,
						qty, price, amt, mat_price, mat_amt, lab_price, lab_amt, exp_price, exp_amt, equ_price, equ_amt, sub_price, sub_amt,
						remark, name_key, input_dt, input_name  
			       FROM Y_CHG_BUDGET_DETAIL
				  WHERE dept_code   = as_from_dept_code
				    AND chg_no_seq  = al_from_chg_no_seq
					AND spec_no_seq = al_from_spec_no_seq);
      EXCEPTION
      WHEN others THEN 
           IF SQL%NOTFOUND THEN
              e_msg      := '타현장복사 실패! [Line No: 2]';
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
END Y_SP_DEPT_BUDGET_COPY;
/
