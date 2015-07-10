<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("direct_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  y_budget_parent.dept_code ," + 
     "          y_budget_parent.spec_no_seq ," + 
     "          y_budget_parent.sum_code ," + 
     "          y_budget_parent.direct_class ," + 
     "          y_budget_parent.name ," + 
     "          y_budget_parent.cnt_amt ," + 
     "          y_budget_parent.amt " + 
     "             FROM y_budget_parent " + 
     "           WHERE ( y_budget_parent.dept_code = " + "'" + arg_dept_code + "'" + ")  and      " + 
     "                 ( y_budget_parent.parent_sum_code = '01' )      " + 
     "          ORDER BY y_budget_parent.sum_code          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>