CREATE OR REPLACE PROCEDURE y_sp_h_leas_raise_grntee_batch (as_dept_code    IN   VARCHAR2,
                                                            as_sell_code    IN   VARCHAR2,
																			   as_pyong        IN   NUMBER,
																			   as_style        IN   VARCHAR2,
																			   as_class        IN   VARCHAR2,
																			   as_option_code  IN   VARCHAR2,
																			   as_guarantee_amt   IN  NUMBER,
																			   as_raise_amt       IN   NUMBER,
																			   as_raise_cont_date IN  DATE,--보증금증가분약정일
																			   as_input_id        IN  VARCHAR2) IS


CURSOR DETAIL_CUR IS
select h_sale_master.dongho,
		 h_sale_master.seq
  from h_sale_master,
       (select max(dongho) dongho,max(seq) seq
		    from h_sale_master
		   where dept_code = as_dept_code
		     and sell_code = as_sell_code
		  group by dept_code,sell_code,dongho ) sale,

		 (select dongho,
			      seq,
					sum(nvl(sell_amt,0)) amt
			 from h_sale_agree
			where dept_code = as_dept_code
           and sell_code = as_sell_code
		   group by dongho,
			       seq) guarantee
 where h_sale_master.dept_code = as_dept_code
   and h_sale_master.sell_code = as_sell_code
	and h_sale_master.pyong = as_pyong
	and h_sale_master.style = as_style
	and h_sale_master.class = as_class
	and h_sale_master.option_code = as_option_code

	and h_sale_master.dongho = sale.dongho
	and h_sale_master.seq    = sale.seq

	and h_sale_master.dongho = guarantee.dongho(+)
   and h_sale_master.seq    = guarantee.seq   (+)
	and h_sale_master.contract_code = '02'
	AND H_SALE_MASTER.CONTRACT_YN ='Y'

	and guarantee.amt = as_guarantee_amt;
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
	C_CNT              INTEGER;
	C_SYSDATE          DATE;
	C_DEGREE_CODE      VARCHAR2(2);
   C_LAND_AMT         NUMBER;
	C_BUILD_AMT          NUMBER;
	C_VAT_AMT            NUMBER;
	C_TODAY            DATE;
   UserErr         EXCEPTION;                  -- Select Data Not Found



BEGIN
  BEGIN
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO C_DONGHO, C_SEQ;
			EXIT WHEN DETAIL_CUR%NOTFOUND;


			C_DEGREE_CODE:='00';
			select nvl(max(ag.DEGREE_CODE), '00')
			  into C_DEGREE_CODE
			  from h_sale_agree ag,
			       h_code_common
			 where ag.dept_code = as_dept_code
			   and ag.sell_code = as_sell_code
				and ag.DONGHO    = C_DONGHO
				and ag.SEQ       = C_SEQ
				and ag.DEGREE_CODE = h_code_common.code
				and h_code_common.code_div = '02'
				and h_code_common.code between '51' and '70';

			if C_DEGREE_CODE = '00' then
				C_DEGREE_CODE := '51';
			else
			   if C_DEGREE_CODE <> '70' then
			   	C_DEGREE_CODE := C_DEGREE_CODE + 1;
				end if;
			end if;

			SELECT SYSDATE
			  INTO C_TODAY
			  FROM DUAL;
			insert into h_sale_agree
			values(as_dept_code, as_sell_code, C_DONGHO, C_SEQ, C_DEGREE_CODE,
                as_raise_cont_date, C_LAND_AMT, C_BUILD_AMT, C_VAT_AMT, as_raise_amt, 'N', 0,C_TODAY,0);

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
END y_sp_h_leas_raise_grntee_batch;
/

