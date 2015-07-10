<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("y_stand_parent_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_high_detail_code = dSet.indexOfColumn("high_detail_code");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_stand_level = dSet.indexOfColumn("stand_level");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_note = dSet.indexOfColumn("note");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO y_stand_parent ( high_detail_code," + 
                    "no_seq," + 
                    "stand_level," + 
                    "name," + 
                    "note )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_high_detail_code);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_stand_level);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_note);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update y_stand_parent set " + 
                            "high_detail_code=?,  " + 
                            "no_seq=?,  " + 
                            "stand_level=?,  " + 
                            "name=?,  " + 
                            "note=?  where high_detail_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_high_detail_code);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_stand_level);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_note);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(6, idx_high_detail_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from y_stand_parent where high_detail_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_high_detail_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>