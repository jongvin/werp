CREATE OR REPLACE FORCE VIEW VIEW_P_PERS_MASTER
(EMP_NO, EMP_NAME, USER_ID, DEPT_CODE, LONG_NAME, 
 SHORT_NAME, GRADE_CODE, GRADE_NAME)
AS 
select a.emp_no,
		 a.emp_name,
		 c.user_id,
		 a.dept_code,
		 d.long_name,
		 d.short_name,
		 a.grade_code,
		 b.grade_name
  from p_pers_master a,
  		 p_code_grade	b,
		 z_authority_user	c,
		 z_code_dept		d
 where a.grade_code = b.grade_code(+)
   and a.dept_code  = d.dept_code(+)
	and a.emp_no     = c.empno(+);



