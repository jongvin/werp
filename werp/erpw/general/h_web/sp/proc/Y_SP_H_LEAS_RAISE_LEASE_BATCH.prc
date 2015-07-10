CREATE OR REPLACE PROCEDURE y_sp_h_leas_raise_lease_batch (as_dept_code    IN   VARCHAR2,
                                                            as_sell_code    IN   VARCHAR2,
																			   as_pyong        IN   NUMBER,
																			   as_style        IN   VARCHAR2,
																			   as_class        IN   VARCHAR2,
																			   as_option_code  IN   VARCHAR2,
																			   as_lease_supply   IN  NUMBER,
																			   as_recont_date     IN  DATE,
																			   as_raise_amt       IN   NUMBER,

																			   as_input_id        IN  VARCHAR2) IS



CURSOR DETAIL_CUR IS
     select h_sale_master.dongho,
		      h_sale_master.seq
       from h_sale_master,
		      (select max(dongho) dongho,max(seq) seq
     			   from h_sale_master
      		  where dept_code =   as_dept_code
     			 	 and sell_code =   as_sell_code
     		    group by dept_code,sell_code,dongho ) sale
      where h_sale_master.dept_code = as_dept_code
        and h_sale_master.sell_code = as_sell_code
        and h_sale_master.dongho = sale.dongho
        and h_sale_master.seq = sale.seq

		  AND H_SALE_MASTER.CONTRACT_YN ='Y'
		  and h_sale_master.pyong = as_pyong
		  and h_sale_master.style = as_style
		  and h_sale_master.class = as_class
		  and h_sale_master.option_code = as_option_code
		  and h_sale_master.lease_supply = as_lease_supply

	    and h_sale_master.contract_code = 02 ;

-------------------------------------------------------------
-- 변수선언
-------------------------------------------------------------
-- 공통 변수
   Wk_errmsg           VARCHAR2(1000);              -- Error Message Edit
   Wk_errflag          INTEGER        DEFAULT 0;   -- Process Error Code
   e_msg               VARCHAR2(100);
-- User Define Error
   C_DONGHO           H_SALE_MASTER.DONGHO%TYPE;    --
   C_SEQ              H_SALE_MASTER.SEQ%TYPE;    --
	C_CONTRACT_DATE    H_SALE_MASTER.CONTRACT_DATE%TYPE;    --
	C_CNT              INTEGER;
	C_SYSDATE          DATE;
	C_DEGREE_CODE      VARCHAR2(2);
	C_LEASE_SUPPLY     NUMBER;
	C_LEASE_VAT        NUMBER;
	C_AMT        NUMBER;
	C_VAT_YN         VARCHAR2(2);
	UserErr         EXCEPTION;                  -- Select Data Not Found



BEGIN
  BEGIN
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO C_DONGHO, C_SEQ;
			EXIT WHEN DETAIL_CUR%NOTFOUND;


			select count(*)
			  into C_CNT
			  from h_leas_lease_agree target
			 where target.dept_code = as_dept_code
		      and target.sell_code = as_sell_code
		      and target.dongho    = C_DONGHO
		      and target.seq       = C_SEQ
				and target.pay_tot_amt > 0
		      and target.agree_date >= as_recont_date;

			IF C_CNT > 0 THEN
				e_msg := C_DONGHO || '세대에'||'기준일 이후에 납입금이존재합니다. 처리불가';
				Wk_errflag := -20011;
				GOTO EXIT_ROUTINE;
			END IF;

			update h_sale_master
			   set lease_supply = as_raise_amt
			  where dept_code = as_dept_code
			    and sell_code = as_sell_code
				 and dongho    = C_DONGHO
				 and seq       = C_SEQ;

			update h_leas_lease_agree target
			   set lease_supply = as_raise_amt,
				    lease_vat    = decode(vat_yn,'Y',TRUNC(as_lease_supply*0.1,0), 0),
					 lease_amt    = as_lease_supply + decode(vat_yn,'Y',TRUNC(as_lease_supply*0.1,0), 0)
		    where target.dept_code = as_dept_code
		      and target.sell_code = as_sell_code
		      and target.dongho    = C_DONGHO
		      and target.seq       = C_SEQ
		      and target.agree_date >= as_recont_date;


		END LOOP;
		CLOSE DETAIL_CUR;

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
END y_sp_h_leas_raise_lease_batch;
/

