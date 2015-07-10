<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_sbcr_10tr");
     gpstatement.gp_dataset = dSet;
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_year_class = dSet.indexOfColumn("year_class");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_sale_amt = dSet.indexOfColumn("sale_amt");
   	int idx_sale_rt = dSet.indexOfColumn("sale_rt");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_SALE ( sbcr_code," + 
                    "year_class," + 
                    "seq," + 
                    "sbcr_name," + 
                    "sale_amt," + 
                    "sale_rt," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_year_class);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_sbcr_name);
      gpstatement.bindColumn(5, idx_sale_amt);
      gpstatement.bindColumn(6, idx_sale_rt);
      gpstatement.bindColumn(7, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update S_SALE set " + 
                            "sbcr_code=?,  " + 
                            "year_class=?,  " + 
                            "seq=?,  " + 
                            "sbcr_name=?,  " + 
                            "sale_amt=?,  " + 
                            "sale_rt=?,  " + 
                            "remark=?  where sbcr_code=? " +
                            "            and year_class=? " +
                            "            and seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_year_class);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_sbcr_name);
      gpstatement.bindColumn(5, idx_sale_amt);
      gpstatement.bindColumn(6, idx_sale_rt);
      gpstatement.bindColumn(7, idx_remark);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(8, idx_sbcr_code);
      gpstatement.bindColumn(9, idx_year_class);
      gpstatement.bindColumn(10, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from S_SALE where sbcr_code=? " +
                            "            and year_class=? " +
                            "            and seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_year_class);
      gpstatement.bindColumn(3, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>