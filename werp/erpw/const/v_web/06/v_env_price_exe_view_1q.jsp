<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));

    String query = "select b.*  from																				" + 
	  "				( SELECT a.dept_code,																			" + 
     "              (select long_name from z_code_dept where dept_code = a.dept_code) dept_name " + 
     "                FROM v_env_amt a   																			" +
     "                GROUP BY a.dept_code  ) b																	" + 
     "               order by dept_name  ASC	    																	";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>