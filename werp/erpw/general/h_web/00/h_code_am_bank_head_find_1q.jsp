<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_name = req.getParameter("arg_dept_name");
    String arg_dept_code = req.getParameter("arg_dept_code");
     arg_dept_name = "%" + arg_dept_name + "%";
     arg_dept_code = "%" + arg_dept_code + "%";
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("bank_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("bank_name",GauceDataColumn.TB_STRING,20));
     String query = "select bank_head_code    bank_code," + 
     " 		 					      bank_head_name    bank_name" + 
     "       			 from erpc.am_code_bank_head " +
	  "                 where ( bank_head_name like " + "'" + arg_dept_name + "'" + 
     "                  or   bank_head_code like " + "'" + arg_dept_code + "'" + " )  " +
     "            order by bank_head_name asc, bank_head_code asc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>