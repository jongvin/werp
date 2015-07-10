<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_lease_income_grt_detail_5tr");	 gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_cont_date = dSet.indexOfColumn("cont_date");
   	int idx_cont_seq = dSet.indexOfColumn("cont_seq");
   	int idx_credit_code = dSet.indexOfColumn("credit_code");
   	int idx_receipt_date = dSet.indexOfColumn("receipt_date");
   	int idx_credit_no = dSet.indexOfColumn("credit_no");
   	int idx_creditor = dSet.indexOfColumn("creditor");
   	int idx_credit_amt = dSet.indexOfColumn("credit_amt");
   	int idx_not_income_amt = dSet.indexOfColumn("not_income_amt");
   	int idx_not_income_month = dSet.indexOfColumn("not_income_month");
   	int idx_cancel_yn = dSet.indexOfColumn("cancel_yn");
   	int idx_cancel_date = dSet.indexOfColumn("cancel_date");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_key_1 = dSet.indexOfColumn("key_1");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_lease_etc ( dept_code," + 
                    "sell_code," + 
                    "cont_date," + 
                    "cont_seq," + 
                    "credit_code," + 
                    "receipt_date," + 
                    "credit_no," + 
                    "creditor," + 
                    "credit_amt," + 
                    "not_income_amt," + 
                    "not_income_month," + 
                    "cancel_yn," + 
                    "cancel_date," +
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_cont_date);
      gpstatement.bindColumn(4, idx_cont_seq);
      gpstatement.bindColumn(5, idx_credit_code);
      gpstatement.bindColumn(6, idx_receipt_date);
      gpstatement.bindColumn(7, idx_credit_no);
      gpstatement.bindColumn(8, idx_creditor);
      gpstatement.bindColumn(9, idx_credit_amt);
      gpstatement.bindColumn(10, idx_not_income_amt);
      gpstatement.bindColumn(11, idx_not_income_month);
      gpstatement.bindColumn(12, idx_cancel_yn);
      gpstatement.bindColumn(13, idx_cancel_date);
      gpstatement.bindColumn(14, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update h_lease_etc set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "cont_date=?,  " + 
                            "cont_seq=?,  " + 
                            "credit_code=?,  " + 
                            "receipt_date=?,  " + 
                            "credit_no=?,  " + 
                            "creditor=?,  " + 
                            "credit_amt=?,  " + 
                            "not_income_amt=?,  " + 
                            "not_income_month=?,  " + 
                            "cancel_yn=?,  " + 
                            "cancel_date=?,  " +
                            "remark=?  where dept_code=? and sell_code=? and cont_date=? and cont_seq=? and credit_code=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_cont_date);
      gpstatement.bindColumn(4, idx_cont_seq);
      gpstatement.bindColumn(5, idx_credit_code);
      gpstatement.bindColumn(6, idx_receipt_date);
      gpstatement.bindColumn(7, idx_credit_no);
      gpstatement.bindColumn(8, idx_creditor);
      gpstatement.bindColumn(9, idx_credit_amt);
      gpstatement.bindColumn(10, idx_not_income_amt);
      gpstatement.bindColumn(11, idx_not_income_month);
      gpstatement.bindColumn(12, idx_cancel_yn);
      gpstatement.bindColumn(13, idx_cancel_date);
      gpstatement.bindColumn(14, idx_remark);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(15, idx_dept_code);
      gpstatement.bindColumn(16, idx_sell_code);
      gpstatement.bindColumn(17, idx_cont_date);
      gpstatement.bindColumn(18, idx_cont_seq);
      gpstatement.bindColumn(19, idx_key_1);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from h_lease_etc where dept_code=? and sell_code=? and cont_date=? and cont_seq=? and credit_code=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_cont_date;
      gpstatement.bindColumn(4, idx_cont_seq);
      gpstatement.bindColumn(5, idx_key_1);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>