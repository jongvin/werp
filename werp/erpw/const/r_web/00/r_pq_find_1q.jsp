<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_name = '%' + req.getParameter("arg_name") + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("pq_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("pq_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT pq_code,   " + 
     "         pq_name   " + 
     "    FROM r_code_pq " + 
     "   WHERE pq_name like " + "'" + arg_name  + "'" + 
     "	  and received_usetag = 'Y'" + 
     " order by pq_code  asc   ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>