<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("gena_acnt_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("gena_acnt_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("use_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("print_order",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  p_code_gena_acnt.gena_acnt_code ," + 
     "          p_code_gena_acnt.gena_acnt_name ," + 
     "          p_code_gena_acnt.use_yn ," + 
     "          p_code_gena_acnt.print_order     FROM p_code_gena_acnt        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>