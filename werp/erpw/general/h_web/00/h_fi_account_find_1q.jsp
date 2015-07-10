<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_name = req.getParameter("arg_name");
	  String arg_number = req.getParameter("arg_number");
     arg_name = "%" + arg_name + "%";
	  arg_number = "%" + arg_number + "%";
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("BANK_ACCOUNT_ID",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("BANK_ACCOUNT_NAME",GauceDataColumn.TB_STRING,80));
	  dSet.addDataColumn(new GauceDataColumn("BANK_ACCOUNT_NUMBER",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("REAL_BANK_ACCOUNT",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("BANK_NAME",GauceDataColumn.TB_STRING,80));
	  dSet.addDataColumn(new GauceDataColumn("BANK_NUMBER",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("BANK_BRANCH_NAME",GauceDataColumn.TB_STRING,80));
	  dSet.addDataColumn(new GauceDataColumn("BANK_BRANCH_ID",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("account_holder_name",GauceDataColumn.TB_STRING,40));
	  dSet.addDataColumn(new GauceDataColumn("FBS_ACCOUNT_CLS",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("VIRTUAL_ACCOUNT_CLS",GauceDataColumn.TB_STRING,1));
     String query = "SELECT BANK_ACCOUNT_ID,  "+
     "  BANK_ACCOUNT_NAME, 												  "+
     "  BANK_ACCOUNT_NUMBER, 											"+
	  "  REAL_BANK_ACCOUNT, 											"+
     "  BANK_NAME, 																				 "+
     "  BANK_NUMBER, 																		  "+
     "  BANK_BRANCH_NAME, 															"+
     "  BANK_BRANCH_ID,																		 "+
	  "                       ACCOUNT_HOLDER_NAME	,				 " +
	  "                       FBS_ACCOUNT_CLS	,				 " +
	  "                       VIRTUAL_ACCOUNT_CLS				 " +
     " FROM V_ACCOUNT_INTERFACE 				  "+
     " WHERE BANK_NAME LIKE " + "'"+arg_name+"'"+
     " AND BANK_ACCOUNT_NUMBER LIKE  " + "'"+arg_number+"'"+
	 " ORDER BY BANK_NAME, 															"+
       " BANK_BRANCH_NAME,																	 "+
       " BANK_ACCOUNT_NUMBER															  ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>