<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("select_1",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("select_2",GauceDataColumn.TB_STRING,40));
    String query = "  select job_code select_1 ," + 
     "          job_name select_2  from p_code_job order by job_code  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>