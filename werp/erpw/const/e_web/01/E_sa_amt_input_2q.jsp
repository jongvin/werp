<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("safety_man",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("real_safety_cost",GauceDataColumn.TB_DECIMAL,13,0));		 
	String query =  " select																			" +	
               "   a.dept_code	,																   " +
					"   a.safety_man	,																	" +
					"   a.real_safety_cost																" +
					" from																					" +
					"	 e_safty_budget_master a														" +	
					" where				 																	" +
					"   a.dept_code = '"+arg_dept_code+"'											" ;

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>