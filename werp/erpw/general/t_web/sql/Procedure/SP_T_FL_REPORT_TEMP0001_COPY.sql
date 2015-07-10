CREATE OR REPLACE Procedure SP_T_FL_REPORT_TEMP0001_COPY
(
	AR_EMP_NO                                  VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                               VARCHAR2
)
Is
	lsClose					Varchar2(2);
	lnAmt					Number;
Begin

--RAISE_APPLICATION_ERROR(-20000, AR_EMP_NO || AR_DEPT_CODE || AR_YEAR || AR_MONTH);
delete 
from T_FL_REPORT_TEMP0001
where emp_no = AR_EMP_NO;

insert into T_FL_REPORT_TEMP0001
(
	   emp_no,
	   flow_item_name,
	   b_y_exec_amt,
	   c_y_exec_amt19,
	   forecast_amt10,
	   forecast_amt11,
	   forecast_amt12,
	   c_y_plan_amt,
	   c_y_forecast_amt,
	   c_plan_rate,
	   b_rate,
	   n_y_forecast_amt,
	   n_rate
)	

select AR_EMP_NO,
	   lpad(' ', (level-1) *2 ) || flow_item_name flow_item_name, 
	   --b.flow_code_b,
	   b_y_exec_amt,
	   c_y_exec_amt19,
	   forecast_amt10,
	   forecast_amt11,
	   forecast_amt12,
	   c_y_plan_amt,
	   c_y_forecast_amt,
	   c_plan_rate,
	   b_rate,
	   n_y_forecast_amt,
	   n_rate 
