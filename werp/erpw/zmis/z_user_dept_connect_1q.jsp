<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
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
     "             order by  z_authority_user.name    ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>