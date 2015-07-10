<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_no_seq = req.getParameter("arg_chg_no_seq");
     String arg_sum_code = req.getParameter("arg_parent_sum_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("direct_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("equ_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  y_budget_parent.dept_code ," + 
     "          y_budget_parent.chg_no_seq ," + 
     "          y_budget_parent.no_seq ," + 
     "          y_budget_parent.sum_code ," + 
     "          y_budget_parent.direct_class ," + 
     "          y_budget_parent.name ," + 
     "          y_budget_parent.ssize ," + 
     "          y_budget_parent.unit ," + 
     "          y_budget_parent.cnt_amt ," + 
     "          y_budget_parent.cnt_mat_amt ," + 
     "          y_budget_parent.cnt_lab_amt ," + 
     "          y_budget_parent.cnt_exp_amt ," + 
     "          y_budget_parent.amt ," + 
     "          y_budget_parent.mat_amt ," + 
     "          y_budget_parent.lab_amt ," + 
     "          y_budget_parent.exp_amt ," + 
     "          y_budget_parent.equ_amt ," + 
     "          y_budget_parent.sub_amt    " + 
     "             FROM y_budget_parent " + 
     "           WHERE ( y_budget_parent.dept_code = " + "'" + arg_dept_code + "'" + ")  and      " + 
     "                 ( y_budget_parent.chg_no_seq = " + arg_chg_no_seq + ")  and     " + 
     "                 ( y_budget_parent.parent_sum_code = " + "'" + arg_sum_code + "'" + " )     " + 
     "          ORDER BY y_budget_parent.sum_code          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>