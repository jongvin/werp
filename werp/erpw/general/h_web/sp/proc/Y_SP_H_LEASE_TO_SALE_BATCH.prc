CREATE OR REPLACE PROCEDURE y_sp_h_lease_to_sale_batch (as_dept_code    IN   VARCHAR2,
                                                            as_sell_code    IN   VARCHAR2,
																			   as_pyong        IN   NUMBER,
																			   as_style        IN   VARCHAR2,
																			   as_class        IN   VARCHAR2,
																			   as_option_code  IN   VARCHAR2,
																			   as_guarantee_amt   IN  NUMBER,
																			   as_recont_date     IN  DATE,
																			   as_raise_amt       IN   NUMBER,
																			   as_raise_cont_date IN  DATE,--�����������о�����
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
-- ��������
-------------------------------------------------------------
-- ���� ����
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
   UserErr         EXCEPTION;                  -- Select Data Not Found



BEGIN
  BEGIN
		OPEN	DETAIL_CUR;
		LOOP
			FETCH DETAIL_CUR INTO C_DONGHO, C_SEQ;
			EXIT WHEN DETAIL_CUR%NOTFOUND;


			y_sp_h_lease_to_sale_cmpt(as_dept_code,as_sell_code,C_DONGHO,C_SEQ,
											  as_recont_date, as_raise_amt,as_raise_cont_date,as_input_id);

		END LOOP;
		CLOSE DETAIL_CUR;

 END;
   -- *****************************************************************************
   -- PROCESS ENDDING ... !
   -- *****************************************************************************
   <<EXIT_ROUTINE>>
   -- ENDING...[0.1] CURSOR CLOSE �� Ȯ�� ó�� !
   IF Wk_errflag = 0 THEN
      Wk_errmsg  := '';                        -- ����� ���� Error Message
      Wk_errflag := 0;                         -- ����� ���� Error Code
   ELSE
      Wk_errmsg := RTRIM(e_msg) || '/>';
      RAISE UserErr;
   END IF;
EXCEPTION
  WHEN UserErr       THEN
       RAISE_APPLICATION_ERROR(Wk_errflag, Wk_errmsg);
END y_sp_h_lease_to_sale_batch;
/

