<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_cust_name = req.getParameter("arg_cust_name") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("temp_cust_code",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("representative_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("addr",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("tel_number",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  decode(cust_type,'2',substrb(cust_code,1,6) || '-' || substrb(cust_code,7,7),substrb(cust_code,1,3) || '-' || substrb(cust_code,4,2) || '-' || substrb(cust_code,6,5)) cust_code ," + 
    "			      cust_code temp_cust_code," +
     "         		      cust_name ," + 
     "          	      representative_name ," + 
     "          	      addr ," + 
     "          	      tel_number " + 
     "         		 FROM z_code_cust_code        " +
     "			WHERE cust_name like " + "'%" + arg_cust_name + "%'" +
     "               order by cust_name asc " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>