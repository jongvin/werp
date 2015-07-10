<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("style",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("option_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("option_name",GauceDataColumn.TB_STRING,20));
    String query = "select max(a.pyong) pyong," + 
     "                     max(a.style) style," + 
     "              		   max(a.class) class," + 
     "               		max(b.class_name) class_name," + 
     "                     max(a.option_code) option_code," +
     "                     max(c.option_name) option_name " +
     "                from h_base_pyong_master a," + 
     "                     h_code_class b," + 
     "                     h_code_option c " +
     "               where a.dept_code   = b.dept_code (+)" + 
     "                 and a.sell_code   = b.sell_code (+)" + 
     "                 and a.class       = b.class (+)" + 
     "                 and a.dept_code   = c.dept_code (+)" +
     "                 and a.sell_code   = c.sell_code (+)" +
     "                 and a.option_code = c.option_code (+) " +
     "                 and a.dept_code   = " + "'" + arg_dept_code + "'" + 
     "                 and a.sell_code   = " + "'" + arg_sell_code + "'" + 
     "               group by a.pyong,a.style,a.class,a.option_code" + 
     "               order by a.pyong asc,a.style asc,a.class asc     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>