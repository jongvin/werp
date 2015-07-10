<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_unin_member_paymaster_2tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_union_code = dSet.indexOfColumn("union_code");
   	int idx_union_id = dSet.indexOfColumn("union_id");
   	int idx_union_seq = dSet.indexOfColumn("union_seq");
   	int idx_pay_degree = dSet.indexOfColumn("pay_degree");
   	int idx_pay_date = dSet.indexOfColumn("pay_date");
   	int idx_pay_amt = dSet.indexOfColumn("pay_amt");
   	int idx_int_div = dSet.indexOfColumn("int_div");
   	int idx_month_interest = dSet.indexOfColumn("month_interest");
   	int idx_interest_day = dSet.indexOfColumn("interest_day");
   	int idx_tot_amt = dSet.indexOfColumn("tot_amt");
   	int idx_f_pay_yn = dSet.indexOfColumn("f_pay_yn");
   	int idx_payer_tag = dSet.indexOfColumn("payer_tag");
   	int idx_interest_rate = dSet.indexOfColumn("interest_rate");
   	int idx_bank_name = dSet.indexOfColumn("bank_name");
   	int idx_repay_date = dSet.indexOfColumn("repay_date");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_UNIN_MOVE_PAY ( dept_code," + 
                    "sell_code," + 
                    "union_code," + 
                    "union_id," + 
                    "union_seq," + 
                    "pay_degree," + 
                    "pay_date," + 
                    "pay_amt," + 
                    "int_div," + 
                    "month_interest," + 
                    "interest_day," + 
                    "tot_amt," + 
                    "f_pay_yn," + 
                    "payer_tag," + 
                    "interest_rate," + 
                    "bank_name," + 
                    "repay_date )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_union_id);
      gpstatement.bindColumn(5, idx_union_seq);
      gpstatement.bindColumn(6, idx_pay_degree);
      gpstatement.bindColumn(7, idx_pay_date);
      gpstatement.bindColumn(8, idx_pay_amt);
      gpstatement.bindColumn(9, idx_int_div);
      gpstatement.bindColumn(10, idx_month_interest);
      gpstatement.bindColumn(11, idx_interest_day);
      gpstatement.bindColumn(12, idx_tot_amt);
      gpstatement.bindColumn(13, idx_f_pay_yn);
      gpstatement.bindColumn(14, idx_payer_tag);
      gpstatement.bindColumn(15, idx_interest_rate);
      gpstatement.bindColumn(16, idx_bank_name);
      gpstatement.bindColumn(17, idx_repay_date);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_unin_move_pay set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "union_code=?,  " + 
                            "union_id=?,  " + 
                            "union_seq=?,  " + 
                            "pay_degree=?,  " + 
                            "pay_date=?,  " + 
                            "pay_amt=?,  " + 
                            "int_div=?,  " + 
                            "month_interest=?,  " + 
                            "interest_day=?,  " + 
                            "tot_amt=?,  " + 
                            "f_pay_yn=?,  " + 
                            "payer_tag=?,  " + 
                            "interest_rate=?,  " + 
                            "bank_name=?,  " + 
                            "repay_date=?  where dept_code=? " +
                            "              and sell_code=? " +
                            "              and union_code=? " +
                            "              and union_id=? " +
                            "              and union_seq=? " +
                            "              and pay_degree=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_union_id);
      gpstatement.bindColumn(5, idx_union_seq);
      gpstatement.bindColumn(6, idx_pay_degree);
      gpstatement.bindColumn(7, idx_pay_date);
      gpstatement.bindColumn(8, idx_pay_amt);
      gpstatement.bindColumn(9, idx_int_div);
      gpstatement.bindColumn(10, idx_month_interest);
      gpstatement.bindColumn(11, idx_interest_day);
      gpstatement.bindColumn(12, idx_tot_amt);
      gpstatement.bindColumn(13, idx_f_pay_yn);
      gpstatement.bindColumn(14, idx_payer_tag);
      gpstatement.bindColumn(15, idx_interest_rate);
      gpstatement.bindColumn(16, idx_bank_name);
      gpstatement.bindColumn(17, idx_repay_date);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(18, idx_dept_code);
      gpstatement.bindColumn(19, idx_sell_code);
      gpstatement.bindColumn(20, idx_union_code);
      gpstatement.bindColumn(21, idx_union_id);
      gpstatement.bindColumn(22, idx_union_seq);
      gpstatement.bindColumn(23, idx_pay_degree);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_unin_move_pay where dept_code=? " + 
                            "              and sell_code=? " +
                            "              and union_code=? " +
                            "              and union_id=? " +
                            "              and union_seq=? " +
                            "              and pay_degree=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_union_id);
      gpstatement.bindColumn(5, idx_union_seq);
      gpstatement.bindColumn(6, idx_pay_degree);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>