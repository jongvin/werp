<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("level_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("level_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("order_seq",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("use_yn",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  p_code_level.level_code ," + 
     "          p_code_level.level_name ," + 
     "          p_code_level.order_seq ," + 
     "          p_code_level.use_yn     FROM p_code_level        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>