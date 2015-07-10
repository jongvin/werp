<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
// 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_code_div = req.getParameter("arg_code_div");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("code_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("old_code",GauceDataColumn.TB_STRING,4));
    String query = "  SELECT  h_code_common.code_div ," + 
     "          h_code_common.code ," + 
     "          h_code_common.code_name,   " + 
     "          h_code_common.code old_code " + 
     "        FROM h_code_common    " + 
     "       WHERE ( h_code_common.code_div = '" + arg_code_div + "' )       " + 
     "       ORDER BY h_code_common.code " ;     
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>