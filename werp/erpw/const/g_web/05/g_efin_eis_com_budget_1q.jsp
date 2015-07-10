<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_group_id = req.getParameter("arg_group_id");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("budget_plan_1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("budget_plan_2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("budget_plan_3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("budget_plan_4",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("budget_plan_total",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("actual_1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("actual_2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("actual_3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("actual_4",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("actual_total",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt_variance",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("variance_rate",GauceDataColumn.TB_STRING,240));
    String query = "  SELECT  a.dept_name ," + 
				       "          a.budget_plan_1 ," + 
				       "          a.budget_plan_2 ," + 
				       "          a.budget_plan_3 ," + 
				       "          a.budget_plan_4 ," + 
				       "          a.budget_plan_total ," + 
				       "          a.actual_1 ," + 
				       "          a.actual_2 ," + 
				       "          a.actual_3 ," + 
				       "          a.actual_4 ," + 
				       "          a.actual_total ," + 
				       "          a.amt_variance ," + 
				       "          a.variance_rate " +
                   " from efin_eis_com_budget a" + 
                   " where group_id = " + arg_group_id + " " +  
                   " order by a.dept_code  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>