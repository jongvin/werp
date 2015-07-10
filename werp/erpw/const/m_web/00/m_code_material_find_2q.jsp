<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_name = req.getParameter("arg_name");
     arg_name = "%" + arg_name + "%";
//---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("mtrgrand",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT mtrgrand,   " + 
     "         NAME   " + 
     "    FROM m_code_material_high  " + 
     "   WHERE llevel = 3 " +
     "      and ( NAME like " + "'" + arg_name + "'" + 
     "      or mtrgrand like '" + arg_name + "') " + 
     "   order by mtrgrand ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>