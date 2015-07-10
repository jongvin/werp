<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
	 String arg_high_detail_code = req.getParameter("arg_high_detail_code");
	 String arg_level = req.getParameter("arg_level");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("req_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("high_detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cat_name",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("budget_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_cash",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_card",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_unp",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_plan",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("pre_exe",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("pre_add_cash",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_add_card",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_add_unp",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("req_cash",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("req_card",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("req_unp",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("add_cash",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("add_card",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("add_unp",GauceDataColumn.TB_DECIMAL,18,0));
    String query = " select a.req_unq_num,"+
"			 a.high_detail_code,"   +
" 			 a.cat_name,"   +
" 			 budget.amt budget_amt,"   +
"			 pre.req_cash pre_cash,"   +
" 			 pre.req_card pre_card,"   +
" 			 pre.req_unp  pre_unp,"   +
" 			 pre.plan_amt pre_plan,"   +
" 			 pre.exe_amt  pre_exe,"   +
" 		     pre.add_cash pre_add_cash,"   +
" 			 pre.add_card pre_add_card,"   +
" 			 pre.add_unp pre_add_unp,"   +
" 			 cur.req_cash ,"   +
" 			 cur.req_card,"   +
" 			 cur.req_unp,"   +
" 			 cur.plan_amt,"   +
" 			 cur.exe_amt,"   +
" 		     cur.add_cash ,"   +
" 			 cur.add_card,"   +
" 			 cur.add_unp"   +
"   from f_req_parent a,"   +
" 			 (select substr(a.high_detail_code,1, "+arg_level+"*2-1+2) sum_detail_code,"   +
" 			         sum(nvl(c.amt,0)) amt"   +
" 				 from f_req_parent a,"   +
" 			         f_req_detail b,"   +
" 						y_chg_budget_detail c"   +
" 		      where a.req_unq_num = b.req_unq_num(+)"   +
" 		        and a.dept_code = '"+arg_dept_code+"'"   +
" 				  and a.req_mnth  = '"+arg_date+"'"   +
" 				  and a.parent_detail_code   like '"+arg_high_detail_code+"'||'%'"   +
" 				  and b.dept_code = c.dept_code"   +
" 				  and b.chg_no_seq = c.chg_no_seq"   +
" 				  and b.spec_no_seq = c.spec_no_seq"   +
" 				  and b.spec_unq_num = c.spec_unq_num "   +
" 		     group by substr(a.high_detail_code,1, "+arg_level+"*2-1+2)"   +
"  			 ) budget, "   +
" 	     (select substr(a.high_detail_code,1, "+arg_level+"*2-1+2) sum_detail_code,"   +
" 		       		sum(nvl(b.req_cash,0)) req_cash,"   +
" 					 	sum(nvl(b.req_card,0)) req_card,"   +
" 					   sum(nvl(b.req_unp,0))  req_unp,"   +
" 					   sum(nvl(b.plan_amt,0)) plan_amt,"   +
" 					   sum(nvl(b.exe_amt,0))  exe_amt,"   +
" 		       		sum(nvl(b.add_cash,0)) add_cash,"   +
" 					 	sum(nvl(b.add_card,0)) add_card,"   +
" 					   sum(nvl(b.add_unp,0))  add_unp"   +
" 		       from f_req_parent a,"   +
" 			         f_req_detail b"   +
" 		      where a.req_unq_num = b.req_unq_num"   +
" 		        and a.dept_code = '"+arg_dept_code+"'"   +
" 				  and a.req_mnth  < '"+arg_date+"'"   +
" 				  and a.parent_detail_code like '"+arg_high_detail_code+"'||'%' "   +
" 		     group by substr(a.high_detail_code,1, "+arg_level+"*2-1+2)"   +
" 			  ) pre,"   +
" 			 (select substr(a.high_detail_code,1, "+arg_level+"*2-1+2) sum_detail_code,"   +
" 		       			sum(nvl(b.req_cash,0)) req_cash,"   +
" 					 	sum(nvl(b.req_card,0)) req_card,"   +
" 					   sum(nvl(b.req_unp,0))  req_unp,"   +
" 					   sum(nvl(b.plan_amt,0)) plan_amt,"   +
" 					   sum(nvl(b.exe_amt,0))  exe_amt,"   +
" 		       		sum(nvl(b.add_cash,0)) add_cash,"   +
" 					 	sum(nvl(b.add_card,0)) add_card,"   +
" 					   sum(nvl(b.add_unp,0))  add_unp"   +
" 		       from f_req_parent a,"   +
" 			         f_req_detail b"   +
" 		      where a.req_unq_num = b.req_unq_num"   +
" 		        and a.dept_code = '"+arg_dept_code+"'"   +
" 				  and a.req_mnth  = '"+arg_date+"'"   +
" 				  and a.parent_detail_code like '"+arg_high_detail_code+"'||'%' "   +
" 		     group by substr(a.high_detail_code,1, "+arg_level+"*2-1+2)"   +
" 			  ) cur"   +
"  where a.high_detail_code = pre.sum_detail_code(+)"   +
"    and a.high_detail_code = cur.sum_detail_code(+)"   +
" 		and a.high_detail_code = budget.sum_detail_code(+)"   +
" 		and a.high_detail_code like '"+arg_high_detail_code+"'||'%' "   +
" 		and a.stand_level = "+arg_level+"+1"   +
"    and a.dept_code = '"+arg_dept_code+"'"   +
" 		and a.req_mnth = '"+arg_date+"'"   +
" order by a.no_seq"  ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>