<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_input_find_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_input_unq_num = dSet.indexOfColumn("input_unq_num");
   	int idx_detailseq = dSet.indexOfColumn("detailseq");
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unitcode = dSet.indexOfColumn("unitcode");
   	int idx_ditag = dSet.indexOfColumn("ditag");
   	int idx_qty = dSet.indexOfColumn("qty");
   	int idx_unitprice = dSet.indexOfColumn("unitprice");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_vatamt = dSet.indexOfColumn("vatamt");
   	int idx_deliverytag = dSet.indexOfColumn("deliverytag");
   	int idx_inouttypecode = dSet.indexOfColumn("inouttypecode");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_vattag = dSet.indexOfColumn("vattag");
   	int idx_vat_unq_num = dSet.indexOfColumn("vat_unq_num");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_request_unq_num = dSet.indexOfColumn("request_unq_num");
   	int idx_est_unq_num = dSet.indexOfColumn("est_unq_num");
   	int idx_approval_unq_num = dSet.indexOfColumn("approval_unq_num");
   	int idx_bigo = dSet.indexOfColumn("bigo");
   	int idx_noout_qty = dSet.indexOfColumn("noout_qty");
   	int idx_tmat_unq_num = dSet.indexOfColumn("tmat_unq_num");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
 if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_input_detail set " + 
                            "noout_qty=?,tmat_unq_num=?  where dept_code=? " +
                            "               and yymmdd=? " +
                            "               and seq=? " +
                            "               and input_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_noout_qty);
      gpstatement.bindColumn(2, idx_tmat_unq_num);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(3, idx_dept_code);
      gpstatement.bindColumn(4, idx_yymmdd);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_input_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>