CREATE OR REPLACE Procedure SP_T_FL_REPORT_TEMP0021_COPY
(
	AR_EMP_NO                                  VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2
)
Is
	lsClose					Varchar2(2);
	lnAmt					Number;
Begin

--RAISE_APPLICATION_ERROR(-20000, AR_EMP_NO || AR_DEPT_CODE || AR_YEAR || AR_MONTH);
delete 
from T_FL_REPORT_TEMP0021
where emp_no = AR_EMP_NO;

insert into T_FL_REPORT_TEMP0021
(
	   emp_no,
	   flow_item_name,
	   b_y_exec_amt,  
	   plan_amt01,    
	   plan_amt02,    
	   plan_amt03,    
	   plan_amt04,    
	   plan_amt05,    
	   plan_amt06,    
	   plan_amt07,    
	   plan_amt08,    
	   plan_amt09,    
	   plan_amt10,    
	   plan_amt11,    
	   plan_amt12,    
	   c_y_plan_amt, 
	   b_c_y_amt
)	

select --a.p_no,
	   --a.flow_code,
	   AR_EMP_NO,
	   lpad(' ', (level-1) *2 ) || flow_item_name flow_item_name,
	   b_y_exec_amt,  
	   plan_amt01,    
	   plan_amt02,    
	   plan_amt03,    
	   plan_amt04,    
	   plan_amt05,    
	   plan_amt06,    
	   plan_amt07,    
	   plan_amt08,    
	   plan_amt09,    
	   plan_amt10,    
	   plan_amt11,    
	   plan_amt12,    
	   c_y_plan_amt, 
	   b_c_y_amt	   
