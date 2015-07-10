CREATE OR REPLACE Procedure SP_T_PL_REPORT_TEMP0005_COPY
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
from T_PL_REPORT_TEMP0005
where emp_no = AR_EMP_NO;

insert into T_PL_REPORT_TEMP0005
(
	        emp_no,
	   	    biz_plan_item_name,
			b_y_exec_amt,    
			b_y_exec_amt19,  
			c_y_plan_amt19,  
			c_y_exec_amt19,  
		    c_plan_rate19,      
		    b_rate19,        
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

select 		--div,
			--p_no,
			--biz_plan_item_no,
			AR_EMP_NO,
			biz_plan_item_name,
			b_y_exec_amt,    
			b_y_exec_amt19,  
			c_y_plan_amt19,  
			c_y_exec_amt19,  
		    c_plan_rate19,      
		    b_rate19,        
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
	select  '11' div,
			p_no,
			biz_plan_item_no,
			biz_plan_item_name,
			b_y_exec_amt,    
			b_y_exec_amt19,  
			c_y_plan_amt19,  
			c_y_exec_amt19,  
		    c_plan_rate19,      
		    b_rate19,        
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
		select  a.p_no,
			    a.biz_plan_item_no,
			    lpad(' ', (level-1) *2 ) || biz_plan_item_name biz_plan_item_name,
			    b_y_exec_amt,    
			    b_y_exec_amt19,  
			    c_y_plan_amt19,  
			    c_y_exec_amt19,  
				c_plan_rate19,      
				b_rate19,        
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
			select  a.p_no,
					a.biz_plan_item_no,
				    sum(b_y_exec_amt)  	 b_y_exec_amt,  
					sum(b_y_exec_amt19)  b_y_exec_amt19,     
					sum(c_y_plan_amt19)  c_y_plan_amt19,     
					sum(c_y_exec_amt19)  c_y_exec_amt19,     
					sum(c_plan_rate19)   c_plan_rate19,     
					sum(b_rate19)        b_rate19,     
					sum(plan_amt10)      plan_amt10,     
					sum(forecast_amt10)  forecast_amt10,     
					sum(plan_amt11)      plan_amt11,     
					sum(forecast_amt11)  forecast_amt11,     
					sum(plan_amt12)      plan_amt12,     
					sum(forecast_amt12)  forecast_amt12,     
					sum(c_y_plan_amt)    c_y_plan_amt,     
					sum(c_y_forecast_amt) c_y_forecast_amt,  
					sum(c_plan_rate)	  c_plan_rate,
					sum(b_rate)	          b_rate,
					sum(n_y_forecast_amt) n_y_forecast_amt,
					sum(n_rate)	 		  n_rate	     
			from t_pl_item a,
				 (select 
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
					 		  biz_plan_item_no,  b_y_exec_amt
						  from 
							 (select comp_code, clse_acc_id,  biz_plan_item_no, 
							 		 sum(exec_amt) b_y_exec_amt
							  from t_pl_comp_plan_exec
							  where comp_code = AR_COMP_CODE
							  and	clse_acc_id = AR_CLSE_ACC_ID - 1
							  group by comp_code, clse_acc_id, biz_plan_item_no)
						  ) b1,
						 (select comp_code, clse_acc_id + 1 clse_acc_id,  biz_plan_item_no,
						 		  b_y_exec_amt19
						  from 
							  (select comp_code, clse_acc_id,  biz_plan_item_no,
							 		  sum(exec_amt) b_y_exec_amt19
							   from   t_pl_comp_plan_exec
							   where  comp_code   = AR_COMP_CODE
							   and	  clse_acc_id = AR_CLSE_ACC_ID - 1
							   and    substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09')
							   group by comp_code, clse_acc_id,  biz_plan_item_no)
						 ) b2,
						 (select comp_code, clse_acc_id,  biz_plan_item_no,
						 		 sum(plan_amt) c_y_plan_amt19, 
						 		 sum(exec_amt) c_y_exec_amt19
						  from  t_pl_comp_plan_exec
						  where comp_code = AR_COMP_CODE
						  and	clse_acc_id = AR_CLSE_ACC_ID
						  and   substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09')
						  group by comp_code, clse_acc_id,  biz_plan_item_no
						 ) b3,
						  (select comp_code, clse_acc_id,  biz_plan_item_no, 
						  		 sum(plan_amt10) plan_amt10,
								 sum(forecast_amt10) forecast_amt10,
								 sum(plan_amt11) plan_amt11,
								 sum(forecast_amt11) forecast_amt11,
								 sum(plan_amt12) plan_amt12, 
								 sum(forecast_amt12) forecast_amt12
						  from(
							  select comp_code, clse_acc_id,  biz_plan_item_no,
							  		 decode(substr(work_ym, 5,6) ,'10', sum(plan_amt), '') 	   plan_amt10, 
							  		 decode(substr(work_ym, 5,6) ,'10', sum(forecast_amt), '') forecast_amt10,
									 decode(substr(work_ym, 5,6) ,'11', sum(plan_amt), '') 	   plan_amt11,
									 decode(substr(work_ym, 5,6) ,'11', sum(forecast_amt), '') forecast_amt11,
									 decode(substr(work_ym, 5,6) ,'12', sum(plan_amt), '') 	   plan_amt12,
									 decode(substr(work_ym, 5,6) ,'12', sum(forecast_amt), '') forecast_amt12
							  from   t_pl_comp_plan_exec
							  where  comp_code = AR_COMP_CODE
							  and	 clse_acc_id = AR_CLSE_ACC_ID
							  and    substr(work_ym, 5,6) in ('10', '11', '12')
							  group by comp_code, clse_acc_id,  biz_plan_item_no,
							  		   substr(work_ym, 5,6))
						  group by comp_code, clse_acc_id,  biz_plan_item_no
						  ) b4,
						 (select comp_code, clse_acc_id,  biz_plan_item_no, 
						 		 sum(plan_amt) c_y_plan_amt,
								 sum(forecast_amt) c_y_forecast_amt
						  from t_pl_comp_plan_exec
						  where comp_code = AR_COMP_CODE
						  and	clse_acc_id = AR_CLSE_ACC_ID
						  group by comp_code, clse_acc_id,  biz_plan_item_no
						  ) b5,
						  (select comp_code, clse_acc_id - 1 clse_acc_id,  biz_plan_item_no, n_y_forecast_amt
						   from
							  (select comp_code, clse_acc_id,  biz_plan_item_no, 
							          sum(plan_amt) n_y_forecast_amt
							   from   t_pl_comp_plan_exec
							   where  comp_code = AR_COMP_CODE
							   and	  clse_acc_id = AR_CLSE_ACC_ID + 1
							   group by comp_code, clse_acc_id,  biz_plan_item_no)
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
				  and	  b5.biz_plan_item_no = b1.biz_plan_item_no(+)
				  and	  b5.biz_plan_item_no = b2.biz_plan_item_no(+)
				  and	  b5.biz_plan_item_no = b3.biz_plan_item_no(+)
				  and	  b5.biz_plan_item_no = b4.biz_plan_item_no(+)
				  and	  b5.biz_plan_item_no = b6.biz_plan_item_no(+)
				  ) b
			where a.biz_plan_item_no = b.biz_plan_item_no(+)
			--group by rollup(a.p_no, a.biz_plan_item_no, biz_plan_item_name)
			group by grouping sets ((a.p_no,
					 		  	     a.biz_plan_item_no,
									 biz_plan_item_name),
									(a.p_no))
			)	a,
			t_pl_item b
		where b.biz_plan_item_no = a.biz_plan_item_no(+)					
		start with a.p_no = '3'
		connect by prior a.biz_plan_item_no = a.p_no
		order siblings by item_level_seq
		)
		
	union all
	select  '12' div,
			p_no,
			-1 biz_plan_item_no,
			'гу╟Х' biz_plan_item_name,
			b_y_exec_amt,    
			b_y_exec_amt19,  
			c_y_plan_amt19,  
			c_y_exec_amt19,  
		    c_plan_rate19,      
		    b_rate19,        
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
		select  
				p_no,
				sum(nvl(b_y_exec_amt,0)) b_y_exec_amt,    
				sum(nvl(b_y_exec_amt19,0)) b_y_exec_amt19,  
				sum(nvl(c_y_plan_amt19,0)) c_y_plan_amt19,  
				sum(nvl(c_y_exec_amt19,0)) c_y_exec_amt19,  
			    sum(nvl(c_plan_rate19,0)) c_plan_rate19,      
			    sum(nvl(b_rate19,0)) b_rate19,        
				sum(nvl(plan_amt10,0)) plan_amt10,      
				sum(nvl(forecast_amt10,0)) forecast_amt10,  
				sum(nvl(plan_amt11,0)) plan_amt11,      
				sum(nvl(forecast_amt11,0)) forecast_amt11,  
				sum(nvl(plan_amt12,0)) plan_amt12,      
				sum(nvl(forecast_amt12,0)) forecast_amt12,  
				sum(nvl(c_y_plan_amt,0)) c_y_plan_amt,    
				sum(nvl(c_y_forecast_amt,0)) c_y_forecast_amt,
				sum(nvl(c_plan_rate,0)) c_plan_rate,     
				sum(nvl(b_rate,0)) b_rate,          
				sum(nvl(n_y_forecast_amt,0)) n_y_forecast_amt,
				sum(nvl(n_rate,0))  n_rate  
		from
			(
			select  a.p_no,
				    a.biz_plan_item_no,
				    lpad(' ', (level-1) *2 ) || biz_plan_item_name biz_plan_item_name,
				    b_y_exec_amt,    
				    b_y_exec_amt19,  
				    c_y_plan_amt19,  
				    c_y_exec_amt19,  
					c_plan_rate19,      
					b_rate19,        
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
				select  a.p_no,
						a.biz_plan_item_no,
					    sum(b_y_exec_amt)  	 b_y_exec_amt,  
						sum(b_y_exec_amt19)  b_y_exec_amt19,     
						sum(c_y_plan_amt19)  c_y_plan_amt19,     
						sum(c_y_exec_amt19)  c_y_exec_amt19,     
						sum(c_plan_rate19)   c_plan_rate19,     
						sum(b_rate19)        b_rate19,     
						sum(plan_amt10)      plan_amt10,     
						sum(forecast_amt10)  forecast_amt10,     
						sum(plan_amt11)      plan_amt11,     
						sum(forecast_amt11)  forecast_amt11,     
						sum(plan_amt12)      plan_amt12,     
						sum(forecast_amt12)  forecast_amt12,     
						sum(c_y_plan_amt)    c_y_plan_amt,     
						sum(c_y_forecast_amt) c_y_forecast_amt,  
						sum(c_plan_rate)	  c_plan_rate,
						sum(b_rate)	          b_rate,
						sum(n_y_forecast_amt) n_y_forecast_amt,
						sum(n_rate)	 		  n_rate	     
				from t_pl_item a,
					 (select 
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
						 		  biz_plan_item_no,  b_y_exec_amt
							  from 
								 (select comp_code, clse_acc_id,  biz_plan_item_no, 
								 		 sum(exec_amt) b_y_exec_amt
								  from t_pl_comp_plan_exec
								  where comp_code = AR_COMP_CODE
								  and	clse_acc_id = AR_CLSE_ACC_ID - 1
								  group by comp_code, clse_acc_id, biz_plan_item_no)
							  ) b1,
							 (select comp_code, clse_acc_id + 1 clse_acc_id,  biz_plan_item_no,
							 		  b_y_exec_amt19
							  from 
								  (select comp_code, clse_acc_id,  biz_plan_item_no,
								 		  sum(exec_amt) b_y_exec_amt19
								   from   t_pl_comp_plan_exec
								   where  comp_code   = AR_COMP_CODE
								   and	  clse_acc_id = AR_CLSE_ACC_ID - 1
								   and    substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09')
								   group by comp_code, clse_acc_id,  biz_plan_item_no)
							 ) b2,
							 (select comp_code, clse_acc_id,  biz_plan_item_no,
							 		 sum(plan_amt) c_y_plan_amt19, 
							 		 sum(exec_amt) c_y_exec_amt19
							  from  t_pl_comp_plan_exec
							  where comp_code = AR_COMP_CODE
							  and	clse_acc_id = AR_CLSE_ACC_ID
							  and   substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09')
							  group by comp_code, clse_acc_id,  biz_plan_item_no
							 ) b3,
							  (select comp_code, clse_acc_id,  biz_plan_item_no, 
							  		 sum(plan_amt10) plan_amt10,
									 sum(forecast_amt10) forecast_amt10,
									 sum(plan_amt11) plan_amt11,
									 sum(forecast_amt11) forecast_amt11,
									 sum(plan_amt12) plan_amt12, 
									 sum(forecast_amt12) forecast_amt12
							  from(
								  select comp_code, clse_acc_id,  biz_plan_item_no,
								  		 decode(substr(work_ym, 5,6) ,'10', sum(plan_amt), '') 	   plan_amt10, 
								  		 decode(substr(work_ym, 5,6) ,'10', sum(forecast_amt), '') forecast_amt10,
										 decode(substr(work_ym, 5,6) ,'11', sum(plan_amt), '') 	   plan_amt11,
										 decode(substr(work_ym, 5,6) ,'11', sum(forecast_amt), '') forecast_amt11,
										 decode(substr(work_ym, 5,6) ,'12', sum(plan_amt), '') 	   plan_amt12,
										 decode(substr(work_ym, 5,6) ,'12', sum(forecast_amt), '') forecast_amt12
								  from   t_pl_comp_plan_exec
								  where  comp_code = AR_COMP_CODE
								  and	 clse_acc_id = AR_CLSE_ACC_ID
								  and    substr(work_ym, 5,6) in ('10', '11', '12')
								  group by comp_code, clse_acc_id,  biz_plan_item_no,
								  		   substr(work_ym, 5,6))
							  group by comp_code, clse_acc_id,  biz_plan_item_no
							  ) b4,
							 (select comp_code, clse_acc_id,  biz_plan_item_no, 
							 		 sum(plan_amt) c_y_plan_amt,
									 sum(forecast_amt) c_y_forecast_amt
							  from t_pl_comp_plan_exec
							  where comp_code = AR_COMP_CODE
							  and	clse_acc_id = AR_CLSE_ACC_ID
							  group by comp_code, clse_acc_id,  biz_plan_item_no
							  ) b5,
							  (select comp_code, clse_acc_id - 1 clse_acc_id,  biz_plan_item_no, n_y_forecast_amt
							   from
								  (select comp_code, clse_acc_id,  biz_plan_item_no, 
								          sum(plan_amt) n_y_forecast_amt
								   from   t_pl_comp_plan_exec
								   where  comp_code = AR_COMP_CODE
								   and	  clse_acc_id = AR_CLSE_ACC_ID + 1
								   group by comp_code, clse_acc_id,  biz_plan_item_no)
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
					  and	  b5.biz_plan_item_no = b1.biz_plan_item_no(+)
					  and	  b5.biz_plan_item_no = b2.biz_plan_item_no(+)
					  and	  b5.biz_plan_item_no = b3.biz_plan_item_no(+)
					  and	  b5.biz_plan_item_no = b4.biz_plan_item_no(+)
					  and	  b5.biz_plan_item_no = b6.biz_plan_item_no(+)
					  ) b
				where a.biz_plan_item_no = b.biz_plan_item_no(+)
				--group by rollup(a.p_no, a.biz_plan_item_no, biz_plan_item_name)
				group by grouping sets ((a.p_no,
						 		  	     a.biz_plan_item_no,
										 biz_plan_item_name),
										(a.p_no))
				)	a,
				t_pl_item b
			where b.biz_plan_item_no = a.biz_plan_item_no(+)					
			start with a.p_no = '3'
			connect by prior a.biz_plan_item_no = a.p_no
			order siblings by item_level_seq
			)
		where p_no=3
		group by p_no
		)
	order by 1
	);
		
End;
/
