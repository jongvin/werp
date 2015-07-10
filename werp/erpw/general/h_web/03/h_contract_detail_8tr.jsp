<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_contract_detail_8tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
		int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
		int idx_union_code = dSet.indexOfColumn("union_code");
		int idx_union_id = dSet.indexOfColumn("union_id");
		int idx_union_seq = dSet.indexOfColumn("union_seq");
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_pyong = dSet.indexOfColumn("pyong");
   	int idx_contract_date = dSet.indexOfColumn("contract_date");
   	int idx_res_dongho = dSet.indexOfColumn("res_dongho");
   	int idx_change_div = dSet.indexOfColumn("change_div");
   	int idx_change_date = dSet.indexOfColumn("change_date");
   	int idx_last_contract_date = dSet.indexOfColumn("last_contract_date");
   	int idx_compensation_quota = dSet.indexOfColumn("compensation_quota");
   	int idx_grnd_quota = dSet.indexOfColumn("grnd_quota");
   	int idx_pyong_sellamt = dSet.indexOfColumn("pyong_sellamt");
   	int idx_collateral_amt = dSet.indexOfColumn("collateral_amt");
   	int idx_move_date = dSet.indexOfColumn("move_date");
   	int idx_mortgage = dSet.indexOfColumn("mortgage");
   	int idx_contract_pyong = dSet.indexOfColumn("contract_pyong");
   	int idx_draw_date = dSet.indexOfColumn("draw_date");
   	int idx_prize_dongho = dSet.indexOfColumn("prize_dongho");
   	int idx_prize_pyong = dSet.indexOfColumn("prize_pyong");
   	int idx_settlement_amt = dSet.indexOfColumn("settlement_amt");
   	int idx_annul_reason = dSet.indexOfColumn("annul_reason");
   	int idx_refund_date = dSet.indexOfColumn("refund_date");
   	int idx_penalty = dSet.indexOfColumn("penalty");
   	int idx_interest_remain_amt = dSet.indexOfColumn("interest_remain_amt");
   	int idx_refund_amt = dSet.indexOfColumn("refund_amt");
   	int idx_rebuild_yn = dSet.indexOfColumn("rebuild_yn");
   	int idx_loan_bank = dSet.indexOfColumn("loan_bank");
   	int idx_loan_date = dSet.indexOfColumn("loan_date");
   	int idx_loan_amt = dSet.indexOfColumn("loan_amt");
   	int idx_loan_interest = dSet.indexOfColumn("loan_interest");
   	int idx_seizure_amt = dSet.indexOfColumn("seizure_amt");
   	int idx_seizure_date = dSet.indexOfColumn("seizure_date");
		int idx_member_pay_amt = dSet.indexOfColumn("member_pay_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_SALE_DETAIL_UNION ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "cust_code," + 
                    "pyong," + 
                    "contract_date," + 
                    "res_dongho," + 
                    "change_div," + 
                    "change_date," + 
                    "last_contract_date," + 
                    "compensation_quota," + 
                    "grnd_quota," + 
                    "pyong_sellamt," + 
                    "collateral_amt," + 
                    "move_date," + 
                    "mortgage," + 
                    "contract_pyong," + 
                    "draw_date," + 
                    "prize_dongho," + 
                    "prize_pyong," + 
                    "settlement_amt," + 
                    "annul_reason," + 
                    "refund_date," + 
                    "penalty," + 
                    "interest_remain_amt," + 
                    "refund_amt," + 
                    "rebuild_yn," + 
                    "loan_bank," + 
                    "loan_date," + 
                    "loan_amt," + 
                    "loan_interest," + 
                    "seizure_amt," + 
                    "seizure_date )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, :31, :32, :33, :34 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_cust_code);
      gpstatement.bindColumn(6, idx_pyong);
      gpstatement.bindColumn(7, idx_contract_date);
      gpstatement.bindColumn(8, idx_res_dongho);
      gpstatement.bindColumn(9, idx_change_div);
      gpstatement.bindColumn(10, idx_change_date);
      gpstatement.bindColumn(11, idx_last_contract_date);
      gpstatement.bindColumn(12, idx_compensation_quota);
      gpstatement.bindColumn(13, idx_grnd_quota);
      gpstatement.bindColumn(14, idx_pyong_sellamt);
      gpstatement.bindColumn(15, idx_collateral_amt);
      gpstatement.bindColumn(16, idx_move_date);
      gpstatement.bindColumn(17, idx_mortgage);
      gpstatement.bindColumn(18, idx_contract_pyong);
      gpstatement.bindColumn(19, idx_draw_date);
      gpstatement.bindColumn(20, idx_prize_dongho);
      gpstatement.bindColumn(21, idx_prize_pyong);
      gpstatement.bindColumn(22, idx_settlement_amt);
      gpstatement.bindColumn(23, idx_annul_reason);
      gpstatement.bindColumn(24, idx_refund_date);
      gpstatement.bindColumn(25, idx_penalty);
      gpstatement.bindColumn(26, idx_interest_remain_amt);
      gpstatement.bindColumn(27, idx_refund_amt);
      gpstatement.bindColumn(28, idx_rebuild_yn);
      gpstatement.bindColumn(29, idx_loan_bank);
      gpstatement.bindColumn(30, idx_loan_date);
      gpstatement.bindColumn(31, idx_loan_amt);
      gpstatement.bindColumn(32, idx_loan_interest);
      gpstatement.bindColumn(33, idx_seizure_amt);
      gpstatement.bindColumn(34, idx_seizure_date);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_unin_member set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "union_code=?,  " +
	                         "union_id=?,  " +
                            "union_seq=?,  " + 
                            "cust_code=?,  " + 
                            "pyong=?,  " + 
                            "contract_date=?,  " + 
                            "res_dongho=?,  " + 
                            "change_div=?,  " + 
                            "change_date=?,  " + 
                            "last_contract_date=?,  " + 
                            "compensation_quota=?,  " + 
                            "grnd_quota=?,  " + 
                            "pyong_sellamt=?,  " + 
                            "collateral_amt=?,  " + 
                            "move_date=?,  " + 
                            "mortgage=?,  " + 
                            "contract_pyong=?,  " + 
                            "draw_date=?,  " + 
                            "prize_dongho=?,  " + 
                            "prize_pyong=?,  " + 
                            "settlement_amt=?,  " + 
                            "annul_reason=?,  " + 
                            "refund_date=?,  " + 
                            "penalty=?,  " + 
                            "interest_remain_amt=?,  " + 
                            "refund_amt=?,  " + 
                            "rebuild_yn=?,  " + 
                            "loan_bank=?,  " + 
                            "loan_date=?,  " + 
                            "loan_amt=?,  " + 
                            "loan_interest=?,  " + 
                            "seizure_amt=?,  " + 
                            "seizure_date=? , "+
	                          " member_pay_amt=?  where dept_code=? " +
                            "                  and sell_code=? " +
                            "                  and union_code=? " +
	                         "                  and union_id=? " +
                            "                  and union_seq=? " ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
		gpstatement.bindColumn(4, idx_union_id);
      gpstatement.bindColumn(5, idx_union_seq);
      gpstatement.bindColumn(6, idx_cust_code);
      gpstatement.bindColumn(7, idx_pyong);
      gpstatement.bindColumn(8, idx_contract_date);
      gpstatement.bindColumn(9, idx_res_dongho);
      gpstatement.bindColumn(10, idx_change_div);
      gpstatement.bindColumn(11, idx_change_date);
      gpstatement.bindColumn(12, idx_last_contract_date);
      gpstatement.bindColumn(13, idx_compensation_quota);
      gpstatement.bindColumn(14, idx_grnd_quota);
      gpstatement.bindColumn(15, idx_pyong_sellamt);
      gpstatement.bindColumn(16, idx_collateral_amt);
      gpstatement.bindColumn(17, idx_move_date);
      gpstatement.bindColumn(18, idx_mortgage);
      gpstatement.bindColumn(19, idx_contract_pyong);
      gpstatement.bindColumn(20, idx_draw_date);
      gpstatement.bindColumn(21, idx_prize_dongho);
      gpstatement.bindColumn(22, idx_prize_pyong);
      gpstatement.bindColumn(23, idx_settlement_amt);
      gpstatement.bindColumn(24, idx_annul_reason);
      gpstatement.bindColumn(25, idx_refund_date);
      gpstatement.bindColumn(26, idx_penalty);
      gpstatement.bindColumn(27, idx_interest_remain_amt);
      gpstatement.bindColumn(28, idx_refund_amt);
      gpstatement.bindColumn(29, idx_rebuild_yn);
      gpstatement.bindColumn(30, idx_loan_bank);
      gpstatement.bindColumn(31, idx_loan_date);
      gpstatement.bindColumn(32, idx_loan_amt);
      gpstatement.bindColumn(33, idx_loan_interest);
      gpstatement.bindColumn(34, idx_seizure_amt);
      gpstatement.bindColumn(35, idx_seizure_date);
		gpstatement.bindColumn(36, idx_member_pay_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(37, idx_dept_code);
      gpstatement.bindColumn(38, idx_sell_code);
      gpstatement.bindColumn(39, idx_union_code);
		gpstatement.bindColumn(40, idx_union_id);
      gpstatement.bindColumn(41, idx_union_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sale_detail_union where dept_code=? " + 
                            "                  and sell_code=? " +
                            "                  and dongho=? " +
                            "                  and seq=? " ;  
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