<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_sbcr_4tr");
     gpstatement.gp_dataset = dSet;
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_key_seq = dSet.indexOfColumn("key_seq");
   	int idx_e_date = dSet.indexOfColumn("e_date");
   	int idx_owner = dSet.indexOfColumn("owner");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_reson = dSet.indexOfColumn("reson");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_AWARD ( sbcr_code," + 
                    "seq," + 
                    "e_date," + 
                    "owner," + 
                    "name," + 
                    "reson )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_e_date);
      gpstatement.bindColumn(4, idx_owner);
      gpstatement.bindColumn(5, idx_name);
      gpstatement.bindColumn(6, idx_reson);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update s_award set " + 
                            "sbcr_code=?,  " + 
                            "seq=?,  " + 
                            "e_date=?,  " + 
                            "owner=?,  " + 
                            "name=?,  " + 
                            "reson=?  where sbcr_code=? " +
                            "           and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_e_date);
      gpstatement.bindColumn(4, idx_owner);
      gpstatement.bindColumn(5, idx_name);
      gpstatement.bindColumn(6, idx_reson);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(7, idx_sbcr_code);
      gpstatement.bindColumn(8, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from s_award where sbcr_code=? " +
       													" and seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>