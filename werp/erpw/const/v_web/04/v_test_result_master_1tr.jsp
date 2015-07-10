<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_test_result_master_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_status = dSet.indexOfColumn("status");
   	int idx_feed_back = dSet.indexOfColumn("feed_back");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_outline = dSet.indexOfColumn("outline");

    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO v_test_result_master ( yymm," + 
                    "status," + 
                    "feed_back," + 
                    "remark ," +
			           "outline)  ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4 ,:5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_yymm);
      gpstatement.bindColumn(2, idx_status);
      gpstatement.bindColumn(3, idx_feed_back);
      gpstatement.bindColumn(4, idx_remark);
      gpstatement.bindColumn(5, idx_outline);
		stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update v_test_result_master set " + 
                            "yymm=?,  " + 
                            "status=?,  " + 
                            "feed_back=?,  " + 
                            "remark=? ,  " +
									 "outline=? " +
									 "where yymm=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_yymm);
      gpstatement.bindColumn(2, idx_status);
      gpstatement.bindColumn(3, idx_feed_back);
      gpstatement.bindColumn(4, idx_remark);
      gpstatement.bindColumn(5, idx_outline);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(6, idx_yymm);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from v_test_result_master where yymm=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_yymm);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>