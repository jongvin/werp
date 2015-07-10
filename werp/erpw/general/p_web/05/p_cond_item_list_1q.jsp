<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_item_code = req.getParameter("arg_item_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("item_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("listitem_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("listitem_name",GauceDataColumn.TB_STRING,60));
    String query = "  SELECT  p_cond_item_list.item_code ," + 
     "          p_cond_item_list.listitem_code ," + 
     "          p_cond_item_list.listitem_name   " + 
     "      FROM p_cond_item_list    " + 
     "      WHERE ( p_cond_item_list.item_code = '" + arg_item_code  + "') " + 
     "      ORDER BY p_cond_item_list.listitem_code          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>