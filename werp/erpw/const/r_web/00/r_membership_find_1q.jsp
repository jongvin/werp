<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_name = '%' + req.getParameter("arg_name") + '%'; 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("membership_no",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("membership_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("customer_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("company_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("addr",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT membership_no,   " + 
     "         membership_name,   " + 
     "		decode(customer_tag,'1',substrb(customer_no,1,3) || '-' || substrb(customer_no,4,2) || '-' || substrb(customer_no,6,5),substrb(customer_no,1,6) || '-' || substrb(customer_no,7,7)) customer_no," + 
     "         company_tag, " +
     "         addr  " + 
     "    FROM r_code_membership  " + 
     "   WHERE membership_name like " + "'" + arg_name + "'" +
     "  order by membership_no asc       ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>