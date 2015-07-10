<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("proj_unq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("proj_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("querytag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("old_proj_unq_key",GauceDataColumn.TB_STRING,7));
    String query = "  SELECT z_authority_userproject.empno," + 
     "             z_authority_user.name name," + 
     "             z_authority_userproject.proj_unq_key," + 
//     "             e.project_name proj_name," + 
     "             d.proj_name proj_name," + 
     "             z_authority_userproject.querytag," + 
     "          z_authority_userproject.proj_unq_key old_proj_unq_key " + 
     "        FROM z_authority_userproject," + 
     "             z_authority_user," + 
     "             (select proj_unq_key,step                       " + 
     "                from r_proj_view_business_form ) z,          " + 
     "             r_proj d ,                                              " + 
     "             efin_projects_v  e  " +  
     "           WHERE ( z_authority_userproject.empno = z_authority_user.empno ) " + 
     "            and z_authority_userproject.proj_unq_key = z.proj_unq_key " + 
     "            and z.proj_unq_key = d.proj_unq_key " + 
     "            and z.step = d.step " + 
     "            and d.proj_code = e.project_code (+) " + 
     "        order by  z_authority_user.name    ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>