<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_req_unq_num = req.getParameter("arg_req_unq_num");
	 String arg_date = req.getParameter("arg_date");
	 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("req_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detail_seq",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("budget_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("pre_cash",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("pre_card",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_unp",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_plan",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("pre_exe",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("req_cash",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("req_card",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("req_unp",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("add_cash",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("add_card",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("add_unp",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("limit_budget_yn",GauceDataColumn.TB_STRING,1));
    String query =  " select b.req_unq_num,"   +
"        b.detail_seq,"   +
" 			 b.dept_code,"   +
" 			 b.chg_no_seq,"   +
" 			 b.spec_no_seq,"   +
" 			 b.spec_unq_num,"   +
" 			 budget.name,"   +
" 			 budget.ssize,"   +
" 			 budget.unit,"   +
" 			 budget.detail_code,"   +
" 			 budget.amt budget_amt,"   +
"			 budget.limit_budget_yn," +
"			 pre.req_cash pre_cash,"   +
" 			 pre.req_card pre_card,"   +
" 			 pre.req_unp  pre_unp,"   +
" 			 pre.plan_amt pre_plan,"   +
" 			 pre.exe_amt  pre_exe,"   +
" 			 b.req_cash ,"   +
" 			 b.req_card,"   +
" 			 b.req_unp,"   +
" 			 b.plan_amt,"   +
" 			 b.exe_amt,"   +
" 			 b.add_cash ,"   +
" 			 b.add_card,"   +
" 			 b.add_unp"   +
"   from f_req_parent a,"   +
" 	     f_req_detail b,"   +
" 			 (select b.dept_code,"   +
" 			         b.chg_no_seq,"   +
" 						b.spec_no_seq,"   +
" 						b.spec_unq_num,"   +
" 						c.NAME,"   +
" 						c.ssize,"   +
" 						c.unit,"   +
"                 c.detail_code," +
"                       y.limit_budget_yn,"+
" 			         sum(nvl(c.amt,0)) amt"   +
" 				 from f_req_parent a,"   +
" 			         f_req_detail b,"   +
" 						y_chg_budget_detail c,"   +
"                      y_stand_detail y "+
" 		      where a.req_unq_num = b.req_unq_num(+)"   +
" 		        and a.req_mnth  = '"+arg_date+"'"   +
" 				  and a.req_unq_num = "+arg_req_unq_num+
" 				  and b.dept_code = c.dept_code"   +
" 				  and b.chg_no_seq = c.chg_no_seq"   +
" 				  and b.spec_no_seq = c.spec_no_seq"   +
" 				  and b.spec_unq_num = c.spec_unq_num "   +
"                and c.detail_code = y.detail_code(+) "+
" 		     group by b.dept_code,"   +
" 			         b.chg_no_seq,"   +
" 						b.spec_no_seq,"   +
" 						b.spec_unq_num,"   +
" 						c.name,"   +
" 						c.ssize,"   +
" 						c.unit,"   +
"                 c.detail_code, " +
"                       y.limit_budget_yn"+
"  			 ) budget, "   +
" 	     (select b.dept_code,"   +
" 			         b.chg_no_seq,"   +
" 						b.spec_no_seq,"   +
" 						b.spec_unq_num,"   +
" 		       		sum(nvl(b.req_cash,0)) req_cash,"   +
" 					 	sum(nvl(b.req_card,0)) req_card,"   +
" 					   sum(nvl(b.req_unp,0))  req_unp,"   +
" 					   sum(nvl(b.plan_amt,0)) plan_amt,"   +
" 					   sum(nvl(b.exe_amt,0))  exe_amt"   +
" 		       from f_req_parent a,"   +
" 			         f_req_detail b"   +
" 		      where a.req_unq_num = b.req_unq_num"   +
" 				  and a.req_mnth  < '"+arg_date+"'"   +
//" 				  and a.req_unq_num = "+arg_req_unq_num+
" 		     group by b.dept_code,"   +
" 			         b.chg_no_seq,"   +
" 						b.spec_no_seq,"   +
" 						b.spec_unq_num"   +
" 			  ) pre"   +
"  where b.dept_code    = budget.dept_code(+)"   +
" 		and b.chg_no_seq 	 = budget.chg_no_seq(+)"   +
" 		and b.spec_no_seq  = budget.spec_no_seq(+)"   +
" 		and b.spec_unq_num = budget.spec_unq_num(+)"   +
" 		and b.dept_code    = pre.dept_code(+)"   +
" 		and b.chg_no_seq 	 = pre.chg_no_seq(+)"   +
" 		and b.spec_no_seq  = pre.spec_no_seq(+)"   +
" 		and b.spec_unq_num = pre.spec_unq_num(+)"   +
" 		and a.req_unq_num = b.req_unq_num"   +
" 		and a.req_unq_num = "+arg_req_unq_num+
" 		and a.req_mnth = '"+arg_date+"'"   +
" order by b.spec_unq_num"  ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>