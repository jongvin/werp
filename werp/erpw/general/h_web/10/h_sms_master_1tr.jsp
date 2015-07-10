<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_sms_master_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_msg = dSet.indexOfColumn("msg");
   	int idx_send_date = dSet.indexOfColumn("send_date");
   	int idx_tag = dSet.indexOfColumn("tag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_sms_master ( no_seq," + 
                    "msg,send_date,tag )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_no_seq);
      gpstatement.bindColumn(2, idx_msg);
      gpstatement.bindColumn(3, idx_send_date);
      gpstatement.bindColumn(4, idx_tag);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sms_master set " + 
                            "no_seq=?,  " + 
                            "msg=?,send_date=?,tag=?  where no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_no_seq);
      gpstatement.bindColumn(2, idx_msg);
      gpstatement.bindColumn(3, idx_send_date);
      gpstatement.bindColumn(4, idx_tag);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(5, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sms_master where no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>