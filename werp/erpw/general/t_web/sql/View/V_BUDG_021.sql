--전월말인원현황-사업장별부서별
Create Or Replace View V_BUDG_021
(
	comp_code,
	dept_code,
 	emp_no,
 	grade_code,
	emp_name,
	order_dt--,
	--bf_order_dept_code,
       --bf_order_grade_code
) 
As
	select comp_code,
	   dept_code,
	   empno emp_no,
	   b_jik grade_code,
	   emp_name,
	   order_dt
from
	(
	select empno, 
		   emp_name,
		   b_dept,
		   b_deptnm,
		   b_jik,
		   order_dt,
		   ymdto,
		   STSGBN
	from
		(
			select a.empno,
				   a.hname emp_name,
				   a.dept dept,
				   a.deptnm deptnm,
				   b.dept b_dept,
				   b.sdeptnm b_deptnm,
				   a.jikgub m_jik,
				   b.jikgub b_jik,
				   b.hobong,
				   to_date(b.ymdfr) order_dt,
				   to_date(b.ymdto) ymdto,
				   b.wrkymd,
				   a.STSGBN,
				   row_number() over(partition by a.empno order by a.empno, ymdfr desc, ymdto desc) no2
			from pmas001vv@cjhrm a,
				 pord001vv@cjhrm b
			where	  a.empno=b.empno(+)
			and  a.STSGBN='AAA'
		)
	where no2=1
	) a,
	(
	select a.dept_code,
	   	   b.dept,
	   	   a.dept_name,
	   	   a.comp_code
    from t_dept_code_org a,
	 	 porg005vv@cjhrm b
	where a.lega_dept=b.dept
	and	budg_cls='T'  
	) b
where a.b_dept = b.dept
/
