<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("paykind",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("payname",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  p_code_paykind.paykind ," + 
     "          p_code_paykind.payname     FROM p_code_paykind        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>