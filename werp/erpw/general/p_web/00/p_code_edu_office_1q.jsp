<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("select_1",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("select_2",GauceDataColumn.TB_STRING,60));
    String query = "  select edu_office_code select_1 ," + 
     "          edu_office_name select_2  from p_code_edu_office order by edu_office_code  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>