<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_income_detail_5tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_bank_head_code = dSet.indexOfColumn("bank_head_code");
   	int idx_loan_request_date = dSet.indexOfColumn("loan_request_date");
   	int idx_loan_request_amt = dSet.indexOfColumn("loan_request_amt");
   	int idx_guarantee_sol_date = dSet.indexOfColumn("guarantee_sol_date");
   	int idx_loan_duty_name = dSet.indexOfColumn("loan_duty_name");
   	int idx_loan_duty_phone = dSet.indexOfColumn("loan_duty_phone");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_SALE_LOAN ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "bank_head_code," + 
                    "loan_request_date," + 
                    "loan_request_amt," + 
                    "guarantee_sol_date," + 
                    "loan_duty_name," + 
                    "loan_duty_phone," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_bank_head_code);
      gpstatement.bindColumn(6, idx_loan_request_date);
      gpstatement.bindColumn(7, idx_loan_request_amt);
      gpstatement.bindColumn(8, idx_guarantee_sol_date);
      gpstatement.bindColumn(9, idx_loan_duty_name);
      gpstatement.bindColumn(10, idx_loan_duty_phone);
      gpstatement.bindColumn(11, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sale_loan set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "bank_head_code=?,  " + 
                            "loan_request_date=?,  " + 
                            "loan_request_amt=?,  " + 
                            "guarantee_sol_date=?,  " + 
                            "loan_duty_name=?,  " + 
                            "loan_duty_phone=?,  " + 
                            "remark=?  where dept_code=? " +
                            "            and sell_code=? " +
                            "            and dongho=? " +
                            "            and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_bank_head_code);
      gpstatement.bindColumn(6, idx_loan_request_date);
      gpstatement.bindColumn(7, idx_loan_request_amt);
      gpstatement.bindColumn(8, idx_guarantee_sol_date);
      gpstatement.bindColumn(9, idx_loan_duty_name);
      gpstatement.bindColumn(10, idx_loan_duty_phone);
      gpstatement.bindColumn(11, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_dept_code);
      gpstatement.bindColumn(13, idx_sell_code);
      gpstatement.bindColumn(14, idx_dongho);
      gpstatement.bindColumn(15, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sale_loan where dept_code=? " +
                            "            and sell_code=? " +
                            "            and dongho=? " +
                            "            and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>