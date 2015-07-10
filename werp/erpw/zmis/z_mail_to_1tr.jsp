<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../comm_function/conn_mssql_mail_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_mail_to_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_sender_id = dSet.indexOfColumn("sender_id");
   	int idx_tran_id = dSet.indexOfColumn("tran_id");
   	int idx_tran_phone = dSet.indexOfColumn("tran_phone");
   	int idx_tran_callback = dSet.indexOfColumn("tran_callback");
   	int idx_tran_msg = dSet.indexOfColumn("tran_msg");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO smsuser.em_tran_worldro ( " + 
                    "sender_id," + 
                    "tran_id," + 
                    "tran_phone," + 
                    "tran_callback," + 
                    "tran_status," + 
                    "tran_date," + 
                    "tran_msg," + 
                    "tran_type )      ";
      sSql = sSql + " VALUES ( ?, ?, ?, ?,'1',getdate(), ?,'0') ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sender_id);
      gpstatement.bindColumn(2, idx_tran_id);
      gpstatement.bindColumn(3, idx_tran_phone);
      gpstatement.bindColumn(4, idx_tran_callback);
      gpstatement.bindColumn(5, idx_tran_msg);
      stmt.executeUpdate();
      stmt.close();
 
		sSql = " INSERT INTO smsuser.em_tran ( " + 
                    "tran_id," + 
                    "tran_phone," + 
                    "tran_callback," + 
                    "tran_status," + 
                    "tran_date," + 
                    "tran_msg," + 
                    "tran_type )      ";
      sSql = sSql + " VALUES (?, ?, ?,'1',getdate(), ?,'0') ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_tran_id);
      gpstatement.bindColumn(2, idx_tran_phone);
      gpstatement.bindColumn(3, idx_tran_callback);
      gpstatement.bindColumn(4, idx_tran_msg);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
    }
     }
 %><%@ include file="../comm_function/conn_tr_end.jsp"%>