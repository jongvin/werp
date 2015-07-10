<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_contract_master_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_pyong = dSet.indexOfColumn("pyong");
   	int idx_style = dSet.indexOfColumn("style");
   	int idx_class = dSet.indexOfColumn("class");
   	int idx_option_code = dSet.indexOfColumn("option_code");
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_union_code = dSet.indexOfColumn("union_code");
   	int idx_union_id = dSet.indexOfColumn("union_id");
   	int idx_contract_code = dSet.indexOfColumn("contract_code");
   	int idx_contract_yn = dSet.indexOfColumn("contract_yn");
   	int idx_contract_date = dSet.indexOfColumn("contract_date");
   	int idx_chg_div = dSet.indexOfColumn("chg_div");
   	int idx_chg_date = dSet.indexOfColumn("chg_date");
   	int idx_last_contract_date = dSet.indexOfColumn("last_contract_date");
   	int idx_ontime_tot_amt = dSet.indexOfColumn("ontime_tot_amt");
   	int idx_fund_amt = dSet.indexOfColumn("fund_amt");
   	int idx_loan_amt = dSet.indexOfColumn("loan_amt");
   	int idx_guarantee_amt = dSet.indexOfColumn("guarantee_amt");
   	int idx_chg_dongho = dSet.indexOfColumn("chg_dongho");
   	int idx_chg_seq = dSet.indexOfColumn("chg_seq");
   	int idx_transfer_reason = dSet.indexOfColumn("transfer_reason");
   	int idx_moveinto_plan_date = dSet.indexOfColumn("moveinto_plan_date");
   	int idx_moveinto_code = dSet.indexOfColumn("moveinto_code");
   	int idx_moveinto_date = dSet.indexOfColumn("moveinto_date");
   	int idx_passwd = dSet.indexOfColumn("passwd");
   	int idx_input_date = dSet.indexOfColumn("input_date");
   	int idx_input_id = dSet.indexOfColumn("input_id");
   	int idx_moveinto_fr_date = dSet.indexOfColumn("moveinto_fr_date");
   	int idx_moveinto_to_date = dSet.indexOfColumn("moveinto_to_date");
   	int idx_remark = dSet.indexOfColumn("remark");
  	   int idx_pre_cont_tag = dSet.indexOfColumn("pre_cont_tag");
   	int idx_pre_cont_date = dSet.indexOfColumn("pre_cont_date");
   	int idx_pre_cont_amt = dSet.indexOfColumn("pre_cont_amt");
   	int idx_pre_cont_memo = dSet.indexOfColumn("pre_cont_memo");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_SALE_MASTER ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "pyong," + 
                    "style," + 
                    "class," + 
                    "option_code," + 
                    "cust_code," + 
                    "union_code," + 
                    "union_id," + 
                    "contract_code," + 
                    "contract_yn," + 
                    "contract_date," + 
                    "chg_div," + 
                    "chg_date," + 
                    "last_contract_date," + 
                    "ontime_tot_amt," + 
                    "fund_amt," + 
                    "loan_amt," + 
                    "guarantee_amt," + 
                    "chg_dongho," + 
                    "chg_seq," + 
                    "transfer_reason," + 
                    "moveinto_plan_date," + 
                    "moveinto_code," + 
                    "moveinto_date," + 
                    "passwd," + 
                    "input_date," + 
	                "input_id," + 
                    "moveinto_fr_date," +
                    "moveinto_to_date," +
                    "remark," +
                    "pre_cont_tag," +
                    "pre_cont_date," +
                    "pre_cont_amt," +
                    "pre_cont_memo )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, TO_DATE(:29,'yyyy.mm.dd hh24:mi:ss'), :30, :31, :32, :33 , :34, :35, :36, :37 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_pyong);
      gpstatement.bindColumn(6, idx_style);
      gpstatement.bindColumn(7, idx_class);
      gpstatement.bindColumn(8, idx_option_code);
      gpstatement.bindColumn(9, idx_cust_code);
      gpstatement.bindColumn(10, idx_union_code);
      gpstatement.bindColumn(11, idx_union_id);
      gpstatement.bindColumn(12, idx_contract_code);
      gpstatement.bindColumn(13, idx_contract_yn);
      gpstatement.bindColumn(14, idx_contract_date);
      gpstatement.bindColumn(15, idx_chg_div);
      gpstatement.bindColumn(16, idx_chg_date);
      gpstatement.bindColumn(17, idx_last_contract_date);
      gpstatement.bindColumn(18, idx_ontime_tot_amt);
      gpstatement.bindColumn(19, idx_fund_amt);
      gpstatement.bindColumn(20, idx_loan_amt);
      gpstatement.bindColumn(21, idx_guarantee_amt);
      gpstatement.bindColumn(22, idx_chg_dongho);
      gpstatement.bindColumn(23, idx_chg_seq);
      gpstatement.bindColumn(24, idx_transfer_reason);
      gpstatement.bindColumn(25, idx_moveinto_plan_date);
      gpstatement.bindColumn(26, idx_moveinto_code);
      gpstatement.bindColumn(27, idx_moveinto_date);
      gpstatement.bindColumn(28, idx_passwd);
      gpstatement.bindColumn(29, idx_input_date);
      gpstatement.bindColumn(30, idx_input_id);
      gpstatement.bindColumn(31, idx_moveinto_fr_date);
      gpstatement.bindColumn(32, idx_moveinto_to_date);
      gpstatement.bindColumn(33, idx_remark);
      gpstatement.bindColumn(34, idx_pre_cont_tag);
      gpstatement.bindColumn(35, idx_pre_cont_date);
      gpstatement.bindColumn(36, idx_pre_cont_amt);
      gpstatement.bindColumn(37, idx_pre_cont_memo);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sale_master set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "pyong=?,  " + 
                            "style=?,  " + 
                            "class=?,  " + 
                            "option_code=?,  " + 
                            "cust_code=?,  " + 
                            "union_code=?,  " + 
                            "union_id=?,  " + 
                            "contract_code=?,  " + 
                            "contract_yn=?,  " + 
                            "contract_date=?,  " + 
                            "chg_div=?,  " + 
                            "chg_date=?,  " + 
                            "last_contract_date=?,  " + 
                            "ontime_tot_amt=?,  " + 
                            "fund_amt=?,  " + 
                            "loan_amt=?,  " + 
                            "guarantee_amt=?,  " + 
                            "chg_dongho=?,  " + 
                            "chg_seq=?,  " + 
                            "transfer_reason=?,  " + 
                            "moveinto_plan_date=?,  " + 
                            "moveinto_code=?,  " + 
                            "moveinto_date=?,  " + 
                            "passwd=?,  " + 
                            "input_date=TO_DATE(?,'yyyy.mm.dd hh24:mi:ss'),  " + 
                            "input_id=?,  " + 
                            "moveinto_fr_date=?, " +
                            "moveinto_to_date=?, " +
                            "remark=?, " +
                            "pre_cont_tag=?, " +
                            "pre_cont_date=?, " +
                            "pre_cont_amt=?, " +
                            "pre_cont_memo=?  where dept_code=? " +
                            "            and sell_code=? " +
                            "            and dongho=?" +
                            "            and seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_pyong);
      gpstatement.bindColumn(6, idx_style);
      gpstatement.bindColumn(7, idx_class);
      gpstatement.bindColumn(8, idx_option_code);
      gpstatement.bindColumn(9, idx_cust_code);
      gpstatement.bindColumn(10, idx_union_code);
      gpstatement.bindColumn(11, idx_union_id);
      gpstatement.bindColumn(12, idx_contract_code);
      gpstatement.bindColumn(13, idx_contract_yn);
      gpstatement.bindColumn(14, idx_contract_date);
      gpstatement.bindColumn(15, idx_chg_div);
      gpstatement.bindColumn(16, idx_chg_date);
      gpstatement.bindColumn(17, idx_last_contract_date);
      gpstatement.bindColumn(18, idx_ontime_tot_amt);
      gpstatement.bindColumn(19, idx_fund_amt);
      gpstatement.bindColumn(20, idx_loan_amt);
      gpstatement.bindColumn(21, idx_guarantee_amt);
      gpstatement.bindColumn(22, idx_chg_dongho);
      gpstatement.bindColumn(23, idx_chg_seq);
      gpstatement.bindColumn(24, idx_transfer_reason);
      gpstatement.bindColumn(25, idx_moveinto_plan_date);
      gpstatement.bindColumn(26, idx_moveinto_code);
      gpstatement.bindColumn(27, idx_moveinto_date);
      gpstatement.bindColumn(28, idx_passwd);
      gpstatement.bindColumn(29, idx_input_date);
      gpstatement.bindColumn(30, idx_input_id);
      gpstatement.bindColumn(31, idx_moveinto_fr_date);
      gpstatement.bindColumn(32, idx_moveinto_to_date);
      gpstatement.bindColumn(33, idx_remark);
      gpstatement.bindColumn(34, idx_pre_cont_tag);
      gpstatement.bindColumn(35, idx_pre_cont_date);
      gpstatement.bindColumn(36, idx_pre_cont_amt);
      gpstatement.bindColumn(37, idx_pre_cont_memo);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(38, idx_dept_code);
      gpstatement.bindColumn(39, idx_sell_code);
      gpstatement.bindColumn(40, idx_dongho);
      gpstatement.bindColumn(41, idx_seq);

      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sale_master where dept_code=? " +
                            "            and sell_code=? " +
                            "            and dongho=?" +
                            "            and seq=?";  
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