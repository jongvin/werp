<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,10));
    String query = "select distinct a.pyong " + 
     "                from h_base_pyong_master a " + 
     "               where a.dept_code = " + "'" + arg_dept_code + "'" + 
     "                 and a.sell_code = " + "'" + arg_sell_code + "'" + 
     "               order by a.pyong asc      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>