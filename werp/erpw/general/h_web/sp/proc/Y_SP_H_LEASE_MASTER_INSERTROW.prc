CREATE OR REPLACE PROCEDURE y_sp_h_lease_master_insertrow(as_dept_code     IN   VARCHAR2,
                                                  as_sell_code     IN   VARCHAR2,
																  as_cont_date  IN   DATE) IS


-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   C_CNT               INTEGER;
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error

   c_cont_seq       H_lease_master.cont_seq%TYPE;
	c_cont_num       H_lease_master.cont_num%TYPE;
	sql_stmt            VARCHAR2(100);
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
	BEGIN
		select decode(nvl(max(cont_seq),0), 0, 1, nvl(max(cont_seq),0)+1)
		  into c_cont_seq 
	     from h_lease_master
	    where dept_code = as_dept_code
	      and sell_code = as_sell_code
		   and to_char(cont_date,'yyyymm') = to_char(as_cont_date,'yyyymm');

		c_cont_num := as_dept_code||'-'||to_char(as_cont_date,'yyyymm')||'-'||trim(to_char(c_cont_seq,'00'));
		
		insert into h_lease_master(dept_code, sell_code, cont_date, cont_seq, cont_num, cont_type, exp_tag)
       values( as_dept_code,as_sell_code,as_cont_date,c_cont_seq,c_cont_num, '01', 'N');
		
		INSERT INTO H_LEASE_DELAY_RATE  
			SELECT DEPT_CODE,SELL_CODE,
		          as_cont_date,
				    c_cont_seq  ,
				    RATE_KIND,
				    MNTH,
				    S_DATE,
				    E_DATE,  
					 RATE,
					 CUTOFF_STD,
					 CUTOFF_UNIT    
		  	  FROM H_BASE_DELAY_RATE   
		    WHERE DEPT_CODE = as_dept_code AND   
		          SELL_CODE = as_sell_code;
		 INSERT INTO H_LEASE_DISCOUNT_RATE  
		    SELECT DEPT_CODE,
			        SELL_CODE,
					  as_cont_date, 
					  c_cont_seq  ,
					  RATE_KIND,
					  S_DATE,
					  E_DATE, 
		           RATE,
					  CUTOFF_STD,
					  CUTOFF_UNIT   
			   FROM H_BASE_DISCOUNT_RATE  
		     WHERE DEPT_CODE = as_dept_code AND  
		           SELL_CODE = as_sell_code;     

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
END y_sp_h_lease_master_insertrow;
/

