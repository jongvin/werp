<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("edu_office_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("edu_office_name",GauceDataColumn.TB_STRING,60));
    String query = "  SELECT  p_code_edu_office.edu_office_code ," + 
     "          p_code_edu_office.edu_office_name     FROM p_code_edu_office        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>