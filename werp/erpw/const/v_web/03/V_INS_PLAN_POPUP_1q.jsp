<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_not_query = req.getParameter("arg_not_query");
  
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("ETC_CODE",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("CHILD_NAME",GauceDataColumn.TB_STRING,20));
   
   String query = " SELECT ETC_CODE , CHILD_NAME FROM Z_CODE_ETC_CHILD WHERE CLASS_TAG = '041' and etc_code <> '0' " +
						" MINUS  " +
						" SELECT ETC_CODE , CHILD_NAME FROM Z_CODE_ETC_CHILD WHERE CLASS_TAG = '041' and etc_code <> '0'" +
						" AND ETC_CODE IN ( "+ arg_not_query +" )	" +
						" ORDER BY ETC_CODE " ;
	

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>