<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
      String arg_dept_name = req.getParameter("arg_dept_name");
		arg_dept_name =  '%' + arg_dept_name + '%' ;
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("user_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("password",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("english_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("querytag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("using_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("g_ipaddress",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("g_sign_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("compcode",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  z_authority_user.empno ," + 
     "          z_authority_user.user_id ," + 
     "          z_authority_user.password ," + 
     "          z_authority_user.name ," + 
     "          z_authority_user.english_name ," + 
     "          z_authority_user.dept_code ," + 
     "          z_authority_user.querytag ," + 
     "          z_authority_user.using_tag ," + 
     "          z_authority_user.g_ipaddress ," + 
     "          z_authority_user.g_sign_tag ," + 
     "          z_authority_user.compcode ," + 
     "          t_company_org.company_name comp_name ," + 
     "          z_code_dept.long_name  " +
     "     FROM z_authority_user ," + 
     "          t_company_org,    " +
     "          z_code_dept    " +
     "   WHERE  z_authority_user.compcode = t_company_org.comp_code(+)  " +
     "     and  z_authority_user.dept_code = z_code_dept.dept_code(+)  " +
	  "     and  z_authority_user.using_tag = 'Y'  "+
	  "     and  z_code_dept.long_name like '" + arg_dept_name + "'"  +
     "      order by t_company_org.company_name , z_code_dept.long_name, z_authority_user.empno" ;
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>