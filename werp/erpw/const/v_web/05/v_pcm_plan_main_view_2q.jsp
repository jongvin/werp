<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
	  
    String query = "SELECT   REPLACE(a.order_name,' ','') name				   " +
     "              FROM v_pcm_plan a													" +
	  "     			  where a.order_name is not null									" +
	  "              group by REPLACE(a.order_name,' ','')					   " +
	  "              ORDER BY REPLACE(a.order_name,' ','') ASC					" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>