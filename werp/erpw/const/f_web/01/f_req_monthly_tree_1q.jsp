<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("req_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("req_mnth",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("high_detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("stand_level",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("req_cat_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("cat_name",GauceDataColumn.TB_STRING,255));
    String query = " select req_unq_num,"   +
"        dept_code,"   +
" 			 req_mnth,"   +
" 			 high_detail_code,"   +
" 			 no_seq,"   +
" 			 stand_level,"   +
" 			 req_cat_code,"   +
" 			 cat_name"   +
"   from f_req_parent"   +
"  where dept_code = '"+arg_dept_code+"'"   +
"    and req_mnth  = '"+arg_date+"'"  +
" order by no_seq" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>