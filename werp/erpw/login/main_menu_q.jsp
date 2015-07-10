<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 --------------------------------- 
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("no1",GauceDataColumn.TB_DECIMAL,10,0));
     dSet.addDataColumn(new GauceDataColumn("level1",GauceDataColumn.TB_DECIMAL,1,0));
     dSet.addDataColumn(new GauceDataColumn("level_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("menu_name",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("addr",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("security",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  test_menu_tree.no1 ," + 
     "          test_menu_tree.level1 ," + 
     "          test_menu_tree.level_code ," + 
     "          test_menu_tree.menu_name ," + 
     "          test_menu_tree.type ," + 
     "          test_menu_tree.addr ," + 
     "          test_menu_tree.security     FROM test_menu_tree   ORDER BY test_menu_tree.no1          ASC      ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>