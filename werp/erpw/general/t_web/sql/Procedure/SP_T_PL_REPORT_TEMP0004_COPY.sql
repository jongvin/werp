CREATE OR REPLACE Procedure SP_T_PL_REPORT_TEMP0004_COPY
(
	AR_EMP_NO                                  VARCHAR2,
	AR_COMP_CODE                               VARCHAR2,
	AR_CLSE_ACC_ID                             VARCHAR2
)
Is
	lsClose					Varchar2(2);
	lnAmt					Number;
Begin

--RAISE_APPLICATION_ERROR(-20000, AR_EMP_NO || AR_DEPT_CODE || AR_YEAR || AR_MONTH);
delete 
from T_PL_REPORT_TEMP0004
where emp_no = AR_EMP_NO;

insert into T_PL_REPORT_TEMP0004
(
	       emp_no,
	   	   dept_name,
		   biz_plan_item_name, 
		   b_y_exec_amt,
		   b_y_exec_amt19,
		   c_y_exec_amt19,
		   c_plan_rate19,
		   plan_amt10,
		   forecast_amt10,
		   plan_amt11,
		   forecast_amt11,
		   plan_amt12,
		   forecast_amt12,
		   c_y_plan_amt,
		   c_y_forecast_amt,
		   c_plan_rate,
		   b_rate,
		   n_y_forecast_amt,
		   n_rate
)	

--select (3/500)*100 from dual
select 	   --div,
		   --dept_code,
		   AR_EMP_NO,
		   dept_name,
		   --biz_plan_item_no,
		   biz_plan_item_name, 
		   b_y_exec_amt,
		   b_y_exec_amt19,
		   c_y_exec_amt19,
		   c_plan_rate19,
		   plan_amt10,
		   forecast_amt10,
		   plan_amt11,
		   forecast_amt11,
		   plan_amt12,
		   forecast_amt12,
		   c_y_plan_amt,
		   c_y_forecast_amt,
		   c_plan_rate,
		   b_rate,
		   n_y_forecast_amt,
		   n_rate
