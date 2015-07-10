<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("moveinto_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("moveinto_fr_time",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("moveinto_to_time",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("old_moveinto_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT  h_code_moveinto.dept_code ," + 
     "          h_code_moveinto.sell_code ," + 
     "          h_code_moveinto.moveinto_code ," + 
     "          h_code_moveinto.moveinto_fr_time ," + 
     "          h_code_moveinto.moveinto_to_time ," + 
     "          h_code_moveinto.remark,     " + 
     "          h_code_moveinto.moveinto_code old_moveinto_code " + 
     "        FROM h_code_moveinto  " + 
     "        WHERE ( h_code_moveinto.dept_code = '" + arg_dept_code + "' ) and  " + 
     "              ( h_code_moveinto.sell_code = '" + arg_sell_code  + "')        "  + 
     "              order by  h_code_moveinto.moveinto_code       " ; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>