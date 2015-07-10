<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_approve_tag = req.getParameter("arg_approve_tag");
	 String arg_mnth = req.getParameter("arg_mnth");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("req_mnth",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("approve_tag",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("trans_amt1",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("trans_amt2",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("memo",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("req_cash",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("req_card",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("req_unp",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("add_cash",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("add_card",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("add_unp",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("budget_amt",GauceDataColumn.TB_DECIMAL,18,0));
	 

    String query =  " select sum(nvl(b.req_cash, 0)) req_cash,"   +
"        sum(nvl(b.req_card, 0)) req_card,"   +
"        sum(nvl(b.req_unp, 0))  req_unp,"   +
"        sum(nvl(b.plan_amt, 0)) plan_amt,"   +
"        sum(nvl(b.exe_amt, 0))  exe_amt,"   +
"        sum(nvl(b.add_cash, 0)) add_cash,"   +
"        sum(nvl(b.add_card, 0)) add_card,"   +
"        sum(nvl(b.add_unp, 0))  add_unp,"   +
"        sum(nvl(d.amt,0)) budget_amt,"   +
"        c.dept_code,"   +
"        z.long_name , "+
"        c.req_mnth,"   +
"        c.approve_tag,"   +
"        c.trans_amt1,"   +
"        c.trans_amt2,"   +
"        c.memo"   +
"   from f_req_parent a,"   +
"        f_req_detail b,"   +
"        f_req_cat c,"   +
"        y_chg_budget_detail d,"   +
"        z_code_dept z "+
"  where c.dept_code = z.dept_code "+
"    and c.approve_tag = '"+arg_approve_tag+"'"+ 
"    and c.req_mnth = '"+arg_mnth+"'"   +
"    and a.req_unq_num = b.req_unq_num"   +
"    and a.dept_code   = c.dept_code"   +
"    and a.req_mnth    = c.req_mnth"   +
"    and b.dept_code   = d.dept_code"   +
"    and b.chg_no_seq  = d.chg_no_seq"   +
"    and b.spec_no_seq = d.spec_no_seq"   +
"    and b.spec_unq_num = d.spec_unq_num"   +
"  group by c.dept_code,"   +
"        z.long_name , "+
"        c.req_mnth,"   +
"        c.approve_tag,"   +
"        c.trans_amt1,"   +
"        c.trans_amt2,"   +
"        c.memo" +
" order by z.long_name";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>