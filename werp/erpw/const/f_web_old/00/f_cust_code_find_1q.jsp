<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_org_id = req.getParameter("arg_org_id");
     String arg_cust_name = "%" + req.getParameter("arg_cust_name") + "%";
     String arg_cust_code =  req.getParameter("arg_cust_name") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("temp_cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("addr",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  vat_registration_num cust_code ," + 
    "			      				replace(vat_registration_num,'-','') temp_cust_code," +
     "         		         vendor_name cust_name ," + 
     "                	      address_line addr " + 
     "         		   FROM efin_supplier_v        " +
     "		      	WHERE org_id = '" + arg_org_id + "'" +
     "                 and (vendor_name like " + "'" + arg_cust_name + "'" +
     "                      or replace(vat_registration_num,'-','') like  " + "'" + arg_cust_code  + "')" +
     "               order by vendor_name asc " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>