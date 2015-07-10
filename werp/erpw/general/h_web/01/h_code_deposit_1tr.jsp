<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_code_deposit_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_deposit_no = dSet.indexOfColumn("deposit_no");
   	int idx_key_deposit_no = dSet.indexOfColumn("key_deposit_no");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
	   int idx_key_dept_code = dSet.indexOfColumn("key_dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
		int idx_key_sell_code = dSet.indexOfColumn("key_sell_code");
   	int idx_bank_code = dSet.indexOfColumn("bank_code");
   	int idx_bank_name = dSet.indexOfColumn("bank_name");
   	int idx_bank_phone = dSet.indexOfColumn("bank_phone");
   	int idx_account_div = dSet.indexOfColumn("account_div");
   	int idx_depositor = dSet.indexOfColumn("depositor");
   	int idx_print_deposit_no = dSet.indexOfColumn("print_deposit_no");
   	int idx_annul_yn = dSet.indexOfColumn("annul_yn");
   	int idx_print_order = dSet.indexOfColumn("print_order");
   	int idx_deposit_tag = dSet.indexOfColumn("deposit_tag");
		int idx_fi_bank_account_id = dSet.indexOfColumn("fi_bank_account_id");
		int idx_fi_bank_account_name = dSet.indexOfColumn("fi_bank_account_name");
		int idx_fi_bank_account_number = dSet.indexOfColumn("fi_bank_account_number");
		int idx_fi_bank_name = dSet.indexOfColumn("fi_bank_name");
		int idx_fi_bank_number = dSet.indexOfColumn("fi_bank_number");
		int idx_fi_bank_branch_name = dSet.indexOfColumn("fi_bank_branch_name");
		int idx_fi_bank_branch_id = dSet.indexOfColumn("fi_bank_branch_id");
		int idx_fi_account_holder_name = dSet.indexOfColumn("fi_account_holder_name");
		int idx_fi_attribute11 = dSet.indexOfColumn("fi_attribute11");
		int idx_fi_attribute12 = dSet.indexOfColumn("fi_attribute12");
		int idx_fi_attribute13 = dSet.indexOfColumn("fi_attribute13");

    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_CODE_DEPOSIT ( deposit_no," + 
                    "dept_code," + 
                    "sell_code," + 
                    "bank_code," + 
                    "bank_name," + 
                    "bank_phone," + 
                    "account_div," + 
                    "depositor," + 
                    "print_deposit_no," + 
                    "annul_yn," + 
                    "print_order," + 
                    "deposit_tag," +
			           "FI_BANK_ACCOUNT_ID," +
						"FI_BANK_ACCOUNT_NAME," +
						"FI_BANK_ACCOUNT_NUMBER," +
						"FI_BANK_NAME," + 
						"FI_BANK_NUMBER," +
						"FI_BANK_BRANCH_NAME," +
						"FI_BANK_BRANCH_ID,"+
			         " FI_ACCOUNT_HOLDER_NAME	,				 " +
	  "             FI_ATTRIBUTE11	,				 " +
	  "             FI_ATTRIBUTE12	,				 " +
	  "             FI_ATTRIBUTE13		)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_deposit_no);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_sell_code);
      gpstatement.bindColumn(4, idx_bank_code);
      gpstatement.bindColumn(5, idx_bank_name);
      gpstatement.bindColumn(6, idx_bank_phone);
      gpstatement.bindColumn(7, idx_account_div);
      gpstatement.bindColumn(8, idx_fi_account_holder_name);
      gpstatement.bindColumn(9, idx_print_deposit_no);
      gpstatement.bindColumn(10, idx_annul_yn);
      gpstatement.bindColumn(11, idx_print_order);
      gpstatement.bindColumn(12, idx_deposit_tag);
		gpstatement.bindColumn(13, idx_fi_bank_account_id);
		gpstatement.bindColumn(14, idx_fi_bank_account_name);
		gpstatement.bindColumn(15, idx_fi_bank_account_number);
		gpstatement.bindColumn(16, idx_fi_bank_name);
		gpstatement.bindColumn(17, idx_fi_bank_number);
		gpstatement.bindColumn(18, idx_fi_bank_branch_name);
		gpstatement.bindColumn(19, idx_fi_bank_branch_id);
		gpstatement.bindColumn(20, idx_fi_account_holder_name);
		gpstatement.bindColumn(21, idx_fi_attribute11);
		gpstatement.bindColumn(22, idx_fi_attribute12);
		gpstatement.bindColumn(23, idx_fi_attribute13);
		 stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_code_deposit set " + 
                            " deposit_no=?,  " + 
                            " dept_code=?,  " + 
                            " sell_code=?,  " + 
                            " bank_code=?,  " + 
                            " bank_name=?,  " + 
                            " bank_phone=?,  " + 
                            " account_div=?,  " + 
                            " depositor=?,  " + 
                            " print_deposit_no=?,  " + 
                            " annul_yn=?,  " + 
                            " print_order=?,  " + 
                            " deposit_tag=?,  "+
	                        " FI_BANK_ACCOUNT_ID=?, " +
									" FI_BANK_ACCOUNT_NAME=?, " +
									" FI_BANK_ACCOUNT_NUMBER=?, " +
									" FI_BANK_NAME=?, " + 
									" FI_BANK_NUMBER=?, " +
									" FI_BANK_BRANCH_NAME=?, " +
									" FI_BANK_BRANCH_ID=?, "+
									" FI_ACCOUNT_HOLDER_NAME=?	,				 " +
				  "             FI_ATTRIBUTE11=?	,				 " +
				  "             FI_ATTRIBUTE12=?	,				 " +
				  "             FI_ATTRIBUTE13=?  where deposit_no=?  "+
                            " and dept_code=? "+
	                         " and sell_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_deposit_no);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_sell_code);
      gpstatement.bindColumn(4, idx_bank_code);
      gpstatement.bindColumn(5, idx_bank_name);
      gpstatement.bindColumn(6, idx_bank_phone);
      gpstatement.bindColumn(7, idx_account_div);
      gpstatement.bindColumn(8, idx_fi_account_holder_name);
      gpstatement.bindColumn(9, idx_print_deposit_no);
      gpstatement.bindColumn(10, idx_annul_yn);
      gpstatement.bindColumn(11, idx_print_order);
      gpstatement.bindColumn(12, idx_deposit_tag);
		gpstatement.bindColumn(13, idx_fi_bank_account_id);
		gpstatement.bindColumn(14, idx_fi_bank_account_name);
		gpstatement.bindColumn(15, idx_fi_bank_account_number);
		gpstatement.bindColumn(16, idx_fi_bank_name);
		gpstatement.bindColumn(17, idx_fi_bank_number);
		gpstatement.bindColumn(18, idx_fi_bank_branch_name);
		gpstatement.bindColumn(19, idx_fi_bank_branch_id);
		gpstatement.bindColumn(20, idx_fi_account_holder_name);
		gpstatement.bindColumn(21, idx_fi_attribute11);
		gpstatement.bindColumn(22, idx_fi_attribute12);
		gpstatement.bindColumn(23, idx_fi_attribute13);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(24, idx_key_deposit_no);
      gpstatement.bindColumn(25, idx_key_dept_code);
		gpstatement.bindColumn(26, idx_key_sell_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_code_deposit where deposit_no=? and dept_code=?  and sell_code=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_deposit_no);
      gpstatement.bindColumn(2, idx_key_dept_code);
		gpstatement.bindColumn(3, idx_key_sell_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>