<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_seq = req.getParameter("arg_chg_seq");
	 String arg_cat_text = req.getParameter("arg_cat_text");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	 dSet.addDataColumn(new GauceDataColumn("chg_seq",GauceDataColumn.TB_DECIMAL,2,0));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,3,0));
	 dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("plan_tot_qty",GauceDataColumn.TB_DECIMAL,12,2));
	 dSet.addDataColumn(new GauceDataColumn("plan_tot_amt",GauceDataColumn.TB_DECIMAL,14,0));
	 dSet.addDataColumn(new GauceDataColumn("col_tag",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("cat_text",GauceDataColumn.TB_STRING,255));
	 dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
	 dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,13,3));
	 dSet.addDataColumn(new GauceDataColumn("price",GauceDataColumn.TB_DECIMAL,17,3));
	 dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,13,0));



    String query = " select cp.dept_code,"   +
"			 cp.chg_seq,"   +
" 			 cp.chg_no_seq,"   +
" 			 cp.spec_no_seq,"   +
" 			 cp.spec_unq_num,"   +
" 			 cp.plan_tot_qty,"   +
" 			 cp.plan_tot_amt,"   +
" 			 bd.col_tag,"   +
" 			 bd.cat_text,"   +
" 			 bd.NAME,"   +
" 			 bd.SSIZE,"   +
" 			 bd.UNIT,"   +
" 			 bd.qty,"   +
" 			 bd.price,"   +
" 			 bd.amt"   +
"   from c_progress_parent cp,"   +
" 	     y_chg_budget_detail bd"   +
" 	     c_chg_progress pp"   +
"  where cp.dept_code 		= bd.dept_code"   +
" 		and cp.chg_no_seq    = bd.chg_no_seq"   +
" 		and cp.spec_no_seq   = bd.spec_no_seq"   +
" 		and cp.spec_unq_num  = bd.spec_unq_num"   +

"		and cp.dept_code = pp.dept_code "+
" 		and cp.chg_seq   = pp.chg_seq"+
" 		and pp.dept_code = '"+arg_dept_code+"'"   +
" 		and pp.chg_seq   = '"+arg_chg_seq +"'"   +
" 		and nvl(bd.cat_text,'....')  like decode('"+arg_cat_text+"', 'ALL', '%', '"+arg_cat_text+"')"  +
" order by cp.spec_unq_num" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>