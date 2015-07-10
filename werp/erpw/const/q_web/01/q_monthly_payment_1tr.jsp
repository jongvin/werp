<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("q_monthly_payment_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymm = dSet.indexOfColumn("yymm");
   	int idx_regist_no = dSet.indexOfColumn("regist_no");
   	int idx_monthly_amt = dSet.indexOfColumn("monthly_amt");
   	int idx_vat = dSet.indexOfColumn("vat");
   	int idx_pay_cash = dSet.indexOfColumn("pay_cash");
   	int idx_pay_bill = dSet.indexOfColumn("pay_bill");
   	int idx_payterm = dSet.indexOfColumn("payterm");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_key_regist_no = dSet.indexOfColumn("key_regist_no");
   	int idx_invoice_num = dSet.indexOfColumn("invoice_num");
   	int idx_bill_day = dSet.indexOfColumn("bill_day");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO Q_MONTHLY_PAYMENT ( dept_code," + 
                    "yymm," + 
                    "regist_no," + 
                    "monthly_amt," + 
                    "vat," + 
                    "pay_cash," + 
                    "pay_bill," + 
                    "payterm," + 
                    "remark ,invoice_num,bill_day)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9 ,:10,:11) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_regist_no);
      gpstatement.bindColumn(4, idx_monthly_amt);
      gpstatement.bindColumn(5, idx_vat);
      gpstatement.bindColumn(6, idx_pay_cash);
      gpstatement.bindColumn(7, idx_pay_bill);
      gpstatement.bindColumn(8, idx_payterm);
      gpstatement.bindColumn(9, idx_remark);
      gpstatement.bindColumn(10, idx_invoice_num);
      gpstatement.bindColumn(11, idx_bill_day);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update q_monthly_payment set " + 
                            "dept_code=?,  " + 
                            "yymm=?,  " + 
                            "regist_no=?,  " + 
                            "monthly_amt=?,  " + 
                            "vat=?,  " + 
                            "pay_cash=?,  " + 
                            "pay_bill=?,  " + 
                            "payterm=?,  " + 
                            "remark=?,invoice_num=? ,bill_day=? where dept_code=? " +
                            " and yymm=? " +
                            " and regist_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_key_regist_no);
      gpstatement.bindColumn(4, idx_monthly_amt);
      gpstatement.bindColumn(5, idx_vat);
      gpstatement.bindColumn(6, idx_pay_cash);
      gpstatement.bindColumn(7, idx_pay_bill);
      gpstatement.bindColumn(8, idx_payterm);
      gpstatement.bindColumn(9, idx_remark);
      gpstatement.bindColumn(10, idx_invoice_num);
      gpstatement.bindColumn(11, idx_bill_day);
/* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(12, idx_dept_code);
      gpstatement.bindColumn(13, idx_yymm);
      gpstatement.bindColumn(14, idx_key_regist_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from q_monthly_payment where dept_code=? " +  
	                    " and yymm=? " +
                            " and regist_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_yymm);
      gpstatement.bindColumn(3, idx_regist_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>