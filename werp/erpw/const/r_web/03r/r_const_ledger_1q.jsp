<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("CONST_NAME",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("CONT_NO",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("CONT_DATE",GauceDataColumn.TB_STRING,10));

	 
	 String query = "select														" + 
						"		CONST_NAME ,										" +
						"		CONT_NO ,											" +
						"		TO_CHAR(CONT_DATE,'YYYY-MM-DD') CONT_DATE	" +
						"	from r_contract_register							" +
						"	where														" +
						"		dept_code = '"+arg_dept_code+"' and			" +
						"		last_tag = 'Y'										" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>