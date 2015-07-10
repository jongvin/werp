<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_code_house_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_sell_date = dSet.indexOfColumn("sell_date");
   	int idx_moveinto_fr_date = dSet.indexOfColumn("moveinto_fr_date");
   	int idx_moveinto_to_date = dSet.indexOfColumn("moveinto_to_date");
   	int idx_approve_date = dSet.indexOfColumn("approve_date");
   	int idx_const_fr_date = dSet.indexOfColumn("const_fr_date");
   	int idx_use_inspect_date = dSet.indexOfColumn("use_inspect_date");
   	int idx_tot_house = dSet.indexOfColumn("tot_house");
   	int idx_contract_delay_yn = dSet.indexOfColumn("contract_delay_yn");
   	int idx_remain_discount_yn = dSet.indexOfColumn("remain_discount_yn");
   	int idx_lease_delay_yn = dSet.indexOfColumn("lease_delay_yn");
   	int idx_ontime_contract_delay_yn = dSet.indexOfColumn("ontime_contract_delay_yn");
   	int idx_ontime_remain_discount_yn = dSet.indexOfColumn("ontime_remain_discount_yn");
   	int idx_penalty_rate = dSet.indexOfColumn("penalty_rate");
   	int idx_income_taxrate = dSet.indexOfColumn("income_taxrate");
   	int idx_residence_taxrate = dSet.indexOfColumn("residence_taxrate");
   	int idx_term_interest_rate = dSet.indexOfColumn("term_interest_rate");
   	int idx_delay_days = dSet.indexOfColumn("delay_days");
   	int idx_delay_rate = dSet.indexOfColumn("delay_rate");
   	int idx_union_yn = dSet.indexOfColumn("union_yn");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_ledger_name = dSet.indexOfColumn("ledger_name");
   	int idx_ledger_phone = dSet.indexOfColumn("ledger_phone");
   	int idx_ledger_items = dSet.indexOfColumn("ledger_items");
	 int idx_union_movein_from = dSet.indexOfColumn("union_movein_from");
    int idx_union_movein_to = dSet.indexOfColumn("union_movein_to");
	 int idx_base_pyong_memo = dSet.indexOfColumn("base_pyong_memo");
	 int idx_rent_delay_yn = dSet.indexOfColumn("rent_delay_yn");
	 int idx_cont_date = dSet.indexOfColumn("cont_date");
	 int idx_loan_tele = dSet.indexOfColumn("loan_tele");
	 int idx_recp_tele = dSet.indexOfColumn("recp_tele");
	 int idx_addr_tele = dSet.indexOfColumn("addr_tele");
	 int idx_mh_tele = dSet.indexOfColumn("mh_tele");
	 int idx_loan_bank_code = dSet.indexOfColumn("loan_bank_code");
	 int idx_share_rate = dSet.indexOfColumn("share_rate");
	 int idx_acntno_due = dSet.indexOfColumn("acntno_due");
	 int idx_acntno_pre = dSet.indexOfColumn("acntno_pre");
     int idx_home_page_yn = dSet.indexOfColumn("home_page_yn"); 

	int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_code_house ( dept_code," + 
                    "sell_code," + 
                    "sell_date," + 
                    "moveinto_fr_date," + 
                    "moveinto_to_date," + 
                    "approve_date," + 
                    "const_fr_date," + 
                    "use_inspect_date," + 
                    "tot_house," + 
                    "contract_delay_yn," + 
                    "remain_discount_yn," + 
                    "lease_delay_yn," + 
                    "ontime_contract_delay_yn," + 
                    "ontime_remain_discount_yn," + 
                    "penalty_rate," + 
                    "income_taxrate," + 
                    "residence_taxrate," + 
                    "term_interest_rate," + 
                    "delay_days," + 
                    "delay_rate," + 
                    "union_yn," + 
                    "remark, " +
                    "ledger_name, " +
                    "ledger_phone, " +
                    "ledger_items ,"+
			        "union_movein_from,"+
			        "union_movein_to,"+
			        "base_pyong_memo,"+
			        "rent_delay_yn,"+
			        "cont_date,"+
                    "loan_tele,"+
			        "recp_tele,"+
			        "addr_tele,"+
			        "mh_tele,"+
			        " loan_bank_code,"+
			        " share_rate,"+
			        " acntno_due,"+
			        " acntno_pre, "+
			        " home_page_yn ) ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25,:26,:27,:28, :29,:30,:31,:32,:33,:34, :35, :36, :37, :38, :39 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_sell_date);
      gpstatement.bindColumn(4, idx_moveinto_fr_date);
      gpstatement.bindColumn(5, idx_moveinto_to_date);
      gpstatement.bindColumn(6, idx_approve_date);
      gpstatement.bindColumn(7, idx_const_fr_date);
      gpstatement.bindColumn(8, idx_use_inspect_date);
      gpstatement.bindColumn(9, idx_tot_house);
      gpstatement.bindColumn(10, idx_contract_delay_yn);
      gpstatement.bindColumn(11, idx_remain_discount_yn);
      gpstatement.bindColumn(12, idx_lease_delay_yn);
      gpstatement.bindColumn(13, idx_ontime_contract_delay_yn);
      gpstatement.bindColumn(14, idx_ontime_remain_discount_yn);
      gpstatement.bindColumn(15, idx_penalty_rate);
      gpstatement.bindColumn(16, idx_income_taxrate);
      gpstatement.bindColumn(17, idx_residence_taxrate);
      gpstatement.bindColumn(18, idx_term_interest_rate);
      gpstatement.bindColumn(19, idx_delay_days);
      gpstatement.bindColumn(20, idx_delay_rate);
      gpstatement.bindColumn(21, idx_union_yn);
      gpstatement.bindColumn(22, idx_remark);
      gpstatement.bindColumn(23, idx_ledger_name);
      gpstatement.bindColumn(24, idx_ledger_phone);
      gpstatement.bindColumn(25, idx_ledger_items);
	  gpstatement.bindColumn(26, idx_union_movein_from);
      gpstatement.bindColumn(27, idx_union_movein_to);
	  gpstatement.bindColumn(28, idx_base_pyong_memo);
	  gpstatement.bindColumn(29, idx_rent_delay_yn);
	  gpstatement.bindColumn(30, idx_cont_date);
	  gpstatement.bindColumn(31, idx_loan_tele);
	  gpstatement.bindColumn(32, idx_recp_tele);
	  gpstatement.bindColumn(33, idx_addr_tele);
	  gpstatement.bindColumn(34, idx_mh_tele);
	  gpstatement.bindColumn(35, idx_loan_bank_code);
	  gpstatement.bindColumn(36, idx_share_rate);
	  gpstatement.bindColumn(37, idx_acntno_due);
	  gpstatement.bindColumn(38, idx_acntno_pre);
      gpstatement.bindColumn(39, idx_home_page_yn); 

      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_code_house set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "sell_date=?,  " + 
                            "moveinto_fr_date=?,  " + 
                            "moveinto_to_date=?,  " + 
                            "approve_date=?,  " + 
                            "const_fr_date=?,  " + 
                            "use_inspect_date=?,  " + 
                            "tot_house=?,  " + 
                            "contract_delay_yn=?,  " + 
                            "remain_discount_yn=?,  " + 
                            "lease_delay_yn=?,  " + 
                            "ontime_contract_delay_yn=?,  " + 
                            "ontime_remain_discount_yn=?,  " + 
                            "penalty_rate=?,  " + 
                            "income_taxrate=?,  " + 
                            "residence_taxrate=?,  " + 
                            "term_interest_rate=?,  " + 
                            "delay_days=?,  " + 
                            "delay_rate=?,  " + 
                            "union_yn=?,  " + 
                            "remark=?, " +
                            "ledger_name=?, " +  
                            "ledger_phone=?, " +
                            "ledger_items=?,"+
	                        "union_movein_from=?,"+
	                        "union_movein_to=?,"+
	                        "base_pyong_memo=?, "+
	                        "rent_delay_yn=?," +
	                        "cont_date=?," +
	                        "loan_tele=?," +
	                        "recp_tele=?," +
	                        "addr_tele=?," +
	                        "mh_tele=?," +
	                        "loan_bank_code=?," +
	                        " share_rate=?," +
	                        " acntno_due=?," +
	                        " acntno_pre=?, " +
                            " home_page_yn=?  " +  
	                       "  where dept_code=? and sell_code=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_sell_date);
      gpstatement.bindColumn(4, idx_moveinto_fr_date);
      gpstatement.bindColumn(5, idx_moveinto_to_date);
      gpstatement.bindColumn(6, idx_approve_date);
      gpstatement.bindColumn(7, idx_const_fr_date);
      gpstatement.bindColumn(8, idx_use_inspect_date);
      gpstatement.bindColumn(9, idx_tot_house);
      gpstatement.bindColumn(10, idx_contract_delay_yn);
      gpstatement.bindColumn(11, idx_remain_discount_yn);
      gpstatement.bindColumn(12, idx_lease_delay_yn);
      gpstatement.bindColumn(13, idx_ontime_contract_delay_yn);
      gpstatement.bindColumn(14, idx_ontime_remain_discount_yn);
      gpstatement.bindColumn(15, idx_penalty_rate);
      gpstatement.bindColumn(16, idx_income_taxrate);
      gpstatement.bindColumn(17, idx_residence_taxrate);
      gpstatement.bindColumn(18, idx_term_interest_rate);
      gpstatement.bindColumn(19, idx_delay_days);
      gpstatement.bindColumn(20, idx_delay_rate);
      gpstatement.bindColumn(21, idx_union_yn);
      gpstatement.bindColumn(22, idx_remark);
      gpstatement.bindColumn(23, idx_ledger_name);
      gpstatement.bindColumn(24, idx_ledger_phone);
      gpstatement.bindColumn(25, idx_ledger_items);
	  gpstatement.bindColumn(26, idx_union_movein_from);
      gpstatement.bindColumn(27, idx_union_movein_to);
	  gpstatement.bindColumn(28, idx_base_pyong_memo);
	  gpstatement.bindColumn(29, idx_rent_delay_yn);
	  gpstatement.bindColumn(30, idx_cont_date);
	  gpstatement.bindColumn(31, idx_loan_tele);
	  gpstatement.bindColumn(32, idx_recp_tele);
	  gpstatement.bindColumn(33, idx_addr_tele);
	  gpstatement.bindColumn(34, idx_mh_tele);
	  gpstatement.bindColumn(35, idx_loan_bank_code);
	  gpstatement.bindColumn(36, idx_share_rate);
	  gpstatement.bindColumn(37, idx_acntno_due);
	  gpstatement.bindColumn(38, idx_acntno_pre);
	  gpstatement.bindColumn(39, idx_home_page_yn);  
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(40, idx_dept_code);
      gpstatement.bindColumn(41, idx_sell_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_code_house where dept_code=? and sell_code=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>