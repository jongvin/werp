<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String arg_code = req.getParameter("arg_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("no_1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("code_1",GauceDataColumn.TB_STRING,11));
     dSet.addDataColumn(new GauceDataColumn("amt_1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("code_2",GauceDataColumn.TB_STRING,11));
     dSet.addDataColumn(new GauceDataColumn("amt_2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("code_3",GauceDataColumn.TB_STRING,11));
     dSet.addDataColumn(new GauceDataColumn("amt_3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_4",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("code_4",GauceDataColumn.TB_STRING,11));
     dSet.addDataColumn(new GauceDataColumn("amt_4",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  select 0  no_1, " +
     "                       '' code_1, " +
     "                       0  amt_1, " +
     "                       0  no_2, " +
     "                       '' code_2, " +
     "                       0  amt_2, " +
     "                       0  no_3, " +
     "                       '' code_3, " +
     "                       0  amt_3, " +
     "                       0  no_4, " +
     "                       '' code_4, " +
     "                       0  amt_4 " +
     "                  from dual    ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>