<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String as_dept_code    = req.getParameter("as_dept_code");
	 String as_sell_code    = req.getParameter("as_sell_code");
      String as_deposit_no = req.getParameter("as_deposit_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("key_deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	 dSet.addDataColumn(new GauceDataColumn("key_dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
	  dSet.addDataColumn(new GauceDataColumn("key_sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("bank_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("bank_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("bank_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("account_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("depositor",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("print_deposit_no",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("annul_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("print_order",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("deposit_tag",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("fi_bank_account_id",GauceDataColumn.TB_DECIMAL,15,0));
	  dSet.addDataColumn(new GauceDataColumn("fi_bank_account_name",GauceDataColumn.TB_STRING,80));
	  dSet.addDataColumn(new GauceDataColumn("fi_bank_account_number",GauceDataColumn.TB_STRING,30));
	  dSet.addDataColumn(new GauceDataColumn("fi_bank_name",GauceDataColumn.TB_STRING,80));
	  dSet.addDataColumn(new GauceDataColumn("fi_bank_number",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("fi_bank_branch_name",GauceDataColumn.TB_STRING,80));
	  dSet.addDataColumn(new GauceDataColumn("fi_bank_branch_id",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("fi_account_holder_name",GauceDataColumn.TB_STRING,40));
	  dSet.addDataColumn(new GauceDataColumn("fi_attribute11",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("fi_attribute12",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("fi_attribute13",GauceDataColumn.TB_STRING,1));

    String query = "  SELECT a.DEPOSIT_NO," + 
     "                       a.deposit_no key_deposit_no, " +
     "    					     b.long_name long_name," + 
     " 						     c.code_name," + 
     "      				     a.DEPT_CODE," + 
	 "      				     a.DEPT_CODE key_dept_code," + 
     "      				     a.SELL_CODE," + 
	  "      				     a.SELL_CODE key_sell_code," + 
     "      				     a.BANK_CODE," + 
     "      				     a.BANK_NAME," + 
     "      				     a.BANK_PHONE," + 
     "      				     a.ACCOUNT_DIV," + 
     "      				     a.DEPOSITOR," + 
     "      				     a.PRINT_DEPOSIT_NO," + 
     "      				     a.ANNUL_YN," + 
     "      				     a.PRINT_ORDER," + 
     "      				     a.DEPOSIT_TAG,   " +
	  "                       a.FI_BANK_ACCOUNT_ID, " +
	  "                       a.FI_BANK_ACCOUNT_NAME, " +
	  "                       a.FI_BANK_ACCOUNT_NUMBER, " +
	  "                       a.FI_BANK_NAME," + 
	  "                       a.FI_BANK_NUMBER, " +
	  "                       a.FI_BANK_BRANCH_NAME, " +
	  "                       a.FI_BANK_BRANCH_ID	,				 " +
	  "                       a.FI_ACCOUNT_HOLDER_NAME	,				 " +
	  "                       a.FI_ATTRIBUTE11	,				 " +
	  "                       a.FI_ATTRIBUTE12	,				 " +
	  "                       a.FI_ATTRIBUTE13				 " +
     "                  FROM H_CODE_DEPOSIT a," + 
     "                       h_code_dept b," + 
     " 			              h_code_common c " +
     "                 WHERE a.dept_code = b.dept_code " +
     "               	 and a.sell_code = c.code " +
     "              	    and c.code_div = '03' " +
	  "                   and a.dept_code like"+"'"+ as_dept_code + "' || '%'" +
	  "                   and a.sell_code like"+"'"+ as_sell_code + "' || '%'" +
     "                   and a.deposit_no like '%'|| " + "'" + as_deposit_no  + "' || '%'" +
	  "                 order by a.dept_code, a.sell_code, c.code_div, a.deposit_no";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>