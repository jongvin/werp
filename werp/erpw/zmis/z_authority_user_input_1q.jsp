<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
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
     "      order by z_authority_user.empno" ;
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>