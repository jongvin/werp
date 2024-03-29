<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2006-05-03)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			
			strSql  = " select 	   div, \n";
			strSql += " 		   dept_code, \n";
			strSql += " 		   dept_name, \n";
			strSql += " 		   biz_plan_item_no, \n";
			strSql += " 		   biz_plan_item_name,  \n";
			strSql += " 		   b_y_exec_amt, \n";
			strSql += " 		   b_y_exec_amt19, \n";
			strSql += " 		   c_y_plan_amt19, \n";
			strSql += " 		   c_y_exec_amt19, \n";
			strSql += " 		   c_plan_rate19, \n";
			strSql += " 		   b_rate19, \n";
			strSql += " 		   plan_amt10, \n";
			strSql += " 		   forecast_amt10, \n";
			strSql += " 		   plan_amt11, \n";
			strSql += " 		   forecast_amt11, \n";
			strSql += " 		   plan_amt12, \n";
			strSql += " 		   forecast_amt12, \n";
			strSql += " 		   c_y_plan_amt, \n";
			strSql += " 		   c_y_forecast_amt, \n";
			strSql += " 		   c_plan_rate, \n";
			strSql += " 		   b_rate, \n";
			strSql += " 		   n_y_plan_amt, \n";
			strSql += " 		   n_rate \n";
			strSql += " from \n";
			strSql += " 	( \n";
			strSql += " 	select '11' div, \n";
			strSql += " 		   b.dept_code, \n";
			strSql += " 		   dept_name, \n";
			strSql += " 		   b.biz_plan_item_no, \n";
			strSql += " 		   biz_plan_item_name,  \n";
			strSql += " 		   b_y_exec_amt, \n";
			strSql += " 		   b_y_exec_amt19, \n";
			strSql += " 		   c_y_plan_amt19, \n";
			strSql += " 		   c_y_exec_amt19, \n";
			strSql += " 		   c_plan_rate19, \n";
			strSql += " 		   b_rate19, \n";
			strSql += " 		   plan_amt10, \n";
			strSql += " 		   forecast_amt10, \n";
			strSql += " 		   plan_amt11, \n";
			strSql += " 		   forecast_amt11, \n";
			strSql += " 		   plan_amt12, \n";
			strSql += " 		   forecast_amt12, \n";
			strSql += " 		   c_y_plan_amt, \n";
			strSql += " 		   c_y_forecast_amt, \n";
			strSql += " 		   c_plan_rate, \n";
			strSql += " 		   b_rate, \n";
			strSql += " 		   n_y_plan_amt, \n";
			strSql += " 		   n_rate \n";
			strSql += " 	from (select * \n";
			strSql += " 		  from t_pl_item \n";
			strSql += " 		   \n";
			strSql += " 		  where mng_code in('매출액','매출이익')) a, \n";
			strSql += " 		 (select  \n";
			strSql += " 		 		 b5.dept_code, \n";
			strSql += " 				 b5.biz_plan_item_no, \n";
			strSql += " 				 decode(nvl(b_y_exec_amt,0), 0, 0, round(b_y_exec_amt/1000000,0))  b_y_exec_amt, \n";
			strSql += " 				 decode(nvl(b_y_exec_amt19,0),0, 0, round(b_y_exec_amt19/1000000,0)) b_y_exec_amt19, \n";
			strSql += " 				 decode(nvl(c_y_plan_amt19,0),0, 0, round(c_y_plan_amt19/1000000,0)) c_y_plan_amt19,  \n";
			strSql += " 		 		 decode(nvl(c_y_exec_amt19,0),0, 0, round(c_y_exec_amt19/1000000,0)) c_y_exec_amt19, \n";
			strSql += " 				 decode(nvl(c_y_plan_amt19,0),0, 0, round((nvl(c_y_exec_amt19,0)/nvl(c_y_plan_amt19,0))*100,1)) c_plan_rate19, \n";
			strSql += " 				 decode(nvl(b_y_exec_amt19,0), 0, 0, round((nvl(c_y_exec_amt19,0)/nvl(b_y_exec_amt19,0))*100,1)) b_rate19, \n";
			strSql += " 				 decode(nvl(plan_amt10,0), 0, 0, round(plan_amt10/1000000,0)) plan_amt10,  \n";
			strSql += " 				 decode(nvl(forecast_amt10,0), 0, 0, round(forecast_amt10/1000000,0)) forecast_amt10, \n";
			strSql += " 				 decode(nvl(plan_amt11,0), 0, 0, round(plan_amt11/1000000,0)) plan_amt11,  \n";
			strSql += " 				 decode(nvl(forecast_amt11,0), 0, 0, round(forecast_amt11/1000000,0)) forecast_amt11, \n";
			strSql += " 				 decode(nvl(plan_amt12,0), 0, 0, round(plan_amt12/1000000,0)) plan_amt12, \n";
			strSql += " 				 decode(nvl(forecast_amt12,0), 0, 0, round(forecast_amt12/1000000,0)) forecast_amt12, \n";
			strSql += " 				 decode(nvl(c_y_plan_amt,0), 0, 0, round(c_y_plan_amt/1000000,0)) c_y_plan_amt, \n";
			strSql += " 				 decode(nvl(c_y_forecast_amt,0), 0, 0, round(c_y_forecast_amt/1000000,0)) c_y_forecast_amt, \n";
			strSql += " 				 decode(nvl(c_y_plan_amt,0),0, 0, round((nvl(c_y_forecast_amt,0)/nvl(c_y_plan_amt,0))*100,1)) c_plan_rate, \n";
			strSql += " 				 decode(nvl(b_y_exec_amt,0), 0, 0, round((nvl(c_y_forecast_amt,0)/nvl(b_y_exec_amt,0))*100,1)) b_rate, \n";
			strSql += " 				 decode(nvl(n_y_plan_amt,0),0, 0,  round(n_y_plan_amt,0)) n_y_plan_amt, \n";
			strSql += " 				 decode(nvl(n_y_plan_amt,0), 0, 0, round(((nvl(c_y_exec_amt19,0) + nvl(forecast_amt10,0) + nvl(forecast_amt11,0) + nvl(forecast_amt12,0))/nvl(n_y_plan_amt,0))*100,1)) n_rate \n";
			strSql += " 		  from  \n";
			strSql += " 				 (select comp_code, clse_acc_id + 1 clse_acc_id,  \n";
			strSql += " 				 		 dept_code, biz_plan_item_no,  b_y_exec_amt \n";
			strSql += " 				  from  \n";
			strSql += " 					 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,  \n";
			strSql += " 					 		 sum(exec_amt) b_y_exec_amt \n";
			strSql += " 					  from t_pl_comp_dept_plan_exec \n";
			strSql += " 					  where comp_code =  ?  \n";
			strSql += " 					  and	clse_acc_id =  ?  - 1 \n";
			strSql += " 					  group by comp_code, clse_acc_id, dept_code,biz_plan_item_no) \n";
			strSql += " 				  ) b1, \n";
			strSql += " 				 (select comp_code, clse_acc_id + 1 clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 				 		  b_y_exec_amt19 \n";
			strSql += " 				  from  \n";
			strSql += " 					  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 					 		  sum(exec_amt) b_y_exec_amt19 \n";
			strSql += " 					   from   t_pl_comp_dept_plan_exec \n";
			strSql += " 					   where  comp_code   =  ?  \n";
			strSql += " 					   and	  clse_acc_id =  ?  - 1 \n";
			strSql += " 					   and    substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09') \n";
			strSql += " 					   group by comp_code, clse_acc_id, dept_code, biz_plan_item_no) \n";
			strSql += " 				 ) b2, \n";
			strSql += " 				 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 				 		 sum(plan_amt) c_y_plan_amt19,  \n";
			strSql += " 				 		 sum(exec_amt) c_y_exec_amt19 \n";
			strSql += " 				  from  t_pl_comp_dept_plan_exec \n";
			strSql += " 				  where comp_code =  ?  \n";
			strSql += " 				  and	clse_acc_id =  ?  \n";
			strSql += " 				  and   substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09') \n";
			strSql += " 				  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 				  ) b3, \n";
			strSql += " 				  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,  \n";
			strSql += " 				  		 sum(plan_amt10) plan_amt10, \n";
			strSql += " 						 sum(forecast_amt10) forecast_amt10, \n";
			strSql += " 						 sum(plan_amt11) plan_amt11, \n";
			strSql += " 						 sum(forecast_amt11) forecast_amt11, \n";
			strSql += " 						 sum(plan_amt12) plan_amt12,  \n";
			strSql += " 						 sum(forecast_amt12) forecast_amt12 \n";
			strSql += " 				  from( \n";
			strSql += " 					  select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 					  		 decode(substr(work_ym, 5,6) ,'10', sum(plan_amt), '') 	   plan_amt10,  \n";
			strSql += " 					  		 decode(substr(work_ym, 5,6) ,'10', sum(forecast_amt), '') forecast_amt10, \n";
			strSql += " 							 decode(substr(work_ym, 5,6) ,'11', sum(plan_amt), '') 	   plan_amt11, \n";
			strSql += " 							 decode(substr(work_ym, 5,6) ,'11', sum(forecast_amt), '') forecast_amt11, \n";
			strSql += " 							 decode(substr(work_ym, 5,6) ,'12', sum(plan_amt), '') 	   plan_amt12, \n";
			strSql += " 							 decode(substr(work_ym, 5,6) ,'12', sum(forecast_amt), '') forecast_amt12 \n";
			strSql += " 					  from   t_pl_comp_dept_plan_exec \n";
			strSql += " 					  where  comp_code =  ?  \n";
			strSql += " 					  and	 clse_acc_id =  ?  \n";
			strSql += " 					  and    substr(work_ym, 5,6) in ('10', '11', '12') \n";
			strSql += " 					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 					  		   substr(work_ym, 5,6)) \n";
			strSql += " 				  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 				  ) b4, \n";
			strSql += " 				 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,  \n";
			strSql += " 				 		 sum(plan_amt) c_y_plan_amt, \n";
			strSql += " 						 sum(forecast_amt) c_y_forecast_amt \n";
			strSql += " 				  from t_pl_comp_dept_plan_exec \n";
			strSql += " 				  where comp_code =  ?  \n";
			strSql += " 				  and	clse_acc_id =  ?  \n";
			strSql += " 				  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 				  ) b5, \n";
			strSql += " 				  (select comp_code, clse_acc_id - 1 clse_acc_id, dept_code, biz_plan_item_no, n_y_plan_amt \n";
			strSql += " 				   from \n";
			strSql += " 					  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,  \n";
			strSql += " 					          sum(plan_amt) n_y_plan_amt \n";
			strSql += " 					   from   t_pl_comp_dept_plan_exec \n";
			strSql += " 					   where  comp_code =  ?  \n";
			strSql += " 					   and	  clse_acc_id =  ?  + 1 \n";
			strSql += " 					   group by comp_code, clse_acc_id, dept_code, biz_plan_item_no) \n";
			strSql += " 				  ) b6 \n";
			strSql += " 		  where   b5.comp_code = b1.comp_code(+) \n";
			strSql += " 		  and	  b5.comp_code = b2.comp_code(+) \n";
			strSql += " 		  and	  b5.comp_code = b3.comp_code(+) \n";
			strSql += " 		  and	  b5.comp_code = b4.comp_code(+) \n";
			strSql += " 		  and	  b5.comp_code = b6.comp_code(+) \n";
			strSql += " 		  and	  b5.clse_acc_id = b1.clse_acc_id(+) \n";
			strSql += " 		  and	  b5.clse_acc_id = b2.clse_acc_id(+)  \n";
			strSql += " 		  and	  b5.clse_acc_id = b3.clse_acc_id(+)  \n";
			strSql += " 		  and	  b5.clse_acc_id = b4.clse_acc_id(+) \n";
			strSql += " 		  and	  b5.clse_acc_id = b6.clse_acc_id(+) \n";
			strSql += " 		  and	  b5.dept_code = b1.dept_code(+) \n";
			strSql += " 		  and	  b5.dept_code = b2.dept_code(+)  \n";
			strSql += " 		  and	  b5.dept_code = b3.dept_code(+)  \n";
			strSql += " 		  and	  b5.dept_code = b4.dept_code(+) \n";
			strSql += " 		  and	  b5.dept_code = b6.dept_code(+) \n";
			strSql += " 		  and	  b5.biz_plan_item_no = b1.biz_plan_item_no(+) \n";
			strSql += " 		  and	  b5.biz_plan_item_no = b2.biz_plan_item_no(+) \n";
			strSql += " 		  and	  b5.biz_plan_item_no = b3.biz_plan_item_no(+) \n";
			strSql += " 		  and	  b5.biz_plan_item_no = b4.biz_plan_item_no(+) \n";
			strSql += " 		  and	  b5.biz_plan_item_no = b6.biz_plan_item_no(+) \n";
			strSql += " 		  ) b, \n";
			strSql += " 		  t_dept_code c	   \n";
			strSql += " 	where a.biz_plan_item_no = b.biz_plan_item_no(+) \n";
			strSql += " 	and	  b.dept_code = c.dept_code(+) \n";
			strSql += " 	 \n";
			strSql += " 	union all \n";
			strSql += " 	 \n";
			strSql += " 	select b1.div, \n";
			strSql += " 		   b1.dept_code, \n";
			strSql += " 		   b1.dept_name, \n";
			strSql += " 		   b1.biz_plan_item_no, \n";
			strSql += " 		   '(%)' biz_plan_item_name,  \n";
			strSql += " 		   decode(a1.b_y_exec_amt, 0, 0, round((b1.b_y_exec_amt/a1.b_y_exec_amt)*100,1)) b_y_exec_amt, \n";
			strSql += " 		   decode(a1.b_y_exec_amt19, 0, 0, round((b1.b_y_exec_amt19/a1.b_y_exec_amt19)*100,1)) b_y_exec_amt19, \n";
			strSql += " 		   decode(a1.c_y_plan_amt19, 0, 0, round((b1.c_y_plan_amt19/a1.c_y_plan_amt19)*100,1)) c_y_plan_amt19, \n";
			strSql += " 		   decode(a1.c_y_exec_amt19, 0, 0, round((b1.c_y_exec_amt19/a1.c_y_exec_amt19)*100,1)) c_y_exec_amt19, \n";
			strSql += " 		   0 c_plan_rate19, \n";
			strSql += " 		   0 b_rate19, \n";
			strSql += " 		   decode(a1.plan_amt10, 0, 0, round((b1.plan_amt10/a1.plan_amt10)*100,1)) plan_amt10, \n";
			strSql += " 		   decode(a1.forecast_amt10, 0, 0, round((b1.forecast_amt10/a1.forecast_amt10)*100,1)) forecast_amt10, \n";
			strSql += " 		   decode(a1.plan_amt11, 0, 0, round((b1.plan_amt11/a1.plan_amt11)*100,1)) plan_amt11, \n";
			strSql += " 		   decode(a1.forecast_amt11, 0, 0, round((b1.forecast_amt11/a1.forecast_amt11)*100,1)) forecast_amt11, \n";
			strSql += " 		   decode(a1.plan_amt12, 0, 0, round((b1.plan_amt12/a1.plan_amt12)*100,1)) plan_amt12, \n";
			strSql += " 		   decode(a1.forecast_amt12, 0, 0, round((b1.forecast_amt12/a1.forecast_amt12)*100,1)) forecast_amt12, \n";
			strSql += " 		   decode(a1.c_y_plan_amt, 0, 0, round((b1.c_y_plan_amt/a1.c_y_plan_amt)*100,1)) c_y_plan_amt, \n";
			strSql += " 		   decode(a1.c_y_forecast_amt, 0, 0, round((b1.c_y_forecast_amt/a1.c_y_forecast_amt)*100,1)) c_y_forecast_amt, \n";
			strSql += " 		   0 c_plan_rate, \n";
			strSql += " 		   0 b_rate, \n";
			strSql += " 		   decode(a1.n_y_plan_amt, 0, 0, round((b1.n_y_plan_amt/a1.n_y_plan_amt)*100,1)) n_y_plan_amt, \n";
			strSql += " 		   0 n_rate	    \n";
			strSql += " 	from \n";
			strSql += " 		(	    \n";
			strSql += " 		select '12' div, \n";
			strSql += " 			   b.dept_code, \n";
			strSql += " 			   dept_name, \n";
			strSql += " 			   b.biz_plan_item_no, \n";
			strSql += " 			   biz_plan_item_name,  \n";
			strSql += " 			   b_y_exec_amt, \n";
			strSql += " 			   b_y_exec_amt19, \n";
			strSql += " 			   c_y_plan_amt19, \n";
			strSql += " 			   c_y_exec_amt19, \n";
			strSql += " 			   c_plan_rate19, \n";
			strSql += " 			   b_rate19, \n";
			strSql += " 			   plan_amt10, \n";
			strSql += " 			   forecast_amt10, \n";
			strSql += " 			   plan_amt11, \n";
			strSql += " 			   forecast_amt11, \n";
			strSql += " 			   plan_amt12, \n";
			strSql += " 			   forecast_amt12, \n";
			strSql += " 			   c_y_plan_amt, \n";
			strSql += " 			   c_y_forecast_amt, \n";
			strSql += " 			   c_plan_rate, \n";
			strSql += " 			   b_rate, \n";
			strSql += " 			   n_y_plan_amt, \n";
			strSql += " 			   n_rate \n";
			strSql += " 		from (select * \n";
			strSql += " 			  from t_pl_item \n";
			strSql += " 			  where mng_code ='매출액') a, \n";
			strSql += " 			 (select  \n";
			strSql += " 			 		 b5.dept_code, \n";
			strSql += " 					 b5.biz_plan_item_no, \n";
			strSql += " 					 decode(nvl(b_y_exec_amt,0), 0, 0, round(b_y_exec_amt/1000000,0))  b_y_exec_amt, \n";
			strSql += " 					 decode(nvl(b_y_exec_amt19,0),0, 0, round(b_y_exec_amt19/1000000,0)) b_y_exec_amt19, \n";
			strSql += " 					 decode(nvl(c_y_plan_amt19,0),0, 0, round(c_y_plan_amt19/1000000,0)) c_y_plan_amt19,  \n";
			strSql += " 			 		 decode(nvl(c_y_exec_amt19,0),0, 0, round(c_y_exec_amt19/1000000,0)) c_y_exec_amt19, \n";
			strSql += " 					 decode(nvl(c_y_plan_amt19,0),0, 0, round((nvl(c_y_exec_amt19,0)/nvl(c_y_plan_amt19,0))*100,1)) c_plan_rate19, \n";
			strSql += " 					 decode(nvl(b_y_exec_amt19,0), 0, 0, round((nvl(c_y_exec_amt19,0)/nvl(b_y_exec_amt19,0))*100,1)) b_rate19, \n";
			strSql += " 					 decode(nvl(plan_amt10,0), 0, 0, round(plan_amt10/1000000,0)) plan_amt10,  \n";
			strSql += " 					 decode(nvl(forecast_amt10,0), 0, 0, round(forecast_amt10/1000000,0)) forecast_amt10, \n";
			strSql += " 					 decode(nvl(plan_amt11,0), 0, 0, round(plan_amt11/1000000,0)) plan_amt11,  \n";
			strSql += " 					 decode(nvl(forecast_amt11,0), 0, 0, round(forecast_amt11/1000000,0)) forecast_amt11, \n";
			strSql += " 					 decode(nvl(plan_amt12,0), 0, 0, round(plan_amt12/1000000,0)) plan_amt12, \n";
			strSql += " 					 decode(nvl(forecast_amt12,0), 0, 0, round(forecast_amt12/1000000,0)) forecast_amt12, \n";
			strSql += " 					 decode(nvl(c_y_plan_amt,0), 0, 0, round(c_y_plan_amt/1000000,0)) c_y_plan_amt, \n";
			strSql += " 					 decode(nvl(c_y_forecast_amt,0), 0, 0, round(c_y_forecast_amt/1000000,0)) c_y_forecast_amt, \n";
			strSql += " 					 decode(nvl(c_y_plan_amt,0),0, 0, round((nvl(c_y_forecast_amt,0)/nvl(c_y_plan_amt,0))*100,1)) c_plan_rate, \n";
			strSql += " 					 decode(nvl(b_y_exec_amt,0), 0, 0, round((nvl(c_y_forecast_amt,0)/nvl(b_y_exec_amt,0))*100,1)) b_rate, \n";
			strSql += " 					 decode(nvl(n_y_plan_amt,0),0, 0,  round(n_y_plan_amt,0)) n_y_plan_amt, \n";
			strSql += " 					 decode(nvl(n_y_plan_amt,0), 0, 0, round(((nvl(c_y_exec_amt19,0) + nvl(forecast_amt10,0) + nvl(forecast_amt11,0) + nvl(forecast_amt12,0))/nvl(n_y_plan_amt,0))*100,1)) n_rate \n";
			strSql += " 			  from  \n";
			strSql += " 					 (select comp_code, clse_acc_id + 1 clse_acc_id,  \n";
			strSql += " 					 		 dept_code, biz_plan_item_no,  b_y_exec_amt \n";
			strSql += " 					  from  \n";
			strSql += " 						 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,  \n";
			strSql += " 						 		 sum(exec_amt) b_y_exec_amt \n";
			strSql += " 						  from t_pl_comp_dept_plan_exec \n";
			strSql += " 						  where comp_code =  ?  \n";
			strSql += " 						  and	clse_acc_id =  ?  - 1 \n";
			strSql += " 						  group by comp_code, clse_acc_id, dept_code,biz_plan_item_no) \n";
			strSql += " 					  ) b1, \n";
			strSql += " 					 (select comp_code, clse_acc_id + 1 clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 					 		  b_y_exec_amt19 \n";
			strSql += " 					  from  \n";
			strSql += " 						  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 						 		  sum(exec_amt) b_y_exec_amt19 \n";
			strSql += " 						   from   t_pl_comp_dept_plan_exec \n";
			strSql += " 						   where  comp_code   =  ?  \n";
			strSql += " 						   and	  clse_acc_id =  ?  - 1 \n";
			strSql += " 						   and    substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09') \n";
			strSql += " 						   group by comp_code, clse_acc_id, dept_code, biz_plan_item_no) \n";
			strSql += " 					 ) b2, \n";
			strSql += " 					 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 					 		 sum(plan_amt) c_y_plan_amt19,  \n";
			strSql += " 					 		 sum(exec_amt) c_y_exec_amt19 \n";
			strSql += " 					  from  t_pl_comp_dept_plan_exec \n";
			strSql += " 					  where comp_code =  ?  \n";
			strSql += " 					  and	clse_acc_id =  ?  \n";
			strSql += " 					  and   substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09') \n";
			strSql += " 					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 					  ) b3, \n";
			strSql += " 					  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,  \n";
			strSql += " 					  		 sum(plan_amt10) plan_amt10, \n";
			strSql += " 							 sum(forecast_amt10) forecast_amt10, \n";
			strSql += " 							 sum(plan_amt11) plan_amt11, \n";
			strSql += " 							 sum(forecast_amt11) forecast_amt11, \n";
			strSql += " 							 sum(plan_amt12) plan_amt12,  \n";
			strSql += " 							 sum(forecast_amt12) forecast_amt12 \n";
			strSql += " 					  from( \n";
			strSql += " 						  select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 						  		 decode(substr(work_ym, 5,6) ,'10', sum(plan_amt), '') 	   plan_amt10,  \n";
			strSql += " 						  		 decode(substr(work_ym, 5,6) ,'10', sum(forecast_amt), '') forecast_amt10, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'11', sum(plan_amt), '') 	   plan_amt11, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'11', sum(forecast_amt), '') forecast_amt11, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'12', sum(plan_amt), '') 	   plan_amt12, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'12', sum(forecast_amt), '') forecast_amt12 \n";
			strSql += " 						  from   t_pl_comp_dept_plan_exec \n";
			strSql += " 						  where  comp_code =  ?  \n";
			strSql += " 						  and	 clse_acc_id =  ?  \n";
			strSql += " 						  and    substr(work_ym, 5,6) in ('10', '11', '12') \n";
			strSql += " 						  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 						  		   substr(work_ym, 5,6)) \n";
			strSql += " 					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 					  ) b4, \n";
			strSql += " 					 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,  \n";
			strSql += " 					 		 sum(plan_amt) c_y_plan_amt, \n";
			strSql += " 							 sum(forecast_amt) c_y_forecast_amt \n";
			strSql += " 					  from t_pl_comp_dept_plan_exec \n";
			strSql += " 					  where comp_code =  ?  \n";
			strSql += " 					  and	clse_acc_id =  ?  \n";
			strSql += " 					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 					  ) b5, \n";
			strSql += " 					  (select comp_code, clse_acc_id - 1 clse_acc_id, dept_code, biz_plan_item_no, n_y_plan_amt \n";
			strSql += " 					   from \n";
			strSql += " 						  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,  \n";
			strSql += " 						          sum(plan_amt) n_y_plan_amt \n";
			strSql += " 						   from   t_pl_comp_dept_plan_exec \n";
			strSql += " 						   where  comp_code =  ?  \n";
			strSql += " 						   and	  clse_acc_id =  ?  + 1 \n";
			strSql += " 						   group by comp_code, clse_acc_id, dept_code, biz_plan_item_no) \n";
			strSql += " 					  ) b6 \n";
			strSql += " 			  where   b5.comp_code = b1.comp_code(+) \n";
			strSql += " 			  and	  b5.comp_code = b2.comp_code(+) \n";
			strSql += " 			  and	  b5.comp_code = b3.comp_code(+) \n";
			strSql += " 			  and	  b5.comp_code = b4.comp_code(+) \n";
			strSql += " 			  and	  b5.comp_code = b6.comp_code(+) \n";
			strSql += " 			  and	  b5.clse_acc_id = b1.clse_acc_id(+) \n";
			strSql += " 			  and	  b5.clse_acc_id = b2.clse_acc_id(+)  \n";
			strSql += " 			  and	  b5.clse_acc_id = b3.clse_acc_id(+)  \n";
			strSql += " 			  and	  b5.clse_acc_id = b4.clse_acc_id(+) \n";
			strSql += " 			  and	  b5.clse_acc_id = b6.clse_acc_id(+) \n";
			strSql += " 			  and	  b5.dept_code = b1.dept_code(+) \n";
			strSql += " 			  and	  b5.dept_code = b2.dept_code(+)  \n";
			strSql += " 			  and	  b5.dept_code = b3.dept_code(+)  \n";
			strSql += " 			  and	  b5.dept_code = b4.dept_code(+) \n";
			strSql += " 			  and	  b5.dept_code = b6.dept_code(+) \n";
			strSql += " 			  and	  b5.biz_plan_item_no = b1.biz_plan_item_no(+) \n";
			strSql += " 			  and	  b5.biz_plan_item_no = b2.biz_plan_item_no(+) \n";
			strSql += " 			  and	  b5.biz_plan_item_no = b3.biz_plan_item_no(+) \n";
			strSql += " 			  and	  b5.biz_plan_item_no = b4.biz_plan_item_no(+) \n";
			strSql += " 			  and	  b5.biz_plan_item_no = b6.biz_plan_item_no(+) \n";
			strSql += " 			  ) b, \n";
			strSql += " 			  t_dept_code c	   \n";
			strSql += " 		where a.biz_plan_item_no = b.biz_plan_item_no(+) \n";
			strSql += " 		and	  b.dept_code = c.dept_code(+) \n";
			strSql += " 		) a1, \n";
			strSql += " 		( \n";
			strSql += " 		select '12' div, \n";
			strSql += " 			   b.dept_code, \n";
			strSql += " 			   dept_name, \n";
			strSql += " 			   b.biz_plan_item_no, \n";
			strSql += " 			   biz_plan_item_name,  \n";
			strSql += " 			   b_y_exec_amt, \n";
			strSql += " 			   b_y_exec_amt19, \n";
			strSql += " 			   c_y_plan_amt19, \n";
			strSql += " 			   c_y_exec_amt19, \n";
			strSql += " 			   c_plan_rate19, \n";
			strSql += " 			   b_rate19, \n";
			strSql += " 			   plan_amt10, \n";
			strSql += " 			   forecast_amt10, \n";
			strSql += " 			   plan_amt11, \n";
			strSql += " 			   forecast_amt11, \n";
			strSql += " 			   plan_amt12, \n";
			strSql += " 			   forecast_amt12, \n";
			strSql += " 			   c_y_plan_amt, \n";
			strSql += " 			   c_y_forecast_amt, \n";
			strSql += " 			   c_plan_rate, \n";
			strSql += " 			   b_rate, \n";
			strSql += " 			   n_y_plan_amt, \n";
			strSql += " 			   n_rate \n";
			strSql += " 		from (select * \n";
			strSql += " 			  from t_pl_item \n";
			strSql += " 			  where mng_code = '매출이익') a, \n";
			strSql += " 			 (select  \n";
			strSql += " 			 		 b5.dept_code, \n";
			strSql += " 					 b5.biz_plan_item_no, \n";
			strSql += " 					 decode(nvl(b_y_exec_amt,0), 0, 0, round(b_y_exec_amt/1000000,0))  b_y_exec_amt, \n";
			strSql += " 					 decode(nvl(b_y_exec_amt19,0),0, 0, round(b_y_exec_amt19/1000000,0)) b_y_exec_amt19, \n";
			strSql += " 					 decode(nvl(c_y_plan_amt19,0),0, 0, round(c_y_plan_amt19/1000000,0)) c_y_plan_amt19,  \n";
			strSql += " 			 		 decode(nvl(c_y_exec_amt19,0),0, 0, round(c_y_exec_amt19/1000000,0)) c_y_exec_amt19, \n";
			strSql += " 					 decode(nvl(c_y_plan_amt19,0),0, 0, round((nvl(c_y_exec_amt19,0)/nvl(c_y_plan_amt19,0))*100,1)) c_plan_rate19, \n";
			strSql += " 					 decode(nvl(b_y_exec_amt19,0), 0, 0, round((nvl(c_y_exec_amt19,0)/nvl(b_y_exec_amt19,0))*100,1)) b_rate19, \n";
			strSql += " 					 decode(nvl(plan_amt10,0), 0, 0, round(plan_amt10/1000000,0)) plan_amt10,  \n";
			strSql += " 					 decode(nvl(forecast_amt10,0), 0, 0, round(forecast_amt10/1000000,0)) forecast_amt10, \n";
			strSql += " 					 decode(nvl(plan_amt11,0), 0, 0, round(plan_amt11/1000000,0)) plan_amt11,  \n";
			strSql += " 					 decode(nvl(forecast_amt11,0), 0, 0, round(forecast_amt11/1000000,0)) forecast_amt11, \n";
			strSql += " 					 decode(nvl(plan_amt12,0), 0, 0, round(plan_amt12/1000000,0)) plan_amt12, \n";
			strSql += " 					 decode(nvl(forecast_amt12,0), 0, 0, round(forecast_amt12/1000000,0)) forecast_amt12, \n";
			strSql += " 					 decode(nvl(c_y_plan_amt,0), 0, 0, round(c_y_plan_amt/1000000,0)) c_y_plan_amt, \n";
			strSql += " 					 decode(nvl(c_y_forecast_amt,0), 0, 0, round(c_y_forecast_amt/1000000,0)) c_y_forecast_amt, \n";
			strSql += " 					 decode(nvl(c_y_plan_amt,0),0, 0, round((nvl(c_y_forecast_amt,0)/nvl(c_y_plan_amt,0))*100,1)) c_plan_rate, \n";
			strSql += " 					 decode(nvl(b_y_exec_amt,0), 0, 0, round((nvl(c_y_forecast_amt,0)/nvl(b_y_exec_amt,0))*100,1)) b_rate, \n";
			strSql += " 					 decode(nvl(n_y_plan_amt,0),0, 0,  round(n_y_plan_amt,0)) n_y_plan_amt, \n";
			strSql += " 					 decode(nvl(n_y_plan_amt,0), 0, 0, round(((nvl(c_y_exec_amt19,0) + nvl(forecast_amt10,0) + nvl(forecast_amt11,0) + nvl(forecast_amt12,0))/nvl(n_y_plan_amt,0))*100,1)) n_rate \n";
			strSql += " 			  from  \n";
			strSql += " 					 (select comp_code, clse_acc_id + 1 clse_acc_id,  \n";
			strSql += " 					 		 dept_code, biz_plan_item_no,  b_y_exec_amt \n";
			strSql += " 					  from  \n";
			strSql += " 						 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,  \n";
			strSql += " 						 		 sum(exec_amt) b_y_exec_amt \n";
			strSql += " 						  from t_pl_comp_dept_plan_exec \n";
			strSql += " 						  where comp_code =  ?  \n";
			strSql += " 						  and	clse_acc_id =  ?  - 1 \n";
			strSql += " 						  group by comp_code, clse_acc_id, dept_code,biz_plan_item_no) \n";
			strSql += " 					  ) b1, \n";
			strSql += " 					 (select comp_code, clse_acc_id + 1 clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 					 		  b_y_exec_amt19 \n";
			strSql += " 					  from  \n";
			strSql += " 						  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 						 		  sum(exec_amt) b_y_exec_amt19 \n";
			strSql += " 						   from   t_pl_comp_dept_plan_exec \n";
			strSql += " 						   where  comp_code   =  ?  \n";
			strSql += " 						   and	  clse_acc_id =  ?  - 1 \n";
			strSql += " 						   and    substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09') \n";
			strSql += " 						   group by comp_code, clse_acc_id, dept_code, biz_plan_item_no) \n";
			strSql += " 					 ) b2, \n";
			strSql += " 					 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 					 		 sum(plan_amt) c_y_plan_amt19,  \n";
			strSql += " 					 		 sum(exec_amt) c_y_exec_amt19 \n";
			strSql += " 					  from  t_pl_comp_dept_plan_exec \n";
			strSql += " 					  where comp_code =  ?  \n";
			strSql += " 					  and	clse_acc_id =  ?  \n";
			strSql += " 					  and   substr(work_ym, 5,6) in ('01', '02', '03','04','05','06','07','08','09') \n";
			strSql += " 					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 					  ) b3, \n";
			strSql += " 					  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,  \n";
			strSql += " 					  		 sum(plan_amt10) plan_amt10, \n";
			strSql += " 							 sum(forecast_amt10) forecast_amt10, \n";
			strSql += " 							 sum(plan_amt11) plan_amt11, \n";
			strSql += " 							 sum(forecast_amt11) forecast_amt11, \n";
			strSql += " 							 sum(plan_amt12) plan_amt12,  \n";
			strSql += " 							 sum(forecast_amt12) forecast_amt12 \n";
			strSql += " 					  from( \n";
			strSql += " 						  select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 						  		 decode(substr(work_ym, 5,6) ,'10', sum(plan_amt), '') 	   plan_amt10,  \n";
			strSql += " 						  		 decode(substr(work_ym, 5,6) ,'10', sum(forecast_amt), '') forecast_amt10, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'11', sum(plan_amt), '') 	   plan_amt11, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'11', sum(forecast_amt), '') forecast_amt11, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'12', sum(plan_amt), '') 	   plan_amt12, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'12', sum(forecast_amt), '') forecast_amt12 \n";
			strSql += " 						  from   t_pl_comp_dept_plan_exec \n";
			strSql += " 						  where  comp_code =  ?  \n";
			strSql += " 						  and	 clse_acc_id =  ?  \n";
			strSql += " 						  and    substr(work_ym, 5,6) in ('10', '11', '12') \n";
			strSql += " 						  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 						  		   substr(work_ym, 5,6)) \n";
			strSql += " 					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 					  ) b4, \n";
			strSql += " 					 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,  \n";
			strSql += " 					 		 sum(plan_amt) c_y_plan_amt, \n";
			strSql += " 							 sum(forecast_amt) c_y_forecast_amt \n";
			strSql += " 					  from t_pl_comp_dept_plan_exec \n";
			strSql += " 					  where comp_code =  ?  \n";
			strSql += " 					  and	clse_acc_id =  ?  \n";
			strSql += " 					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 					  ) b5, \n";
			strSql += " 					  (select comp_code, clse_acc_id - 1 clse_acc_id, dept_code, biz_plan_item_no, n_y_plan_amt \n";
			strSql += " 					   from \n";
			strSql += " 						  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,  \n";
			strSql += " 						          sum(plan_amt) n_y_plan_amt \n";
			strSql += " 						   from   t_pl_comp_dept_plan_exec \n";
			strSql += " 						   where  comp_code =  ?  \n";
			strSql += " 						   and	  clse_acc_id =  ?  + 1 \n";
			strSql += " 						   group by comp_code, clse_acc_id, dept_code, biz_plan_item_no) \n";
			strSql += " 					  ) b6 \n";
			strSql += " 			  where   b5.comp_code = b1.comp_code(+) \n";
			strSql += " 			  and	  b5.comp_code = b2.comp_code(+) \n";
			strSql += " 			  and	  b5.comp_code = b3.comp_code(+) \n";
			strSql += " 			  and	  b5.comp_code = b4.comp_code(+) \n";
			strSql += " 			  and	  b5.comp_code = b6.comp_code(+) \n";
			strSql += " 			  and	  b5.clse_acc_id = b1.clse_acc_id(+) \n";
			strSql += " 			  and	  b5.clse_acc_id = b2.clse_acc_id(+)  \n";
			strSql += " 			  and	  b5.clse_acc_id = b3.clse_acc_id(+)  \n";
			strSql += " 			  and	  b5.clse_acc_id = b4.clse_acc_id(+) \n";
			strSql += " 			  and	  b5.clse_acc_id = b6.clse_acc_id(+) \n";
			strSql += " 			  and	  b5.dept_code = b1.dept_code(+) \n";
			strSql += " 			  and	  b5.dept_code = b2.dept_code(+)  \n";
			strSql += " 			  and	  b5.dept_code = b3.dept_code(+)  \n";
			strSql += " 			  and	  b5.dept_code = b4.dept_code(+) \n";
			strSql += " 			  and	  b5.dept_code = b6.dept_code(+) \n";
			strSql += " 			  and	  b5.biz_plan_item_no = b1.biz_plan_item_no(+) \n";
			strSql += " 			  and	  b5.biz_plan_item_no = b2.biz_plan_item_no(+) \n";
			strSql += " 			  and	  b5.biz_plan_item_no = b3.biz_plan_item_no(+) \n";
			strSql += " 			  and	  b5.biz_plan_item_no = b4.biz_plan_item_no(+) \n";
			strSql += " 			  and	  b5.biz_plan_item_no = b6.biz_plan_item_no(+) \n";
			strSql += " 			  ) b, \n";
			strSql += " 			  t_dept_code c	   \n";
			strSql += " 		where a.biz_plan_item_no = b.biz_plan_item_no(+) \n";
			strSql += " 		and	  b.dept_code = c.dept_code(+) \n";
			strSql += " 		) b1 \n";
			strSql += " 	where a1.div	   = b1.div(+) \n";
			strSql += " 	and   a1.dept_code = b1.dept_code(+)  \n";
			strSql += " 	order by 2, 1, 5 \n";
			strSql += " 	) ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("5COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("6CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("7COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("8CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("9COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("10CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("11COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("12CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("13COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("14CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("15COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("16CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("17COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("18CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("19COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("20CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("21COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("22CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("23COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("24CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("25COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("26CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("27COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("28CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("29COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("30CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("31COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("32CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("33COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("34CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("35COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("36CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("3COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("4CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("5COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("6CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("7COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("8CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("9COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("10CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("11COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("12CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("13COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("14CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("15COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("16CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("17COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("18CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("19COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("20CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("21COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("22CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("23COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("24CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("25COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("26CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("27COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("28CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("29COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("30CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("31COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("32CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("33COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("34CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("35COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("36CLSE_ACC_ID", strCLSE_ACC_ID);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("COPY"))
		{

			
			strSql  = " select '######' comp_code, \n";
			strSql += " 	   '######' clse_acc_id, \n";
			strSql += " 	   '######' dept_code, \n";
			strSql += " 	   '######' month, \n";
			strSql += " 	   '######' b_clse_acc_id, \n";
			strSql += " 	   '######' n_clse_acc_id, \n";
			strSql += " 	   '######' emp_no \n";
			strSql += " from dual ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","COPY Select 오류-> "+ ex.getMessage());
			}
		}
		
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
			GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
		}
	}
%>