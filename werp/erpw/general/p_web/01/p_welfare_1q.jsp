<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("welfare_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("welfare_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("welfare_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  p_code_welfare.welfare_code ," + 
     "          p_code_welfare.welfare_name, " +
     "          p_code_welfare.welfare_amt " +
     "     FROM p_code_welfare        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>