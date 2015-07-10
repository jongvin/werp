<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><% 
     GauceDataSet dSet = req.getGauceDataSet("h_income_detail_12tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_paid_date = dSet.indexOfColumn("paid_date");
		int idx_paid_seq = dSet.indexOfColumn("paid_seq");
		int idx_key_paid_date = dSet.indexOfColumn("key_paid_date");
		int idx_key_paid_seq = dSet.indexOfColumn("key_paid_seq");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_memo = dSet.indexOfColumn("memo");
      int idx_loan_interest_tag = dSet.indexOfColumn("loan_interest_tag"); 
		int idx_loan_bank_code = dSet.indexOfColumn("loan_bank_code"); 
		int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_sale_loan_interest ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "paid_date," +
			           "paid_seq,"+
                    "amt," + 
                    "memo, "+
			           "loan_interest_tag,"+
			           "loan_bank_code )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_paid_date);
		gpstatement.bindColumn(6, idx_paid_seq);
      gpstatement.bindColumn(7, idx_amt);
      gpstatement.bindColumn(8, idx_memo);
		gpstatement.bindColumn(9, idx_loan_interest_tag);
		gpstatement.bindColumn(10, idx_loan_bank_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sale_loan_interest set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "paid_date=?,  " + 
	                         "paid_seq=?,  " +
                            "amt=?,  " + 
                            "memo=?, loan_interest_tag=?, loan_bank_code=? where dept_code=? "+
                            " and sell_code=?"+
	                        " and dongho=? "+
	                        " and seq=? "+
	                        " and paid_date=? "+
	                        " and paid_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_paid_date);
		gpstatement.bindColumn(6, idx_paid_seq);
      gpstatement.bindColumn(7, idx_amt);
      gpstatement.bindColumn(8, idx_memo);
		gpstatement.bindColumn(9, idx_loan_interest_tag);
		gpstatement.bindColumn(10, idx_loan_bank_code);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_dept_code);
      gpstatement.bindColumn(12,idx_sell_code);
	  gpstatement.bindColumn(13, idx_dongho);
	  gpstatement.bindColumn(14, idx_seq);
	  gpstatement.bindColumn(15, idx_key_paid_date);
	  gpstatement.bindColumn(16, idx_key_paid_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sale_loan_interest where dept_code=? "+
                            " and sell_code=?"+
	                        " and dongho=? "+
	                        " and seq=? "+
	                        " and paid_date=?"+
	                        " and paid_seq=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
	  gpstatement.bindColumn(3, idx_dongho);
	  gpstatement.bindColumn(4, idx_seq);
	  gpstatement.bindColumn(5, idx_key_paid_date);
	  gpstatement.bindColumn(6, idx_key_paid_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>

