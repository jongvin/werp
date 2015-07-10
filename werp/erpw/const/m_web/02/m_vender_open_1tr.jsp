<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_vender_open_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_estimateyymm = dSet.indexOfColumn("estimateyymm");
   	int idx_estimateseq = dSet.indexOfColumn("estimateseq");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_est_unq_num = dSet.indexOfColumn("est_unq_num");
   	int idx_unitprice = dSet.indexOfColumn("unitprice");
   	int idx_chgprice = dSet.indexOfColumn("chgprice");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_VENDER_EST_DETAIL ( estimateyymm," + 
                    "estimateseq," + 
                    "sbcr_code," + 
                    "est_unq_num," + 
                    "unitprice," + 
                    "chgprice )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_estimateyymm);
      gpstatement.bindColumn(2, idx_estimateseq);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_est_unq_num);
      gpstatement.bindColumn(5, idx_unitprice);
      gpstatement.bindColumn(6, idx_chgprice);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_vender_est_detail set " + 
                            "estimateyymm=?,  " + 
                            "estimateseq=?,  " + 
                            "sbcr_code=?,  " + 
                            "est_unq_num=?,  " + 
                            "unitprice=?,  " + 
                            "chgprice=?  where estimateyymm=? " +
                            "              and estimateseq=? " +
                            "              and sbcr_code=? " +
                            "              and est_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_estimateyymm);
      gpstatement.bindColumn(2, idx_estimateseq);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_est_unq_num);
      gpstatement.bindColumn(5, idx_unitprice);
      gpstatement.bindColumn(6, idx_chgprice);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_estimateyymm);
      gpstatement.bindColumn(8, idx_estimateseq);
      gpstatement.bindColumn(9, idx_sbcr_code);
      gpstatement.bindColumn(10, idx_est_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_vender_est_detail where estimateyymm=? " +
                            "              and estimateseq=? " +
                            "              and sbcr_code=? " +
                            "              and est_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_estimateyymm);
      gpstatement.bindColumn(2, idx_estimateseq);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_est_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>