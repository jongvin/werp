<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_name = req.getParameter("arg_dept_name");
     String arg_dept_code = req.getParameter("arg_dept_code");
     arg_dept_name = "%" + arg_dept_name + "%";
     arg_dept_code = "%" + arg_dept_code + "%";
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("bank_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("bank_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cms_deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("deposit_name",GauceDataColumn.TB_STRING,30));
    String query = "select b.bank_code    bank_code," + 
     " 		 					b.bank_name    bank_name," + 
     " 		 					a.deposit_no   deposit_no," + 
     " 		 					replace(a.deposit_no,'-','') cms_deposit_no," + 
     " 		 					a.deposit_name  deposit_name" +
     "       			 from erpc.am_code_deposit a," + 
     " 	  						erpc.am_code_bank b " +
     "               where a.bank_code = b.bank_code " +
     "                 and a.use_yn = 'Y'  " +
     "                 and ( b.bank_name like " + "'" + arg_dept_name + "'" + 
     "                  or   b.bank_code like " + "'" + arg_dept_code + "'" + " )  " +
     "            order by b.bank_code asc," + 
     "                     a.deposit_no asc        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>