<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_sale_income_unknown_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_deposit_no = dSet.indexOfColumn("deposit_no");
   	int idx_receipt_date = dSet.indexOfColumn("receipt_date");
		int idx_deposit_no_key = dSet.indexOfColumn("deposit_no_key");
   	int idx_receipt_date_key = dSet.indexOfColumn("receipt_date_key");
   	int idx_receipt_seq = dSet.indexOfColumn("receipt_seq");
   	int idx_receipt_code = dSet.indexOfColumn("receipt_code");
   	int idx_deposit_name = dSet.indexOfColumn("deposit_name");
   	int idx_fb_seq = dSet.indexOfColumn("fb_seq");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_confirm_amt = dSet.indexOfColumn("confirm_amt");
   	int idx_input_id = dSet.indexOfColumn("input_id");
   	int idx_input_date = dSet.indexOfColumn("input_date");
   	int idx_memo = dSet.indexOfColumn("memo");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_daily_seq = dSet.indexOfColumn("daily_seq");
   	int idx_apply_yn = dSet.indexOfColumn("apply_yn");
   	int idx_error_code = dSet.indexOfColumn("error_code");
   	int idx_error_msg = dSet.indexOfColumn("error_msg");
   	int idx_work_no = dSet.indexOfColumn("work_no");
   	int idx_work_date = dSet.indexOfColumn("work_date");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_SALE_INCOME_UNKNOWN ( deposit_no," + 
                    "receipt_date," + 
                    " receipt_seq ,"+
		              "receipt_code," + 
                    "deposit_name," + 
                    "fb_seq," + 
                    "amt," + 
                    "confirm_amt," + 
                    "input_id," + 
                    "input_date," + 
                    "memo," + 
                    "dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "daily_seq," + 
                    "apply_yn," + 
                    "error_code," + 
                    "error_msg )      ";
      sSql = sSql + " VALUES ( :1, :2, (SELECT nvl(MAX(receipt_seq),0) +1 FROM H_SALE_INCOME_UNKNOWN WHERE deposit_no = :3 AND receipt_date = :4) ,:5, :6, :7, :8, :9, :10, to_date(:11, 'yyyy.mm.dd hh24:mi:ss'), :12, :13, :14, :15, :16, :17, :18, :19, :20) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_deposit_no);
      gpstatement.bindColumn(2, idx_receipt_date);
		gpstatement.bindColumn(3, idx_deposit_no);
      gpstatement.bindColumn(4, idx_receipt_date);
      /*gpstatement.bindColumn(3, idx_receipt_seq);*/
      gpstatement.bindColumn(5, idx_receipt_code);
      gpstatement.bindColumn(6, idx_deposit_name);
      gpstatement.bindColumn(7, idx_fb_seq);
      gpstatement.bindColumn(8, idx_amt);
      gpstatement.bindColumn(9, idx_confirm_amt);
      gpstatement.bindColumn(10, idx_input_id);
      gpstatement.bindColumn(11, idx_input_date);
      gpstatement.bindColumn(12, idx_memo);
      gpstatement.bindColumn(13, idx_dept_code);
      gpstatement.bindColumn(14, idx_sell_code);
      gpstatement.bindColumn(15, idx_dongho);
      gpstatement.bindColumn(16, idx_seq);
      gpstatement.bindColumn(17, idx_daily_seq);
      gpstatement.bindColumn(18, idx_apply_yn);
      gpstatement.bindColumn(19, idx_error_code);
      gpstatement.bindColumn(20, idx_error_msg);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sale_income_unknown set " + 
                            "deposit_no=?,  " + 
                            "receipt_date=?,  " + 
                            "receipt_seq=(SELECT nvl(MAX(receipt_seq),0) +1 FROM H_SALE_INCOME_UNKNOWN WHERE deposit_no =? AND receipt_date =?),  " + 
                            "receipt_code=?,  " + 
                            "deposit_name=?,  " + 
                            "fb_seq=?,  " + 
                            "amt=?,  " + 
                            "confirm_amt=?,  " + 
                            "input_id=?,  " + 
                            "input_date=to_date(?, 'yyyy.mm.dd hh24:mi:ss'),  " + 
                            "memo=?,  " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "daily_seq=?,  " + 
                            "apply_yn=?,  " + 
                            "error_code=?,  " + 
                            "error_msg=? where deposit_no=?  "+
	                         " and receipt_date=? and receipt_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_deposit_no);
      gpstatement.bindColumn(2, idx_receipt_date);
		gpstatement.bindColumn(3, idx_deposit_no);
      gpstatement.bindColumn(4, idx_receipt_date);
      /*gpstatement.bindColumn(3, idx_receipt_seq);*/
      gpstatement.bindColumn(5, idx_receipt_code);
      gpstatement.bindColumn(6, idx_deposit_name);
      gpstatement.bindColumn(7, idx_fb_seq);
      gpstatement.bindColumn(8, idx_amt);
      gpstatement.bindColumn(9, idx_confirm_amt);
      gpstatement.bindColumn(10, idx_input_id);
      gpstatement.bindColumn(11, idx_input_date);
      gpstatement.bindColumn(12, idx_memo);
      gpstatement.bindColumn(13, idx_dept_code);
      gpstatement.bindColumn(14, idx_sell_code);
      gpstatement.bindColumn(15, idx_dongho);
      gpstatement.bindColumn(16, idx_seq);
      gpstatement.bindColumn(17, idx_daily_seq);
      gpstatement.bindColumn(18, idx_apply_yn);
      gpstatement.bindColumn(19, idx_error_code);
      gpstatement.bindColumn(20, idx_error_msg);
      /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(21, idx_deposit_no_key);
      gpstatement.bindColumn(22, idx_receipt_date_key);
      gpstatement.bindColumn(23, idx_receipt_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sale_income_unknown where deposit_no=? and receipt_date=? and receipt_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_deposit_no_key);
      gpstatement.bindColumn(2, idx_receipt_date_key);
      gpstatement.bindColumn(3, idx_receipt_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>