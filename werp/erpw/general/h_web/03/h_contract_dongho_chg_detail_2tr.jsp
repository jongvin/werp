<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_contract_dongho_chg_detail_2tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_degree_code = dSet.indexOfColumn("degree_code");
   	int idx_degree_seq = dSet.indexOfColumn("degree_seq");
   	int idx_receipt_date = dSet.indexOfColumn("receipt_date");
   	int idx_receipt_code = dSet.indexOfColumn("receipt_code");
   	int idx_deposit_no = dSet.indexOfColumn("deposit_no");
   	int idx_r_amt = dSet.indexOfColumn("r_amt");
   	int idx_r_land_amt = dSet.indexOfColumn("r_land_amt");
   	int idx_r_build_amt = dSet.indexOfColumn("r_build_amt");
   	int idx_r_vat_amt = dSet.indexOfColumn("r_vat_amt");
   	int idx_delay_days = dSet.indexOfColumn("delay_days");
   	int idx_delay_amt = dSet.indexOfColumn("delay_amt");
   	int idx_discount_days = dSet.indexOfColumn("discount_days");
   	int idx_discount_amt = dSet.indexOfColumn("discount_amt");
   	int idx_real_amt = dSet.indexOfColumn("real_amt");
   	int idx_input_id = dSet.indexOfColumn("input_id");
   	int idx_input_date = dSet.indexOfColumn("input_date");
   	int idx_work_date = dSet.indexOfColumn("work_date");
   	int idx_work_no = dSet.indexOfColumn("work_no");
   	int idx_tax_date = dSet.indexOfColumn("tax_date");
   	int idx_tax_no = dSet.indexOfColumn("tax_no");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_SALE_INCOME ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "degree_code," + 
                    "degree_seq," + 
                    "receipt_date," + 
                    "receipt_code," + 
                    "deposit_no," + 
                    "r_amt," + 
                    "r_land_amt," + 
                    "r_build_amt," + 
                    "r_vat_amt," + 
                    "delay_days," + 
                    "delay_amt," + 
                    "discount_days," + 
                    "discount_amt," + 
                    "input_id," + 
                    "input_date," + 
                    "work_date," + 
                    "work_no," + 
                    "tax_date," + 
                    "tax_no )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_degree_code);
      gpstatement.bindColumn(6, idx_degree_seq);
      gpstatement.bindColumn(7, idx_receipt_date);
      gpstatement.bindColumn(8, idx_receipt_code);
      gpstatement.bindColumn(9, idx_deposit_no);
      gpstatement.bindColumn(10, idx_r_amt);
      gpstatement.bindColumn(11, idx_r_land_amt);
      gpstatement.bindColumn(12, idx_r_build_amt);
      gpstatement.bindColumn(13, idx_r_vat_amt);
      gpstatement.bindColumn(14, idx_delay_days);
      gpstatement.bindColumn(15, idx_delay_amt);
      gpstatement.bindColumn(16, idx_discount_days);
      gpstatement.bindColumn(17, idx_discount_amt);
      gpstatement.bindColumn(18, idx_input_id);
      gpstatement.bindColumn(19, idx_input_date);
      gpstatement.bindColumn(20, idx_work_date);
      gpstatement.bindColumn(21, idx_work_no);
      gpstatement.bindColumn(22, idx_tax_date);
      gpstatement.bindColumn(23, idx_tax_no);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update h_sale_income set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "degree_code=?,  " + 
                            "degree_seq=?,  " + 
                            "receipt_date=?,  " + 
                            "receipt_code=?,  " + 
                            "deposit_no=?,  " + 
                            "r_amt=?,  " + 
                            "r_land_amt=?,  " + 
                            "r_build_amt=?,  " + 
                            "r_vat_amt=?,  " + 
                            "delay_days=?,  " + 
                            "delay_amt=?,  " + 
                            "discount_days=?,  " + 
                            "discount_amt=?,  " + 
                            "input_id=?,  " + 
                            "input_date=?,  " + 
                            "work_date=?,  " + 
                            "work_no=?,  " + 
                            "tax_date=?,  " + 
                            "tax_no=?  where dept_code=? " +
                            "            and sell_code=? " +
                            "            and dongho=? " +
                            "            and seq=? " +
                            "            and degree_code=? " +
                            "            and degree_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_degree_code);
      gpstatement.bindColumn(6, idx_degree_seq);
      gpstatement.bindColumn(7, idx_receipt_date);
      gpstatement.bindColumn(8, idx_receipt_code);
      gpstatement.bindColumn(9, idx_deposit_no);
      gpstatement.bindColumn(10, idx_r_amt);
      gpstatement.bindColumn(11, idx_r_land_amt);
      gpstatement.bindColumn(12, idx_r_build_amt);
      gpstatement.bindColumn(13, idx_r_vat_amt);
      gpstatement.bindColumn(14, idx_delay_days);
      gpstatement.bindColumn(15, idx_delay_amt);
      gpstatement.bindColumn(16, idx_discount_days);
      gpstatement.bindColumn(17, idx_discount_amt);
      gpstatement.bindColumn(18, idx_input_id);
      gpstatement.bindColumn(19, idx_input_date);
      gpstatement.bindColumn(20, idx_work_date);
      gpstatement.bindColumn(21, idx_work_no);
      gpstatement.bindColumn(22, idx_tax_date);
      gpstatement.bindColumn(23, idx_tax_no);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(24, idx_dept_code);
      gpstatement.bindColumn(25, idx_sell_code);
      gpstatement.bindColumn(26, idx_dongho);
      gpstatement.bindColumn(27, idx_seq);
      gpstatement.bindColumn(28, idx_degree_code);
      gpstatement.bindColumn(29, idx_degree_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from h_sale_income where dept_code=? " +  
                            "            and sell_code=? " +
                            "            and dongho=? " +
                            "            and seq=? " +
                            "            and degree_code=? " +
                            "            and degree_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_degree_code);
      gpstatement.bindColumn(6, idx_degree_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>