<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_name = req.getParameter("arg_dept_name");
    String arg_dept_code = req.getParameter("arg_dept_code");
     arg_dept_name = "%" + arg_dept_name + "%";
     arg_dept_code = "%" + arg_dept_code + "%";
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("bank_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("bank_name",GauceDataColumn.TB_STRING,20));
     String query = "select bank_code    bank_code," + 
     " 		 					      bank_name    bank_name" + 
     "       			 from EFIN_BANK_CODE_V  " +
	  "                 where ( bank_name like " + "'" + arg_dept_name + "'" + 
     "                  or   bank_code like " + "'" + arg_dept_code + "'" + " )  " +
     "            order by bank_name asc, bank_code asc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>