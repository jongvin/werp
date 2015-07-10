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
			
			strSql  = " select  div, \n";
			strSql += " 		a.p_no, \n";
			strSql += " 	    b.biz_plan_item_no, \n";
			strSql += " 	    lpad(' ', (level-1) *2 ) || a.biz_plan_item_name biz_plan_item_name,    \n";
			strSql += " 	    b_y_exec_bg,   \n";
			strSql += " 	    c_y_plan_bg,   \n";
			strSql += " 	    c_y_forecast_bg,   \n";
			strSql += " 		c_plan_rate19,       \n";
			strSql += " 		b_rate19    \n";
			strSql += " from \n";
			strSql += " 	( \n";
			strSql += " 	select  '11' div, \n";
			strSql += " 			a.p_no, \n";
			strSql += " 			a.biz_plan_item_no, \n";
			strSql += " 			biz_plan_item_name, \n";
			strSql += " 			sum(b_y_exec_bg)  b_y_exec_bg,      \n";
			strSql += " 			sum(c_y_plan_bg)  c_y_plan_bg,      \n";
			strSql += " 			sum(c_y_forecast_bg)  c_y_forecast_bg,      \n";
			strSql += " 			sum(c_plan_rate19)   c_plan_rate19,      \n";
			strSql += " 			sum(b_rate19)        b_rate19 \n";
			strSql += " 	from t_pl_item a, \n";
			strSql += " 		 (select  \n";
			strSql += " 				 b3.biz_plan_item_no, \n";
			strSql += " 				 decode(nvl(b_y_exec_bg,0),0, 0, round(b_y_exec_bg/100000000,0)) b_y_exec_bg, \n";
			strSql += " 				 decode(nvl(c_y_plan_bg,0),0, 0, round(c_y_plan_bg/100000000,0)) c_y_plan_bg,  \n";
			strSql += " 		 		 decode(nvl(c_y_forecast_bg,0),0, 0, round(c_y_forecast_bg/100000000,0)) c_y_forecast_bg, \n";
			strSql += " 				 decode(nvl(c_y_plan_bg,0),0, 0, round((nvl(c_y_forecast_bg,0)/nvl(c_y_plan_bg,0))*100,1)) c_plan_rate19, \n";
			strSql += " 				 decode(nvl(b_y_exec_bg,0), 0, 0, round((nvl(c_y_forecast_bg,0)/nvl(b_y_exec_bg,0))*100,1)) b_rate19 \n";
			strSql += " 		  from  \n";
			strSql += " 				  \n";
			strSql += " 				 (select comp_code, clse_acc_id + 1 clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 				 		  b_y_exec_bg \n";
			strSql += " 				  from  \n";
			strSql += " 					  (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 					 		  sum(exec_amt) b_y_exec_bg \n";
			strSql += " 					   from   t_pl_comp_plan_exec \n";
			strSql += " 					   where  comp_code   =  ?  \n";
			strSql += " 					   and	  clse_acc_id =  ?  - 1 \n";
			strSql += " 					   and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 					   group by comp_code, clse_acc_id,  biz_plan_item_no) \n";
			strSql += " 				 ) b2, \n";
			strSql += " 				 (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 				 		 sum(plan_amt) c_y_plan_bg,  \n";
			strSql += " 				 		 sum(forecast_amt) c_y_forecast_bg \n";
			strSql += " 				  from  t_pl_comp_plan_exec \n";
			strSql += " 				  where comp_code =  ?  \n";
			strSql += " 				  and	clse_acc_id =  ?  \n";
			strSql += " 				  and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 				  group by comp_code, clse_acc_id,  biz_plan_item_no \n";
			strSql += " 				 ) b3 \n";
			strSql += "    \n";
			strSql += " 		  where   b3.comp_code = b2.comp_code(+) \n";
			strSql += " 		  and	  b3.clse_acc_id = b2.clse_acc_id(+) \n";
			strSql += " 		  and	  b3.biz_plan_item_no = b2.biz_plan_item_no(+) \n";
			strSql += " 		  ) b \n";
			strSql += " 	where a.biz_plan_item_no = b.biz_plan_item_no(+) \n";
			strSql += " 	group by grouping sets ((a.p_no, \n";
			strSql += " 			 		  	     a.biz_plan_item_no, \n";
			strSql += " 							 biz_plan_item_name), \n";
			strSql += " 							(a.p_no)) \n";
			strSql += " 							 \n";
			strSql += " 	union all \n";
			strSql += " 	 \n";
			strSql += " 	select \n";
			strSql += " 		  '12' div, \n";
			strSql += " 		  b1.p_no, \n";
			strSql += " 	      b1.biz_plan_item_no, \n";
			strSql += " 	      '(%)' biz_plan_item_name, \n";
			strSql += " 		  decode(a1.b_y_exec_bg, 0, 0, round((b1.b_y_exec_bg/a1.b_y_exec_bg)*100,1)) b_y_exec_bg, \n";
			strSql += " 		  decode(a1.c_y_plan_bg, 0, 0, round((b1.c_y_plan_bg/a1.c_y_plan_bg)*100,1)) c_y_plan_bg, \n";
			strSql += " 		  decode(a1.c_y_forecast_bg, 0, 0, round((b1.c_y_forecast_bg/a1.c_y_forecast_bg)*100,1)) c_y_forecast_bg, \n";
			strSql += " 		  0 c_plan_rate19, \n";
			strSql += " 		  0 b_rate19 \n";
			strSql += " 	 from \n";
			strSql += " 	 ( \n";
			strSql += " 	   select \n";
			strSql += " 			 '12' div, \n";
			strSql += " 			 p_no, \n";
			strSql += " 			 b3.biz_plan_item_no, \n";
			strSql += " 			 biz_plan_item_name, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0),0, 0, round(b_y_exec_bg/100000000,0)) b_y_exec_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round(c_y_plan_bg/100000000,0)) c_y_plan_bg, \n";
			strSql += " 	 		 decode(nvl(c_y_forecast_bg,0),0, 0, round(c_y_forecast_bg/100000000,0)) c_y_forecast_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round((nvl(c_y_forecast_bg,0)/nvl(c_y_plan_bg,0))*100,1)) c_plan_rate19, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0), 0, 0, round((nvl(c_y_forecast_bg,0)/nvl(b_y_exec_bg,0))*100,1)) b_rate19 \n";
			strSql += " 	  from \n";
			strSql += " 			  \n";
			strSql += " 			 (select comp_code, clse_acc_id + 1 clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		  b_y_exec_bg \n";
			strSql += " 			  from \n";
			strSql += " 				  (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 				 		  sum(exec_amt) b_y_exec_bg \n";
			strSql += " 				   from   t_pl_comp_plan_exec \n";
			strSql += " 				   where  comp_code   =  ?  \n";
			strSql += " 				   and	  clse_acc_id =  ?  - 1 \n";
			strSql += " 				   and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 				   group by comp_code, clse_acc_id,  biz_plan_item_no) \n";
			strSql += " 			 ) b2, \n";
			strSql += " 			 (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		 sum(plan_amt) c_y_plan_bg, \n";
			strSql += " 			 		 sum(forecast_amt) c_y_forecast_bg \n";
			strSql += " 			  from  t_pl_comp_plan_exec \n";
			strSql += " 			  where comp_code =  ?  \n";
			strSql += " 			  and	clse_acc_id =  ?  \n";
			strSql += " 			  and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 			  group by comp_code, clse_acc_id,  biz_plan_item_no \n";
			strSql += " 			 ) b3, \n";
			strSql += " 			  (select * \n";
			strSql += " 			   from t_pl_item \n";
			strSql += " 			   where biz_plan_item_name = '매출액') c \n";
			strSql += " 	  where   b3.comp_code = b2.comp_code(+) \n";
			strSql += " 	  and	  b3.clse_acc_id = b2.clse_acc_id(+) \n";
			strSql += " 	  and	  b3.biz_plan_item_no = b2.biz_plan_item_no(+) \n";
			strSql += " 	  and	  c.biz_plan_item_no = b3.biz_plan_item_no(+) \n";
			strSql += " 	 ) a1, \n";
			strSql += " 	 ( \n";
			strSql += " 	   select \n";
			strSql += " 			 '12' div, \n";
			strSql += " 			 p_no, \n";
			strSql += " 			 b3.biz_plan_item_no, \n";
			strSql += " 			 biz_plan_item_name, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0),0, 0, round(b_y_exec_bg/100000000,0)) b_y_exec_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round(c_y_plan_bg/100000000,0)) c_y_plan_bg, \n";
			strSql += " 	 		 decode(nvl(c_y_forecast_bg,0),0, 0, round(c_y_forecast_bg/100000000,0)) c_y_forecast_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round((nvl(c_y_forecast_bg,0)/nvl(c_y_plan_bg,0))*100,1)) c_plan_rate19, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0), 0, 0, round((nvl(c_y_forecast_bg,0)/nvl(b_y_exec_bg,0))*100,1)) b_rate19 \n";
			strSql += " 	  from \n";
			strSql += " 			 (select comp_code, clse_acc_id + 1 clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		  b_y_exec_bg \n";
			strSql += " 			  from \n";
			strSql += " 				  (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 				 		  sum(exec_amt) b_y_exec_bg \n";
			strSql += " 				   from   t_pl_comp_plan_exec \n";
			strSql += " 				   where  comp_code   =  ?  \n";
			strSql += " 				   and	  clse_acc_id =  ?  - 1 \n";
			strSql += " 				   and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 				   group by comp_code, clse_acc_id,  biz_plan_item_no) \n";
			strSql += " 			 ) b2, \n";
			strSql += " 			 (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		 sum(plan_amt) c_y_plan_bg, \n";
			strSql += " 			 		 sum(forecast_amt) c_y_forecast_bg \n";
			strSql += " 			  from  t_pl_comp_plan_exec \n";
			strSql += " 			  where comp_code =  ?  \n";
			strSql += " 			  and	clse_acc_id =  ?  \n";
			strSql += " 			  and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 			  group by comp_code, clse_acc_id,  biz_plan_item_no \n";
			strSql += " 			 ) b3, \n";
			strSql += " 			  (select * \n";
			strSql += " 			   from t_pl_item \n";
			strSql += " 			   where biz_plan_item_name = '매출이익') c \n";
			strSql += " 	  where   b3.comp_code = b2.comp_code(+) \n";
			strSql += " 	  and	  b3.clse_acc_id = b2.clse_acc_id(+) \n";
			strSql += " 	  and	  b3.biz_plan_item_no = b2.biz_plan_item_no(+) \n";
			strSql += " 	  and	  c.biz_plan_item_no = b3.biz_plan_item_no(+) \n";
			strSql += " 	 ) b1 \n";
			strSql += " 	 where b1.div = a1.div(+) \n";
			strSql += "  \n";
			strSql += " 	 union all \n";
			strSql += "  \n";
			strSql += " 	 select \n";
			strSql += " 	  '12' div, \n";
			strSql += " 	  b1.p_no, \n";
			strSql += "       b1.biz_plan_item_no, \n";
			strSql += "       '(%)' biz_plan_item_name, \n";
			strSql += " 	  decode(a1.b_y_exec_bg, 0, 0, round((b1.b_y_exec_bg/a1.b_y_exec_bg)*100,1)) b_y_exec_bg, \n";
			strSql += " 	  decode(a1.c_y_plan_bg, 0, 0, round((b1.c_y_plan_bg/a1.c_y_plan_bg)*100,1)) c_y_plan_bg, \n";
			strSql += " 	  decode(a1.c_y_forecast_bg, 0, 0, round((b1.c_y_forecast_bg/a1.c_y_forecast_bg)*100,1)) c_y_forecast_bg, \n";
			strSql += " 	  0 c_plan_rate19, \n";
			strSql += " 	  0 b_rate19 \n";
			strSql += " from \n";
			strSql += " 	 ( \n";
			strSql += " 	   select \n";
			strSql += " 			 '12' div, \n";
			strSql += " 			 p_no, \n";
			strSql += " 			 b3.biz_plan_item_no, \n";
			strSql += " 			 biz_plan_item_name, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0),0, 0, round(b_y_exec_bg/100000000,0)) b_y_exec_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round(c_y_plan_bg/100000000,0)) c_y_plan_bg, \n";
			strSql += " 	 		 decode(nvl(c_y_forecast_bg,0),0, 0, round(c_y_forecast_bg/100000000,0)) c_y_forecast_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round((nvl(c_y_forecast_bg,0)/nvl(c_y_plan_bg,0))*100,1)) c_plan_rate19, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0), 0, 0, round((nvl(c_y_forecast_bg,0)/nvl(b_y_exec_bg,0))*100,1)) b_rate19 \n";
			strSql += " 	  from \n";
			strSql += " 			 (select comp_code, clse_acc_id + 1 clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		  b_y_exec_bg \n";
			strSql += " 			  from \n";
			strSql += " 				  (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 				 		  sum(exec_amt) b_y_exec_bg \n";
			strSql += " 				   from   t_pl_comp_plan_exec \n";
			strSql += " 				   where  comp_code   =  ?  \n";
			strSql += " 				   and	  clse_acc_id =  ?  - 1 \n";
			strSql += " 				   and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 				   group by comp_code, clse_acc_id,  biz_plan_item_no) \n";
			strSql += " 			 ) b2, \n";
			strSql += " 			 (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		 sum(plan_amt) c_y_plan_bg, \n";
			strSql += " 			 		 sum(forecast_amt) c_y_forecast_bg \n";
			strSql += " 			  from  t_pl_comp_plan_exec \n";
			strSql += " 			  where comp_code =  ?  \n";
			strSql += " 			  and	clse_acc_id =  ?  \n";
			strSql += " 			  and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 			  group by comp_code, clse_acc_id,  biz_plan_item_no \n";
			strSql += " 			 ) b3, \n";
			strSql += " 			  (select * \n";
			strSql += " 			   from t_pl_item \n";
			strSql += " 			   where biz_plan_item_name = '매출액') c \n";
			strSql += " 	  where   b3.comp_code = b2.comp_code(+) \n";
			strSql += " 	  and	  b3.clse_acc_id = b2.clse_acc_id(+) \n";
			strSql += " 	  and	  b3.biz_plan_item_no = b2.biz_plan_item_no(+) \n";
			strSql += " 	  and	  c.biz_plan_item_no = b3.biz_plan_item_no(+) \n";
			strSql += " 	 ) a1, \n";
			strSql += " 	 ( \n";
			strSql += " 	   select \n";
			strSql += " 			 '12' div, \n";
			strSql += " 			 p_no, \n";
			strSql += " 			 b3.biz_plan_item_no, \n";
			strSql += " 			 biz_plan_item_name, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0),0, 0, round(b_y_exec_bg/100000000,0)) b_y_exec_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round(c_y_plan_bg/100000000,0)) c_y_plan_bg, \n";
			strSql += " 	 		 decode(nvl(c_y_forecast_bg,0),0, 0, round(c_y_forecast_bg/100000000,0)) c_y_forecast_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round((nvl(c_y_forecast_bg,0)/nvl(c_y_plan_bg,0))*100,1)) c_plan_rate19, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0), 0, 0, round((nvl(c_y_forecast_bg,0)/nvl(b_y_exec_bg,0))*100,1)) b_rate19 \n";
			strSql += " 	  from \n";
			strSql += " 			 (select comp_code, clse_acc_id + 1 clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		  b_y_exec_bg \n";
			strSql += " 			  from \n";
			strSql += " 				  (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 				 		  sum(exec_amt) b_y_exec_bg \n";
			strSql += " 				   from   t_pl_comp_plan_exec \n";
			strSql += " 				   where  comp_code   =  ?  \n";
			strSql += " 				   and	  clse_acc_id =  ?  - 1 \n";
			strSql += " 				   and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 				   group by comp_code, clse_acc_id,  biz_plan_item_no) \n";
			strSql += " 			 ) b2, \n";
			strSql += " 			 (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		 sum(plan_amt) c_y_plan_bg, \n";
			strSql += " 			 		 sum(forecast_amt) c_y_forecast_bg \n";
			strSql += " 			  from  t_pl_comp_plan_exec \n";
			strSql += " 			  where comp_code =  ?  \n";
			strSql += " 			  and	clse_acc_id =  ?  \n";
			strSql += " 			  and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 			  group by comp_code, clse_acc_id,  biz_plan_item_no \n";
			strSql += " 			 ) b3, \n";
			strSql += " 			  (select * \n";
			strSql += " 			   from t_pl_item \n";
			strSql += " 			   where biz_plan_item_name = '영업이익') c \n";
			strSql += " 	  where   b3.comp_code = b2.comp_code(+) \n";
			strSql += " 	  and	  b3.clse_acc_id = b2.clse_acc_id(+) \n";
			strSql += " 	  and	  b3.biz_plan_item_no = b2.biz_plan_item_no(+) \n";
			strSql += " 	  and	  c.biz_plan_item_no = b3.biz_plan_item_no(+) \n";
			strSql += " 	 ) b1 \n";
			strSql += " 	 where b1.div = a1.div(+) \n";
			strSql += " 	  \n";
			strSql += " 	 union all \n";
			strSql += "  \n";
			strSql += " 	 select \n";
			strSql += " 	  '12' div, \n";
			strSql += " 	  b1.p_no, \n";
			strSql += "       b1.biz_plan_item_no, \n";
			strSql += "       '(%)' biz_plan_item_name, \n";
			strSql += " 	  decode(a1.b_y_exec_bg, 0, 0, round((b1.b_y_exec_bg/a1.b_y_exec_bg)*100,1)) b_y_exec_bg, \n";
			strSql += " 	  decode(a1.c_y_plan_bg, 0, 0, round((b1.c_y_plan_bg/a1.c_y_plan_bg)*100,1)) c_y_plan_bg, \n";
			strSql += " 	  decode(a1.c_y_forecast_bg, 0, 0, round((b1.c_y_forecast_bg/a1.c_y_forecast_bg)*100,1)) c_y_forecast_bg, \n";
			strSql += " 	  0 c_plan_rate19, \n";
			strSql += " 	  0 b_rate19 \n";
			strSql += " from \n";
			strSql += " 	 ( \n";
			strSql += " 	   select \n";
			strSql += " 			 '12' div, \n";
			strSql += " 			 p_no, \n";
			strSql += " 			 b3.biz_plan_item_no, \n";
			strSql += " 			 biz_plan_item_name, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0),0, 0, round(b_y_exec_bg/100000000,0)) b_y_exec_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round(c_y_plan_bg/100000000,0)) c_y_plan_bg, \n";
			strSql += " 	 		 decode(nvl(c_y_forecast_bg,0),0, 0, round(c_y_forecast_bg/100000000,0)) c_y_forecast_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round((nvl(c_y_forecast_bg,0)/nvl(c_y_plan_bg,0))*100,1)) c_plan_rate19, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0), 0, 0, round((nvl(c_y_forecast_bg,0)/nvl(b_y_exec_bg,0))*100,1)) b_rate19 \n";
			strSql += " 	  from \n";
			strSql += " 			 (select comp_code, clse_acc_id + 1 clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		  b_y_exec_bg \n";
			strSql += " 			  from \n";
			strSql += " 				  (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 				 		  sum(exec_amt) b_y_exec_bg \n";
			strSql += " 				   from   t_pl_comp_plan_exec \n";
			strSql += " 				   where  comp_code   =  ?  \n";
			strSql += " 				   and	  clse_acc_id =  ?  - 1 \n";
			strSql += " 				   and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 				   group by comp_code, clse_acc_id,  biz_plan_item_no) \n";
			strSql += " 			 ) b2, \n";
			strSql += " 			 (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		 sum(plan_amt) c_y_plan_bg, \n";
			strSql += " 			 		 sum(forecast_amt) c_y_forecast_bg \n";
			strSql += " 			  from  t_pl_comp_plan_exec \n";
			strSql += " 			  where comp_code =  ?  \n";
			strSql += " 			  and	clse_acc_id =  ?  \n";
			strSql += " 			  and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 			  group by comp_code, clse_acc_id,  biz_plan_item_no \n";
			strSql += " 			 ) b3, \n";
			strSql += " 			  (select * \n";
			strSql += " 			   from t_pl_item \n";
			strSql += " 			   where biz_plan_item_name = '매출액') c \n";
			strSql += " 	  where   b3.comp_code = b2.comp_code(+) \n";
			strSql += " 	  and	  b3.clse_acc_id = b2.clse_acc_id(+) \n";
			strSql += " 	  and	  b3.biz_plan_item_no = b2.biz_plan_item_no(+) \n";
			strSql += " 	  and	  c.biz_plan_item_no = b3.biz_plan_item_no(+) \n";
			strSql += " 	 ) a1, \n";
			strSql += " 	 ( \n";
			strSql += " 	   select \n";
			strSql += " 			 '12' div, \n";
			strSql += " 			 p_no, \n";
			strSql += " 			 b3.biz_plan_item_no, \n";
			strSql += " 			 biz_plan_item_name, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0),0, 0, round(b_y_exec_bg/100000000,0)) b_y_exec_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round(c_y_plan_bg/100000000,0)) c_y_plan_bg, \n";
			strSql += " 	 		 decode(nvl(c_y_forecast_bg,0),0, 0, round(c_y_forecast_bg/100000000,0)) c_y_forecast_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round((nvl(c_y_forecast_bg,0)/nvl(c_y_plan_bg,0))*100,1)) c_plan_rate19, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0), 0, 0, round((nvl(c_y_forecast_bg,0)/nvl(b_y_exec_bg,0))*100,1)) b_rate19 \n";
			strSql += " 	  from \n";
			strSql += " 			  \n";
			strSql += " 			 (select comp_code, clse_acc_id + 1 clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		  b_y_exec_bg \n";
			strSql += " 			  from \n";
			strSql += " 				  (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 				 		  sum(exec_amt) b_y_exec_bg \n";
			strSql += " 				   from   t_pl_comp_plan_exec \n";
			strSql += " 				   where  comp_code   =  ?  \n";
			strSql += " 				   and	  clse_acc_id =  ?  - 1 \n";
			strSql += " 				   and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 				   group by comp_code, clse_acc_id,  biz_plan_item_no) \n";
			strSql += " 			 ) b2, \n";
			strSql += " 			 (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		 sum(plan_amt) c_y_plan_bg, \n";
			strSql += " 			 		 sum(forecast_amt) c_y_forecast_bg \n";
			strSql += " 			  from  t_pl_comp_plan_exec \n";
			strSql += " 			  where comp_code =  ?  \n";
			strSql += " 			  and	clse_acc_id =  ?  \n";
			strSql += " 			  and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 			  group by comp_code, clse_acc_id,  biz_plan_item_no \n";
			strSql += " 			 ) b3, \n";
			strSql += " 			  (select * \n";
			strSql += " 			   from t_pl_item \n";
			strSql += " 			   where biz_plan_item_name = '경상이익') c \n";
			strSql += " 	  where   b3.comp_code = b2.comp_code(+) \n";
			strSql += " 	  and	  b3.clse_acc_id = b2.clse_acc_id(+) \n";
			strSql += " 	  and	  b3.biz_plan_item_no = b2.biz_plan_item_no(+) \n";
			strSql += " 	  and	  c.biz_plan_item_no = b3.biz_plan_item_no(+) \n";
			strSql += " 	 ) b1 \n";
			strSql += " 	 where b1.div = a1.div(+) \n";
			strSql += " 	  \n";
			strSql += " 	 union all \n";
			strSql += "  \n";
			strSql += " 	 select \n";
			strSql += " 	  '12' div, \n";
			strSql += " 	  b1.p_no, \n";
			strSql += "       b1.biz_plan_item_no, \n";
			strSql += "       '(%)' biz_plan_item_name, \n";
			strSql += " 	  decode(a1.b_y_exec_bg, 0, 0, round((b1.b_y_exec_bg/a1.b_y_exec_bg)*100,1)) b_y_exec_bg, \n";
			strSql += " 	  decode(a1.c_y_plan_bg, 0, 0, round((b1.c_y_plan_bg/a1.c_y_plan_bg)*100,1)) c_y_plan_bg, \n";
			strSql += " 	  decode(a1.c_y_forecast_bg, 0, 0, round((b1.c_y_forecast_bg/a1.c_y_forecast_bg)*100,1)) c_y_forecast_bg, \n";
			strSql += " 	  0 c_plan_rate19, \n";
			strSql += " 	  0 b_rate19 \n";
			strSql += " 	  from \n";
			strSql += " 	 ( \n";
			strSql += " 	   select \n";
			strSql += " 			 '12' div, \n";
			strSql += " 			 p_no, \n";
			strSql += " 			 b3.biz_plan_item_no, \n";
			strSql += " 			 biz_plan_item_name, \n";
			strSql += " 			 decode(nvl(b_y_exec_amt,0), 0, 0, round(b_y_exec_amt/100000000,0))  b_y_exec_amt, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0),0, 0, round(b_y_exec_bg/100000000,0)) b_y_exec_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round(c_y_plan_bg/100000000,0)) c_y_plan_bg, \n";
			strSql += " 	 		 decode(nvl(c_y_forecast_bg,0),0, 0, round(c_y_forecast_bg/100000000,0)) c_y_forecast_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round((nvl(c_y_forecast_bg,0)/nvl(c_y_plan_bg,0))*100,1)) c_plan_rate19, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0), 0, 0, round((nvl(c_y_forecast_bg,0)/nvl(b_y_exec_bg,0))*100,1)) b_rate19 \n";
			strSql += " 	  from \n";
			strSql += " 			 (select comp_code, clse_acc_id + 1 clse_acc_id, \n";
			strSql += " 		 		  biz_plan_item_no,  b_y_exec_amt \n";
			strSql += " 			  from \n";
			strSql += " 				 (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 				 		 sum(exec_amt) b_y_exec_amt \n";
			strSql += " 				  from t_pl_comp_plan_exec \n";
			strSql += " 				  where comp_code =  ?  \n";
			strSql += " 				  and	clse_acc_id =  ?  - 1 \n";
			strSql += " 				  group by comp_code, clse_acc_id, biz_plan_item_no) \n";
			strSql += " 			  ) b1, \n";
			strSql += " 			 (select comp_code, clse_acc_id + 1 clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		  b_y_exec_bg \n";
			strSql += " 			  from \n";
			strSql += " 				  (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 				 		  sum(exec_amt) b_y_exec_bg \n";
			strSql += " 				   from   t_pl_comp_plan_exec \n";
			strSql += " 				   where  comp_code   =  ?  \n";
			strSql += " 				   and	  clse_acc_id =  ?  - 1 \n";
			strSql += " 				   and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 				   group by comp_code, clse_acc_id,  biz_plan_item_no) \n";
			strSql += " 			 ) b2, \n";
			strSql += " 			 (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		 sum(plan_amt) c_y_plan_bg, \n";
			strSql += " 			 		 sum(forecast_amt) c_y_forecast_bg \n";
			strSql += " 			  from  t_pl_comp_plan_exec \n";
			strSql += " 			  where comp_code =  ?  \n";
			strSql += " 			  and	clse_acc_id =  ?  \n";
			strSql += " 			  and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 			  group by comp_code, clse_acc_id,  biz_plan_item_no \n";
			strSql += " 			 ) b3, \n";
			strSql += " 			   \n";
			strSql += " 			  (select * \n";
			strSql += " 			   from t_pl_item \n";
			strSql += " 			   where biz_plan_item_name = '매출액') c \n";
			strSql += " 	  where   b3.comp_code = b2.comp_code(+) \n";
			strSql += " 	  and	  b3.clse_acc_id = b2.clse_acc_id(+) \n";
			strSql += " 	  and	  b3.biz_plan_item_no = b2.biz_plan_item_no(+) \n";
			strSql += " 	  and	  c.biz_plan_item_no = b3.biz_plan_item_no(+) \n";
			strSql += " 	 ) a1, \n";
			strSql += " 	 ( \n";
			strSql += " 	   select \n";
			strSql += " 			 '12' div, \n";
			strSql += " 			 p_no, \n";
			strSql += " 			 b3.biz_plan_item_no, \n";
			strSql += " 			 biz_plan_item_name, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0),0, 0, round(b_y_exec_bg/100000000,0)) b_y_exec_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round(c_y_plan_bg/100000000,0)) c_y_plan_bg, \n";
			strSql += " 	 		 decode(nvl(c_y_forecast_bg,0),0, 0, round(c_y_forecast_bg/100000000,0)) c_y_forecast_bg, \n";
			strSql += " 			 decode(nvl(c_y_plan_bg,0),0, 0, round((nvl(c_y_forecast_bg,0)/nvl(c_y_plan_bg,0))*100,1)) c_plan_rate19, \n";
			strSql += " 			 decode(nvl(b_y_exec_bg,0), 0, 0, round((nvl(c_y_forecast_bg,0)/nvl(b_y_exec_bg,0))*100,1)) b_rate19 \n";
			strSql += " 	  from \n";
			strSql += " 			 \n";
			strSql += " 			 (select comp_code, clse_acc_id + 1 clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		  b_y_exec_bg \n";
			strSql += " 			  from \n";
			strSql += " 				  (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 				 		  sum(exec_amt) b_y_exec_bg \n";
			strSql += " 				   from   t_pl_comp_plan_exec \n";
			strSql += " 				   where  comp_code   =  ?  \n";
			strSql += " 				   and	  clse_acc_id =  ?  - 1 \n";
			strSql += " 				   and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 				   group by comp_code, clse_acc_id,  biz_plan_item_no) \n";
			strSql += " 			 ) b2, \n";
			strSql += " 			 (select comp_code, clse_acc_id,  biz_plan_item_no, \n";
			strSql += " 			 		 sum(plan_amt) c_y_plan_bg, \n";
			strSql += " 			 		 sum(forecast_amt) c_y_forecast_bg \n";
			strSql += " 			  from  t_pl_comp_plan_exec \n";
			strSql += " 			  where comp_code =  ?  \n";
			strSql += " 			  and	clse_acc_id =  ?  \n";
			strSql += " 			  and    substr(work_ym, 5,6) in ('01','02','03','04','05','06','07','08','09','10','11','12') \n";
			strSql += " 			  group by comp_code, clse_acc_id,  biz_plan_item_no \n";
			strSql += " 			 ) b3, \n";
			strSql += " 			  (select * \n";
			strSql += " 			   from t_pl_item \n";
			strSql += " 			   where biz_plan_item_name = '세전이익') c \n";
			strSql += " 	  where   b3.comp_code = b2.comp_code(+) \n";
			strSql += " 	  and	  b3.clse_acc_id = b2.clse_acc_id(+) \n";
			strSql += " 	  and	  b3.biz_plan_item_no = b2.biz_plan_item_no(+) \n";
			strSql += " 	  and	  c.biz_plan_item_no = b3.biz_plan_item_no(+) \n";
			strSql += " 	 ) b1 \n";
			strSql += " 	 where b1.div = a1.div(+) \n";
			strSql += " 	)	a, \n";
			strSql += " 	(select * \n";
			strSql += " 	from t_pl_item \n";
			strSql += " 	where level_tag in ('1','2')) b \n";
			strSql += " where b.biz_plan_item_no = a.biz_plan_item_no					 \n";
			strSql += " start with a.p_no = '0' \n";
			strSql += " connect by prior a.biz_plan_item_no = a.p_no \n";
			strSql += " order siblings by item_level_seq \n";
			strSql += "  ";
			
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
			lrArgData.addColumn("37COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("38CLSE_ACC_ID", CITData.VARCHAR2);
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
			lrArgData.setValue("37COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("38CLSE_ACC_ID", strCLSE_ACC_ID);
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
			strSql += " 	   '######' bungi, \n";
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