Create Or Replace View V_T_BUDG_DEPT_INFO
(
	comp_code,
	dept_code,
	grade_code,
	emp_no
) 
As
select  comp_code,
	   dept_code,
	   b_jik grade_code,
	   empno emp_no
	   
from
	(
	select empno, 
		   hname,
		   b_dept,
		   b_deptnm,
		   b_jik,
		   ymdfr,
		   ymdto
	from
		(
			select a.empno,
				   a.hname,
				   a.dept dept,
				   a.deptnm deptnm,
				   b.dept b_dept,
				   b.sdeptnm b_deptnm,
				   a.jikgub m_jik,
				   b.jikgub b_jik,
				   b.hobong,
				   to_date(b.ymdfr) ymdfr,
				   to_date(b.ymdto) ymdto,
				   b.wrkymd,
				   row_number() over(partition by a.empno order by a.empno, ymdfr desc) no2
			from pmas001vv@cjhrm a,
				 pord001vv@cjhrm b
			where a.STSGBN='AAA'
			and	  a.empno=b.empno
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
	) b
where a.b_dept = b.dept
/
