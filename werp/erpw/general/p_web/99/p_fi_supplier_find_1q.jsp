<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sup_num = "%" + req.getParameter("arg_sup_num") + "%"; 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("vendor_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("vat_registration_num",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  a.name ," + 
     "  		      a.vendor_name ," + 
     "  		      a.vat_registration_num " + 
     "  		FROM efin_supplier_v  a " +
     "  	where (a.vendor_name like '" + arg_sup_num+ "' " +
     "  	   or a.vat_registration_num like '" + arg_sup_num + "'   )  " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>