CREATE OR REPLACE PROCEDURE y_sp_h_lease_master_deleterow(as_dept_code     IN   VARCHAR2,
                                                  as_sell_code     IN   VARCHAR2,
																  as_cont_date  IN   DATE,
																  as_cont_seq   IN   INTEGER) IS


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
	   delete h_lease_grt_income
		 where dept_code = as_dept_code
		   and sell_code = as_sell_code
		   and cont_date = as_cont_date
			and cont_seq  = as_cont_seq;
		
		delete h_lease_grt_income_daily
		 where dept_code = as_dept_code
		   and sell_code = as_sell_code
		   and cont_date = as_cont_date
			and cont_seq  = as_cont_seq;
			
		delete h_lease_grt_agree
		 where dept_code = as_dept_code
		   and sell_code = as_sell_code
		   and cont_date = as_cont_date
			and cont_seq  = as_cont_seq;
		
		delete h_lease_rent_income
		 where dept_code = as_dept_code
		   and sell_code = as_sell_code
		   and cont_date = as_cont_date
			and cont_seq  = as_cont_seq;
		
		delete h_lease_rent_income_daily
		 where dept_code = as_dept_code
		   and sell_code = as_sell_code
		   and cont_date = as_cont_date
			and cont_seq  = as_cont_seq;
		
		delete h_lease_rent_agree
		 where dept_code = as_dept_code
		   and sell_code = as_sell_code
		   and cont_date = as_cont_date
			and cont_seq  = as_cont_seq;
		
		delete h_lease_rent_detail
		 where dept_code = as_dept_code
		   and sell_code = as_sell_code
		   and cont_date = as_cont_date
			and cont_seq  = as_cont_seq;
		
		delete h_lease_detail
		 where dept_code = as_dept_code
		   and sell_code = as_sell_code
		   and cont_date = as_cont_date
			and cont_seq  = as_cont_seq;
		
		delete h_lease_cont_dongho
		 where dept_code = as_dept_code
		   and sell_code = as_sell_code
		   and cont_date = as_cont_date
			and cont_seq  = as_cont_seq;
		
		delete h_lease_delay_rate
		 where dept_code = as_dept_code
		   and sell_code = as_sell_code
		   and cont_date = as_cont_date
			and cont_seq  = as_cont_seq;
		
		delete h_lease_discount_rate
		 where dept_code = as_dept_code
		   and sell_code = as_sell_code
		   and cont_date = as_cont_date
			and cont_seq  = as_cont_seq;
		
		delete h_lease_etc
		 where dept_code = as_dept_code
		   and sell_code = as_sell_code
		   and cont_date = as_cont_date
			and cont_seq  = as_cont_seq;
			
		delete h_lease_master
       where dept_code = as_dept_code
		   and sell_code = as_sell_code
		   and cont_date = as_cont_date
			and cont_seq  = as_cont_seq;
		  
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
END y_sp_h_lease_master_deleterow;
/

