<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_employ_degree = req.getParameter("arg_employ_degree");
     String arg_interview_degree = req.getParameter("arg_interview_degree");
     String arg_staff_no = req.getParameter("arg_staff_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("employ_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("interview_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("staff_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("appl_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("appl_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("appl_part",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("appl_part2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("inter_view",GauceDataColumn.TB_STRING,400));
    String query = "  SELECT  a.employ_degree ," + 
     "          a.interview_degree ," + 
     "          a.staff_no ," + 
     "          a.appl_no ," + 
     "          b.appl_name,   " + 
     "          b.appl_part,   " + 
     "          b.appl_part2,   " + 
     "          a.grade, " + 
     "          a.inter_view " +      
     "     FROM p_emp_inter_appl a, p_emp_applicant b " +
     "  where a.employ_degree = b.employ_degree 	" +
     "    and a.appl_no = b.appl_no 	" +
     "    and a.employ_degree    = '" + arg_employ_degree + "' " +
     "	 and a.interview_degree = " + arg_interview_degree + " " +
     "	 and a.staff_no         = '" + arg_staff_no + "' " +
     "  order by b.appl_part, b.appl_no          ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>