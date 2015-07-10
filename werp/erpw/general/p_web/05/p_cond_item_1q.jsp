<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_item_div = req.getParameter("arg_item_div");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("item_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("item_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("table_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("col_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("item_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("item_type",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("code_table_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("attr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("width",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("sort",GauceDataColumn.TB_DECIMAL,3,0));
    String query = "  SELECT  item_code ," + 
     "          item_name ," + 
     "          table_name ," + 
     "          col_name ," + 
     "          item_div ," + 
     "          item_type ," + 
     "          code_table_name ," + 
     "          code_name ," + 
     "          attr_name,width,sort     FROM p_cond_item    " + 
     "     WHERE " + arg_item_div + "  " + 
     "     ORDER BY sort,item_name          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>