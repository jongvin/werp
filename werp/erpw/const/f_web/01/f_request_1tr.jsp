<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("f_request_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_rqst_date = dSet.indexOfColumn("rqst_date");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_res_type = dSet.indexOfColumn("res_type");
	int idx_exe_type = dSet.indexOfColumn("exe_type");
   	int idx_rqst_detail = dSet.indexOfColumn("rqst_detail");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_cust_name = dSet.indexOfColumn("cust_name");
   	int idx_vatcode = dSet.indexOfColumn("vatcode");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_vat = dSet.indexOfColumn("vat");
   	int idx_acntcode = dSet.indexOfColumn("acntcode");
	int idx_acntname = dSet.indexOfColumn("acntname");
   	int idx_fund_type = dSet.indexOfColumn("fund_type");
   	int idx_cost_type = dSet.indexOfColumn("cost_type");
   	int idx_receipt_rqst_type = dSet.indexOfColumn("receipt_rqst_type");
   	int idx_receipt_date = dSet.indexOfColumn("receipt_date");
   	int idx_credit_card_no = dSet.indexOfColumn("credit_card_no");
   	int idx_card_user = dSet.indexOfColumn("card_user");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
   	int idx_key_seq = dSet.indexOfColumn("key_seq");
   	int idx_use_name = dSet.indexOfColumn("use_name");
   	int idx_cash_amt = dSet.indexOfColumn("cash_amt");
   	int idx_bill_amt = dSet.indexOfColumn("bill_amt");
   	int idx_deduct_amt = dSet.indexOfColumn("deduct_amt");
   	int idx_code = dSet.indexOfColumn("code");
   	int idx_det_code = dSet.indexOfColumn("det_code"); 	
	int idx_item_code = dSet.indexOfColumn("item_code"); 	
	int idx_invoice_num = dSet.indexOfColumn("invoice_num"); 	
	int idx_dr_class = dSet.indexOfColumn("dr_class"); 	
	int idx_pay_date = dSet.indexOfColumn("pay_date");
	int idx_income_type = dSet.indexOfColumn("income_type");
	int idx_income_amt = dSet.indexOfColumn("income_amt");
	int idx_civi_amt = dSet.indexOfColumn("civi_amt");
	int idx_work_date = dSet.indexOfColumn("work_date");
	int idx_temp_chk = dSet.indexOfColumn("temp_chk");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO F_REQUEST ( dept_code," + 
                    "rqst_date," + 
                    "seq," + 
                    "res_type," + 
					"exe_type," +
                    "rqst_detail," + 
                    "order_number," + 
                    "cust_code," + 
                    "cust_name," + 
                    "vatcode," + 
                    "amt," + 
                    "vat," + 
                    "acntcode," + 
					"acntname," + 
                    "fund_type," + 
                    "cost_type," + 
                    "receipt_rqst_type," + 
                    "receipt_date," + 
                    "credit_card_no," + 
                    "card_user," + 
                    "spec_no_seq," + 
                    "spec_unq_num," +
                    "use_name, " +
                    "cash_amt, " +
                    "bill_amt, " +
                    "deduct_amt, " +
                    "code, " +
                    "det_code, "+
					"item_code,invoice_num,dr_class, pay_date,income_type,income_amt,civi_amt ,work_date,temp_chk)      ";
      sSql = sSql + " VALUES ( :1, :2,(select nvl(max(seq),0)+1 from f_request where dept_code = :3 and rqst_date = :4), :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30,:31,:32, :33,:34,:35,:36,:37,:38 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_rqst_date);
	  gpstatement.bindColumn(3, idx_dept_code);
      gpstatement.bindColumn(4, idx_rqst_date);
      gpstatement.bindColumn(5, idx_res_type);
	  gpstatement.bindColumn(6, idx_exe_type);
      gpstatement.bindColumn(7, idx_rqst_detail);
      gpstatement.bindColumn(8, idx_order_number);
      gpstatement.bindColumn(9, idx_cust_code);
      gpstatement.bindColumn(10, idx_cust_name);
      gpstatement.bindColumn(11, idx_vatcode);
      gpstatement.bindColumn(12, idx_amt);
      gpstatement.bindColumn(13, idx_vat);
      gpstatement.bindColumn(14, idx_acntcode);
	  gpstatement.bindColumn(15, idx_acntname);
      gpstatement.bindColumn(16, idx_fund_type);
      gpstatement.bindColumn(17, idx_cost_type);
      gpstatement.bindColumn(18, idx_receipt_rqst_type);
      gpstatement.bindColumn(19, idx_receipt_date);
      gpstatement.bindColumn(20, idx_credit_card_no);
      gpstatement.bindColumn(21, idx_card_user);
      gpstatement.bindColumn(22, idx_spec_no_seq);
      gpstatement.bindColumn(23, idx_spec_unq_num);
      gpstatement.bindColumn(24, idx_use_name);
      gpstatement.bindColumn(25, idx_cash_amt);
      gpstatement.bindColumn(26, idx_bill_amt);
      gpstatement.bindColumn(27, idx_deduct_amt);
      gpstatement.bindColumn(28, idx_code);
      gpstatement.bindColumn(29, idx_det_code);
	  gpstatement.bindColumn(30, idx_item_code);
	  gpstatement.bindColumn(31, idx_invoice_num);
	  gpstatement.bindColumn(32, idx_dr_class);
	  gpstatement.bindColumn(33, idx_pay_date);
	  gpstatement.bindColumn(34, idx_income_type);
	  gpstatement.bindColumn(35, idx_income_amt);
	  gpstatement.bindColumn(36, idx_civi_amt);
	  gpstatement.bindColumn(37, idx_work_date);
	  gpstatement.bindColumn(38, idx_temp_chk);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update f_request set " + 
                            "dept_code=?,  " + 
                            "rqst_date=?,  " + 
                            "seq=?,  " + 
                            "res_type=?,  " + 
							"exe_type=?,  " + 
                            "rqst_detail=?,  " + 
                            "order_number=?,  " + 
                            "cust_code=?,  " + 
                            "cust_name=?,  " + 
                            "vatcode=?,  " + 
                            "amt=?,  " + 
                            "vat=?,  " + 
                            "acntcode=?,  " + 
							"acntname=?,  " + 
                            "fund_type=?,  " + 
                            "cost_type=?,  " + 
                            "receipt_rqst_type=?,  " + 
                            "receipt_date=?,  " + 
                            "credit_card_no=?,  " + 
                            "card_user=?,  " + 
                            "spec_no_seq=?,  " + 
                            "spec_unq_num=?,  " + 
                            "use_name=?, " +
                            "cash_amt=?, " +
                            "bill_amt=?, " +
                            "deduct_amt=?, " +
                            "code=?, " +
                            "det_code=?,"+
	                        " item_code=? ,invoice_num=?,dr_class=?, pay_date=? ,income_type=?,income_amt=?,civi_amt=?,work_date=?,temp_chk=? where dept_code=? " +
                            " and rqst_date=?  " + 
                            " and seq=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_rqst_date);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_res_type);
	  gpstatement.bindColumn(5, idx_exe_type);
      gpstatement.bindColumn(6, idx_rqst_detail);
      gpstatement.bindColumn(7, idx_order_number);
      gpstatement.bindColumn(8, idx_cust_code);
      gpstatement.bindColumn(9, idx_cust_name);
      gpstatement.bindColumn(10, idx_vatcode);
      gpstatement.bindColumn(11, idx_amt);
      gpstatement.bindColumn(12, idx_vat);
      gpstatement.bindColumn(13, idx_acntcode);
	  gpstatement.bindColumn(14, idx_acntname);
      gpstatement.bindColumn(15, idx_fund_type);
      gpstatement.bindColumn(16, idx_cost_type);
      gpstatement.bindColumn(17, idx_receipt_rqst_type);
      gpstatement.bindColumn(18, idx_receipt_date);
      gpstatement.bindColumn(19, idx_credit_card_no);
      gpstatement.bindColumn(20, idx_card_user);
      gpstatement.bindColumn(21, idx_spec_no_seq);
      gpstatement.bindColumn(22, idx_spec_unq_num);
      gpstatement.bindColumn(23, idx_use_name);
      gpstatement.bindColumn(24, idx_cash_amt);
      gpstatement.bindColumn(25, idx_bill_amt);
      gpstatement.bindColumn(26, idx_deduct_amt);
      gpstatement.bindColumn(27, idx_code);
      gpstatement.bindColumn(28, idx_det_code);
	  gpstatement.bindColumn(29, idx_item_code);
	  gpstatement.bindColumn(30, idx_invoice_num);
	  gpstatement.bindColumn(31, idx_dr_class);
	  gpstatement.bindColumn(32, idx_pay_date);
	  gpstatement.bindColumn(33, idx_income_type);
	  gpstatement.bindColumn(34, idx_income_amt);
	  gpstatement.bindColumn(35, idx_civi_amt);
	  gpstatement.bindColumn(36, idx_work_date);
	  gpstatement.bindColumn(37, idx_temp_chk);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(38, idx_dept_code);
      gpstatement.bindColumn(39, idx_rqst_date);
      gpstatement.bindColumn(40, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from f_request where dept_code=? " +
                            " and rqst_date=?  " + 
                            " and seq=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_rqst_date);
      gpstatement.bindColumn(3, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>