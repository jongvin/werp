<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_empno = req.getParameter("arg_empno");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("title_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("user_id",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  z_authority_user.empno empno," + 
     "          z_authority_user.name name," + 
     "          z_authority_user.dept_code dept_code," + 
     "          z_code_dept.long_name long_name,  " +
     "          p_code_grade.grade_name,  " +
     "          p_code_title.title_name,  " +
     "          z_authority_user.user_id  " +
     "     FROM z_authority_user ," + 
     "          z_code_dept,       " + 
     "          p_pers_master,       " + 
     "          p_code_grade,       " + 
     "          p_code_title       " + 
     "    WHERE ( z_code_dept.dept_code(+) = z_authority_user.dept_code ) and  " + 
     "          ( p_pers_master.emp_no (+) = z_authority_user.empno ) and  " + 
     "          ( p_code_grade.grade_code(+) = p_pers_master.grade_code ) and  " + 
     "          ( p_code_title.title_code(+) = p_pers_master.title_code ) and  " + 
     "          ( z_authority_user.empno = " + "'" + arg_empno + "'" + ")     " +
     "  order by  z_authority_user.dept_code, p_pers_master.grade_code, z_authority_user.name ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>