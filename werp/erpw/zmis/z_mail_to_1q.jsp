<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../comm_function/conn_mssql_mail_q.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sender_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("tran_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("tran_phone",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("tran_callback",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("tran_msg",GauceDataColumn.TB_STRING,255));
    String query = "  SELECT " + 
     "             a.sender_id," + 
     "             a.tran_id," + 
     "             a.tran_phone," + 
     "             a.tran_callback," + 
     "             a.tran_msg " + 
     "     FROM smsuser.em_tran_worldro a " + 
     "     where a.tran_pr = 0     ";
%><%@ include file="../comm_function/conn_q_end.jsp"%>