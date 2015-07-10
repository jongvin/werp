<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("old_class",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT  h_code_class.dept_code ," + 
     "          h_code_class.sell_code ," + 
     "          h_code_class.class ," + 
     "          h_code_class.class_name ,   " + 
     "          h_code_class.class old_class " + 
     "          FROM h_code_class    " + 
     "       WHERE ( h_code_class.dept_code = '" + arg_dept_code + "') and  " + 
     "             ( h_code_class.sell_code = '" + arg_sell_code + "' )       " + 
     "             order by h_code_class.class       ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>