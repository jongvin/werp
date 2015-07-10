<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_pgrm_content_tr"); gpstatement.gp_dataset = dSet;
   	int idx_pgrm_above_key = dSet.indexOfColumn("pgrm_above_key");
   	int idx_pgrm_seq_key = dSet.indexOfColumn("pgrm_seq_key");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_pgrm_name = dSet.indexOfColumn("pgrm_name");
   	int idx_pgrm_id = dSet.indexOfColumn("pgrm_id");
   	int idx_rw_tag = dSet.indexOfColumn("rw_tag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO z_pgrm_content ( pgrm_above_key," + 
                    "pgrm_seq_key," + 
                    "no_seq," + 
                    "pgrm_name," + 
                    "pgrm_id,rw_tag )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_pgrm_above_key);
      gpstatement.bindColumn(2, idx_pgrm_seq_key);
      gpstatement.bindColumn(3, idx_no_seq);
      gpstatement.bindColumn(4, idx_pgrm_name);
      gpstatement.bindColumn(5, idx_pgrm_id);
      gpstatement.bindColumn(6, idx_rw_tag);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_pgrm_content set " + 
                            "pgrm_above_key=?,  " + 
                            "pgrm_seq_key=?,  " + 
                            "no_seq=?,  " + 
                            "pgrm_name=?,  " + 
                            "pgrm_id=?,rw_tag=?  where ( pgrm_above_key=? and pgrm_seq_key=? )";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_pgrm_above_key);
      gpstatement.bindColumn(2, idx_pgrm_seq_key);
      gpstatement.bindColumn(3, idx_no_seq);
      gpstatement.bindColumn(4, idx_pgrm_name);
      gpstatement.bindColumn(5, idx_pgrm_id);
      gpstatement.bindColumn(6, idx_rw_tag);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_pgrm_above_key);
      gpstatement.bindColumn(8, idx_pgrm_seq_key);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_pgrm_content where ( pgrm_above_key=? and pgrm_seq_key=? )"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_pgrm_above_key);
      gpstatement.bindColumn(2, idx_pgrm_seq_key);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../comm_function/conn_tr_end.jsp"%>