<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_cust_code = req.getParameter("arg_cust_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
    String query = "  SELECT cust_code " + 
     "                  FROM h_code_cust  "  +
     "                 where cust_code = " + "'" + arg_cust_code + "'";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>