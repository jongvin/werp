--전월말기준금액
CREATE OR REPLACE VIEW V_BUDG_022 AS	
select
	  comp_code,
	  dept_code,
	  emp_no,
	  emp_name,
	  order_dt,
	  --bf_order_dept_code,
	  --bf_order_grade_code, 
	  a.budg_code_no,
	  a.item_no,
	  a.item_name,
	  a.day_calc_tag,
	  a.all_chg_tag,
	  a.unit_tag,
	  budg_ym,
	  rn,
	  qty,
	  unit_cost,
	  qty*unit_cost amt

from
	(
	select  comp_code,
		   dept_code,
		   emp_no,
		   emp_name,
		   order_dt,
		   --bf_order_dept_code,
		   --bf_order_grade_code, 
		   a.budg_code_no,
		   a.item_no,
		   a.item_name,
		   a.day_calc_tag,
		   a.all_chg_tag,
		   a.unit_tag,
		   rn,
		   budg_ym,
		   (CASE a.unit_tag WHEN 'D' 
			    THEN decode(day_calc_tag,'M',30, 
					 		'D',
							to_number(F_T_Get_Last_Days2(budg_ym)) 
							)
			WHEN 'M' --월당단가 
				 THEN decode(day_calc_tag,'M',1, 
					 	    'D',  
							 1
							  
						   ) 
			END) qty,
			unit_cost
	from
	( 
	select comp_code,
		   dept_code,
		   emp_no,
		   emp_name,
		   order_dt,
		   --bf_order_dept_code,
		   --bf_order_grade_code, 
		   a.budg_code_no,
		   a.item_no,
		   a.item_name,
		   a.day_calc_tag,
		   a.all_chg_tag,
		   a.unit_tag,
		   rn,
		   budg_ym,
		   a.unit_cost	   
	from 
	(
		select 
			   comp_code,
			   dept_code,
			   emp_no,
			   emp_name,
			   order_dt,
			   --bf_order_dept_code,
			   --bf_order_grade_code, 
			   a.budg_code_no,
			   a.item_no,
			   a.item_name,
			   a.day_calc_tag,
			   a.all_chg_tag,
			   a.unit_tag,
			   a.unit_cost
		from
		(select
			   a.comp_code,
			   dept_code,
			   emp_no,
			   emp_name,
			   order_dt,
			   --bf_order_dept_code,
			   --bf_order_grade_code, 
			   a.budg_code_no,
			   a.item_no,
			   a.item_name,
			   a.day_calc_tag,
			   a.all_chg_tag,
			   a.unit_tag,
			   decode(a.grade_unit_tag, 
			   		  'T',
					  (select c.unit_cost
					  from t_budg_item_grade_cost c
					  where c.budg_code_no= a.budg_code_no
					  and   c.item_no     = a.item_no
					  and	c.grade_code  = b.grade_code), 
					  a.unit_cost) unit_cost	     
		from t_budg_item_cost a,
			 V_BUDG_021 b) a 
		
	) a, 
	(SELECT  to_char(sysdate,'YYYY') 
			||'-'|| decode(to_char(rownum),
						   '10','10' || '-01',
						   '11','11' || '-01',
						   '12','12' || '-01',
						   '0' || to_char(rownum) || '-01' 
						   )  budg_ym, 
			rownum rn 
	FROM all_objects b 
	WHERE rownum <= 12) b 
	) a
) a
	   
--sysdate 적용월 역할 