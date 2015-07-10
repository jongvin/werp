<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("y_wbs_code_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_wbs_code = dSet.indexOfColumn("wbs_code");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_llevel = dSet.indexOfColumn("llevel");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_note = dSet.indexOfColumn("note");
   	int idx_old_wbs_code = dSet.indexOfColumn("old_wbs_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO y_wbs_code ( wbs_code," + 
                    "no_seq," + 
                    "llevel," + 
                    "name," + 
                    "note " + 
                    "  )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_wbs_code);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_llevel);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_note);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update y_wbs_code set " + 
                            "wbs_code=?,  " + 
                            "no_seq=?,  " + 
                            "llevel=?,  " + 
                            "name=?,  " + 
                            "note=?  " + 
                            "   where wbs_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_wbs_code);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_llevel);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_note);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(6, idx_old_wbs_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from y_wbs_code where wbs_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_old_wbs_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>