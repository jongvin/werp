<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("file_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("file_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  p_eval_file.file_code ," + 
     "          p_eval_file.file_name     FROM p_eval_file        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>