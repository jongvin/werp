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
			
			strSql  = " select div, \n";
			strSql += " 	   dept_code, \n";
			strSql += " 	   dept_name, \n";
			strSql += " 	   biz_plan_item_no, \n";
			strSql += " 	   biz_plan_item_name,  \n";
			strSql += " 	   b_y_exec_amt, \n";
			strSql += " 	   c_y_exec_amt, \n";
			strSql += " 	   bc_y_dif_exec_amt, \n";
			strSql += " 	   exec_amt01, \n";
			strSql += " 	   exec_amt02, \n";
			strSql += " 	   exec_amt03, \n";
			strSql += " 	   exec_amt04, \n";
			strSql += " 	   exec_amt05, \n";
			strSql += " 	   exec_amt06, \n";
			strSql += " 	   exec_amt121, \n";
			strSql += " 	   exec_amt07, \n";
			strSql += " 	   exec_amt08, \n";
			strSql += " 	   exec_amt09, \n";
			strSql += " 	   exec_amt10, \n";
			strSql += " 	   exec_amt11, \n";
			strSql += " 	   exec_amt12, \n";
			strSql += " 	   exec_amt122 \n";
			strSql += " from \n";
			strSql += " 	( \n";
			strSql += " 	select '11' div, \n";
			strSql += " 		   b.dept_code, \n";
			strSql += " 		   dept_name, \n";
			strSql += " 		   b.biz_plan_item_no, \n";
			strSql += " 		   biz_plan_item_name,  \n";
			strSql += " 		   b_y_exec_amt, \n";
			strSql += " 		   c_y_exec_amt, \n";
			strSql += " 		   bc_y_dif_exec_amt, \n";
			strSql += " 		   exec_amt01, \n";
			strSql += " 		   exec_amt02, \n";
			strSql += " 		   exec_amt03, \n";
			strSql += " 		   exec_amt04, \n";
			strSql += " 		   exec_amt05, \n";
			strSql += " 		   exec_amt06, \n";
			strSql += " 		   exec_amt121, \n";
			strSql += " 		   exec_amt07, \n";
			strSql += " 		   exec_amt08, \n";
			strSql += " 		   exec_amt09, \n";
			strSql += " 		   exec_amt10, \n";
			strSql += " 		   exec_amt11, \n";
			strSql += " 		   exec_amt12, \n";
			strSql += " 		   exec_amt122 \n";
			strSql += " 	from (select * \n";
			strSql += " 		  from t_pl_item \n";
			strSql += " 		  where mng_code in('매출액','매출이익')) a, \n";
			strSql += " 		 (select  \n";
			strSql += " 		 		 b2.dept_code, \n";
			strSql += " 			     b2.biz_plan_item_no, \n";
			strSql += " 			     decode(nvl(b_y_exec_amt,0),0, 0, round(b_y_exec_amt/1000000,0)) b_y_exec_amt, \n";
			strSql += " 			     decode(nvl(c_y_exec_amt,0),0, 0, round(c_y_exec_amt/1000000,0)) c_y_exec_amt, \n";
			strSql += " 			     decode(nvl(c_y_exec_amt,0),0, 0, round(c_y_exec_amt/1000000,0)) - decode(nvl(b_y_exec_amt,0),0, 0, round(b_y_exec_amt/1000000,0)) bc_y_dif_exec_amt, \n";
			strSql += " 				 decode(nvl(exec_amt01,0), 0, 0, round(exec_amt01/1000000,0)) exec_amt01, \n";
			strSql += " 			     decode(nvl(exec_amt02,0), 0, 0, round(exec_amt02/1000000,0)) exec_amt02,  \n";
			strSql += " 			     decode(nvl(exec_amt03,0), 0, 0, round(exec_amt03/1000000,0)) exec_amt03,  \n";
			strSql += " 			     decode(nvl(exec_amt04,0), 0, 0, round(exec_amt04/1000000,0)) exec_amt04, \n";
			strSql += " 			     decode(nvl(exec_amt05,0), 0, 0, round(exec_amt05/1000000,0)) exec_amt05,  \n";
			strSql += " 			     decode(nvl(exec_amt06,0), 0, 0, round(exec_amt06/1000000,0)) exec_amt06, \n";
			strSql += " 				 decode(nvl(exec_amt01,0), 0, 0, round(exec_amt01/1000000,0)) + decode(nvl(exec_amt02,0), 0, 0, round(exec_amt02/1000000,0)) + \n";
			strSql += " 				 decode(nvl(exec_amt03,0), 0, 0, round(exec_amt03/1000000,0)) + decode(nvl(exec_amt04,0), 0, 0, round(exec_amt04/1000000,0)) + \n";
			strSql += " 				 decode(nvl(exec_amt05,0), 0, 0, round(exec_amt05/1000000,0)) + decode(nvl(exec_amt06,0), 0, 0, round(exec_amt06/1000000,0)) exec_amt121, \n";
			strSql += " 				 decode(nvl(exec_amt07,0), 0, 0, round(exec_amt07/1000000,0)) exec_amt07, \n";
			strSql += " 				 decode(nvl(exec_amt08,0), 0, 0, round(exec_amt08/1000000,0)) exec_amt08,  \n";
			strSql += " 				 decode(nvl(exec_amt09,0), 0, 0, round(exec_amt09/1000000,0)) exec_amt09,  \n";
			strSql += " 				 decode(nvl(exec_amt10,0), 0, 0, round(exec_amt10/1000000,0)) exec_amt10, \n";
			strSql += " 				 decode(nvl(exec_amt11,0), 0, 0, round(exec_amt11/1000000,0)) exec_amt11,  \n";
			strSql += " 				 decode(nvl(exec_amt12,0), 0, 0, round(exec_amt12/1000000,0)) exec_amt12, \n";
			strSql += " 				 decode(nvl(exec_amt07,0), 0, 0, round(exec_amt07/1000000,0)) + decode(nvl(exec_amt08,0), 0, 0, round(exec_amt08/1000000,0)) +  \n";
			strSql += " 				 decode(nvl(exec_amt09,0), 0, 0, round(exec_amt09/1000000,0)) + decode(nvl(exec_amt10,0), 0, 0, round(exec_amt10/1000000,0)) + \n";
			strSql += " 				 decode(nvl(exec_amt11,0), 0, 0, round(exec_amt11/1000000,0)) + decode(nvl(exec_amt12,0), 0, 0, round(exec_amt12/1000000,0)) exec_amt122 \n";
			strSql += " 		  from  \n";
			strSql += " 			 (select comp_code, clse_acc_id + 1 clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 					 		  b_y_exec_amt \n";
			strSql += " 			  from  \n";
			strSql += " 				   (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 						   sum(exec_amt) b_y_exec_amt \n";
			strSql += " 				    from   t_pl_comp_dept_plan_exec \n";
			strSql += " 					where  comp_code   =  ?  \n";
			strSql += " 					and	   clse_acc_id =  ?  - 1 \n";
			strSql += " 					and   substr(work_ym, 1,4) =  ? -1 \n";
			strSql += " 					group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 				   ) \n";
			strSql += " 			 ) b1, \n";
			strSql += " 			(select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 					sum(exec_amt) c_y_exec_amt  \n";
			strSql += " 			 from   t_pl_comp_dept_plan_exec \n";
			strSql += " 			 where  comp_code =  ?  \n";
			strSql += " 			 and	clse_acc_id =  ?  \n";
			strSql += " 			 and   substr(work_ym, 1,4) =  ?  \n";
			strSql += " 			 group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 			) b2, \n";
			strSql += " 			(select comp_code, clse_acc_id, dept_code, biz_plan_item_no,  \n";
			strSql += " 					sum(exec_amt01) exec_amt01, \n";
			strSql += " 					sum(exec_amt02) exec_amt02, \n";
			strSql += " 					sum(exec_amt03) exec_amt03, \n";
			strSql += " 					sum(exec_amt04) exec_amt04, \n";
			strSql += " 					sum(exec_amt05) exec_amt05, \n";
			strSql += " 					sum(exec_amt06) exec_amt06, \n";
			strSql += " 					sum(exec_amt07) exec_amt07, \n";
			strSql += " 					sum(exec_amt08) exec_amt08, \n";
			strSql += " 					sum(exec_amt09) exec_amt09, \n";
			strSql += " 					sum(exec_amt10) exec_amt10, \n";
			strSql += " 				    sum(exec_amt11) exec_amt11, \n";
			strSql += " 					sum(exec_amt12) exec_amt12  \n";
			strSql += " 			from \n";
			strSql += " 				( \n";
			strSql += " 				select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 					   decode(substr(work_ym, 5,6) ,'01', sum(exec_amt), '') 	   exec_amt01,  \n";
			strSql += " 					   decode(substr(work_ym, 5,6) ,'02', sum(exec_amt), '') 	   exec_amt02, \n";
			strSql += " 					   decode(substr(work_ym, 5,6) ,'03', sum(exec_amt), '') 	   exec_amt03, \n";
			strSql += " 					   decode(substr(work_ym, 5,6) ,'04', sum(exec_amt), '') 	   exec_amt04,  \n";
			strSql += " 					   decode(substr(work_ym, 5,6) ,'05', sum(exec_amt), '') 	   exec_amt05, \n";
			strSql += " 					   decode(substr(work_ym, 5,6) ,'06', sum(exec_amt), '') 	   exec_amt06, \n";
			strSql += " 					   decode(substr(work_ym, 5,6) ,'07', sum(exec_amt), '') 	   exec_amt07,  \n";
			strSql += " 					   decode(substr(work_ym, 5,6) ,'08', sum(exec_amt), '') 	   exec_amt08, \n";
			strSql += " 					   decode(substr(work_ym, 5,6) ,'09', sum(exec_amt), '') 	   exec_amt09, \n";
			strSql += " 					   decode(substr(work_ym, 5,6) ,'10', sum(exec_amt), '') 	   exec_amt10,  \n";
			strSql += " 					   decode(substr(work_ym, 5,6) ,'11', sum(exec_amt), '') 	   exec_amt11, \n";
			strSql += " 					   decode(substr(work_ym, 5,6) ,'12', sum(exec_amt), '') 	   exec_amt12 \n";
			strSql += " 				from   t_pl_comp_dept_plan_exec \n";
			strSql += " 				where  comp_code =  ?  \n";
			strSql += " 				and	   clse_acc_id =  ?  \n";
			strSql += " 				and   substr(work_ym, 1,4) =  ?  \n";
			strSql += " 				group by comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 						 substr(work_ym, 5,6)) \n";
			strSql += " 				group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 		       ) b3 \n";
			strSql += " 		  where   b2.comp_code = b1.comp_code(+) \n";
			strSql += " 		  and	  b2.comp_code = b3.comp_code(+) \n";
			strSql += " 		  and	  b2.clse_acc_id = b1.clse_acc_id(+) \n";
			strSql += " 		  and	  b2.clse_acc_id = b3.clse_acc_id(+)  \n";
			strSql += " 		  and	  b2.dept_code = b1.dept_code(+) \n";
			strSql += " 		  and	  b2.dept_code = b3.dept_code(+)  \n";
			strSql += " 		  and	  b2.biz_plan_item_no = b1.biz_plan_item_no(+) \n";
			strSql += " 		  and	  b2.biz_plan_item_no = b3.biz_plan_item_no(+) \n";
			strSql += " 		  ) b, \n";
			strSql += " 		  t_dept_code c	   \n";
			strSql += " 	where a.biz_plan_item_no = b.biz_plan_item_no(+) \n";
			strSql += " 	and	  b.dept_code = c.dept_code \n";
			strSql += " 	 \n";
			strSql += " 	union all \n";
			strSql += " 	 \n";
			strSql += " 	select b1.div, \n";
			strSql += " 		   b1.dept_code, \n";
			strSql += " 		   b1.dept_name, \n";
			strSql += " 		   b1.biz_plan_item_no, \n";
			strSql += " 		   '(%)' biz_plan_item_name,  \n";
			strSql += " 		   decode(a1.b_y_exec_amt, 0, 0, round((b1.b_y_exec_amt/a1.b_y_exec_amt)*100, 2)) b_y_exec_amt, \n";
			strSql += " 		   decode(a1.c_y_exec_amt, 0, 0, round((b1.c_y_exec_amt/a1.c_y_exec_amt)*100, 2)) c_y_exec_amt, \n";
			strSql += " 		   decode(a1.bc_y_dif_exec_amt, 0, 0, round((b1.bc_y_dif_exec_amt/a1.bc_y_dif_exec_amt)*100, 2)) bc_y_dif_exec_amt, \n";
			strSql += " 		   decode(a1.exec_amt01, 0, 0, round((b1.exec_amt01/a1.exec_amt01)*100, 2)) exec_amt01, \n";
			strSql += " 		   decode(a1.exec_amt02, 0, 0, round((b1.exec_amt02/a1.exec_amt02)*100, 2)) exec_amt02, \n";
			strSql += " 		   decode(a1.exec_amt03, 0, 0, round((b1.exec_amt03/a1.exec_amt03)*100, 2)) exec_amt03, \n";
			strSql += " 		   decode(a1.exec_amt04, 0, 0, round((b1.exec_amt04/a1.exec_amt04)*100, 2)) exec_amt04, \n";
			strSql += " 		   decode(a1.exec_amt05, 0, 0, round((b1.exec_amt05/a1.exec_amt05)*100, 2)) exec_amt05, \n";
			strSql += " 		   decode(a1.exec_amt06, 0, 0, round((b1.exec_amt06/a1.exec_amt06)*100, 2)) exec_amt06, \n";
			strSql += " 		   decode(a1.exec_amt121, 0, 0, round((b1.exec_amt121/a1.exec_amt121)*100, 2)) exec_amt121, \n";
			strSql += " 		   decode(a1.exec_amt07, 0, 0, round((b1.exec_amt07/a1.exec_amt07)*100, 2)) exec_amt07, \n";
			strSql += " 		   decode(a1.exec_amt08, 0, 0, round((b1.exec_amt08/a1.exec_amt08)*100, 2)) exec_amt08, \n";
			strSql += " 		   decode(a1.exec_amt09, 0, 0, round((b1.exec_amt09/a1.exec_amt09)*100, 2)) exec_amt09, \n";
			strSql += " 		   decode(a1.exec_amt10, 0, 0, round((b1.exec_amt10/a1.exec_amt10)*100, 2)) exec_amt10, \n";
			strSql += " 		   decode(a1.exec_amt11, 0, 0, round((b1.exec_amt11/a1.exec_amt11)*100, 2)) exec_amt11, \n";
			strSql += " 		   decode(a1.exec_amt12, 0, 0, round((b1.exec_amt12/a1.exec_amt12)*100, 2)) exec_amt12, \n";
			strSql += " 		   decode(a1.exec_amt122, 0, 0, round((b1.exec_amt122/a1.exec_amt122)*100, 2)) exec_amt122 \n";
			strSql += " 	from \n";
			strSql += " 		(	    \n";
			strSql += " 		select '12' div, \n";
			strSql += " 			   b.dept_code, \n";
			strSql += " 			   dept_name, \n";
			strSql += " 			   b.biz_plan_item_no, \n";
			strSql += " 			   biz_plan_item_name,  \n";
			strSql += " 			   b_y_exec_amt, \n";
			strSql += " 			   c_y_exec_amt, \n";
			strSql += " 			   bc_y_dif_exec_amt, \n";
			strSql += " 			   exec_amt01, \n";
			strSql += " 			   exec_amt02, \n";
			strSql += " 			   exec_amt03, \n";
			strSql += " 			   exec_amt04, \n";
			strSql += " 			   exec_amt05, \n";
			strSql += " 			   exec_amt06, \n";
			strSql += " 			   exec_amt121, \n";
			strSql += " 			   exec_amt07, \n";
			strSql += " 			   exec_amt08, \n";
			strSql += " 			   exec_amt09, \n";
			strSql += " 			   exec_amt10, \n";
			strSql += " 			   exec_amt11, \n";
			strSql += " 			   exec_amt12, \n";
			strSql += " 			   exec_amt122 \n";
			strSql += " 		from (select * \n";
			strSql += " 			  from t_pl_item \n";
			strSql += " 			  where mng_code ='매출액') a, \n";
			strSql += " 			 (select  \n";
			strSql += " 			 		 b2.dept_code, \n";
			strSql += " 					 b2.biz_plan_item_no, \n";
			strSql += " 					 decode(nvl(b_y_exec_amt,0),0, 0, round(b_y_exec_amt/1000000,0)) b_y_exec_amt, \n";
			strSql += " 					 decode(nvl(c_y_exec_amt,0),0, 0, round(c_y_exec_amt/1000000,0)) c_y_exec_amt, \n";
			strSql += " 					 decode(nvl(c_y_exec_amt,0),0, 0, round(c_y_exec_amt/1000000,0)) - decode(nvl(b_y_exec_amt,0),0, 0, round(b_y_exec_amt/1000000,0)) bc_y_dif_exec_amt, \n";
			strSql += " 					 decode(nvl(exec_amt01,0), 0, 0, round(exec_amt01/1000000,0)) exec_amt01, \n";
			strSql += " 					 decode(nvl(exec_amt02,0), 0, 0, round(exec_amt02/1000000,0)) exec_amt02,  \n";
			strSql += " 					 decode(nvl(exec_amt03,0), 0, 0, round(exec_amt03/1000000,0)) exec_amt03,  \n";
			strSql += " 					 decode(nvl(exec_amt04,0), 0, 0, round(exec_amt04/1000000,0)) exec_amt04, \n";
			strSql += " 					 decode(nvl(exec_amt05,0), 0, 0, round(exec_amt05/1000000,0)) exec_amt05,  \n";
			strSql += " 					 decode(nvl(exec_amt06,0), 0, 0, round(exec_amt06/1000000,0)) exec_amt06, \n";
			strSql += " 					 decode(nvl(exec_amt01,0), 0, 0, round(exec_amt01/1000000,0)) + decode(nvl(exec_amt02,0), 0, 0, round(exec_amt02/1000000,0)) + \n";
			strSql += " 					 decode(nvl(exec_amt03,0), 0, 0, round(exec_amt03/1000000,0)) + decode(nvl(exec_amt04,0), 0, 0, round(exec_amt04/1000000,0)) + \n";
			strSql += " 					 decode(nvl(exec_amt05,0), 0, 0, round(exec_amt05/1000000,0)) + decode(nvl(exec_amt06,0), 0, 0, round(exec_amt06/1000000,0)) exec_amt121, \n";
			strSql += " 					 decode(nvl(exec_amt07,0), 0, 0, round(exec_amt07/1000000,0)) exec_amt07, \n";
			strSql += " 					 decode(nvl(exec_amt08,0), 0, 0, round(exec_amt08/1000000,0)) exec_amt08,  \n";
			strSql += " 					 decode(nvl(exec_amt09,0), 0, 0, round(exec_amt09/1000000,0)) exec_amt09,  \n";
			strSql += " 					 decode(nvl(exec_amt10,0), 0, 0, round(exec_amt10/1000000,0)) exec_amt10, \n";
			strSql += " 					 decode(nvl(exec_amt11,0), 0, 0, round(exec_amt11/1000000,0)) exec_amt11,  \n";
			strSql += " 					 decode(nvl(exec_amt12,0), 0, 0, round(exec_amt12/1000000,0)) exec_amt12, \n";
			strSql += " 					 decode(nvl(exec_amt07,0), 0, 0, round(exec_amt07/1000000,0)) + decode(nvl(exec_amt08,0), 0, 0, round(exec_amt08/1000000,0)) +  \n";
			strSql += " 					 decode(nvl(exec_amt09,0), 0, 0, round(exec_amt09/1000000,0)) + decode(nvl(exec_amt10,0), 0, 0, round(exec_amt10/1000000,0)) + \n";
			strSql += " 					 decode(nvl(exec_amt11,0), 0, 0, round(exec_amt11/1000000,0)) + decode(nvl(exec_amt12,0), 0, 0, round(exec_amt12/1000000,0)) exec_amt122 \n";
			strSql += " 			  from  \n";
			strSql += " 					 (select comp_code, clse_acc_id + 1 clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 					 		  b_y_exec_amt \n";
			strSql += " 					  from  \n";
			strSql += " 						  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 						 		  sum(exec_amt) b_y_exec_amt \n";
			strSql += " 						   from   t_pl_comp_dept_plan_exec \n";
			strSql += " 						   where  comp_code   =  ?  \n";
			strSql += " 						   and	  clse_acc_id =  ?  - 1 \n";
			strSql += " 						   and   substr(work_ym, 1,4) =  ? -1 \n";
			strSql += " 						   group by comp_code, clse_acc_id, dept_code, biz_plan_item_no) \n";
			strSql += " 					 ) b1, \n";
			strSql += " 					 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 					 		 sum(exec_amt) c_y_exec_amt  \n";
			strSql += " 					  from  t_pl_comp_dept_plan_exec \n";
			strSql += " 					  where comp_code =  ?  \n";
			strSql += " 					  and	clse_acc_id =  ?  \n";
			strSql += " 					  and   substr(work_ym, 1,4) =  ?  \n";
			strSql += " 					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 					  ) b2, \n";
			strSql += " 					  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,  \n";
			strSql += " 					  		  sum(exec_amt01) exec_amt01, \n";
			strSql += " 							  sum(exec_amt02) exec_amt02, \n";
			strSql += " 							  sum(exec_amt03) exec_amt03, \n";
			strSql += " 							  sum(exec_amt04) exec_amt04, \n";
			strSql += " 							  sum(exec_amt05) exec_amt05, \n";
			strSql += " 							  sum(exec_amt06) exec_amt06, \n";
			strSql += " 							  sum(exec_amt07) exec_amt07, \n";
			strSql += " 							  sum(exec_amt08) exec_amt08, \n";
			strSql += " 							  sum(exec_amt09) exec_amt09, \n";
			strSql += " 							  sum(exec_amt10) exec_amt10, \n";
			strSql += " 							  sum(exec_amt11) exec_amt11, \n";
			strSql += " 							  sum(exec_amt12) exec_amt12  \n";
			strSql += " 					  from( \n";
			strSql += " 						  select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 						  		 decode(substr(work_ym, 5,6) ,'01', sum(exec_amt), '') 	   exec_amt01,  \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'02', sum(exec_amt), '') 	   exec_amt02, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'03', sum(exec_amt), '') 	   exec_amt03, \n";
			strSql += " 						  		 decode(substr(work_ym, 5,6) ,'04', sum(exec_amt), '') 	   exec_amt04,  \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'05', sum(exec_amt), '') 	   exec_amt05, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'06', sum(exec_amt), '') 	   exec_amt06, \n";
			strSql += " 						  		 decode(substr(work_ym, 5,6) ,'07', sum(exec_amt), '') 	   exec_amt07,  \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'08', sum(exec_amt), '') 	   exec_amt08, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'09', sum(exec_amt), '') 	   exec_amt09, \n";
			strSql += " 						  		 decode(substr(work_ym, 5,6) ,'10', sum(exec_amt), '') 	   exec_amt10,  \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'11', sum(exec_amt), '') 	   exec_amt11, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'12', sum(exec_amt), '') 	   exec_amt12 \n";
			strSql += " 						  from   t_pl_comp_dept_plan_exec \n";
			strSql += " 						  where  comp_code =  ?  \n";
			strSql += " 						  and	 clse_acc_id =  ?  \n";
			strSql += " 						  and   substr(work_ym, 1,4) =  ?  \n";
			strSql += " 						  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 						  		   substr(work_ym, 5,6)) \n";
			strSql += " 					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 					  ) b3 \n";
			strSql += " 			  where   b2.comp_code = b1.comp_code(+) \n";
			strSql += " 			  and	  b2.comp_code = b3.comp_code(+) \n";
			strSql += " 			  and	  b2.clse_acc_id = b1.clse_acc_id(+) \n";
			strSql += " 			  and	  b2.clse_acc_id = b3.clse_acc_id(+)  \n";
			strSql += " 			  and	  b2.dept_code = b1.dept_code(+) \n";
			strSql += " 			  and	  b2.dept_code = b3.dept_code(+)  \n";
			strSql += " 			  and	  b2.biz_plan_item_no = b1.biz_plan_item_no(+) \n";
			strSql += " 			  and	  b2.biz_plan_item_no = b3.biz_plan_item_no(+) \n";
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
			strSql += " 			   c_y_exec_amt, \n";
			strSql += " 			   bc_y_dif_exec_amt, \n";
			strSql += " 			   exec_amt01, \n";
			strSql += " 			   exec_amt02, \n";
			strSql += " 			   exec_amt03, \n";
			strSql += " 			   exec_amt04, \n";
			strSql += " 			   exec_amt05, \n";
			strSql += " 			   exec_amt06, \n";
			strSql += " 			   exec_amt121, \n";
			strSql += " 			   exec_amt07, \n";
			strSql += " 			   exec_amt08, \n";
			strSql += " 			   exec_amt09, \n";
			strSql += " 			   exec_amt10, \n";
			strSql += " 			   exec_amt11, \n";
			strSql += " 			   exec_amt12, \n";
			strSql += " 			   exec_amt122 \n";
			strSql += " 		from (select * \n";
			strSql += " 			  from t_pl_item \n";
			strSql += " 			  where mng_code = '매출이익') a, \n";
			strSql += " 			 (select  \n";
			strSql += " 			 		 b2.dept_code, \n";
			strSql += " 					 b2.biz_plan_item_no, \n";
			strSql += " 					 decode(nvl(b_y_exec_amt,0),0, 0, round(b_y_exec_amt/1000000,0)) b_y_exec_amt, \n";
			strSql += " 					 decode(nvl(c_y_exec_amt,0),0, 0, round(c_y_exec_amt/1000000,0)) c_y_exec_amt, \n";
			strSql += " 					 decode(nvl(c_y_exec_amt,0),0, 0, round(c_y_exec_amt/1000000,0)) - decode(nvl(b_y_exec_amt,0),0, 0, round(b_y_exec_amt/1000000,0)) bc_y_dif_exec_amt, \n";
			strSql += " 					 decode(nvl(exec_amt01,0), 0, 0, round(exec_amt01/1000000,0)) exec_amt01, \n";
			strSql += " 					 decode(nvl(exec_amt02,0), 0, 0, round(exec_amt02/1000000,0)) exec_amt02,  \n";
			strSql += " 					 decode(nvl(exec_amt03,0), 0, 0, round(exec_amt03/1000000,0)) exec_amt03,  \n";
			strSql += " 					 decode(nvl(exec_amt04,0), 0, 0, round(exec_amt04/1000000,0)) exec_amt04, \n";
			strSql += " 					 decode(nvl(exec_amt05,0), 0, 0, round(exec_amt05/1000000,0)) exec_amt05,  \n";
			strSql += " 					 decode(nvl(exec_amt06,0), 0, 0, round(exec_amt06/1000000,0)) exec_amt06, \n";
			strSql += " 					 decode(nvl(exec_amt01,0), 0, 0, round(exec_amt01/1000000,0)) + decode(nvl(exec_amt02,0), 0, 0, round(exec_amt02/1000000,0)) + \n";
			strSql += " 					 decode(nvl(exec_amt03,0), 0, 0, round(exec_amt03/1000000,0)) + decode(nvl(exec_amt04,0), 0, 0, round(exec_amt04/1000000,0)) + \n";
			strSql += " 					 decode(nvl(exec_amt05,0), 0, 0, round(exec_amt05/1000000,0)) + decode(nvl(exec_amt06,0), 0, 0, round(exec_amt06/1000000,0)) exec_amt121, \n";
			strSql += " 					 decode(nvl(exec_amt07,0), 0, 0, round(exec_amt07/1000000,0)) exec_amt07, \n";
			strSql += " 					 decode(nvl(exec_amt08,0), 0, 0, round(exec_amt08/1000000,0)) exec_amt08,  \n";
			strSql += " 					 decode(nvl(exec_amt09,0), 0, 0, round(exec_amt09/1000000,0)) exec_amt09,  \n";
			strSql += " 					 decode(nvl(exec_amt10,0), 0, 0, round(exec_amt10/1000000,0)) exec_amt10, \n";
			strSql += " 					 decode(nvl(exec_amt11,0), 0, 0, round(exec_amt11/1000000,0)) exec_amt11,  \n";
			strSql += " 					 decode(nvl(exec_amt12,0), 0, 0, round(exec_amt12/1000000,0)) exec_amt12, \n";
			strSql += " 					 decode(nvl(exec_amt07,0), 0, 0, round(exec_amt07/1000000,0)) + decode(nvl(exec_amt08,0), 0, 0, round(exec_amt08/1000000,0)) +  \n";
			strSql += " 					 decode(nvl(exec_amt09,0), 0, 0, round(exec_amt09/1000000,0)) + decode(nvl(exec_amt10,0), 0, 0, round(exec_amt10/1000000,0)) + \n";
			strSql += " 					 decode(nvl(exec_amt11,0), 0, 0, round(exec_amt11/1000000,0)) + decode(nvl(exec_amt12,0), 0, 0, round(exec_amt12/1000000,0)) exec_amt122 \n";
			strSql += " 			  from  \n";
			strSql += " 					 (select comp_code, clse_acc_id + 1 clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 					 		  b_y_exec_amt \n";
			strSql += " 					  from  \n";
			strSql += " 						  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 						 		  sum(exec_amt) b_y_exec_amt \n";
			strSql += " 						   from   t_pl_comp_dept_plan_exec \n";
			strSql += " 						   where  comp_code   =  ?  \n";
			strSql += " 						   and	  clse_acc_id =  ?  - 1 \n";
			strSql += " 						   and   substr(work_ym, 1,4) =  ? -1 \n";
			strSql += " 						   group by comp_code, clse_acc_id, dept_code, biz_plan_item_no) \n";
			strSql += " 					 ) b1, \n";
			strSql += " 					 (select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 					 		 sum(exec_amt) c_y_exec_amt \n";
			strSql += " 					  from  t_pl_comp_dept_plan_exec \n";
			strSql += " 					  where comp_code =  ?  \n";
			strSql += " 					  and	clse_acc_id =  ?  \n";
			strSql += " 					  and   substr(work_ym, 1,4) =  ?  \n";
			strSql += " 					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 					  ) b2, \n";
			strSql += " 					  (select comp_code, clse_acc_id, dept_code, biz_plan_item_no,  \n";
			strSql += " 					  		  sum(exec_amt01) exec_amt01, \n";
			strSql += " 							  sum(exec_amt02) exec_amt02, \n";
			strSql += " 							  sum(exec_amt03) exec_amt03, \n";
			strSql += " 							  sum(exec_amt04) exec_amt04, \n";
			strSql += " 							  sum(exec_amt05) exec_amt05, \n";
			strSql += " 							  sum(exec_amt06) exec_amt06, \n";
			strSql += " 							  sum(exec_amt07) exec_amt07, \n";
			strSql += " 							  sum(exec_amt08) exec_amt08, \n";
			strSql += " 							  sum(exec_amt09) exec_amt09, \n";
			strSql += " 							  sum(exec_amt10) exec_amt10, \n";
			strSql += " 							  sum(exec_amt11) exec_amt11, \n";
			strSql += " 							  sum(exec_amt12) exec_amt12  \n";
			strSql += " 					  from( \n";
			strSql += " 						  select comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 						  		 decode(substr(work_ym, 5,6) ,'01', sum(exec_amt), '') 	   exec_amt01,  \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'02', sum(exec_amt), '') 	   exec_amt02, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'03', sum(exec_amt), '') 	   exec_amt03, \n";
			strSql += " 						  		 decode(substr(work_ym, 5,6) ,'04', sum(exec_amt), '') 	   exec_amt04,  \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'05', sum(exec_amt), '') 	   exec_amt05, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'06', sum(exec_amt), '') 	   exec_amt06, \n";
			strSql += " 						  		 decode(substr(work_ym, 5,6) ,'07', sum(exec_amt), '') 	   exec_amt07,  \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'08', sum(exec_amt), '') 	   exec_amt08, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'09', sum(exec_amt), '') 	   exec_amt09, \n";
			strSql += " 						  		 decode(substr(work_ym, 5,6) ,'10', sum(exec_amt), '') 	   exec_amt10,  \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'11', sum(exec_amt), '') 	   exec_amt11, \n";
			strSql += " 								 decode(substr(work_ym, 5,6) ,'12', sum(exec_amt), '') 	   exec_amt12 \n";
			strSql += " 						  from   t_pl_comp_dept_plan_exec \n";
			strSql += " 						  where  comp_code =  ?  \n";
			strSql += " 						  and	 clse_acc_id =  ?  \n";
			strSql += " 						  and   substr(work_ym, 1,4) =  ?  \n";
			strSql += " 						  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no, \n";
			strSql += " 						  		   substr(work_ym, 5,6)) \n";
			strSql += " 					  group by comp_code, clse_acc_id, dept_code, biz_plan_item_no \n";
			strSql += " 					  ) b3 \n";
			strSql += " 			  where   b2.comp_code = b1.comp_code(+) \n";
			strSql += " 			  and	  b2.comp_code = b3.comp_code(+) \n";
			strSql += " 			  and	  b2.clse_acc_id = b1.clse_acc_id(+) \n";
			strSql += " 			  and	  b2.clse_acc_id = b3.clse_acc_id(+)  \n";
			strSql += " 			  and	  b2.dept_code = b1.dept_code(+) \n";
			strSql += " 			  and	  b2.dept_code = b3.dept_code(+)  \n";
			strSql += " 			  and	  b2.biz_plan_item_no = b1.biz_plan_item_no(+) \n";
			strSql += " 			  and	  b2.biz_plan_item_no = b3.biz_plan_item_no(+) \n";
			strSql += " 			  ) b, \n";
			strSql += " 			  t_dept_code c	   \n";
			strSql += " 		where a.biz_plan_item_no = b.biz_plan_item_no(+) \n";
			strSql += " 		and	  b.dept_code = c.dept_code(+) \n";
			strSql += " 		) b1 \n";
			strSql += " 	where a1.div	   = b1.div(+) \n";
			strSql += " 	and   a1.dept_code = b1.dept_code  \n";
			strSql += " 	order by 2, 1, 5 \n";
			strSql += " 	) \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("3CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("4COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("6CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("7COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("8CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("9CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("10COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("11CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("12CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("13COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("14CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("15CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("16COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("17CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("18CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("19COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("20CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("21CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("22COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("23CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("24CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("25COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("26CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("27CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("3CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("4COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("5CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("6CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("7COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("8CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("9CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("10COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("11CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("12CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("13COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("14CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("15CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("16COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("17CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("18CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("19COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("20CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("21CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("22COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("23CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("24CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("25COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("26CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("27CLSE_ACC_ID", strCLSE_ACC_ID);
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
			strSql += " 	   '######' mon1, \n";
			strSql += " 	   '######' mon2, \n";
			strSql += " 	   '######' mon3, \n";
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