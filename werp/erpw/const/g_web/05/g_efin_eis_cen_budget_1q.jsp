<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_group_id = req.getParameter("arg_group_id");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("category1_name",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("category2_name",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("category3_name",GauceDataColumn.TB_STRING,240));
     dSet.addDataColumn(new GauceDataColumn("amt_budget_plan",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("q_amt_budget",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("q_amt_actual",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("q_amt_variance",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_amt_budget_plan",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_amt_actual",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_variance_rate",GauceDataColumn.TB_STRING,240));
    String query = "  " + 
                 "select a.category1_name,						" +
					  "		 a.category2_name,               	" +
					  "		 a.category3_name,               	" +
					  "		 a.amt_budget_plan,		 		 		" +
					  "		 a.q_amt_budget,                 	" +
					  "		 a.q_amt_actual,                 	" +
					  "		 a.q_amt_variance,               	" +
					  "		 a.a_amt_budget_plan,            	" +
					  "		 a.a_amt_actual,                 	" +
					  "		 a.a_variance_rate						" +	 
					  "	from efin_eis_cen_budget a          	" +
                 " where group_id = " + arg_group_id + " 	" +  
                 " order by a.category1_code, a.category2_code, a.category3_code  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>