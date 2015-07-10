<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_wbs_code = req.getParameter("arg_wbs_code");
     String arg_name = '%' + req.getParameter("arg_name") + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT WBS_CODE," + 
     "                       detail_code, " +
     "                       NAME," + 
     "                       ssize," + 
     "                       unit," + 
     "                       NOTE       " +
     "                  FROM Y_PROJMNG_BASIC " +
     "                 WHERE wbs_code  = " + "'" + arg_wbs_code + "'" +
//     "                   AND NAME like " + "'" + arg_name + "'" + 
     "              ORDER BY WBS_CODE ASC,detail_code asc      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>