<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("edu_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("edu_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("edu_part_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("edu_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  p_code_edu.edu_code ," + 
     "          p_code_edu.edu_name ," + 
     "          p_code_edu.edu_part_code, p_code_edu.edu_tag     FROM p_code_edu        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>