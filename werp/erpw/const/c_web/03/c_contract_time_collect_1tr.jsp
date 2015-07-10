<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_contract_time_collect_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_cont_no = dSet.indexOfColumn("cont_no");
   	int idx_chg_degree = dSet.indexOfColumn("chg_degree");
   	int idx_extablish_time = dSet.indexOfColumn("extablish_time");
   	int idx_collection_time = dSet.indexOfColumn("collection_time");
   	int idx_extablish_tag = dSet.indexOfColumn("extablish_tag");
   	int idx_received_date = dSet.indexOfColumn("received_date");
   	int idx_prepay_amt = dSet.indexOfColumn("prepay_amt");
   	int idx_exchange_tag = dSet.indexOfColumn("exchange_tag");
   	int idx_reservation_amt = dSet.indexOfColumn("reservation_amt");
   	int idx_supply_amt = dSet.indexOfColumn("supply_amt");
   	int idx_vat_amt = dSet.indexOfColumn("vat_amt");
   	int idx_sum_amt = dSet.indexOfColumn("sum_amt");
   	int idx_cash_amt = dSet.indexOfColumn("cash_amt");
   	int idx_bill_amt = dSet.indexOfColumn("bill_amt");
   	int idx_bill_date = dSet.indexOfColumn("bill_date");
   	int idx_delay_day = dSet.indexOfColumn("delay_day");
   	int idx_delay_interest_amt = dSet.indexOfColumn("delay_interest_amt");
   	int idx_collection_cond = dSet.indexOfColumn("collection_cond");
   	int idx_bankname = dSet.indexOfColumn("bankname");
   	int idx_deposit_no = dSet.indexOfColumn("deposit_no");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO R_CONTRACT_TIME_COLLECTION ( dept_code,		" + 
                    "        cont_no,														" + 
                    "        chg_degree,													" + 
                    "        extablish_time,												" + 
                    "        collection_time,											" + 
                    "        extablish_tag,												" + 
                    "        received_date,												" + 
                    "        prepay_amt,													" + 
                    "        exchange_tag, 												" +
                    "        reservation_amt,											" + 
                    "        supply_amt,													" + 
                    "        vat_amt,														" + 
                    "        sum_amt,														" + 
                    "        cash_amt,														" + 
                    "        bill_amt,														" + 
                    "        bill_date,													" + 
                    "        delay_day,													" + 
                    "        delay_interest_amt,										" + 
                    "        collection_cond,											" + 
                    "        bankname,														" + 
                    "        deposit_no,													" + 
                    "        remark )      												";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cont_no);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_extablish_time);
      gpstatement.bindColumn(5, idx_collection_time);
      gpstatement.bindColumn(6, idx_extablish_tag);
      gpstatement.bindColumn(7, idx_received_date);
      gpstatement.bindColumn(8, idx_prepay_amt);
      gpstatement.bindColumn(9, idx_exchange_tag);
      gpstatement.bindColumn(10, idx_reservation_amt);
      gpstatement.bindColumn(11, idx_supply_amt);
      gpstatement.bindColumn(12, idx_vat_amt);
      gpstatement.bindColumn(13, idx_sum_amt);
      gpstatement.bindColumn(14, idx_cash_amt);
      gpstatement.bindColumn(15, idx_bill_amt);
      gpstatement.bindColumn(16, idx_bill_date);
      gpstatement.bindColumn(17, idx_delay_day);
      gpstatement.bindColumn(18, idx_delay_interest_amt);
      gpstatement.bindColumn(19, idx_collection_cond);
      gpstatement.bindColumn(20, idx_bankname);
      gpstatement.bindColumn(21, idx_deposit_no);
      gpstatement.bindColumn(22, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update r_contract_time_collection set 	" + 
                    "       dept_code=?,  						" + 
                    "       cont_no=?,  							" + 
                    "       chg_degree=?,  						" + 
                    "       extablish_time=?,  					" + 
                    "       collection_time=?,  				" + 
                    "       extablish_tag=?,  					" + 
                    "       received_date=?,  					" + 
                    "       prepay_amt=?,  						" + 
                    "       exchange_tag=?, 						" +
                    "       reservation_amt=?,  				" + 
                    "       supply_amt=?, 					 	" + 
                    "       vat_amt=?,  							" + 
                    "       sum_amt=?,  							" + 
                    "       cash_amt=?,  							" + 
                    "       bill_amt=?,  							" + 
                    "       bill_date=?,  						" + 
                    "       delay_day=?,  						" + 
                    "       delay_interest_amt=?,  			" + 
                    "       collection_cond=?,  				" + 
                    "       bankname=?,  							" + 
                    "       deposit_no=?,  						" + 
                    "       remark=?  								" + 
                    " where dept_code=? and cont_no=? and chg_degree=? and extablish_time=? and collection_time=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cont_no);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_extablish_time);
      gpstatement.bindColumn(5, idx_collection_time);
      gpstatement.bindColumn(6, idx_extablish_tag);
      gpstatement.bindColumn(7, idx_received_date);
      gpstatement.bindColumn(8, idx_prepay_amt);
      gpstatement.bindColumn(9, idx_exchange_tag);
      gpstatement.bindColumn(10, idx_reservation_amt);
      gpstatement.bindColumn(11, idx_supply_amt);
      gpstatement.bindColumn(12, idx_vat_amt);
      gpstatement.bindColumn(13, idx_sum_amt);
      gpstatement.bindColumn(14, idx_cash_amt);
      gpstatement.bindColumn(15, idx_bill_amt);
      gpstatement.bindColumn(16, idx_bill_date);
      gpstatement.bindColumn(17, idx_delay_day);
      gpstatement.bindColumn(18, idx_delay_interest_amt);
      gpstatement.bindColumn(19, idx_collection_cond);
      gpstatement.bindColumn(20, idx_bankname);
      gpstatement.bindColumn(21, idx_deposit_no);
      gpstatement.bindColumn(22, idx_remark);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(23, idx_dept_code);
      gpstatement.bindColumn(24, idx_cont_no);
      gpstatement.bindColumn(25, idx_chg_degree);
      gpstatement.bindColumn(26, idx_extablish_time);
      gpstatement.bindColumn(27, idx_collection_time);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from r_contract_time_collection where dept_code=? and cont_no=? and chg_degree=? and extablish_time=? and collection_time=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cont_no);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_extablish_time);
      gpstatement.bindColumn(5, idx_collection_time);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ include file="../../../comm_function/conn_tr_end.jsp"%>