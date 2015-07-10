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
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("year",GauceDataColumn.TB_STRING,7));	
	 dSet.addDataColumn(new GauceDataColumn("year_org",GauceDataColumn.TB_STRING,10));	
	 dSet.addDataColumn(new GauceDataColumn("plan_mm_qty",GauceDataColumn.TB_DECIMAL,11,3));
	 dSet.addDataColumn(new GauceDataColumn("plan_mm_amt",GauceDataColumn.TB_DECIMAL,14,0));

    String query = " select cd.dept_code," +
"		cd.chg_seq," +
"		cd.chg_no_seq," +
"		cd.spec_unq_num,"   +
"        to_char(cd.year,'yyyy.mm') year,"   +
"        to_char(cd.year, 'yyyy.mm.dd') year_org, "+
"        cd.plan_mm_qty,"   +
"  			 cd.plan_mm_amt"   +
"  	from c_progress_detail cd,"   +
" 	         y_chg_budget_detail bd,"   +
"			c_chg_progress pp"+
"   where pp.dept_code = '"+arg_dept_code+"'"   +
"     and pp.chg_seq   = '"+arg_chg_seq+"'"   +
"       and pp.dept_code = cd.dept_code "+
"       and pp.chg_seq = cd.chg_seq "+
" 		 and cd.dept_code = bd.dept_code"   +
" 		 and cd.chg_no_seq = bd.chg_no_seq"   +
" 		 and cd.spec_unq_num = bd.spec_unq_num"   +
" 		 and cd.spec_no_seq  = bd.spec_no_seq"   +
" 		 and nvl(bd.cat_text,'....')  like decode('"+arg_cat_text+"', 'ALL', '%', '"+arg_cat_text+"')"   +
"		and cd.year >= '2005.12.01'"+
"  order by spec_unq_num,"   +
"         year"  ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>