<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("parent_sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("invest_class",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  c_spec_const_parent.dept_code dept_code," + 
     "          to_char(c_spec_const_parent.yymm,'yyyy.mm.dd')  yymm," + 
     "          c_spec_const_parent.spec_no_seq spec_no_seq," + 
     "          y_budget_parent.no_seq no_seq," + 
     "          y_budget_parent.sum_code sum_code," + 
     "          y_budget_parent.parent_sum_code parent_sum_code," + 
     "          y_budget_parent.llevel llevel," + 
     "          y_budget_parent.name name," + 
     "          y_budget_parent.invest_class  invest_class   FROM c_spec_const_parent ," + 
     "          y_budget_parent    " + 
     "         WHERE ( c_spec_const_parent.dept_code = y_budget_parent.dept_code ) and  " + 
     "               ( c_spec_const_parent.spec_no_seq = y_budget_parent.spec_no_seq ) and " + 
     "               ( ( c_spec_const_parent.dept_code = '" + arg_dept_code + "') and  " + 
     "                 ( c_spec_const_parent.yymm = '" + arg_yymm + "') )      " + 
     "         ORDER BY no_seq ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>