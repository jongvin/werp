<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 String arg_acntname = req.getParameter("arg_acntname") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("account_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("account_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT  account_code ," + 
     "         		      account_name  " + 
     "         		 FROM efin_accounts_v  " +
     "               where enabled_flag = 'Y'" +
	  "                 and summary_flag = 'N'" +
	  "                 and hierarchy_level = 6 " +
     "                    and account_name like " + "'%" + arg_acntname + "'" +
     " order by account_code asc       " ;
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>