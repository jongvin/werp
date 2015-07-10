<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_mssql_confirm_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_estimate_plan_02_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_unq_num = dSet.indexOfColumn("unq_num");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_register_chk = dSet.indexOfColumn("register_chk");
   	int idx_cn_limit_amt1 = dSet.indexOfColumn("cn_limit_amt1");
   	int idx_long_name = dSet.indexOfColumn("long_name");
   	int idx_est_cnt = dSet.indexOfColumn("est_cnt");
   	int idx_sel_cnt = dSet.indexOfColumn("sel_cnt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_estimate_plan_02 ( unq_num," + 
                    "no_seq," + 
                    "sbcr_name," + 
                    "register_chk," + 
                    "cn_limit_amt1," + 
                    "long_name," + 
                    "est_cnt," + 
                    "sel_cnt )";
      sSql = sSql + " VALUES ( ?, ?, ?, ?, ?, ?, ?, ?) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_sbcr_name);
      gpstatement.bindColumn(4, idx_register_chk);
      gpstatement.bindColumn(5, idx_cn_limit_amt1);
      gpstatement.bindColumn(6, idx_long_name);
      gpstatement.bindColumn(7, idx_est_cnt);
      gpstatement.bindColumn(8, idx_sel_cnt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>