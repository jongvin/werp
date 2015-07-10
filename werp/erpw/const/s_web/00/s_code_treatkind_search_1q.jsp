<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
    String arg_treatkind_name = req.getParameter("arg_treatkind_name");
    String arg_treatkind_code = req.getParameter("arg_treatkind_code");
    arg_treatkind_name = "%" + arg_treatkind_name + "%";
    arg_treatkind_code = "%" + arg_treatkind_code + "%";

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("treatkind_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("treatkind_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT  s_code_treatkind.treatkind_code ," + 
     "          s_code_treatkind.treatkind_name     FROM s_code_treatkind   " + 
     "     WHERE ( s_code_treatkind.treatkind_name like " + "'" + arg_treatkind_name + "'" + ") " +  
     "          or  ( s_code_treatkind.treatkind_code like " + "'" + arg_treatkind_code + "'" + " )       " + 
     "        ORDER BY s_code_treatkind.treatkind_code          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>