CREATE OR REPLACE FUNCTION F_H_COMPARE_AGREE(as_dept_code     IN   VARCHAR2,
															  as_sell_code     IN   VARCHAR2,
															  as_pyong IN NUMBER,
															  as_style IN VARCHAR2,
															  as_class IN VARCHAR2,
															  as_option_code IN VARCHAR2,
															  as_DONGHO IN VARCHAR2,
															  as_SEQ    IN INTEGER)
RETURN  VARCHAR2 Is cp_yn	VARCHAR2(1);
BEGIN
select decode(nvl(count(*), 0), 0,'Y','N')
  into cp_yn
  from 
(
(select d.degree_code,
       d.agree_date,
		 d.land_amt,
		 d.build_amt,
		 d.vat_amt,
		 d.sell_amt
  from h_base_pyong_master m,
       h_base_pyong_detail d
 where m.dept_code = as_dept_code
   and m.sell_code = as_sell_code
	and m.pyong = as_pyong
	and m.style = as_style
	and m.class = as_class
	and m.option_code = as_option_code
	and m.dept_code = d.dept_code
	and m.sell_code = d.sell_code
	and m.spec_unq_num = d.spec_unq_num
minus
select a.degree_code,
       a.agree_date,
		 a.land_amt,
		 a.build_amt,
		 a.vat_amt,
		 a.sell_amt
  from h_sale_agree a
 where a.dept_code = as_dept_code
   and a.sell_code = as_sell_code
	and a.dongho    = as_dongho
	and a.seq       = as_seq)
union all
(select a.degree_code,
       a.agree_date,
		 a.land_amt,
		 a.build_amt,
		 a.vat_amt,
		 a.sell_amt
  from h_sale_agree a
 where a.dept_code = as_dept_code
   and a.sell_code = as_sell_code
	and a.dongho    = as_dongho
	and a.seq       = as_seq
minus
select d.degree_code,
       d.agree_date,
		 d.land_amt,
		 d.build_amt,
		 d.vat_amt,
		 d.sell_amt
  from h_base_pyong_master m,
       h_base_pyong_detail d
 where m.dept_code = as_dept_code
   and m.sell_code = as_sell_code
	and m.pyong = as_pyong
	and m.style = as_style
	and m.class = as_class
	and m.option_code = as_option_code
	and m.dept_code = d.dept_code
	and m.sell_code = d.sell_code
	and m.spec_unq_num = d.spec_unq_num

)
);

RETURN cp_yn;
END;
/

