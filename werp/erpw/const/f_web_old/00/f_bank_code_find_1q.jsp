<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("bank_account_id",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("bank_account_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bank_branch_name",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("folder_id",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT  bank_account_id ," + 
    "			                  bank_account_number," +
     "         		         bank_branch_name ," + 
     "          	            folder_id " + 
     "         		 FROM f_dept_account        " +
     "			WHERE dept_code = " + "'" + arg_dept_code + "'" +
     "               order by bank_account_id asc " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>