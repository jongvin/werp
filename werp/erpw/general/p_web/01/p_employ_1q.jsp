<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("employ_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("employ_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("old_employ_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT  p_code_employ.employ_code ," + 
     "          p_code_employ.employ_name ," + 
     "          p_code_employ.old_employ_code     FROM p_code_employ        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>