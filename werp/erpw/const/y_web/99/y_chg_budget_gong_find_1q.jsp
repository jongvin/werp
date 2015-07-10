<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_no_seq = req.getParameter("arg_chg_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  " + 
     "          y_chg_budget_parent.no_seq ," + 
     "          y_chg_budget_parent.sum_code ," + 
     "          y_chg_budget_parent.llevel ," + 
     "          y_chg_budget_parent.name " + 
     "               FROM y_chg_budget_parent   " + 
     "     where   ( y_chg_budget_parent.dept_code = " + "'" + arg_dept_code + "'" + ") and  " + 
     "              ( y_chg_budget_parent.chg_no_seq = " + arg_chg_no_seq + ")  " + 
     "         ORDER BY y_chg_budget_parent.no_seq          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>