from
	(
	select  a.p_no,
			a.flow_code,
		    sum(b_y_exec_amt) b_y_exec_amt,  
			sum(plan_amt01)  plan_amt01,     
			sum(plan_amt02)  plan_amt02,     
			sum(plan_amt03)  plan_amt03,     
			sum(plan_amt04)  plan_amt04,     
			sum(plan_amt05)  plan_amt05,     
			sum(plan_amt06)  plan_amt06,     
			sum(plan_amt07)  plan_amt07,     
			sum(plan_amt08)  plan_amt08,     
			sum(plan_amt09)  plan_amt09,     
			sum(plan_amt10)  plan_amt10,     
			sum(plan_amt11)  plan_amt11,     
			sum(plan_amt12)  plan_amt12,     
			sum(c_y_plan_amt) c_y_plan_amt,  
			sum(b_c_y_amt)	 b_c_y_amt	     
	from t_fl_flow_code a,
		 (select 
		 		 b3.flow_code,
				 decode(nvl(b_y_exec_amt,0), 0, 0, round(b_y_exec_amt/1000000,2))  b_y_exec_amt,
				 decode(nvl(plan_amt01,0), 0, 0, round(plan_amt01/1000000,2)) plan_amt01,  
				 decode(nvl(plan_amt02,0), 0, 0, round(plan_amt02/1000000,2)) plan_amt02,
				 decode(nvl(plan_amt03,0), 0, 0, round(plan_amt03/1000000,2)) plan_amt03,
				 decode(nvl(plan_amt04,0), 0, 0, round(plan_amt04/1000000,2)) plan_amt04,  
				 decode(nvl(plan_amt05,0), 0, 0, round(plan_amt05/1000000,2)) plan_amt05,
				 decode(nvl(plan_amt06,0), 0, 0, round(plan_amt06/1000000,2)) plan_amt06,
				 decode(nvl(plan_amt07,0), 0, 0, round(plan_amt07/1000000,2)) plan_amt07,  
				 decode(nvl(plan_amt08,0), 0, 0, round(plan_amt08/1000000,2)) plan_amt08,
				 decode(nvl(plan_amt09,0), 0, 0, round(plan_amt09/1000000,2)) plan_amt09,
				 decode(nvl(plan_amt10,0), 0, 0, round(plan_amt10/1000000,2)) plan_amt10, 
				 decode(nvl(plan_amt11,0), 0, 0, round(plan_amt11/1000000,2)) plan_amt11,
				 decode(nvl(plan_amt12,0), 0, 0, round(plan_amt12/1000000,2)) plan_amt12,
				 decode(nvl(c_y_plan_amt,0), 0, 0, round(c_y_plan_amt/1000000,2)) c_y_plan_amt,
				 round( decode(nvl(b_y_exec_amt,0), 0, 0, b_y_exec_amt/1000000) + decode( nvl(c_y_plan_amt,0), 0, 0, c_y_plan_amt/1000000),2) b_c_y_amt
		  from 
				 (select comp_code, clse_acc_id + 1 clse_acc_id, dept_code, flow_code,  b_y_exec_amt
				  from 
					 (select comp_code, clse_acc_id, dept_code, flow_code, sum(exec_amt) b_y_exec_amt
					  from t_fl_month_plan_exec
					  where comp_code = AR_COMP_CODE
					  and	clse_acc_id = AR_CLSE_ACC_ID - 1
					  and	dept_code	= AR_DEPT_CODE
					  group by comp_code, clse_acc_id, dept_code, flow_code)
				  ) b1,
				  (select comp_code, clse_acc_id, dept_code, flow_code,
				  		 sum(plan_amt01) plan_amt01,
						 sum(plan_amt02) plan_amt02,
						 sum(plan_amt03) plan_amt03,
						 sum(plan_amt04) plan_amt04,
						 sum(plan_amt05) plan_amt05,
						 sum(plan_amt06) plan_amt06,
						 sum(plan_amt07) plan_amt07,
						 sum(plan_amt08) plan_amt08,
						 sum(plan_amt09) plan_amt09,
						 sum(plan_amt10) plan_amt10,
						 sum(plan_amt11) plan_amt11,
						 sum(plan_amt12) plan_amt12
				  from 
				  	  (
					  select comp_code, clse_acc_id, dept_code, flow_code,
					  		  decode(substr(work_ym, 5,6) ,'01', sum(plan_amt), '') plan_amt01,
					  		  decode(substr(work_ym, 5,6) ,'02', sum(plan_amt), '') plan_amt02,
							  decode(substr(work_ym, 5,6) ,'03', sum(plan_amt), '') plan_amt03,
							  decode(substr(work_ym, 5,6) ,'04', sum(plan_amt), '') plan_amt04,
							  decode(substr(work_ym, 5,6) ,'05', sum(plan_amt), '') plan_amt05,
							  decode(substr(work_ym, 5,6) ,'06', sum(plan_amt), '') plan_amt06,
							  decode(substr(work_ym, 5,6) ,'07', sum(plan_amt), '') plan_amt07,
							  decode(substr(work_ym, 5,6) ,'08', sum(plan_amt), '') plan_amt08,
							  decode(substr(work_ym, 5,6) ,'09', sum(plan_amt), '') plan_amt09, 
					  		  decode(substr(work_ym, 5,6) ,'10', sum(plan_amt), '') plan_amt10,
							  decode(substr(work_ym, 5,6) ,'11', sum(plan_amt), '') plan_amt11,
							  decode(substr(work_ym, 5,6) ,'12', sum(plan_amt), '') plan_amt12
					  from t_fl_month_plan_exec
					  where comp_code = AR_COMP_CODE
					  and	clse_acc_id = AR_CLSE_ACC_ID
					  and	dept_code	= AR_DEPT_CODE
					  group by comp_code, clse_acc_id, dept_code, flow_code,
					  		   substr(work_ym, 5,6))
				   group by comp_code, clse_acc_id, dept_code, flow_code) b2,
				 (select comp_code, clse_acc_id, dept_code, flow_code, sum(plan_amt) c_y_plan_amt
				  from t_fl_month_plan_exec
				  where comp_code = AR_COMP_CODE
				  and	clse_acc_id = AR_CLSE_ACC_ID
				  and	dept_code	= AR_DEPT_CODE
				  group by comp_code, clse_acc_id, dept_code, flow_code) b3
		  where   b3.comp_code = b1.comp_code(+)
		  and	  b3.comp_code = b2.comp_code(+)
		  and	  b3.clse_acc_id = b1.clse_acc_id(+)
		  and	  b3.clse_acc_id = b2.clse_acc_id(+)
		  and	  b3.dept_code = b1.dept_code(+)
		  and	  b3.dept_code = b2.dept_code(+)  
		  and	  b3.flow_code = b1.flow_code(+)
		  and	  b3.flow_code = b2.flow_code(+)
		  ) b
	where a.flow_code = b.flow_code(+)
	group by grouping sets ((a.p_no,
			 		  	     a.flow_code),
							(a.p_no))
	)	a,
	t_fl_flow_code b
where a.flow_code = b.flow_code					
start with a.p_no= 0
connect by prior a.flow_code = a.p_no
order siblings by level_seq;
	
	


End;
/
