<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_employ_degree = req.getParameter("arg_employ_degree");
     String arg_interview_degree = req.getParameter("arg_interview_degree");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("employ_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("interview_degree",GauceDataColumn.TB_NUMBER,1));
     dSet.addDataColumn(new GauceDataColumn("staff_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("staff_dept",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("staff_grade",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("closing_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));          
     dSet.addDataColumn(new GauceDataColumn("a_focus",GauceDataColumn.TB_STRING,20));          
    String query = "  SELECT  a.employ_degree ," + 
     "          a.interview_degree ," + 
     "          a.staff_no ," + 
     "          a.staff_dept ," + 
     "          a.staff_grade ," + 
     "          b.closing_tag ," + 
     "          c.emp_name, '' a_focus " + 
     "   FROM p_emp_inter_staff  a, " +
     "		  p_emp_inter_degree b, " +
     "        p_pers_master      c " +
     " where a.employ_degree    = b.employ_degree    " +
     "   and a.interview_degree = b.interview_degree  " +
     "   and a.staff_no         = c.emp_no  " +
     "   and a.employ_degree    = '" + arg_employ_degree   + "' " +
     "   and a.interview_degree = '" + arg_interview_degree   + "' "   ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>