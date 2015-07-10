<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_name = '%' + req.getParameter("arg_name") + '%';
//---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("mtrgrand",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("acctag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT max(a.MTRCODE) MTRCODE,   " + 
     "         max(a.NAME) NAME,   " + 
     "         max(a.SSIZE) SSIZE,   " + 
     "         max(a.UNITCODE) UNITCODE,   " + 
	  "   max(( select child_name from z_code_etc_child where class_tag = '006' and etc_code =  a.ditag )) DITAG ," +
     "         max(a.mtrgrand) mtrgrand,  " + 
     "         max(a.acctag) acctag" +
     "    FROM M_CODE_MATERIAL a, " + 
     "         Y_BUDGET_DETAIL b " +
     "   WHERE a.mtrcode  = b.mat_code (+) " +
     "     and a.name like '" + arg_name + "'" +
     "     AND b.dept_code = '" + arg_dept + "' " + 
     "   group by a.mtrcode";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>