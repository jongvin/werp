<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     //String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("di_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("key_value",GauceDataColumn.TB_STRING,3));
    String query = "   select code,   		  " +
                   "          name,   		  " +
	                "          di_tag, 		  " +
	                "          code key_value " +
                   "     from f_request_acnt " +
                   " order by di_tag, code " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>