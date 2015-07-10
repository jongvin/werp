<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_pay_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_prgs_degree = dSet.indexOfColumn("prgs_degree");
   	int idx_prgs_start_dt = dSet.indexOfColumn("prgs_start_dt");
   	int idx_prgs_end_dt = dSet.indexOfColumn("prgs_end_dt");
   	int idx_checker = dSet.indexOfColumn("checker");
   	int idx_check_dt = dSet.indexOfColumn("check_dt");
   	int idx_pay_dt = dSet.indexOfColumn("pay_dt");
   	int idx_pay_cond = dSet.indexOfColumn("pay_cond");
   	int idx_pre_prgs = dSet.indexOfColumn("pre_prgs");
   	int idx_pre_prgs_notax = dSet.indexOfColumn("pre_prgs_notax");
   	int idx_pre_sbc_deduction = dSet.indexOfColumn("pre_sbc_deduction");
   	int idx_pre_advance_deduction = dSet.indexOfColumn("pre_advance_deduction");
   	int idx_pre_employ_amt = dSet.indexOfColumn("pre_employ_amt");
   	int idx_pre_etc_amt = dSet.indexOfColumn("pre_etc_amt");
   	int idx_pre_deduction_detail = dSet.indexOfColumn("pre_deduction_detail");
   	int idx_pre_purchase_vat = dSet.indexOfColumn("pre_purchase_vat");
   	int idx_pre_misctax = dSet.indexOfColumn("pre_misctax");
   	int idx_pre_misctax_notax = dSet.indexOfColumn("pre_misctax_notax");
   	int idx_pre_vat = dSet.indexOfColumn("pre_vat");
   	int idx_pre_netpay_amt = dSet.indexOfColumn("pre_netpay_amt");
   	int idx_pre_pay = dSet.indexOfColumn("pre_pay");
   	int idx_pre_cash = dSet.indexOfColumn("pre_cash");
   	int idx_pre_bill = dSet.indexOfColumn("pre_bill");
   	int idx_tm_prgs = dSet.indexOfColumn("tm_prgs");
   	int idx_tm_prgs_notax = dSet.indexOfColumn("tm_prgs_notax");
   	int idx_tm_sbc_deduction = dSet.indexOfColumn("tm_sbc_deduction");
   	int idx_tm_advance_deduction = dSet.indexOfColumn("tm_advance_deduction");
   	int idx_tm_employ_amt = dSet.indexOfColumn("tm_employ_amt");
   	int idx_tm_etc_amt = dSet.indexOfColumn("tm_etc_amt");
   	int idx_tm_deduction_detail = dSet.indexOfColumn("tm_deduction_detail");
   	int idx_tm_purchase_vat = dSet.indexOfColumn("tm_purchase_vat");
   	int idx_tm_misctax = dSet.indexOfColumn("tm_misctax");
   	int idx_tm_misctax_notax = dSet.indexOfColumn("tm_misctax_notax");
   	int idx_tm_vat = dSet.indexOfColumn("tm_vat");
   	int idx_tm_netpay_amt = dSet.indexOfColumn("tm_netpay_amt");
   	int idx_tm_pay = dSet.indexOfColumn("tm_pay");
   	int idx_tm_cash = dSet.indexOfColumn("tm_cash");
   	int idx_tm_bill = dSet.indexOfColumn("tm_bill");
   	int idx_price_pay_dt = dSet.indexOfColumn("price_pay_dt");
   	int idx_mediation_reason = dSet.indexOfColumn("mediation_reason");
   	int idx_mediation_amt = dSet.indexOfColumn("mediation_amt");
   	int idx_mediation_dt = dSet.indexOfColumn("mediation_dt");
   	int idx_mediation_vat = dSet.indexOfColumn("mediation_vat");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_web_yn = dSet.indexOfColumn("web_yn");
   	int idx_slipseq = dSet.indexOfColumn("slipseq");
   	int idx_invoice_num = dSet.indexOfColumn("invoice_num");
   	int idx_pre_pre_tax = dSet.indexOfColumn("pre_pre_tax");
   	int idx_pre_pre_notax = dSet.indexOfColumn("pre_pre_notax");
   	int idx_pre_pre_vat = dSet.indexOfColumn("pre_pre_vat");
   	int idx_tm_pre_tax = dSet.indexOfColumn("tm_pre_tax");
   	int idx_tm_pre_notax = dSet.indexOfColumn("tm_pre_notax");
   	int idx_tm_pre_vat = dSet.indexOfColumn("tm_pre_vat");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_pay ( dept_code," + 
                    "yymm," + 
                    "seq," + 
                    "order_number," + 
                    "prgs_degree," + 
                    "prgs_start_dt," + 
                    "prgs_end_dt," + 
                    "checker," + 
                    "check_dt," + 
                    "pay_dt," + 
                    "pay_cond," + 
                    "pre_prgs," + 
                    "pre_prgs_notax," + 
                    "pre_sbc_deduction," + 
                    "pre_advance_deduction," + 
                    "pre_employ_amt," + 
                    "pre_etc_amt," + 
                    "pre_deduction_detail," + 
                    "pre_purchase_vat," + 
                    "pre_misctax," + 
                    "pre_misctax_notax," + 
                    "pre_vat," + 
                    "pre_netpay_amt," + 
                    "pre_pay," + 
                    "pre_cash," + 
                    "pre_bill," + 
                    "tm_prgs," + 
                    "tm_prgs_notax," + 
                    "tm_sbc_deduction," + 
                    "tm_advance_deduction," + 
                    "tm_employ_amt," + 
                    "tm_etc_amt," + 
                    "tm_deduction_detail," + 
                    "tm_purchase_vat," + 
                    "tm_misctax," + 
                    "tm_misctax_notax," + 
                    "tm_vat," + 
                    "tm_netpay_amt," + 
                    "tm_pay," + 
                    "tm_cash," + 
                    "tm_bill," + 
                    "price_pay_dt," + 
                    "mediation_reason," + 
                    "mediation_amt," + 
                    "mediation_dt," + 
                    "mediation_vat," + 
                    "remark,      "  + 
                    "web_yn ,invoice_num ,slipseq,pre_pre_tax,pre_pre_notax,pre_pre_vat,tm_pre_tax,tm_pre_notax,tm_pre_vat)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, :31, :32, :33, :34, :35, :36, :37, :38, :39, :40, :41, :42, :43, :44, :45, :46, :47, :48,:49,:50,:51,:52,:53,:54,:55,:56 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_order_number);
      gpstatement.bindColumn(5, idx_prgs_degree);
      gpstatement.bindColumn(6, idx_prgs_start_dt);
      gpstatement.bindColumn(7, idx_prgs_end_dt);
      gpstatement.bindColumn(8, idx_checker);
      gpstatement.bindColumn(9, idx_check_dt);
      gpstatement.bindColumn(10, idx_pay_dt);
      gpstatement.bindColumn(11, idx_pay_cond);
      gpstatement.bindColumn(12, idx_pre_prgs);
      gpstatement.bindColumn(13, idx_pre_prgs_notax);
      gpstatement.bindColumn(14, idx_pre_sbc_deduction);
      gpstatement.bindColumn(15, idx_pre_advance_deduction);
      gpstatement.bindColumn(16, idx_pre_employ_amt);
      gpstatement.bindColumn(17, idx_pre_etc_amt);
      gpstatement.bindColumn(18, idx_pre_deduction_detail);
      gpstatement.bindColumn(19, idx_pre_purchase_vat);
      gpstatement.bindColumn(20, idx_pre_misctax);
      gpstatement.bindColumn(21, idx_pre_misctax_notax);
      gpstatement.bindColumn(22, idx_pre_vat);
      gpstatement.bindColumn(23, idx_pre_netpay_amt);
      gpstatement.bindColumn(24, idx_pre_pay);
      gpstatement.bindColumn(25, idx_pre_cash);
      gpstatement.bindColumn(26, idx_pre_bill);
      gpstatement.bindColumn(27, idx_tm_prgs);
      gpstatement.bindColumn(28, idx_tm_prgs_notax);
      gpstatement.bindColumn(29, idx_tm_sbc_deduction);
      gpstatement.bindColumn(30, idx_tm_advance_deduction);
      gpstatement.bindColumn(31, idx_tm_employ_amt);
      gpstatement.bindColumn(32, idx_tm_etc_amt);
      gpstatement.bindColumn(33, idx_tm_deduction_detail);
      gpstatement.bindColumn(34, idx_tm_purchase_vat);
      gpstatement.bindColumn(35, idx_tm_misctax);
      gpstatement.bindColumn(36, idx_tm_misctax_notax);
      gpstatement.bindColumn(37, idx_tm_vat);
      gpstatement.bindColumn(38, idx_tm_netpay_amt);
      gpstatement.bindColumn(39, idx_tm_pay);
      gpstatement.bindColumn(40, idx_tm_cash);
      gpstatement.bindColumn(41, idx_tm_bill);
      gpstatement.bindColumn(42, idx_price_pay_dt);
      gpstatement.bindColumn(43, idx_mediation_reason);
      gpstatement.bindColumn(44, idx_mediation_amt);
      gpstatement.bindColumn(45, idx_mediation_dt);
      gpstatement.bindColumn(46, idx_mediation_vat);
      gpstatement.bindColumn(47, idx_remark);
      gpstatement.bindColumn(48, idx_web_yn);
      gpstatement.bindColumn(49, idx_invoice_num);
      gpstatement.bindColumn(50, idx_slipseq);
      gpstatement.bindColumn(51, idx_pre_pre_tax);
      gpstatement.bindColumn(52, idx_pre_pre_notax);
      gpstatement.bindColumn(53, idx_pre_pre_vat);
      gpstatement.bindColumn(54, idx_tm_pre_tax);
      gpstatement.bindColumn(55, idx_tm_pre_notax);
      gpstatement.bindColumn(56, idx_tm_pre_vat);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_pay set " + 
                            "dept_code=?,  " + 
                            "yymm=?,  " + 
                            "seq=?,  " + 
                            "order_number=?,  " + 
                            "prgs_degree=?,  " + 
                            "prgs_start_dt=?,  " + 
                            "prgs_end_dt=?,  " + 
                            "checker=?,  " + 
                            "check_dt=?,  " + 
                            "pay_dt=?,  " + 
                            "pay_cond=?,  " + 
                            "pre_prgs=?,  " + 
                            "pre_prgs_notax=?,  " + 
                            "pre_sbc_deduction=?,  " + 
                            "pre_advance_deduction=?,  " + 
                            "pre_employ_amt=?,  " + 
                            "pre_etc_amt=?,  " + 
                            "pre_deduction_detail=?,  " + 
                            "pre_purchase_vat=?,  " + 
                            "pre_misctax=?,  " + 
                            "pre_misctax_notax=?,  " + 
                            "pre_vat=?,  " + 
                            "pre_netpay_amt=?,  " + 
                            "pre_pay=?,  " + 
                            "pre_cash=?,  " + 
                            "pre_bill=?,  " + 
                            "tm_prgs=?,  " + 
                            "tm_prgs_notax=?,  " + 
                            "tm_sbc_deduction=?,  " + 
                            "tm_advance_deduction=?,  " + 
                            "tm_employ_amt=?,  " + 
                            "tm_etc_amt=?,  " + 
                            "tm_deduction_detail=?,  " + 
                            "tm_purchase_vat=?,  " + 
                            "tm_misctax=?,  " + 
                            "tm_misctax_notax=?,  " + 
                            "tm_vat=?,  " + 
                            "tm_netpay_amt=?,  " + 
                            "tm_pay=?,  " + 
                            "tm_cash=?,  " + 
                            "tm_bill=?,  " + 
                            "price_pay_dt=?,  " + 
                            "mediation_reason=?,  " + 
                            "mediation_amt=?,  " + 
                            "mediation_dt=?,  " + 
                            "mediation_vat=?,  " + 
                            "remark=?, " + 
                            "web_yn=?,invoice_num=? ,slipseq=?,pre_pre_tax=?,pre_pre_notax=?,pre_pre_vat=?, " + 
                            "tm_pre_tax=?,tm_pre_notax=?,tm_pre_vat=? " +
                            " where (dept_code=? and yymm=? and seq=? and order_number=?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_order_number);
      gpstatement.bindColumn(5, idx_prgs_degree);
      gpstatement.bindColumn(6, idx_prgs_start_dt);
      gpstatement.bindColumn(7, idx_prgs_end_dt);
      gpstatement.bindColumn(8, idx_checker);
      gpstatement.bindColumn(9, idx_check_dt);
      gpstatement.bindColumn(10, idx_pay_dt);
      gpstatement.bindColumn(11, idx_pay_cond);
      gpstatement.bindColumn(12, idx_pre_prgs);
      gpstatement.bindColumn(13, idx_pre_prgs_notax);
      gpstatement.bindColumn(14, idx_pre_sbc_deduction);
      gpstatement.bindColumn(15, idx_pre_advance_deduction);
      gpstatement.bindColumn(16, idx_pre_employ_amt);
      gpstatement.bindColumn(17, idx_pre_etc_amt);
      gpstatement.bindColumn(18, idx_pre_deduction_detail);
      gpstatement.bindColumn(19, idx_pre_purchase_vat);
      gpstatement.bindColumn(20, idx_pre_misctax);
      gpstatement.bindColumn(21, idx_pre_misctax_notax);
      gpstatement.bindColumn(22, idx_pre_vat);
      gpstatement.bindColumn(23, idx_pre_netpay_amt);
      gpstatement.bindColumn(24, idx_pre_pay);
      gpstatement.bindColumn(25, idx_pre_cash);
      gpstatement.bindColumn(26, idx_pre_bill);
      gpstatement.bindColumn(27, idx_tm_prgs);
      gpstatement.bindColumn(28, idx_tm_prgs_notax);
      gpstatement.bindColumn(29, idx_tm_sbc_deduction);
      gpstatement.bindColumn(30, idx_tm_advance_deduction);
      gpstatement.bindColumn(31, idx_tm_employ_amt);
      gpstatement.bindColumn(32, idx_tm_etc_amt);
      gpstatement.bindColumn(33, idx_tm_deduction_detail);
      gpstatement.bindColumn(34, idx_tm_purchase_vat);
      gpstatement.bindColumn(35, idx_tm_misctax);
      gpstatement.bindColumn(36, idx_tm_misctax_notax);
      gpstatement.bindColumn(37, idx_tm_vat);
      gpstatement.bindColumn(38, idx_tm_netpay_amt);
      gpstatement.bindColumn(39, idx_tm_pay);
      gpstatement.bindColumn(40, idx_tm_cash);
      gpstatement.bindColumn(41, idx_tm_bill);
      gpstatement.bindColumn(42, idx_price_pay_dt);
      gpstatement.bindColumn(43, idx_mediation_reason);
      gpstatement.bindColumn(44, idx_mediation_amt);
      gpstatement.bindColumn(45, idx_mediation_dt);
      gpstatement.bindColumn(46, idx_mediation_vat);
      gpstatement.bindColumn(47, idx_remark);
      gpstatement.bindColumn(48, idx_web_yn);
      gpstatement.bindColumn(49, idx_invoice_num);
      gpstatement.bindColumn(50, idx_slipseq);
      gpstatement.bindColumn(51, idx_pre_pre_tax);
      gpstatement.bindColumn(52, idx_pre_pre_notax);
      gpstatement.bindColumn(53, idx_pre_pre_vat);
      gpstatement.bindColumn(54, idx_tm_pre_tax);
      gpstatement.bindColumn(55, idx_tm_pre_notax);
      gpstatement.bindColumn(56, idx_tm_pre_vat);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(57, idx_dept_code);
      gpstatement.bindColumn(58, idx_yymm);
      gpstatement.bindColumn(59, idx_seq);
      gpstatement.bindColumn(60, idx_order_number);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_pay where (dept_code=? and yymm=? and seq=? and order_number=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_order_number);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>