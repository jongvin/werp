<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_process_setting_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_setcode = dSet.indexOfColumn("setcode");
   	int idx_setname = dSet.indexOfColumn("setname");
   	int idx_process_tag = dSet.indexOfColumn("process_tag");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_old_setcode = dSet.indexOfColumn("old_setcode");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO z_process_setting ( setcode," + 
                    "setname," + 
                    "process_tag," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_setcode);
      gpstatement.bindColumn(2, idx_setname);
      gpstatement.bindColumn(3, idx_process_tag);
      gpstatement.bindColumn(4, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update z_process_setting set " + 
                            "setcode=?,  " + 
                            "setname=?,  " + 
                            "process_tag=?,  " + 
                            "remark=?  where setcode=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_setcode);
      gpstatement.bindColumn(2, idx_setname);
      gpstatement.bindColumn(3, idx_process_tag);
      gpstatement.bindColumn(4, idx_remark);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(5, idx_old_setcode);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from z_process_setting where setcode=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_old_setcode);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../comm_function/conn_tr_end.jsp"%>