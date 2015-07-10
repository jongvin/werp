CREATE OR REPLACE FORCE VIEW TEMP_VIEW_INSA
(EMP_NO, DEPT_CODE, COST_DEPT_CODE, WORK_DEPT_CODE)
AS 
select a.emp_no, a.dept_code, a.cost_dept_code, a.work_dept_code
																		  from p_order_master a,
																		  		 ( select a.emp_no, max(a.order_no) m_order_no 
																					from p_order_master a,
																						  ( select a.emp_no, a.order_no
																								from p_order_master a,
																									  p_order_add_dept m
																								where a.emp_no = m.emp_no
																								  and a.spec_no_seq = m.spec_no_seq
																								  and a.emp_no <> '20031002'
																							) m
																					where a.emp_no  = m.emp_no
																					  and a.order_no < m.order_no 
																					group by a.emp_no
																					order by a.emp_no
																				   ) m
																		 where a.emp_no  = m.emp_no
																		   and a.order_no = m.m_order_no;



