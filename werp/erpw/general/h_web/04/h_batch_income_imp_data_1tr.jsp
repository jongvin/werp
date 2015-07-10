<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_batch_income_imp_data_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_imp_id = dSet.indexOfColumn("imp_id");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_degree_code = dSet.indexOfColumn("degree_code");
   	int idx_receipt_date = dSet.indexOfColumn("receipt_date");
   	int idx_receipt_amt = dSet.indexOfColumn("receipt_amt");
   	int idx_delay_days = dSet.indexOfColumn("delay_days");
   	int idx_delay_amt = dSet.indexOfColumn("delay_amt");
		int idx_discount_days = dSet.indexOfColumn("discount_days");
   	int idx_discount_amt = dSet.indexOfColumn("discount_amt");
   	int idx_deposit_no = dSet.indexOfColumn("deposit_no");
   	int idx_receipt_code = dSet.indexOfColumn("receipt_code");
   	int idx_process = dSet.indexOfColumn("process");
   	int idx_error_process = dSet.indexOfColumn("error_process");
   	int idx_error_data = dSet.indexOfColumn("error_data");
   	int idx_error_data_message = dSet.indexOfColumn("error_data_message");
		int idx_col_1 = dSet.indexOfColumn("col_1");
		int idx_work_seq = dSet.indexOfColumn("work_seq");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_BATCH_INCOME_IMP_DATA ( imp_id," + 
                    "dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "degree_code," + 
                    "receipt_date," + 
                    "receipt_amt," + 
                    "delay_days," + 
                    "delay_amt," + 
			           "discount_days," + 
                    "discount_amt," + 
                    "deposit_no," + 
                    "receipt_code," + 
                    "process," + 
                    "error_process," + 
                    "error_data," + 
                    "error_data_message, col_1, work_seq )      ";
      sSql = sSql + " VALUES ( H_income_imp_data_work_seq.nextval  , :1,:2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17,:18, :19) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      //gpstatement.bindColumn(1, idx_imp_id);
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_degree_code);
      gpstatement.bindColumn(6, idx_receipt_date);
      gpstatement.bindColumn(7, idx_receipt_amt);
      gpstatement.bindColumn(8, idx_delay_days);
      gpstatement.bindColumn(9, idx_delay_amt);
		gpstatement.bindColumn(10, idx_discount_days);
      gpstatement.bindColumn(11, idx_discount_amt);
      gpstatement.bindColumn(12, idx_deposit_no);
      gpstatement.bindColumn(13, idx_receipt_code);
      gpstatement.bindColumn(14, idx_process);
      gpstatement.bindColumn(15, idx_error_process);
      gpstatement.bindColumn(16, idx_error_data);
      gpstatement.bindColumn(17, idx_error_data_message);
		gpstatement.bindColumn(18, idx_col_1);
		gpstatement.bindColumn(19, idx_work_seq);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_batch_income_imp_data set " + 
                            "imp_id=?,  " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "degree_code=?,  " + 
                            "receipt_date=?,  " + 
                            "receipt_amt=?,  " + 
                            "delay_days=?,  " + 
                            "delay_amt=?,  " + 
	                         "discount_days=?,  " + 
                            "discount_amt=?,  " + 
                            "deposit_no=?,  " + 
                            "receipt_code=?,  " + 
                            "process=?,  " + 
                            "error_process=?,  " + 
                            "error_data=?,  " + 
                            "error_data_message=? , work_seq=? where imp_id=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_imp_id);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_sell_code);
      gpstatement.bindColumn(4, idx_dongho);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_degree_code);
      gpstatement.bindColumn(7, idx_receipt_date);
      gpstatement.bindColumn(8, idx_receipt_amt);
      gpstatement.bindColumn(9, idx_delay_days);
      gpstatement.bindColumn(10, idx_delay_amt);
		gpstatement.bindColumn(11, idx_discount_days);
      gpstatement.bindColumn(12, idx_discount_amt);
      gpstatement.bindColumn(13, idx_deposit_no);
      gpstatement.bindColumn(14, idx_receipt_code);
      gpstatement.bindColumn(15, idx_process);
      gpstatement.bindColumn(16, idx_error_process);
      gpstatement.bindColumn(17, idx_error_data);
      gpstatement.bindColumn(18, idx_error_data_message);
		gpstatement.bindColumn(19, idx_work_seq);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(20, idx_imp_id);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_batch_income_imp_data where imp_id=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_imp_id);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>