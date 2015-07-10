<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_employ_degree = req.getParameter("arg_employ_degree");
     String arg_interview_degree = req.getParameter("arg_interview_degree");
     String arg_appl_no = req.getParameter("arg_appl_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("employ_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("interview_degree",GauceDataColumn.TB_NUMBER,1));
     dSet.addDataColumn(new GauceDataColumn("staff_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("appl_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("grade",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("inter_view",GauceDataColumn.TB_STRING,400));
     dSet.addDataColumn(new GauceDataColumn("staff_dept",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("staff_grade",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  a.employ_degree ," + 
     "          a.interview_degree ," + 
     "          a.staff_no ," + 
     "          a.appl_no ," + 
     "          a.grade ," + 
     "          c.emp_name ," + 
     "          a.inter_view,     " +
     "          d.long_name staff_dept,     " +
     "          e.grade_name staff_grade    " +
     "     FROM p_emp_inter_appl a, p_emp_inter_staff b, p_pers_master c, " +
     "	        z_code_dept d, p_code_grade e	" +
     "  where a.employ_degree = b.employ_degree		" +
     "    and a.interview_degree = b.interview_degree		" +
     "    and a.staff_no = b.staff_no		" +
     "    and a.staff_no = c.emp_no 	" +
     "    and b.staff_dept = d.dept_code (+)	" +
     "    and b.staff_grade = e.grade_code (+)	" +
     "	  and a.employ_degree    = '" + arg_employ_degree + "' " +
     "	  and a.interview_degree = " + arg_interview_degree + " " +
     "	  and a.appl_no         = '" + arg_appl_no + "' " +
     "  order by a.appl_no          ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>