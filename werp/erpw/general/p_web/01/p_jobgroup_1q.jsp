<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("jobgroup_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("jobgroup_name",GauceDataColumn.TB_STRING,20));     
    String query = "  SELECT  p_code_jobgroup.jobgroup_code ," + 
     "          p_code_jobgroup.jobgroup_name     FROM p_code_jobgroup        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>