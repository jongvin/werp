<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("select_1",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("select_2",GauceDataColumn.TB_STRING,40));
    String query = "  select visa_div_code select_1 ," + 
     "          visa_div_name select_2  from p_code_visa_div order by visa_div_code  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>