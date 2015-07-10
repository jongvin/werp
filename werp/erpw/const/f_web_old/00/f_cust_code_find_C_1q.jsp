<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_org_id = req.getParameter("arg_org_id");
     String arg_cust_name = "%" + req.getParameter("arg_cust_name") + "%";
     String arg_cust_code =  req.getParameter("arg_cust_name") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("temp_cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
//     dSet.addDataColumn(new GauceDataColumn("addr",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  tax_registration_num cust_code ," + 
    "			      				replace(tax_registration_num,'-','') temp_cust_code," +
     "         		         customer_name cust_name " + 
//     "                	      ,address_line addr " + 
     "         		   FROM efin_customer_v        " +
     "		      	WHERE org_id = '" + arg_org_id + "'" +
     "                 and (customer_name like " + "'" + arg_cust_name + "'" +
     "                      or replace(tax_registration_num,'-','') like  " + "'" + arg_cust_code  + "')" +
     "               order by customer_name asc " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>