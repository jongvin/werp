<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("flicense_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("flicense_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("flang_code",GauceDataColumn.TB_STRING,3));
    String query = "  SELECT p_code_flicense.flicense_code," + 
     "             p_code_flicense.flicense_name, p_code_flicense.flang_code         FROM p_code_flicense        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>