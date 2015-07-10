<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_gauce_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String arg_empno = req.getParameter("arg_empno");
     String arg_user_id = req.getParameter("arg_user_id");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("user_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("password",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("english_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("querytag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("using_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("g_ipaddress",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("g_sign_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("old_dept_code",GauceDataColumn.TB_STRING,7));
    String query = "  SELECT  z_authority_user.empno ," + 
     "          z_authority_user.user_id ," + 
     "          z_authority_user.password ," + 
     "          z_authority_user.name ," + 
     "          z_authority_user.english_name ," + 
     "          z_authority_user.querytag ," + 
     "          z_authority_user.using_tag ," + 
     "          z_authority_user.g_ipaddress ," + 
     "          z_authority_user.g_sign_tag ," + 
     "          view_dept_code.comp_name ," + 
     "          view_dept_code.long_name, " + 
     "          nvl(p_pers_master.dept_code,z_authority_user.dept_code) dept_code, " + 
     "          p_pers_master.comp_code, " + 
     "          z_authority_user.dept_code old_dept_code " + 
     "       FROM z_authority_user ," + 
     "          view_dept_code, " + 
     "          p_pers_master " + 
     "       WHERE    " +
     "              z_authority_user.empno = p_pers_master.emp_no (+) " + 
     "         and  p_pers_master.dept_code = view_dept_code.dept_code(+) " + 
//     "         and  z_authority_user.empno = '" + arg_empno + "' " + 
     "         and  z_authority_user.user_id = '" + arg_user_id + "' " +   
     "      order by z_authority_user.user_id" ;
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>