<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_from = req.getParameter("arg_from");
     String arg_to = req.getParameter("arg_to");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("c_yymm",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT to_char(c_yymm,'YYYY.MM.DD') c_yymm   " + 
     "                  FROM c_calendar_yymm   " + 
     "                 WHERE c_yymm >= " + "'" + arg_from + "'" +
     "                   AND c_yymm <= " + "'" + arg_to + "'" +
     "              ORDER BY c_yymm ASC ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>