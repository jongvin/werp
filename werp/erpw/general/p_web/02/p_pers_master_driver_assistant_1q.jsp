<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("driver_bank",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("driver_account",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT  p_pers_driver_assistant.emp_no ," + 
     "          p_pers_driver_assistant.driver_bank ," + 
     "          p_pers_driver_assistant.driver_account     FROM p_pers_driver_assistant  " + 
     "    WHERE ( p_pers_driver_assistant.emp_no = '" + arg_emp_no + "')       ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>