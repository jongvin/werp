<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp = req.getParameter("arg_comp");
     String arg_dept_name = req.getParameter("arg_dept_name");
     arg_dept_name = "%" + arg_dept_name + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT  a.dept_code , 										" +
     "          a.comp_code ,                                           " +
     "          b.comp_name ,                                           " +
     "          a.long_name ,                                           " +
     "          a.process_code                                          " +
     "     FROM z_code_dept a, z_code_comp b                            " +
     " where a.comp_code = b.comp_code                                  " +
     "   and ( a.dept_code like '" + arg_dept_name + "' or              " +
     "         a.long_name like '" + arg_dept_name + "' )               " +
     "   and b.comp_code = '" + arg_comp + "'                           " +
     " order by a.dept_code                                             " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>