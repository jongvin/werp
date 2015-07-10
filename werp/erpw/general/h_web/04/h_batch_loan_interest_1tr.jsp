<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_batch_loan_interest_1tr");
     gpstatement.gp_dataset = dSet;
	
   	int idx_dongho = dSet.indexOfColumn("dongho");
	int idx_receipt_seq = dSet.indexOfColumn("receipt_seq");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_col_1 = dSet.indexOfColumn("col_1");
   	int idx_process = dSet.indexOfColumn("process");
   	int idx_error_process = dSet.indexOfColumn("error_process");
   	int idx_error_data = dSet.indexOfColumn("error_data");
	int idx_error_data_message = dSet.indexOfColumn("error_data_message");
	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_receipt_date = dSet.indexOfColumn("receipt_date");
   	int idx_col_2 = dSet.indexOfColumn("col_2");
   	int idx_col_3 = dSet.indexOfColumn("col_3");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_batch_loan_interest ( dept_code," + 
                    "sell_code," + 
                    "receipt_date," + 
                    "receipt_seq," + 
                    "dongho," + 
                    "seq," + 
                    "amt," + 
                    "col_1," + 
                    "col_2," + 
                    "col_3," + 
                    "process," + 
                    "error_process," + 
                    "error_data,"+
			        "error_data_message )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_receipt_date);
      gpstatement.bindColumn(4, idx_receipt_seq);
      gpstatement.bindColumn(5, idx_dongho);
      gpstatement.bindColumn(6, idx_seq);
      gpstatement.bindColumn(7, idx_amt);
      gpstatement.bindColumn(8, idx_col_1);
      gpstatement.bindColumn(9, idx_col_2);
      gpstatement.bindColumn(10, idx_col_3);
      gpstatement.bindColumn(11, idx_process);
      gpstatement.bindColumn(12, idx_error_process);
      gpstatement.bindColumn(13, idx_error_data);
	  gpstatement.bindColumn(14, idx_error_data_message);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_batch_loan_interest set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "receipt_date=?,  " + 
                            "receipt_seq=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "amt=?,  " + 
                            "col_1=?,  " + 
                            "col_2=?,  " + 
                            "col_3=?,  " + 
                            "process=?,  " + 
                            "error_process=?,  " + 
                            "error_data=?, "+
	                        "error_data_message=? where dept_code=?  "+
	                        " and sell_code=? and receipt_date=? and receipt_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_receipt_date);
      gpstatement.bindColumn(4, idx_receipt_seq);
      gpstatement.bindColumn(5, idx_dongho);
      gpstatement.bindColumn(6, idx_seq);
      gpstatement.bindColumn(7, idx_amt);
      gpstatement.bindColumn(8, idx_col_1);
      gpstatement.bindColumn(9, idx_col_2);
      gpstatement.bindColumn(10, idx_col_3);
      gpstatement.bindColumn(11, idx_process);
      gpstatement.bindColumn(12, idx_error_process);
      gpstatement.bindColumn(13, idx_error_data);
	  gpstatement.bindColumn(14, idx_error_data_message);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_dept_code);
      gpstatement.bindColumn(16, idx_sell_code);
      gpstatement.bindColumn(17, idx_receipt_date);
	  gpstatement.bindColumn(18, idx_receipt_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_batch_loan_interest where dept_code=? and sell_code=? and receipt_date=? and receipt_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
	  gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_receipt_date);
	  gpstatement.bindColumn(4, idx_receipt_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>