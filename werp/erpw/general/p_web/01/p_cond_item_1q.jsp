<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_div = req.getParameter("arg_div");
     as_div = as_div + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("r_item_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("r_item_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("table_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("col_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("item_div",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("item_type",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("code_table_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("attr_name",GauceDataColumn.TB_STRING,60));
    String query = "  SELECT  hr_cond_result_item.r_item_code ," + 
     "          hr_cond_result_item.r_item_name ," + 
     "          hr_cond_result_item.table_name ," + 
     "          hr_cond_result_item.col_name ," + 
     "          hr_cond_result_item.item_div ," + 
     "          hr_cond_result_item.item_type ," + 
     "          hr_cond_result_item.code_table_name ," + 
     "          hr_cond_result_item.code_name ," + 
     "          hr_cond_result_item.attr_name    " + 
     "    FROM hr_cond_result_item   " + 
     "   WHERE ( hr_cond_result_item.item_div like '" + arg_div + "' ) " + 
     " ORDER BY hr_cond_result_item.r_item_code          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>