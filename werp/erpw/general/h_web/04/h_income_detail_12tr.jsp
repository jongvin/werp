<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_income_detail_12tr"); gpstatement.gp_dataset = dSet;

	  
   int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_receipt_date = dSet.indexOfColumn("receipt_date");
   	int idx_daily_seq = dSet.indexOfColumn("daily_seq");
	int idx_receipt_class_code = dSet.indexOfColumn("receipt_class_code");
	int idx_loan_interest_tag = dSet.indexOfColumn("loan_interest_tag");
	int idx_loan_rdm_yn = dSet.indexOfColumn("loan_rdm_yn");
	int idx_loan_degree_code = dSet.indexOfColumn("loan_degree_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = "";  
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sale_income_daily set " + 
                            "receipt_class_code=?, " +
							"loan_interest_tag=?, " +
							"loan_rdm_yn=? ,"+
	                  " loan_degree_code=? where dept_code=? " +
                            "            and sell_code=? " +
                            "            and dongho=? " +
                            "            and seq=? " +
                            "            and receipt_date=? " +
                            "            and daily_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_receipt_class_code);
	  gpstatement.bindColumn(2, idx_loan_interest_tag);
	  gpstatement.bindColumn(3, idx_loan_rdm_yn);
	  gpstatement.bindColumn(4, idx_loan_degree_code);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(5, idx_dept_code);
      gpstatement.bindColumn(6, idx_sell_code);
      gpstatement.bindColumn(7, idx_dongho);
      gpstatement.bindColumn(8, idx_seq);
      gpstatement.bindColumn(9, idx_receipt_date);
      gpstatement.bindColumn(10, idx_daily_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "";  
      
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>