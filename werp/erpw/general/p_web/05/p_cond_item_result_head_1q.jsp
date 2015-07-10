<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_no_seq = req.getParameter("arg_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("item_code_1",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("item_check_1",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("item_name_1",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("item_code_2",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("item_check_2",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("item_name_2",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("item_code_3",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("item_check_3",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("item_name_3",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("item_code_4",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("item_check_4",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("item_name_4",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("item_code_5",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("item_check_5",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("item_name_5",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("item_code_6",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("item_check_6",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("item_name_6",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("item_code_7",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("item_check_7",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("item_name_7",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("item_code_8",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("item_check_8",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("item_name_8",GauceDataColumn.TB_STRING,60));
    String query = "  SELECT  p_cond_item_result_head.no_seq ," + 
     "          p_cond_item_result_head.seq ," + 
     "          p_cond_item_result_head.item_code_1 ," + 
     "          p_cond_item_result_head.item_check_1 ," + 
     "          p_cond_item_result_head.item_name_1 ," + 
     "          p_cond_item_result_head.item_code_2 ," + 
     "          p_cond_item_result_head.item_check_2 ," + 
     "          p_cond_item_result_head.item_name_2 ," + 
     "          p_cond_item_result_head.item_code_3 ," + 
     "          p_cond_item_result_head.item_check_3 ," + 
     "          p_cond_item_result_head.item_name_3 ," + 
     "          p_cond_item_result_head.item_code_4 ," + 
     "          p_cond_item_result_head.item_check_4 ," + 
     "          p_cond_item_result_head.item_name_4 ," + 
     "          p_cond_item_result_head.item_code_5 ," + 
     "          p_cond_item_result_head.item_check_5 ," + 
     "          p_cond_item_result_head.item_name_5 ," + 
     "          p_cond_item_result_head.item_code_6 ," + 
     "          p_cond_item_result_head.item_check_6 ," + 
     "          p_cond_item_result_head.item_name_6 ," + 
     "          p_cond_item_result_head.item_code_7 ," + 
     "          p_cond_item_result_head.item_check_7 ," + 
     "          p_cond_item_result_head.item_name_7 ," + 
     "          p_cond_item_result_head.item_code_8 ," + 
     "          p_cond_item_result_head.item_check_8 ," + 
     "          p_cond_item_result_head.item_name_8   " + 
     "      FROM p_cond_item_result_head   " + 
     "     WHERE ( p_cond_item_result_head.no_seq = " + arg_no_seq  + ")       " + 
     "  order by seq ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>