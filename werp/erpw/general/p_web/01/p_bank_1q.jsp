<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("bank_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("bank_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("old_bank_code",GauceDataColumn.TB_STRING,4));
    String query = "  SELECT  p_code_bank.bank_code ," + 
     "          p_code_bank.bank_name ," + 
     "          p_code_bank.old_bank_code     FROM p_code_bank   " +
     "	order by  p_code_bank.bank_code    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>