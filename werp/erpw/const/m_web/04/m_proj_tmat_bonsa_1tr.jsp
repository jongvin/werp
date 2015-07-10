<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_proj_tmat_bonsa_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_input_unq_num = dSet.indexOfColumn("input_unq_num");
   	int idx_detailseq = dSet.indexOfColumn("detailseq");
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unitcode = dSet.indexOfColumn("unitcode");
   	int idx_qty = dSet.indexOfColumn("qty");
   	int idx_proc_yn = dSet.indexOfColumn("proc_yn");
   	int idx_unitprice = dSet.indexOfColumn("unitprice");
   	int idx_buy_tag = dSet.indexOfColumn("buy_tag");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_ditag = dSet.indexOfColumn("ditag");
   	int idx_rent_cnt = dSet.indexOfColumn("rent_cnt");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_k_rent_cnt = dSet.indexOfColumn("k_rent_cnt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_tmat_stock set " + 
                            " years=?  where dept_code=? " +
                            " and yymmdd=?  " + 
                            " and seq=?  and input_unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_k_rent_cnt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_yymmdd);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_input_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
   	
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>