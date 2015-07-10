<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_contract_tender_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_cont_no = dSet.indexOfColumn("cont_no");
   	int idx_chg_degree = dSet.indexOfColumn("chg_degree");
   	int idx_pq_code = dSet.indexOfColumn("pq_code");
   	int idx_pq_amt = dSet.indexOfColumn("pq_amt");
   	int idx_estimation_standard = dSet.indexOfColumn("estimation_standard");
   	int idx_identity_standard = dSet.indexOfColumn("identity_standard");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO R_TENDER_PQ ( dept_code," + 
                    " cont_no," + 
                    " chg_degree," + 
                    " pq_code," + 
                    " pq_amt," + 
                    " estimation_standard," + 
                    " identity_standard )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cont_no);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_pq_code);
      gpstatement.bindColumn(5, idx_pq_amt);
      gpstatement.bindColumn(6, idx_estimation_standard);
      gpstatement.bindColumn(7, idx_identity_standard);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update r_tender_pq set " + 
                            " dept_code=?,  " + 
                            " cont_no=?,  " + 
                            " chg_degree=?,  " + 
                            " pq_code=?,  " + 
                            " pq_amt=?,  " + 
                            " estimation_standard=?,  " + 
                            " identity_standard=?  where dept_code=? " +
                            " and cont_no=? " + 
                            " and chg_degree=? " +
                            " and pq_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cont_no);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_pq_code);
      gpstatement.bindColumn(5, idx_pq_amt);
      gpstatement.bindColumn(6, idx_estimation_standard);
      gpstatement.bindColumn(7, idx_identity_standard);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_dept_code);
      gpstatement.bindColumn(9, idx_cont_no);
      gpstatement.bindColumn(10, idx_chg_degree);
      gpstatement.bindColumn(11, idx_pq_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_tender_pq where dept_code=? " + 
                            " and cont_no=? " + 
                            " and chg_degree=? " +
                            " and pq_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cont_no);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_pq_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>