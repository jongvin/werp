<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_name = '%' + req.getParameter("arg_name") + '%'; 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("order_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("customer_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("addr1",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT order_no,   " + 
     "         order_name,   " + 
     "		decode(customer_tag,'1',substrb(customer_no,1,3) || '-' || substrb(customer_no,4,2) || '-' || substrb(customer_no,6,5),substrb(customer_no,1,6) || '-' || substrb(customer_no,7,7)) customer_no," + 
     "         addr1  " + 
     "    FROM r_code_order  " + 
     "   WHERE order_name like " + "'" + arg_name + "'" +
     "  order by order_no asc       ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>