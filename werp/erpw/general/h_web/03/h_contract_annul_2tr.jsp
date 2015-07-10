<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_contract_annul_2tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_refund_date = dSet.indexOfColumn("refund_date");
   	int idx_penalty = dSet.indexOfColumn("penalty");
   	int idx_term_interest = dSet.indexOfColumn("term_interest");
   	int idx_income_tax = dSet.indexOfColumn("income_tax");
   	int idx_residence_tax = dSet.indexOfColumn("residence_tax");
   	int idx_lease_deduct_amt = dSet.indexOfColumn("lease_deduct_amt");
   	int idx_subtr_amt = dSet.indexOfColumn("subtr_amt");
   	int idx_loan_cap = dSet.indexOfColumn("loan_cap");
   	int idx_refund_amt = dSet.indexOfColumn("refund_amt");
   	int idx_bank_head_code = dSet.indexOfColumn("bank_head_code");
   	int idx_bank_head_name = dSet.indexOfColumn("bank_head_name");
   	int idx_deposit_no = dSet.indexOfColumn("deposit_no");
   	int idx_annul_reason = dSet.indexOfColumn("annul_reason");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_SALE_ANNUL ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "refund_date," + 
                    "penalty," + 
                    "term_interest," + 
                    "income_tax," + 
                    "residence_tax," + 
                    "lease_deduct_amt," + 
                    "subtr_amt," + 
                    "loan_cap," + 
                    "refund_amt," + 
                    "bank_head_code," + 
                    "bank_head_name," + 
                    "deposit_no," + 
                    "annul_reason )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_refund_date);
      gpstatement.bindColumn(6, idx_penalty);
      gpstatement.bindColumn(7, idx_term_interest);
      gpstatement.bindColumn(8, idx_income_tax);
      gpstatement.bindColumn(9, idx_residence_tax);
      gpstatement.bindColumn(10, idx_lease_deduct_amt);
      gpstatement.bindColumn(11, idx_subtr_amt);
      gpstatement.bindColumn(12, idx_loan_cap);
      gpstatement.bindColumn(13, idx_refund_amt);
      gpstatement.bindColumn(14, idx_bank_head_code);
      gpstatement.bindColumn(15, idx_bank_head_name);
      gpstatement.bindColumn(16, idx_deposit_no);
      gpstatement.bindColumn(17, idx_annul_reason);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sale_annul set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "refund_date=?,  " + 
                            "penalty=?,  " + 
                            "term_interest=?,  " + 
                            "income_tax=?,  " + 
                            "residence_tax=?,  " + 
                            "lease_deduct_amt=?,  " + 
                            "subtr_amt=?,  " + 
                            "loan_cap=?,  " + 
                            "refund_amt=?,  " + 
                            "bank_head_code=?,  " + 
                            "bank_head_name=?,  " + 
                            "deposit_no=?,  " + 
                            "annul_reason=?  where dept_code=? " +
                            "                  and sell_code=? " +
                            "                  and dongho=?" +
                            "                  and seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_refund_date);
      gpstatement.bindColumn(6, idx_penalty);
      gpstatement.bindColumn(7, idx_term_interest);
      gpstatement.bindColumn(8, idx_income_tax);
      gpstatement.bindColumn(9, idx_residence_tax);
      gpstatement.bindColumn(10, idx_lease_deduct_amt);
      gpstatement.bindColumn(11, idx_subtr_amt);
      gpstatement.bindColumn(12, idx_loan_cap);
      gpstatement.bindColumn(13, idx_refund_amt);
      gpstatement.bindColumn(14, idx_bank_head_code);
      gpstatement.bindColumn(15, idx_bank_head_name);
      gpstatement.bindColumn(16, idx_deposit_no);
      gpstatement.bindColumn(17, idx_annul_reason);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(18, idx_dept_code);
      gpstatement.bindColumn(19, idx_sell_code);
      gpstatement.bindColumn(20, idx_dongho);
      gpstatement.bindColumn(21, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sale_annul where dept_code=? " +
      													"  and sell_code=? " +
      													"  and dongho=?" +
      													"  and seq=?"; 
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