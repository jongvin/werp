<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_cms_conversion_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code"); 
   	int idx_receipt_date = dSet.indexOfColumn("receipt_date");
   	int idx_receipt_seq = dSet.indexOfColumn("receipt_seq");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_receipt_code = dSet.indexOfColumn("receipt_code");
   	int idx_bank_head_code = dSet.indexOfColumn("bank_head_code");
   	int idx_deposit_no = dSet.indexOfColumn("deposit_no");
   	int idx_receipt_amt = dSet.indexOfColumn("receipt_amt");
   	int idx_cancel_yn = dSet.indexOfColumn("cancel_yn");
   	int idx_process_yn = dSet.indexOfColumn("process_yn");
   	int idx_prgss_status = dSet.indexOfColumn("prgss_status");
		int idx_receipt_class_code = dSet.indexOfColumn("receipt_class_code");
		int idx_work_seq = dSet.indexOfColumn("work_seq");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_SALE_BANK ( dept_code," + 
                    "receipt_date," + 
                    "receipt_seq," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "receipt_code," + 
                    "bank_head_code," + 
                    "deposit_no," + 
                    "receipt_amt," + 
                    "cancel_yn," + 
                    "process_yn," + 
                    "prgss_status,"+
			           "receipt_class_code, work_seq )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15  ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_receipt_date);
      gpstatement.bindColumn(3, idx_receipt_seq);
      gpstatement.bindColumn(4, idx_sell_code);
      gpstatement.bindColumn(5, idx_dongho);
      gpstatement.bindColumn(6, idx_seq);
      gpstatement.bindColumn(7, idx_receipt_code);
      gpstatement.bindColumn(8, idx_bank_head_code);
      gpstatement.bindColumn(9, idx_deposit_no);
      gpstatement.bindColumn(10, idx_receipt_amt);
      gpstatement.bindColumn(11, idx_cancel_yn);
      gpstatement.bindColumn(12, idx_process_yn);
      gpstatement.bindColumn(13, idx_prgss_status);
		gpstatement.bindColumn(14, idx_receipt_class_code);
		gpstatement.bindColumn(15, idx_work_seq);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sale_bank set " + 
                            "dept_code=?,  " + 
                            "receipt_date=?,  " + 
                            "receipt_seq=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "receipt_code=?,  " + 
                            "bank_head_code=?,  " + 
                            "deposit_no=?,  " + 
                            "receipt_amt=?,  " + 
                            "cancel_yn=?,  " + 
                            "process_yn=?,  " + 
                            "prgss_status=?,"+
	                         "receipt_class_code=?, work_seq=?  where dept_code=? " +
                            "                  and receipt_date=? " +
                            "                  and receipt_seq=? "+
	                        "                  and sell_code =?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_receipt_date);
      gpstatement.bindColumn(3, idx_receipt_seq);
      gpstatement.bindColumn(4, idx_sell_code);
      gpstatement.bindColumn(5, idx_dongho);
      gpstatement.bindColumn(6, idx_seq);
      gpstatement.bindColumn(7, idx_receipt_code);
      gpstatement.bindColumn(8, idx_bank_head_code);
      gpstatement.bindColumn(9, idx_deposit_no);
      gpstatement.bindColumn(10, idx_receipt_amt);
      gpstatement.bindColumn(11, idx_cancel_yn);
      gpstatement.bindColumn(12, idx_process_yn);
      gpstatement.bindColumn(13, idx_prgss_status);
		gpstatement.bindColumn(14, idx_receipt_class_code);
		gpstatement.bindColumn(15, idx_work_seq);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(16, idx_dept_code);
      gpstatement.bindColumn(17, idx_receipt_date);
      gpstatement.bindColumn(18, idx_receipt_seq);
	  gpstatement.bindColumn(19, idx_sell_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sale_bank where dept_code=? " + 
                            "                  and receipt_date=? " +
                            "                  and receipt_seq=? "+
	                        "                  and sell_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_receipt_date);
      gpstatement.bindColumn(3, idx_receipt_seq);
	  gpstatement.bindColumn(4, idx_sell_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>