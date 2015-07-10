<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //String arg_cust_name = req.getParameter("arg_cust_name") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,60));
    String query = "  SELECT  code  ," + 
     "         		      name   " + 
     "         		 FROM f_vat_code order by code asc       " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>