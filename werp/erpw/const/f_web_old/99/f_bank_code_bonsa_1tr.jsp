<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("f_bank_code_bonsa_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code           = dSet.indexOfColumn("dept_code");
   	int idx_wbs_code            = dSet.indexOfColumn("wbs_code");
   	int idx_bank_account_id     = dSet.indexOfColumn("bank_account_id");
   	int idx_bank_account_number = dSet.indexOfColumn("bank_account_number");
   	int idx_bank_branch_name    = dSet.indexOfColumn("bank_branch_name");
   	int idx_folder_id           = dSet.indexOfColumn("folder_id");
   	int idx_as_class            = dSet.indexOfColumn("as_class");
    int rowCnt = dSet.getDataRowCnt();
	String str_wbs_code = "";
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
		str_wbs_code = rows.getString(idx_wbs_code);
		if (str_wbs_code.equals("")) str_wbs_code = "-";
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO F_DEPT_BONSA_ACCOUNT ( dept_code," + 
			        "wbs_code,"+
                    "bank_account_id," + 
                    "bank_account_number," + 
                    "bank_branch_name," + 
                    "folder_id,as_class )      ";
      sSql = sSql + " VALUES ( :1,'" + str_wbs_code + "',:2, :3, :4, :5 , :6) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_bank_account_id);
      gpstatement.bindColumn(3, idx_bank_account_number);
      gpstatement.bindColumn(4, idx_bank_branch_name);
      gpstatement.bindColumn(5, idx_folder_id);
      gpstatement.bindColumn(6, idx_as_class);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update F_DEPT_BONSA_ACCOUNT set " + 
                            "dept_code=?,  " + 
                            "wbs_code=?,  " + 
                            "bank_account_id=?,  " + 
                            "bank_account_number=?,  " + 
                            "bank_branch_name=?,  " + 
                            "folder_id=?,  " + 
                            "as_class=?  where dept_code=? " +
                            "              and wbs_code=? " +
                            "              and bank_account_id=?" +
                            "              and bank_account_number=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_wbs_code);
      gpstatement.bindColumn(3, idx_bank_account_id);
      gpstatement.bindColumn(4, idx_bank_account_number);
      gpstatement.bindColumn(5, idx_bank_branch_name);
      gpstatement.bindColumn(6, idx_folder_id);
      gpstatement.bindColumn(7, idx_as_class);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_dept_code);
      gpstatement.bindColumn(9, idx_wbs_code);
      gpstatement.bindColumn(10,idx_bank_account_id);
      gpstatement.bindColumn(11,idx_bank_account_number);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from F_DEPT_BONSA_ACCOUNT where dept_code=? " +
                            "               and bank_account_id=? " +
                            "               and bank_account_number=? ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_bank_account_id);
      gpstatement.bindColumn(3, idx_bank_account_number);
      stmt.executeUpdate();
      stmt.close();
    }
   }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>