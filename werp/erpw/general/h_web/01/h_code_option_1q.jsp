<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("option_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("option_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("old_option_code",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  h_code_option.dept_code ," + 
     "          h_code_option.sell_code ," + 
     "          h_code_option.option_code ," + 
     "          h_code_option.option_name,   " + 
     "          h_code_option.option_code old_option_code   " + 
     "      FROM h_code_option " + 
     "     WHERE ( h_code_option.dept_code = '" + arg_dept_code + "' ) and     " + 
     "     ( h_code_option.sell_code = '" + arg_sell_code + "' )       " + 
     "     order by h_code_option.option_code      "; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>