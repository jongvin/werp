<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 --------------------------------- 
     String arg_sabun = req.getParameter("arg_sabun");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sabun",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("password",GauceDataColumn.TB_STRING,8));
    String query = "  SELECT  test_password.sabun ," + 
     "          test_password.password     FROM test_password  WHERE ( test_password.sabun = " + "'" + arg_sabun + "'" + ")  ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>