CREATE OR REPLACE PROCEDURE y_sp_h_type_chg_insert(as_dept_code    IN   VARCHAR2,
                                                   as_sell_code    IN   VARCHAR2,
                                                   as_dongho       IN   VARCHAR2,
                                                   as_cdongho      IN   VARCHAR2,
                                                   as_b_seq        IN   INTEGER,
                                                   as_seq          IN   INTEGER,
																	as_lease_supply IN   NUMBER,
																	as_lease_vat IN   NUMBER,
																	as_chg_date     IN   DATE) IS
-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(500);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   C_LEVEL              NUMBER(20,5);  --
   C_CNT                NUMBER(20,5);  --
   UserErr         EXCEPTION;                  -- Select Data Not Found
BEGIN
  BEGIN

	 y_sp_h_name_chg_insert(as_dept_code,as_sell_code,as_dongho,as_cdongho,as_b_seq,as_seq);

	 update h_leas_lease_agree
	    set lease_amt = as_lease_supply + as_lease_vat,
		     lease_supply = as_lease_supply,
			  lease_vat    = as_lease_vat,
			  vat_yn = decode(as_lease_vat, 0, 'N', 'Y')
	  where dept_code = as_dept_code
	    and sell_code = as_sell_code
		 and dongho    = as_dongho
		 and seq       = as_seq
		 and agree_date > as_chg_date;

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
END y_sp_h_type_chg_insert;
/

