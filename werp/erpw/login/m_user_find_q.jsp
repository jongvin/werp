<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_empno = req.getParameter("arg_empno");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("user_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
    String query = "  SELECT  z_user.user_key ," + 
     "          z_user.empno     FROM z_user      WHERE ( z_user.empno = " + "'" + arg_empno + "'" + ")       ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>