<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
	 String arg_chg_no_seq = req.getParameter("arg_chg_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cat_text",GauceDataColumn.TB_STRING,255));
    String query = "  SELECT distinct  cat_text  " + 
     "            FROM y_chg_budget_detail  " + 
     "          WHERE dept_code = '" + arg_dept_code + "' " +
	 "             and   chg_no_seq = '" + arg_chg_no_seq  +"'"+
	 "             ORDER BY cat_text     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>