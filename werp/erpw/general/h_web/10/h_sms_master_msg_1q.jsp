<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
      String arg_no_seq = req.getParameter("arg_no_seq");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("msg",GauceDataColumn.TB_STRING,300));
    String query = "  SELECT  h_sms_master.no_seq ," + 
     "          h_sms_master.msg     FROM h_sms_master " + 
     "          where no_seq = " + arg_no_seq + " " + 
     "  ORDER BY h_sms_master.no_seq          DESC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>