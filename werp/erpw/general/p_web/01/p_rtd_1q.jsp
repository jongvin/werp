<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("rtd_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("rtd_name",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT  p_code_rtd.rtd_code ," + 
     "          p_code_rtd.rtd_name     FROM p_code_rtd        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>