from t_fl_flow_code_b a,
	 (select 
	 		 b2.flow_code_b,
			 decode(nvl(b_y_exec_amt,0), 0, 0, round(b_y_exec_amt/1000000,2))  b_y_exec_amt, 
	 		 decode(nvl(c_y_exec_amt19,0),0, 0, round(c_y_exec_amt19/1000000,2)) c_y_exec_amt19, 
			 decode(nvl(forecast_amt10,0), 0, 0, round(forecast_amt10/1000000,2)) forecast_amt10, 
			 decode(nvl(forecast_amt11,0), 0, 0, round(forecast_amt11/1000000,2)) forecast_amt11,
			 decode(nvl(forecast_amt12,0), 0, 0, round(forecast_amt12/1000000,2)) forecast_amt12,
			 decode(nvl(c_y_plan_amt,0), 0, 0, round(c_y_plan_amt/1000000,2)) c_y_plan_amt,
			 decode(nvl(c_y_forecast_amt,0), 0, 0, round(c_y_forecast_amt/1000000,2)) c_y_forecast_amt,
			 decode(nvl(c_y_plan_amt,0),0, 0, round((nvl(c_y_forecast_amt,0)/nvl(c_y_plan_amt,0))*100,2)) c_plan_rate,
			 decode(nvl(b_y_exec_amt,0), 0, 0, round((nvl(c_y_forecast_amt,0)/nvl(b_y_exec_amt,0))*100,2)) b_rate,
			 decode(nvl(n_y_forecast_amt,0),0, 0,  round(n_y_forecast_amt,2)) n_y_forecast_amt,
			 decode(nvl(n_y_forecast_amt,0), 0, 0, round(((nvl(c_y_exec_amt19,0) + nvl(forecast_amt10,0) + nvl(forecast_amt11,0) + nvl(forecast_amt12,0))/nvl(n_y_forecast_amt,0))*100,2)) n_rate
	  from 
			 (select comp_code, clse_acc_id + 1 clse_acc_id, flow_code_b,  b_y_exec_amt
			  from 
				 (select comp_code, clse_acc_id, flow_code_b, sum(exec_amt) b_y_exec_amt
				  from t_fl_month_plan_exec_b
				  where comp_code = AR_COMP_CODE
				  and	clse_acc_id = AR_CLSE_ACC_ID - 1
				  group by comp_code, clse_acc_id, flow_code_b)
			  ) b1,
			 (select comp_code, clse_acc_id, flow_code_b, sum(exec_amt) c_y_exec_amt19
			  from t_fl_month_plan_exec_b
			  where comp_code = AR_COMP_CODE
			  and	clse_acc_id = AR_CLSE_ACC_ID
			  and substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09')
			  group by comp_code, clse_acc_id, flow_code_b) b2,
			  (select comp_code, clse_acc_id, flow_code_b, 
			  		 sum(forecast_amt10) forecast_amt10,
					 sum(forecast_amt11) forecast_amt11, 
					 sum(forecast_amt12) forecast_amt12
			  from(
				  select comp_code, clse_acc_id, flow_code_b, 
				  		  decode(substr(work_ym, 5,6) ,'10', sum(forecast_amt), '') forecast_amt10,
						  decode(substr(work_ym, 5,6) ,'11', sum(forecast_amt), '') forecast_amt11,
						  decode(substr(work_ym, 5,6) ,'12', sum(forecast_amt), '') forecast_amt12
				  from t_fl_month_plan_exec_b
				  where comp_code = AR_COMP_CODE
				  and	clse_acc_id = AR_CLSE_ACC_ID
				  and substr(work_ym, 5,6) in ('10', '11', '12')
				  group by comp_code, clse_acc_id, flow_code_b,
				  		   substr(work_ym, 5,6))
			  group by comp_code, clse_acc_id, flow_code_b
			  ) b3,
			 (select comp_code, clse_acc_id, flow_code_b, sum(plan_amt) c_y_plan_amt
			  from t_fl_month_plan_exec_b
			  where comp_code = AR_COMP_CODE
			  and	clse_acc_id = AR_CLSE_ACC_ID
			  group by comp_code, clse_acc_id, flow_code_b) b4,
			  (select comp_code, clse_acc_id, flow_code_b, sum(forecast_amt) c_y_forecast_amt
			  from t_fl_month_plan_exec_b
			  where comp_code = AR_COMP_CODE
			  and	clse_acc_id = AR_CLSE_ACC_ID
			  group by comp_code, clse_acc_id, flow_code_b) b5,
			  (select comp_code, clse_acc_id - 1 clse_acc_id, flow_code_b, n_y_forecast_amt
			   from
				  (select comp_code, clse_acc_id, flow_code_b, sum(plan_amt) n_y_forecast_amt
				  from t_fl_month_plan_exec_b
				  where comp_code = AR_COMP_CODE
				  and	clse_acc_id = AR_CLSE_ACC_ID + 1
				  group by comp_code, clse_acc_id, flow_code_b)
			  ) b6
	  where   b2.comp_code = b1.comp_code(+)
	  and	  b2.comp_code = b3.comp_code(+)
	  and	  b2.comp_code = b4.comp_code(+)
	  and	  b2.comp_code = b5.comp_code(+)
	  and	  b2.comp_code = b6.comp_code(+)
	  and	  b2.clse_acc_id = b1.clse_acc_id(+)
	  and	  b2.clse_acc_id = b3.clse_acc_id(+) 
	  and	  b2.clse_acc_id = b4.clse_acc_id(+) 
	  and	  b2.clse_acc_id = b5.clse_acc_id(+)
	  and	  b2.clse_acc_id = b6.clse_acc_id(+)
	  and	  b2.flow_code_b = b1.flow_code_b(+)
	  and	  b2.flow_code_b = b3.flow_code_b(+)
	  and	  b2.flow_code_b = b4.flow_code_b(+)
	  and	  b2.flow_code_b = b5.flow_code_b(+)
	  and	  b2.flow_code_b = b6.flow_code_b(+)
	  ) b	  
where a.flow_code_b = b.flow_code_b(+)
start with p_no= 0
connect by prior a.flow_code_b = p_no
order siblings by flow_item_kind, level_seq;

End;
/
