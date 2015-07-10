CREATE OR REPLACE Procedure SP_T_FL_REPORT_TEMP0003_COPY
(
	AR_EMP_NO                                  VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2,
	AR_DEPT_CODE                               VARCHAR2,
	AR_MONTH								   VARCHAR2
)
Is
	lsClose					Varchar2(2);
	lnAmt					Number;
Begin

--RAISE_APPLICATION_ERROR(-20000, AR_EMP_NO || AR_DEPT_CODE || AR_YEAR || AR_MONTH);
delete 
from T_FL_REPORT_TEMP0003
where emp_no = AR_EMP_NO;

insert into T_FL_REPORT_TEMP0003
(
	   emp_no,
	   flow_item_name,
	   b_y_exec_amt,     
	   c_m_plan_amt,    
	   c_m_exec_amt,    
	   c_y_plan_amt,    
	   c_y_exec_amt,    
	   b_c_y_plan_amt, 
	   b_c_y_exec_amt
)	

select --a.p_no,
	   --a.flow_code,
	   AR_EMP_NO,
	   lpad(' ', (level-1) *2 ) || flow_item_name flow_item_name,
	   b_y_exec_amt,     
	   c_m_plan_amt,    
	   c_m_exec_amt,    
	   c_y_plan_amt,    
	   c_y_exec_amt,    
	   b_c_y_plan_amt, 
	   b_c_y_exec_amt   
from
	(
	select  a.p_no,
			a.flow_code,
		    sum(b_y_exec_amt) b_y_exec_amt,  
			sum(c_m_plan_amt) c_m_plan_amt,     
			sum(c_m_exec_amt) c_m_exec_amt,     
			sum(c_y_plan_amt) c_y_plan_amt,  
			sum(c_y_exec_amt) c_y_exec_amt,
			sum(b_c_y_plan_amt) b_c_y_plan_amt,  
			sum(b_c_y_exec_amt) b_c_y_exec_amt	     
	from t_fl_flow_code a,
		 (select 
		 		 b3.flow_code,
				 decode(nvl(b_y_exec_amt,0), 0, 0, round(b_y_exec_amt/1000000,2))  b_y_exec_amt,
				 decode(nvl(c_m_plan_amt,0), 0, 0, round(c_m_plan_amt/1000000,2)) c_m_plan_amt,  
				 decode(nvl(c_m_exec_amt,0), 0, 0, round(c_m_exec_amt/1000000,2)) c_m_exec_amt,
				 decode(nvl(c_y_plan_amt,0), 0, 0, round(c_y_plan_amt/1000000,2)) c_y_plan_amt,
				 decode(nvl(c_y_exec_amt,0), 0, 0, round(c_y_exec_amt/1000000,2)) c_y_exec_amt,
				 round(decode(nvl(b_y_exec_amt,0), 0, 0, round(b_y_exec_amt/1000000,2)) + decode(nvl(c_y_plan_amt,0), 0, 0, round(c_y_plan_amt/1000000,2)),2) b_c_y_plan_amt, 
				 round(decode(nvl(b_y_exec_amt,0), 0, 0, round(b_y_exec_amt/1000000,2)) + decode(nvl(c_y_exec_amt,0), 0, 0, round(c_y_exec_amt/1000000,2)), 2) b_c_y_exec_amt
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
				  		  sum(plan_amt) c_m_plan_amt,
						  sum(exec_amt) c_m_exec_amt
				  from t_fl_month_plan_exec
				  where comp_code = AR_COMP_CODE
				  and	clse_acc_id = AR_CLSE_ACC_ID
				  and	dept_code	= AR_DEPT_CODE
				  and   substr(work_ym, 1,6) = AR_CLSE_ACC_ID || AR_MONTH
				  group by comp_code, clse_acc_id, dept_code, flow_code) b2,
				 (select comp_code, clse_acc_id, flow_code, dept_code, sum(plan_amt) c_y_plan_amt, sum(exec_amt) c_y_exec_amt
				  from t_fl_month_plan_exec
				  where comp_code = AR_COMP_CODE
				  and	clse_acc_id = AR_CLSE_ACC_ID
				  and	dept_code	= AR_DEPT_CODE
				  and   substr(work_ym, 1,6) between AR_CLSE_ACC_ID || '01' and AR_CLSE_ACC_ID || AR_MONTH
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
