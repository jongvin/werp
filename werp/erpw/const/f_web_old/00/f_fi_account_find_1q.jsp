<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
	String arg_name = req.getParameter("arg_name");
	String arg_number = req.getParameter("arg_number");
	String arg_org_code = req.getParameter("arg_org_code");
	arg_name = "%" + arg_name + "%";
	arg_number = "%" + arg_number + "%";

 //---------------------------------------------------------- 
 	dSet.addDataColumn(new GauceDataColumn("BANK_NAME",GauceDataColumn.TB_STRING,80));
	dSet.addDataColumn(new GauceDataColumn("BANK_ACCOUNT_ID",GauceDataColumn.TB_DECIMAL,15,0));
	dSet.addDataColumn(new GauceDataColumn("BANK_ACCOUNT_NUMBER",GauceDataColumn.TB_STRING,30));
	dSet.addDataColumn(new GauceDataColumn("BANK_BRANCH_NAME",GauceDataColumn.TB_STRING,80));
	dSet.addDataColumn(new GauceDataColumn("FOLDER_CODE",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("account_holder_name",GauceDataColumn.TB_STRING,80));
	dSet.addDataColumn(new GauceDataColumn("bank_account_name",GauceDataColumn.TB_STRING,80));

     String query = "SELECT BANK_NAME,  "+
					"       BANK_ACCOUNT_ID, " +
					"       BANK_ACCOUNT_NUMBER, " +
					"       BANK_BRANCH_NAME, " +
					"       FOLDER_CODE," +
					"       account_holder_name," +
					"       bank_account_name" +
					" FROM " +
					"       efin_internal_bank_account_v "+
					" WHERE BANK_NAME LIKE " + "'"+ arg_name +"'"+
					" AND BANK_ACCOUNT_NUMBER LIKE  " + "'"+ arg_number + "'" +
					" AND org_code = '" + arg_org_code + "' "+
					" AND Natural_accounts IN ('111114','111131') "+
					" ORDER BY BANK_NAME, 															"+
					" BANK_BRANCH_NAME,																	 "+
					" BANK_ACCOUNT_NUMBER  "; //111114 => 전도금(보통예금)
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>