from
	(
	select '11' div,
		   b.dept_code,
		   dept_name,
		   b.biz_plan_item_no,
		   biz_plan_item_name, 
		   b_y_exec_amt,
		   b_y_exec_amt19,
		   c_y_exec_amt19,
		   c_plan_rate19,
		   plan_amt10,
		   forecast_amt10,
		   plan_amt11,
		   forecast_amt11,
		   plan_amt12,
		   forecast_amt12,
		   c_y_plan_amt,
		   c_y_forecast_amt,
		   c_plan_rate,
		   b_rate,
		   n_y_forecast_amt,
		   n_rate
	from (select *
		  from t_pl_item
		  
		  where mng_code in('매출액','매출이익')) a,
		 (select 
		 		 b5.dept_code,
				 b5.biz_plan_item_no,
				 decode(nvl(b_y_exec_amt,0), 0, 0, round(b_y_exec_amt/1000000,2))  b_y_exec_amt,
				 decode(nvl(b_y_exec_amt19,0),0, 0, round(b_y_exec_amt19/1000000,2)) b_y_exec_amt19,
				 decode(nvl(c_y_plan_amt19,0),0, 0, round(c_y_plan_amt19/1000000,2)) c_y_plan_amt19, 
		 		 decode(nvl(c_y_exec_amt19,0),0, 0, round(c_y_exec_amt19/1000000,2)) c_y_exec_amt19,
				 decode(nvl(c_y_plan_amt19,0),0, 0, round((nvl(c_y_exec_amt19,0)/nvl(c_y_plan_amt19,0))*100,2)) c_plan_rate19,
				 decode(nvl(b_y_exec_amt19,0), 0, 0, round((nvl(c_y_exec_amt19,0)/nvl(b_y_exec_amt19,0))*100,2)) b_rate19,
				 decode(nvl(plan_amt10,0), 0, 0, round(plan_amt10/1000000,2)) plan_amt10, 
				 decode(nvl(forecast_amt10,0), 0, 0, round(forecast_amt10/1000000,2)) forecast_amt10,
				 decode(nvl(plan_amt11,0), 0, 0, round(plan_amt11/1000000,2)) plan_amt11, 
				 decode(nvl(forecast_amt11,0), 0, 0, round(forecast_amt11/1000000,2)) forecast_amt11,
				 decode(nvl(plan_amt12,0), 0, 0, round(plan_amt12/1000000,2)) plan_amt12,
				 decode(nvl(forecast_amt12,0), 0, 0, round(forecast_amt12/1000000,2)) forecast_amt12,
				 decode(nvl(c_y_plan_amt,0), 0, 0, round(c_y_plan_amt/1000000,2)) c_y_plan_amt,
				 decode(nvl(c_y_forecast_amt,0), 0, 0, round(c_y_forecast_amt/1000000,2)) c_y_forecast_amt,
				 decode(nvl(c_y_plan_amt,0),0, 0, round((nvl(c_y_forecast_amt,0)/nvl(c_y_plan_amt,0))*100,2)) c_plan_rate,
				 decode(nvl(b_y_exec_amt,0), 0, 0, round((nvl(c_y_forecast_amt,0)/nvl(b_y_exec_amt,0))*100,2)) b_rate,
				 decode(nvl(n_y_forecast_amt,0),0, 0,  round(n_y_forecast_amt,2)) n_y_forecast_amt,
				 decode(nvl(n_y_forecast_amt,0), 0, 0, round(((nvl(c_y_exec_amt19,0) + nvl(forecast_amt10,0) + nvl(forecast_amt11,0) + nvl(forecast_amt12,0))/nvl(n_y_forecast_amt,0))*100,2)) n_rate
		  from 
				 (select comp_code, clse_acc_id + 1 clse_acc_id, 
				 		 dept_code, biz_plan_item_no,  b_y_exec_amt
				  from 
					 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, 
					 		 sum(exec_amt) b_y_exec_amt
					  from t_pl_comp_dept_plan_exec
					  where comp_code = AR_COMP_CODE
					  and	clse_acc_id = AR_CLSE_ACC_ID - 1
					  group by comp_code, clse_acc_id, dept_code,biz_plan_item_no)
				  ) b1,
				 (select comp_code, clse_acc_id + 1 clse_acc_id, dept_code, biz_plan_item_no,
				 		  b_y_exec_amt19
				  from 
					  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,
					 		  sum(exec_amt) b_y_exec_amt19
					   from   t_pl_comp_dept_plan_exec
					   where  comp_code   = AR_COMP_CODE
					   and	  clse_acc_id = AR_CLSE_ACC_ID - 1
					   and    substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09')
					   group by comp_code, clse_acc_id, dept_code, biz_plan_item_no)
				 ) b2,
				 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,
				 		 sum(plan_amt) c_y_plan_amt19, 
				 		 sum(exec_amt) c_y_exec_amt19
				  from  t_pl_comp_dept_plan_exec
				  where comp_code = AR_COMP_CODE
				  and	clse_acc_id = AR_CLSE_ACC_ID
				  and   substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09')
				  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no
				  ) b3,
				  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, 
				  		 sum(plan_amt10) plan_amt10,
						 sum(forecast_amt10) forecast_amt10,
						 sum(plan_amt11) plan_amt11,
						 sum(forecast_amt11) forecast_amt11,
						 sum(plan_amt12) plan_amt12, 
						 sum(forecast_amt12) forecast_amt12
				  from(
					  select comp_code, clse_acc_id, dept_code, biz_plan_item_no,
					  		 decode(substr(work_ym, 5,6) ,'10', sum(plan_amt), '') 	   plan_amt10, 
					  		 decode(substr(work_ym, 5,6) ,'10', sum(forecast_amt), '') forecast_amt10,
							 decode(substr(work_ym, 5,6) ,'11', sum(plan_amt), '') 	   plan_amt11,
							 decode(substr(work_ym, 5,6) ,'11', sum(forecast_amt), '') forecast_amt11,
							 decode(substr(work_ym, 5,6) ,'12', sum(plan_amt), '') 	   plan_amt12,
							 decode(substr(work_ym, 5,6) ,'12', sum(forecast_amt), '') forecast_amt12
					  from   t_pl_comp_dept_plan_exec
					  where  comp_code = AR_COMP_CODE
					  and	 clse_acc_id = AR_CLSE_ACC_ID
					  and    substr(work_ym, 5,6) in ('10', '11', '12')
					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no,
					  		   substr(work_ym, 5,6))
				  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no
				  ) b4,
				 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, 
				 		 sum(plan_amt) c_y_plan_amt,
						 sum(forecast_amt) c_y_forecast_amt
				  from t_pl_comp_dept_plan_exec
				  where comp_code = AR_COMP_CODE
				  and	clse_acc_id = AR_CLSE_ACC_ID
				  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no
				  ) b5,
				  (select comp_code, clse_acc_id - 1 clse_acc_id, dept_code, biz_plan_item_no, n_y_forecast_amt
				   from
					  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, 
					          sum(plan_amt) n_y_forecast_amt
					   from   t_pl_comp_dept_plan_exec
					   where  comp_code = AR_COMP_CODE
					   and	  clse_acc_id = AR_CLSE_ACC_ID + 1
					   group by comp_code, clse_acc_id, dept_code, biz_plan_item_no)
				  ) b6
		  where   b5.comp_code = b1.comp_code(+)
		  and	  b5.comp_code = b2.comp_code(+)
		  and	  b5.comp_code = b3.comp_code(+)
		  and	  b5.comp_code = b4.comp_code(+)
		  and	  b5.comp_code = b6.comp_code(+)
		  and	  b5.clse_acc_id = b1.clse_acc_id(+)
		  and	  b5.clse_acc_id = b2.clse_acc_id(+) 
		  and	  b5.clse_acc_id = b3.clse_acc_id(+) 
		  and	  b5.clse_acc_id = b4.clse_acc_id(+)
		  and	  b5.clse_acc_id = b6.clse_acc_id(+)
		  and	  b5.dept_code = b1.dept_code(+)
		  and	  b5.dept_code = b2.dept_code(+) 
		  and	  b5.dept_code = b3.dept_code(+) 
		  and	  b5.dept_code = b4.dept_code(+)
		  and	  b5.dept_code = b6.dept_code(+)
		  and	  b5.biz_plan_item_no = b1.biz_plan_item_no(+)
		  and	  b5.biz_plan_item_no = b2.biz_plan_item_no(+)
		  and	  b5.biz_plan_item_no = b3.biz_plan_item_no(+)
		  and	  b5.biz_plan_item_no = b4.biz_plan_item_no(+)
		  and	  b5.biz_plan_item_no = b6.biz_plan_item_no(+)
		  ) b,
		  t_dept_code c	  
	where a.biz_plan_item_no = b.biz_plan_item_no(+)
	and	  b.dept_code = c.dept_code(+)
	
	union all
	
	select b1.div,
		   b1.dept_code,
		   b1.dept_name,
		   b1.biz_plan_item_no,
		   '(%)' biz_plan_item_name, 
		   decode(a1.b_y_exec_amt, 0, 0, round((b1.b_y_exec_amt/a1.b_y_exec_amt)*100, 2)) b_y_exec_amt,
		   decode(a1.b_y_exec_amt19, 0, 0, round((b1.b_y_exec_amt19/a1.b_y_exec_amt19)*100, 2)) b_y_exec_amt19,
		   decode(a1.c_y_exec_amt19, 0, 0, round((b1.c_y_exec_amt19/a1.c_y_exec_amt19)*100, 2)) c_y_exec_amt19,
		   0 c_plan_rate19,
		   decode(a1.plan_amt10, 0, 0, round((b1.plan_amt10/a1.plan_amt10)*100, 2)) plan_amt10,
		   decode(a1.forecast_amt10, 0, 0, round((b1.forecast_amt10/a1.forecast_amt10)*100, 2)) forecast_amt10,
		   decode(a1.plan_amt11, 0, 0, round((b1.plan_amt11/a1.plan_amt11)*100, 2)) plan_amt11,
		   decode(a1.forecast_amt11, 0, 0, round((b1.forecast_amt11/a1.forecast_amt11)*100, 2)) forecast_amt11,
		   decode(a1.plan_amt12, 0, 0, round((b1.plan_amt12/a1.plan_amt12)*100, 2)) plan_amt12,
		   decode(a1.forecast_amt12, 0, 0, round((b1.forecast_amt12/a1.forecast_amt12)*100, 2)) forecast_amt12,
		   decode(a1.c_y_plan_amt, 0, 0, round((b1.c_y_plan_amt/a1.c_y_plan_amt)*100, 2)) c_y_plan_amt,
		   decode(a1.c_y_forecast_amt, 0, 0, round((b1.c_y_forecast_amt/a1.c_y_forecast_amt)*100, 2)) c_y_forecast_amt,
		   0 c_plan_rate,
		   0 b_rate,
		   decode(a1.n_y_forecast_amt, 0, 0, round((b1.n_y_forecast_amt/a1.n_y_forecast_amt)*100, 2)) n_y_forecast_amt,
		   0 n_rate	   
	from
		(	   
		select '12' div,
			   b.dept_code,
			   dept_name,
			   b.biz_plan_item_no,
			   biz_plan_item_name, 
			   b_y_exec_amt,
			   b_y_exec_amt19,
			   c_y_exec_amt19,
			   c_plan_rate19,
			   plan_amt10,
			   forecast_amt10,
			   plan_amt11,
			   forecast_amt11,
			   plan_amt12,
			   forecast_amt12,
			   c_y_plan_amt,
			   c_y_forecast_amt,
			   c_plan_rate,
			   b_rate,
			   n_y_forecast_amt,
			   n_rate
		from (select *
			  from t_pl_item
			  where mng_code ='매출액') a,
			 (select 
			 		 b5.dept_code,
					 b5.biz_plan_item_no,
					 decode(nvl(b_y_exec_amt,0), 0, 0, round(b_y_exec_amt/1000000,2))  b_y_exec_amt,
					 decode(nvl(b_y_exec_amt19,0),0, 0, round(b_y_exec_amt19/1000000,2)) b_y_exec_amt19,
					 decode(nvl(c_y_plan_amt19,0),0, 0, round(c_y_plan_amt19/1000000,2)) c_y_plan_amt19, 
			 		 decode(nvl(c_y_exec_amt19,0),0, 0, round(c_y_exec_amt19/1000000,2)) c_y_exec_amt19,
					 decode(nvl(c_y_plan_amt19,0),0, 0, round((nvl(c_y_exec_amt19,0)/nvl(c_y_plan_amt19,0))*100,2)) c_plan_rate19,
					 decode(nvl(b_y_exec_amt19,0), 0, 0, round((nvl(c_y_exec_amt19,0)/nvl(b_y_exec_amt19,0))*100,2)) b_rate19,
					 decode(nvl(plan_amt10,0), 0, 0, round(plan_amt10/1000000,2)) plan_amt10, 
					 decode(nvl(forecast_amt10,0), 0, 0, round(forecast_amt10/1000000,2)) forecast_amt10,
					 decode(nvl(plan_amt11,0), 0, 0, round(plan_amt11/1000000,2)) plan_amt11, 
					 decode(nvl(forecast_amt11,0), 0, 0, round(forecast_amt11/1000000,2)) forecast_amt11,
					 decode(nvl(plan_amt12,0), 0, 0, round(plan_amt12/1000000,2)) plan_amt12,
					 decode(nvl(forecast_amt12,0), 0, 0, round(forecast_amt12/1000000,2)) forecast_amt12,
					 decode(nvl(c_y_plan_amt,0), 0, 0, round(c_y_plan_amt/1000000,2)) c_y_plan_amt,
					 decode(nvl(c_y_forecast_amt,0), 0, 0, round(c_y_forecast_amt/1000000,2)) c_y_forecast_amt,
					 decode(nvl(c_y_plan_amt,0),0, 0, round((nvl(c_y_forecast_amt,0)/nvl(c_y_plan_amt,0))*100,2)) c_plan_rate,
					 decode(nvl(b_y_exec_amt,0), 0, 0, round((nvl(c_y_forecast_amt,0)/nvl(b_y_exec_amt,0))*100,2)) b_rate,
					 decode(nvl(n_y_forecast_amt,0),0, 0,  round(n_y_forecast_amt,2)) n_y_forecast_amt,
					 decode(nvl(n_y_forecast_amt,0), 0, 0, round(((nvl(c_y_exec_amt19,0) + nvl(forecast_amt10,0) + nvl(forecast_amt11,0) + nvl(forecast_amt12,0))/nvl(n_y_forecast_amt,0))*100,2)) n_rate
			  from 
					 (select comp_code, clse_acc_id + 1 clse_acc_id, 
					 		 dept_code, biz_plan_item_no,  b_y_exec_amt
					  from 
						 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, 
						 		 sum(exec_amt) b_y_exec_amt
						  from t_pl_comp_dept_plan_exec
						  where comp_code = AR_COMP_CODE
						  and	clse_acc_id = AR_CLSE_ACC_ID - 1
						  group by comp_code, clse_acc_id, dept_code,biz_plan_item_no)
					  ) b1,
					 (select comp_code, clse_acc_id + 1 clse_acc_id, dept_code, biz_plan_item_no,
					 		  b_y_exec_amt19
					  from 
						  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,
						 		  sum(exec_amt) b_y_exec_amt19
						   from   t_pl_comp_dept_plan_exec
						   where  comp_code   = AR_COMP_CODE
						   and	  clse_acc_id = AR_CLSE_ACC_ID - 1
						   and    substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09')
						   group by comp_code, clse_acc_id, dept_code, biz_plan_item_no)
					 ) b2,
					 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,
					 		 sum(plan_amt) c_y_plan_amt19, 
					 		 sum(exec_amt) c_y_exec_amt19
					  from  t_pl_comp_dept_plan_exec
					  where comp_code = AR_COMP_CODE
					  and	clse_acc_id = AR_CLSE_ACC_ID
					  and   substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09')
					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no
					  ) b3,
					  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, 
					  		 sum(plan_amt10) plan_amt10,
							 sum(forecast_amt10) forecast_amt10,
							 sum(plan_amt11) plan_amt11,
							 sum(forecast_amt11) forecast_amt11,
							 sum(plan_amt12) plan_amt12, 
							 sum(forecast_amt12) forecast_amt12
					  from(
						  select comp_code, clse_acc_id, dept_code, biz_plan_item_no,
						  		 decode(substr(work_ym, 5,6) ,'10', sum(plan_amt), '') 	   plan_amt10, 
						  		 decode(substr(work_ym, 5,6) ,'10', sum(forecast_amt), '') forecast_amt10,
								 decode(substr(work_ym, 5,6) ,'11', sum(plan_amt), '') 	   plan_amt11,
								 decode(substr(work_ym, 5,6) ,'11', sum(forecast_amt), '') forecast_amt11,
								 decode(substr(work_ym, 5,6) ,'12', sum(plan_amt), '') 	   plan_amt12,
								 decode(substr(work_ym, 5,6) ,'12', sum(forecast_amt), '') forecast_amt12
						  from   t_pl_comp_dept_plan_exec
						  where  comp_code = AR_COMP_CODE
						  and	 clse_acc_id = AR_CLSE_ACC_ID
						  and    substr(work_ym, 5,6) in ('10', '11', '12')
						  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no,
						  		   substr(work_ym, 5,6))
					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no
					  ) b4,
					 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, 
					 		 sum(plan_amt) c_y_plan_amt,
							 sum(forecast_amt) c_y_forecast_amt
					  from t_pl_comp_dept_plan_exec
					  where comp_code = AR_COMP_CODE
					  and	clse_acc_id = AR_CLSE_ACC_ID
					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no
					  ) b5,
					  (select comp_code, clse_acc_id - 1 clse_acc_id, dept_code, biz_plan_item_no, n_y_forecast_amt
					   from
						  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, 
						          sum(plan_amt) n_y_forecast_amt
						   from   t_pl_comp_dept_plan_exec
						   where  comp_code = AR_COMP_CODE
						   and	  clse_acc_id = AR_CLSE_ACC_ID + 1
						   group by comp_code, clse_acc_id, dept_code, biz_plan_item_no)
					  ) b6
			  where   b5.comp_code = b1.comp_code(+)
			  and	  b5.comp_code = b2.comp_code(+)
			  and	  b5.comp_code = b3.comp_code(+)
			  and	  b5.comp_code = b4.comp_code(+)
			  and	  b5.comp_code = b6.comp_code(+)
			  and	  b5.clse_acc_id = b1.clse_acc_id(+)
			  and	  b5.clse_acc_id = b2.clse_acc_id(+) 
			  and	  b5.clse_acc_id = b3.clse_acc_id(+) 
			  and	  b5.clse_acc_id = b4.clse_acc_id(+)
			  and	  b5.clse_acc_id = b6.clse_acc_id(+)
			  and	  b5.dept_code = b1.dept_code(+)
			  and	  b5.dept_code = b2.dept_code(+) 
			  and	  b5.dept_code = b3.dept_code(+) 
			  and	  b5.dept_code = b4.dept_code(+)
			  and	  b5.dept_code = b6.dept_code(+)
			  and	  b5.biz_plan_item_no = b1.biz_plan_item_no(+)
			  and	  b5.biz_plan_item_no = b2.biz_plan_item_no(+)
			  and	  b5.biz_plan_item_no = b3.biz_plan_item_no(+)
			  and	  b5.biz_plan_item_no = b4.biz_plan_item_no(+)
			  and	  b5.biz_plan_item_no = b6.biz_plan_item_no(+)
			  ) b,
			  t_dept_code c	  
		where a.biz_plan_item_no = b.biz_plan_item_no(+)
		and	  b.dept_code = c.dept_code(+)
		) a1,
		(
		select '12' div,
			   b.dept_code,
			   dept_name,
			   b.biz_plan_item_no,
			   biz_plan_item_name, 
			   b_y_exec_amt,
			   b_y_exec_amt19,
			   c_y_exec_amt19,
			   c_plan_rate19,
			   plan_amt10,
			   forecast_amt10,
			   plan_amt11,
			   forecast_amt11,
			   plan_amt12,
			   forecast_amt12,
			   c_y_plan_amt,
			   c_y_forecast_amt,
			   c_plan_rate,
			   b_rate,
			   n_y_forecast_amt,
			   n_rate
		from (select *
			  from t_pl_item
			  where mng_code = '매출이익') a,
			 (select 
			 		 b5.dept_code,
					 b5.biz_plan_item_no,
					 decode(nvl(b_y_exec_amt,0), 0, 0, round(b_y_exec_amt/1000000,2))  b_y_exec_amt,
					 decode(nvl(b_y_exec_amt19,0),0, 0, round(b_y_exec_amt19/1000000,2)) b_y_exec_amt19,
					 decode(nvl(c_y_plan_amt19,0),0, 0, round(c_y_plan_amt19/1000000,2)) c_y_plan_amt19, 
			 		 decode(nvl(c_y_exec_amt19,0),0, 0, round(c_y_exec_amt19/1000000,2)) c_y_exec_amt19,
					 decode(nvl(c_y_plan_amt19,0),0, 0, round((nvl(c_y_exec_amt19,0)/nvl(c_y_plan_amt19,0))*100,2)) c_plan_rate19,
					 decode(nvl(b_y_exec_amt19,0), 0, 0, round((nvl(c_y_exec_amt19,0)/nvl(b_y_exec_amt19,0))*100,2)) b_rate19,
					 decode(nvl(plan_amt10,0), 0, 0, round(plan_amt10/1000000,2)) plan_amt10, 
					 decode(nvl(forecast_amt10,0), 0, 0, round(forecast_amt10/1000000,2)) forecast_amt10,
					 decode(nvl(plan_amt11,0), 0, 0, round(plan_amt11/1000000,2)) plan_amt11, 
					 decode(nvl(forecast_amt11,0), 0, 0, round(forecast_amt11/1000000,2)) forecast_amt11,
					 decode(nvl(plan_amt12,0), 0, 0, round(plan_amt12/1000000,2)) plan_amt12,
					 decode(nvl(forecast_amt12,0), 0, 0, round(forecast_amt12/1000000,2)) forecast_amt12,
					 decode(nvl(c_y_plan_amt,0), 0, 0, round(c_y_plan_amt/1000000,2)) c_y_plan_amt,
					 decode(nvl(c_y_forecast_amt,0), 0, 0, round(c_y_forecast_amt/1000000,2)) c_y_forecast_amt,
					 decode(nvl(c_y_plan_amt,0),0, 0, round((nvl(c_y_forecast_amt,0)/nvl(c_y_plan_amt,0))*100,2)) c_plan_rate,
					 decode(nvl(b_y_exec_amt,0), 0, 0, round((nvl(c_y_forecast_amt,0)/nvl(b_y_exec_amt,0))*100,2)) b_rate,
					 decode(nvl(n_y_forecast_amt,0),0, 0,  round(n_y_forecast_amt,2)) n_y_forecast_amt,
					 decode(nvl(n_y_forecast_amt,0), 0, 0, round(((nvl(c_y_exec_amt19,0) + nvl(forecast_amt10,0) + nvl(forecast_amt11,0) + nvl(forecast_amt12,0))/nvl(n_y_forecast_amt,0))*100,2)) n_rate
			  from 
					 (select comp_code, clse_acc_id + 1 clse_acc_id, 
					 		 dept_code, biz_plan_item_no,  b_y_exec_amt
					  from 
						 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, 
						 		 sum(exec_amt) b_y_exec_amt
						  from t_pl_comp_dept_plan_exec
						  where comp_code = AR_COMP_CODE
						  and	clse_acc_id = AR_CLSE_ACC_ID - 1
						  group by comp_code, clse_acc_id, dept_code,biz_plan_item_no)
					  ) b1,
					 (select comp_code, clse_acc_id + 1 clse_acc_id, dept_code, biz_plan_item_no,
					 		  b_y_exec_amt19
					  from 
						  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,
						 		  sum(exec_amt) b_y_exec_amt19
						   from   t_pl_comp_dept_plan_exec
						   where  comp_code   = AR_COMP_CODE
						   and	  clse_acc_id = AR_CLSE_ACC_ID - 1
						   and    substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09')
						   group by comp_code, clse_acc_id, dept_code, biz_plan_item_no)
					 ) b2,
					 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,
					 		 sum(plan_amt) c_y_plan_amt19, 
					 		 sum(exec_amt) c_y_exec_amt19
					  from  t_pl_comp_dept_plan_exec
					  where comp_code = AR_COMP_CODE
					  and	clse_acc_id = AR_CLSE_ACC_ID
					  and   substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09')
					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no
					  ) b3,
					  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, 
					  		 sum(plan_amt10) plan_amt10,
							 sum(forecast_amt10) forecast_amt10,
							 sum(plan_amt11) plan_amt11,
							 sum(forecast_amt11) forecast_amt11,
							 sum(plan_amt12) plan_amt12, 
							 sum(forecast_amt12) forecast_amt12
					  from(
						  select comp_code, clse_acc_id, dept_code, biz_plan_item_no,
						  		 decode(substr(work_ym, 5,6) ,'10', sum(plan_amt), '') 	   plan_amt10, 
						  		 decode(substr(work_ym, 5,6) ,'10', sum(forecast_amt), '') forecast_amt10,
								 decode(substr(work_ym, 5,6) ,'11', sum(plan_amt), '') 	   plan_amt11,
								 decode(substr(work_ym, 5,6) ,'11', sum(forecast_amt), '') forecast_amt11,
								 decode(substr(work_ym, 5,6) ,'12', sum(plan_amt), '') 	   plan_amt12,
								 decode(substr(work_ym, 5,6) ,'12', sum(forecast_amt), '') forecast_amt12
						  from   t_pl_comp_dept_plan_exec
						  where  comp_code = AR_COMP_CODE
						  and	 clse_acc_id = AR_CLSE_ACC_ID
						  and    substr(work_ym, 5,6) in ('10', '11', '12')
						  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no,
						  		   substr(work_ym, 5,6))
					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no
					  ) b4,
					 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, 
					 		 sum(plan_amt) c_y_plan_amt,
							 sum(forecast_amt) c_y_forecast_amt
					  from t_pl_comp_dept_plan_exec
					  where comp_code = AR_COMP_CODE
					  and	clse_acc_id = AR_CLSE_ACC_ID
					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no
					  ) b5,
					  (select comp_code, clse_acc_id - 1 clse_acc_id, dept_code, biz_plan_item_no, n_y_forecast_amt
					   from
						  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, 
						          sum(plan_amt) n_y_forecast_amt
						   from   t_pl_comp_dept_plan_exec
						   where  comp_code = AR_COMP_CODE
						   and	  clse_acc_id = AR_CLSE_ACC_ID + 1
						   group by comp_code, clse_acc_id, dept_code, biz_plan_item_no)
					  ) b6
			  where   b5.comp_code = b1.comp_code(+)
			  and	  b5.comp_code = b2.comp_code(+)
			  and	  b5.comp_code = b3.comp_code(+)
			  and	  b5.comp_code = b4.comp_code(+)
			  and	  b5.comp_code = b6.comp_code(+)
			  and	  b5.clse_acc_id = b1.clse_acc_id(+)
			  and	  b5.clse_acc_id = b2.clse_acc_id(+) 
			  and	  b5.clse_acc_id = b3.clse_acc_id(+) 
			  and	  b5.clse_acc_id = b4.clse_acc_id(+)
			  and	  b5.clse_acc_id = b6.clse_acc_id(+)
			  and	  b5.dept_code = b1.dept_code(+)
			  and	  b5.dept_code = b2.dept_code(+) 
			  and	  b5.dept_code = b3.dept_code(+) 
			  and	  b5.dept_code = b4.dept_code(+)
			  and	  b5.dept_code = b6.dept_code(+)
			  and	  b5.biz_plan_item_no = b1.biz_plan_item_no(+)
			  and	  b5.biz_plan_item_no = b2.biz_plan_item_no(+)
			  and	  b5.biz_plan_item_no = b3.biz_plan_item_no(+)
			  and	  b5.biz_plan_item_no = b4.biz_plan_item_no(+)
			  and	  b5.biz_plan_item_no = b6.biz_plan_item_no(+)
			  ) b,
			  t_dept_code c	  
		where a.biz_plan_item_no = b.biz_plan_item_no(+)
		and	  b.dept_code = c.dept_code(+)
		) b1
	where a1.div	   = b1.div(+)
	and   a1.dept_code = b1.dept_code(+) 
	order by 2, 1, 5
	);


	
End;
/
