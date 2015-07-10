<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_vender_est_list_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_estimateyymm = dSet.indexOfColumn("estimateyymm");
   	int idx_estimateseq = dSet.indexOfColumn("estimateseq");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_choicetag = dSet.indexOfColumn("choicetag");
   	int idx_est_yn = dSet.indexOfColumn("est_yn");
   	int idx_estimatedate = dSet.indexOfColumn("estimatedate");
   	int idx_deliverymethod = dSet.indexOfColumn("deliverymethod");
   	int idx_deliverylimitdate = dSet.indexOfColumn("deliverylimitdate");
   	int idx_paymentmethod = dSet.indexOfColumn("paymentmethod");
   	int idx_quality = dSet.indexOfColumn("quality");
   	int idx_recommend = dSet.indexOfColumn("recommend");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_chg_amt = dSet.indexOfColumn("chg_amt");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_VENDER_EST ( estimateyymm," + 
                    "estimateseq," + 
                    "sbcr_code," + 
                    "choicetag," + 
                    "est_yn," + 
                    "estimatedate," + 
                    "deliverymethod," + 
                    "deliverylimitdate," + 
                    "paymentmethod," + 
                    "quality," + 
                    "recommend," + 
                    "amt," + 
                    "chg_amt," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, TO_DATE(:6,'yyyy.mm.dd hh24:mi'), :7, :8, :9, :10, :11, :12, :13, :14) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_estimateyymm);
      gpstatement.bindColumn(2, idx_estimateseq);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_choicetag);
      gpstatement.bindColumn(5, idx_est_yn);
      gpstatement.bindColumn(6, idx_estimatedate);
      gpstatement.bindColumn(7, idx_deliverymethod);
      gpstatement.bindColumn(8, idx_deliverylimitdate);
      gpstatement.bindColumn(9, idx_paymentmethod);
      gpstatement.bindColumn(10, idx_quality);
      gpstatement.bindColumn(11, idx_recommend);
      gpstatement.bindColumn(12, idx_amt);
      gpstatement.bindColumn(13, idx_chg_amt);
      gpstatement.bindColumn(14, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_vender_est set " + 
                            "estimateyymm=?,  " + 
                            "estimateseq=?,  " + 
                            "sbcr_code=?,  " + 
                            "choicetag=?,  " + 
                            "est_yn=?,  " + 
                            "estimatedate=TO_DATE(?,'yyyy.mm.dd hh24:mi'),  " + 
                            "deliverymethod=?,  " + 
                            "deliverylimitdate=?,  " + 
                            "paymentmethod=?,  " + 
                            "quality=?,  " + 
                            "recommend=?,  " + 
                            "amt=?,  " + 
                            "chg_amt=?,  " + 
                            "remark=? where estimateyymm=? " +
                            " and estimateseq=? " +
                            " and sbcr_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_estimateyymm);
      gpstatement.bindColumn(2, idx_estimateseq);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_choicetag);
      gpstatement.bindColumn(5, idx_est_yn);
      gpstatement.bindColumn(6, idx_estimatedate);
      gpstatement.bindColumn(7, idx_deliverymethod);
      gpstatement.bindColumn(8, idx_deliverylimitdate);
      gpstatement.bindColumn(9, idx_paymentmethod);
      gpstatement.bindColumn(10, idx_quality);
      gpstatement.bindColumn(11, idx_recommend);
      gpstatement.bindColumn(12, idx_amt);
      gpstatement.bindColumn(13, idx_chg_amt);
      gpstatement.bindColumn(14, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_estimateyymm);
      gpstatement.bindColumn(16, idx_estimateseq);
      gpstatement.bindColumn(17, idx_sbcr_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_vender_est where estimateyymm=? " +
                            " and estimateseq=? " +
                            " and sbcr_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_estimateyymm);
      gpstatement.bindColumn(2, idx_estimateseq);
      gpstatement.bindColumn(3, idx_sbcr_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>