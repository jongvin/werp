<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp_code = req.getParameter("arg_comp_code");
     String arg_dept_name = req.getParameter("arg_dept_name");
     arg_dept_name = "%" + arg_dept_name + "%";
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("short_name",GauceDataColumn.TB_STRING,20));
    String query = " " + 
      "  select a.comp_code,           " + 
      "        a.flex_value dept_code,                        " + 
      "        a.description  long_name,                       " + 
      "        a.description  short_name                       " + 
      "   from (                                              " + 
      "     select substr(a.department_code,1,2) comp_code,        " + 
      "            a.department_code flex_value,                   " + 
      "            a.department_name description,                 " + 
      "            b.dept_code dept_code                      " + 
      "         from efin_departments_v  a,             " + 
      "              z_code_dept b                            " + 
      "         where a.department_code = b.dept_code (+)) a       " + 
      "   where a.dept_code is null                           " + 
      "     and a.description like '"  + arg_dept_name + "'   "  + 
      "     and a.comp_code = '"  + arg_comp_code + "'        " + 
      "   order by a.flex_value ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>