<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
    String arg_name = req.getParameter("arg_name");
    arg_name = arg_name + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("querytag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("old_dept_code",GauceDataColumn.TB_STRING,7));
    String query = "  SELECT z_authority_userprojcode.empno," + 
     "             z_authority_user.name name," + 
     "             z_authority_userprojcode.dept_code," + 
     "             z_code_dept.long_name long_name," + 
     "             z_authority_userprojcode.querytag," + 
     "          z_authority_userprojcode.dept_code old_dept_code      FROM z_authority_userprojcode," + 
     "             z_authority_user," + 
     "             z_code_dept       WHERE ( z_authority_userprojcode.empno = z_authority_user.empno ) " + 
     "            and             ( z_authority_userprojcode.dept_code = z_code_dept.dept_code (+) ) " + 
     "            and z_authority_user.name like '" + arg_name + "' " + 
     "             order by  z_authority_user.name    ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>