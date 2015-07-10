<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_estimation_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_estimateyymm = dSet.indexOfColumn("estimateyymm");
   	int idx_estimateseq = dSet.indexOfColumn("estimateseq");
   	int idx_estimatedetailseq = dSet.indexOfColumn("estimatedetailseq");
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unitcode = dSet.indexOfColumn("unitcode");
   	int idx_qty = dSet.indexOfColumn("qty");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_request_unq_num = dSet.indexOfColumn("request_unq_num");
   	int idx_est_unq_num = dSet.indexOfColumn("est_unq_num");
   	int idx_chg_cnt = dSet.indexOfColumn("chg_cnt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_EST_DETAIL ( dept_code," + 
                    "estimateyymm," + 
                    "estimateseq," + 
                    "est_unq_num, " +
                    "estimatedetailseq," + 
                    "mtrcode," + 
                    "name," + 
                    "ssize," + 
                    "unitcode," + 
                    "qty," + 
                    "spec_no_seq," + 
                    "spec_unq_num," + 
                    "request_unq_num ,chg_cnt)";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13,:14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_estimateyymm);
      gpstatement.bindColumn(3, idx_estimateseq);
      gpstatement.bindColumn(4, idx_est_unq_num);
      gpstatement.bindColumn(5, idx_estimatedetailseq);
      gpstatement.bindColumn(6, idx_mtrcode);
      gpstatement.bindColumn(7, idx_name);
      gpstatement.bindColumn(8, idx_ssize);
      gpstatement.bindColumn(9, idx_unitcode);
      gpstatement.bindColumn(10, idx_qty);
      gpstatement.bindColumn(11, idx_spec_no_seq);
      gpstatement.bindColumn(12, idx_spec_unq_num);
      gpstatement.bindColumn(13, idx_request_unq_num);
      gpstatement.bindColumn(14, idx_chg_cnt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_est_detail set " + 
                            "dept_code=?,  " + 
                            "estimateyymm=?,  " + 
                            "estimateseq=?,  " + 
                            "estimatedetailseq=?,  " + 
                            "mtrcode=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unitcode=?,  " + 
                            "qty=?,  " + 
                            "spec_no_seq=?,  " + 
                            "spec_unq_num=?,  " + 
                            "request_unq_num=?,  " + 
                            "est_unq_num=? ,chg_cnt=? where dept_code=? " +
                            " and estimateyymm=? " +
                            " and estimateseq=? " +
                            " and est_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_estimateyymm);
      gpstatement.bindColumn(3, idx_estimateseq);
      gpstatement.bindColumn(4, idx_estimatedetailseq);
      gpstatement.bindColumn(5, idx_mtrcode);
      gpstatement.bindColumn(6, idx_name);
      gpstatement.bindColumn(7, idx_ssize);
      gpstatement.bindColumn(8, idx_unitcode);
      gpstatement.bindColumn(9, idx_qty);
      gpstatement.bindColumn(10, idx_spec_no_seq);
      gpstatement.bindColumn(11, idx_spec_unq_num);
      gpstatement.bindColumn(12, idx_request_unq_num);
      gpstatement.bindColumn(13, idx_est_unq_num);
      gpstatement.bindColumn(14, idx_chg_cnt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_dept_code);
      gpstatement.bindColumn(16, idx_estimateyymm);
      gpstatement.bindColumn(17, idx_estimateseq);
      gpstatement.bindColumn(18, idx_est_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_est_detail where dept_code=? " +
                            " and estimateyymm=? " +
                            " and estimateseq=? " +
                            " and est_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_estimateyymm);
      gpstatement.bindColumn(3, idx_estimateseq);
      gpstatement.bindColumn(4, idx_est_unq_num);
      stmt.executeUpdate();
      stmt.close();
      	      sSql = "update m_request_detail set " + 
	                            "nappr_qty=nappr_qty + ?  " + 
	                            " where dept_code=? " +  
	                            " and request_unq_num=?  " +
	                            " and chg_cnt=? " ;
	      stmt = conn.prepareStatement(sSql); 
	      gpstatement.gp_stmt = stmt;
	      gpstatement.bindColumn(1, idx_qty);
	      gpstatement.bindColumn(2, idx_dept_code);
	      gpstatement.bindColumn(3, idx_request_unq_num);
	      gpstatement.bindColumn(4, idx_chg_cnt);
	      stmt.executeUpdate();
	      stmt.close();

    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>