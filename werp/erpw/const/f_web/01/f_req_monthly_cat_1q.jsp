<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("req_mnth",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("approve_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("trans_amt1",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("trans_amt2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("memo",GauceDataColumn.TB_STRING,256));
    String query = " select dept_code,"   +
" 			 req_mnth,"   +
" 			 approve_tag,"   +
" 			 trans_amt1,"   +
" 			 trans_amt2,"   +
" 			 memo"   +
"   from f_req_cat"   +
"  where dept_code = '"+arg_dept_code+"'"   +
"    and req_mnth  = '"+arg_date+"'";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>