<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_name = req.getParameter("arg_dept_name");
     String arg_dept_code = req.getParameter("arg_dept_code");
     arg_dept_name = "%" + arg_dept_name + "%";
     arg_dept_code = "%" + arg_dept_code + "%";
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_proj_tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("use_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT  a.dept_code ," + 
     "          a.comp_code ," + 
     "          b.company_name comp_name," + 
     "          a.long_name ," + 
     "          a.dept_proj_tag ," + 
     "          a.use_tag,  " + 
     "          a.process_code  " + 
     "     FROM z_code_dept a, " + 
     "          t_company_org b " +
     "     WHERE a.comp_code = b.comp_code (+)" +
     "       and (( a.long_name like " + "'" + arg_dept_name + "'" + ") " +  
     "          or  ( a.dept_code like " + "'" + arg_dept_code + "'" + " ))      " + 
     "         order by   a.dept_code     ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>