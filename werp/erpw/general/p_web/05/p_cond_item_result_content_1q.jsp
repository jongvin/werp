<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_no_seq = req.getParameter("arg_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("left_1",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("left_2",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("item_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("item_compute",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("item_cond",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("item_cond_code",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("right_1",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("right_2",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("item_logic",GauceDataColumn.TB_STRING,3));
    String query = "  SELECT  p_cond_item_result_content.no_seq ," + 
     "          p_cond_item_result_content.seq ," + 
     "          p_cond_item_result_content.left_1 ," + 
     "          p_cond_item_result_content.left_2 ," + 
     "          p_cond_item_result_content.item_name ," + 
     "          p_cond_item_result_content.item_compute ," + 
     "          p_cond_item_result_content.item_cond ," + 
     "          p_cond_item_result_content.item_cond_code ," + 
     "          p_cond_item_result_content.right_1 ," + 
     "          p_cond_item_result_content.right_2 ," + 
     "          p_cond_item_result_content.item_logic   " + 
     "      FROM p_cond_item_result_content   " + 
     "      WHERE ( p_cond_item_result_content.no_seq = " + arg_no_seq + ")       " + 
     "      order by seq ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>