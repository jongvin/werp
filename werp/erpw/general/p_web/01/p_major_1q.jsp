<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("major_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("major_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("old_major_code",GauceDataColumn.TB_STRING,3));
    String query = "  SELECT  p_code_major.major_code ," + 
     "          p_code_major.major_name ," + 
     "          p_code_major.old_major_code     FROM p_code_major        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>