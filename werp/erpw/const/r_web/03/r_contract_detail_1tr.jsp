<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_contract_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_cont_no = dSet.indexOfColumn("cont_no");
   	int idx_chg_degree = dSet.indexOfColumn("chg_degree");
   	int idx_contract_year_tag = dSet.indexOfColumn("contract_year_tag");
   	int idx_completion_tag = dSet.indexOfColumn("completion_tag");
   	int idx_order_no = dSet.indexOfColumn("order_no");
   	int idx_const_name = dSet.indexOfColumn("const_name");
   	int idx_const_process_class = dSet.indexOfColumn("const_process_class");
   	int idx_last_tag = dSet.indexOfColumn("last_tag");
   	int idx_receive_code = dSet.indexOfColumn("receive_code");
   	int idx_parent_dept_code = dSet.indexOfColumn("parent_dept_code");
   	int idx_ledger_no = dSet.indexOfColumn("ledger_no");
   	int idx_membership_no = dSet.indexOfColumn("membership_no");
   	int idx_const_shortname = dSet.indexOfColumn("const_shortname");
   	int idx_region_code = dSet.indexOfColumn("region_code");
   	int idx_position = dSet.indexOfColumn("position");
   	int idx_position2 = dSet.indexOfColumn("position2");
   	int idx_field_tel = dSet.indexOfColumn("field_tel");
   	int idx_charge_pm1 = dSet.indexOfColumn("charge_pm1");
   	int idx_charge_pm2 = dSet.indexOfColumn("charge_pm2");
   	int idx_constkind_tag = dSet.indexOfColumn("constkind_tag");
   	int idx_pq_tag = dSet.indexOfColumn("pq_tag");
   	int idx_const_tag = dSet.indexOfColumn("const_tag");
   	int idx_receive_tag = dSet.indexOfColumn("receive_tag");
   	int idx_tender_tag = dSet.indexOfColumn("tender_tag");
   	int idx_order_tag = dSet.indexOfColumn("order_tag");
   	int idx_contract_tag = dSet.indexOfColumn("contract_tag");
   	int idx_tax_tag = dSet.indexOfColumn("tax_tag");
   	int idx_change_tag = dSet.indexOfColumn("change_tag");
   	int idx_up_date = dSet.indexOfColumn("up_date");
   	int idx_change_kind = dSet.indexOfColumn("change_kind");
   	int idx_bid_date = dSet.indexOfColumn("bid_date");
   	int idx_cont_date = dSet.indexOfColumn("cont_date");
   	int idx_design_amt = dSet.indexOfColumn("design_amt");
   	int idx_survey_amt = dSet.indexOfColumn("survey_amt");
   	int idx_budget_amt = dSet.indexOfColumn("budget_amt");
   	int idx_bid_amt = dSet.indexOfColumn("bid_amt");
   	int idx_change_supply_amt = dSet.indexOfColumn("change_supply_amt");
   	int idx_change_vat_amt = dSet.indexOfColumn("change_vat_amt");
   	int idx_change_sum_amt = dSet.indexOfColumn("change_sum_amt");
   	int idx_tot_cont_amt = dSet.indexOfColumn("tot_cont_amt");
   	int idx_const_outline1 = dSet.indexOfColumn("const_outline1");
   	int idx_const_outline2 = dSet.indexOfColumn("const_outline2");
   	int idx_limit_contents1 = dSet.indexOfColumn("limit_contents1");
   	int idx_limit_contents2 = dSet.indexOfColumn("limit_contents2");
   	int idx_use_seal_no = dSet.indexOfColumn("use_seal_no");
   	int idx_order_charger = dSet.indexOfColumn("order_charger");
   	int idx_order_tel = dSet.indexOfColumn("order_tel");
   	int idx_order_remark = dSet.indexOfColumn("order_remark");
   	int idx_demand_charger = dSet.indexOfColumn("demand_charger");
   	int idx_demand_tel = dSet.indexOfColumn("demand_tel");
   	int idx_demand_remark = dSet.indexOfColumn("demand_remark");
   	int idx_master_dept = dSet.indexOfColumn("master_dept");
   	int idx_start_date = dSet.indexOfColumn("start_date");
   	int idx_completion_date = dSet.indexOfColumn("completion_date");
   	int idx_completion_testdate = dSet.indexOfColumn("completion_testdate");
   	int idx_delay_rate = dSet.indexOfColumn("delay_rate");
   	int idx_reserve_rate = dSet.indexOfColumn("reserve_rate");
   	int idx_cont_rate = dSet.indexOfColumn("cont_rate");
   	int idx_warranty_rate = dSet.indexOfColumn("warranty_rate");
   	int idx_warranty_amt = dSet.indexOfColumn("warranty_amt");
   	int idx_warranty_start = dSet.indexOfColumn("warranty_start");
   	int idx_warranty_end = dSet.indexOfColumn("warranty_end");
   	int idx_control_tag = dSet.indexOfColumn("control_tag");
   	int idx_bankname = dSet.indexOfColumn("bankname");
   	int idx_deposit_no = dSet.indexOfColumn("deposit_no");
   	int idx_constamt_paycond = dSet.indexOfColumn("constamt_paycond");
   	int idx_extablish_paycond = dSet.indexOfColumn("extablish_paycond");
   	int idx_completion_paycond = dSet.indexOfColumn("completion_paycond");
   	int idx_deposit_paycond = dSet.indexOfColumn("deposit_paycond");
   	int idx_etc_paycond = dSet.indexOfColumn("etc_paycond");
   	int idx_designer = dSet.indexOfColumn("designer");
   	int idx_administer = dSet.indexOfColumn("administer");
   	int idx_payment_condition = dSet.indexOfColumn("payment_condition");
   	int idx_payment_method = dSet.indexOfColumn("payment_method");
   	int idx_change_status = dSet.indexOfColumn("change_status");
   	int idx_operation_rate = dSet.indexOfColumn("operation_rate");
   	int idx_operation_supply_amt = dSet.indexOfColumn("operation_supply_amt");
   	int idx_operation_vat_amt = dSet.indexOfColumn("operation_vat_amt");
   	int idx_operation_sum_amt = dSet.indexOfColumn("operation_sum_amt");
   	int idx_operation_tot_cont_amt = dSet.indexOfColumn("operation_tot_cont_amt");
   	int idx_masterdept_tag = dSet.indexOfColumn("masterdept_tag");
   	int idx_exempt_amt = dSet.indexOfColumn("exempt_amt");
   	int idx_etc_amt = dSet.indexOfColumn("etc_amt");
	int idx_proj_deputy = dSet.indexOfColumn("proj_deputy");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO R_CONTRACT_REGISTER ( dept_code," + 
                    "cont_no," + 
                    "chg_degree," + 
                    "contract_year_tag," + 
                    "completion_tag," + 
                    "order_no," + 
                    "const_name," + 
                    "const_process_class," + 
                    "last_tag," + 
                    "receive_code," + 
                    "parent_dept_code," + 
                    "ledger_no," + 
                    "membership_no," + 
                    "const_shortname," + 
                    "region_code," + 
                    "position," + 
                    "position2," + 
                    "field_tel," + 
                    "charge_pm1," + 
                    "charge_pm2," + 
                    "constkind_tag," + 
                    "pq_tag," + 
                    "const_tag," + 
                    "receive_tag," + 
                    "tender_tag," + 
                    "order_tag," + 
                    "contract_tag," + 
                    "tax_tag," + 
                    "change_tag," + 
                    "up_date," + 
                    "change_kind," + 
                    "bid_date," + 
                    "cont_date," + 
                    "design_amt," + 
                    "survey_amt," + 
                    "budget_amt," + 
                    "bid_amt," + 
                    "change_supply_amt," + 
                    "change_vat_amt," + 
                    "change_sum_amt," + 
                    "tot_cont_amt," + 
                    "const_outline1," + 
                    "const_outline2," + 
                    "limit_contents1," + 
                    "limit_contents2," + 
                    "use_seal_no," + 
                    "order_charger," + 
                    "order_tel," + 
                    "order_remark," + 
                    "demand_charger," + 
                    "demand_tel," + 
                    "demand_remark," + 
                    "master_dept," + 
                    "start_date," + 
                    "completion_date," + 
                    "completion_testdate," + 
                    "delay_rate," + 
                    "reserve_rate," + 
                    "cont_rate," + 
                    "warranty_rate," + 
                    "warranty_amt," + 
                    "warranty_start," + 
                    "warranty_end," + 
                    "control_tag," + 
                    "bankname," + 
                    "deposit_no," + 
                    "constamt_paycond," + 
                    "extablish_paycond," + 
                    "completion_paycond," + 
                    "deposit_paycond," + 
                    "etc_paycond," + 
                    "designer," + 
                    "administer," + 
                    "payment_condition," + 
                    "payment_method," + 
                    "change_status," + 
                    "operation_rate," + 
                    "operation_supply_amt," + 
                    "operation_vat_amt," + 
                    "operation_sum_amt," + 
                    "operation_tot_cont_amt,"+
			        "proj_deputy, masterdept_tag, exempt_amt, etc_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, :31, :32, :33, :34, :35, :36, :37, :38, :39, :40, :41, :42, :43, :44, :45, :46, :47, :48, :49, :50, :51, :52, :53, :54, :55, :56, :57, :58, :59, :60, :61, :62, :63, :64, :65, :66, :67, :68, :69, :70, :71, :72, :73, :74, :75, :76, :77, :78, :79, :80, :81, :82, :83, :84, :85 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cont_no);
      gpstatement.bindColumn(3, idx_chg_degree);
      gpstatement.bindColumn(4, idx_contract_year_tag);
      gpstatement.bindColumn(5, idx_completion_tag);
      gpstatement.bindColumn(6, idx_order_no);
      gpstatement.bindColumn(7, idx_const_name);
      gpstatement.bindColumn(8, idx_const_process_class);
      gpstatement.bindColumn(9, idx_last_tag);
      gpstatement.bindColumn(10, idx_receive_code);
      gpstatement.bindColumn(11, idx_parent_dept_code);
      gpstatement.bindColumn(12, idx_ledger_no);
      gpstatement.bindColumn(13, idx_membership_no);
      gpstatement.bindColumn(14, idx_const_shortname);
      gpstatement.bindColumn(15, idx_region_code);
      gpstatement.bindColumn(16, idx_position);
      gpstatement.bindColumn(17, idx_position2);
      gpstatement.bindColumn(18, idx_field_tel);
      gpstatement.bindColumn(19, idx_charge_pm1);
      gpstatement.bindColumn(20, idx_charge_pm2);
      gpstatement.bindColumn(21, idx_constkind_tag);
      gpstatement.bindColumn(22, idx_pq_tag);
      gpstatement.bindColumn(23, idx_const_tag);
      gpstatement.bindColumn(24, idx_receive_tag);
      gpstatement.bindColumn(25, idx_tender_tag);
      gpstatement.bindColumn(26, idx_order_tag);
      gpstatement.bindColumn(27, idx_contract_tag);
      gpstatement.bindColumn(28, idx_tax_tag);
      gpstatement.bindColumn(29, idx_change_tag);
      gpstatement.bindColumn(30, idx_up_date);
      gpstatement.bindColumn(31, idx_change_kind);
      gpstatement.bindColumn(32, idx_bid_date);
      gpstatement.bindColumn(33, idx_cont_date);
      gpstatement.bindColumn(34, idx_design_amt);
      gpstatement.bindColumn(35, idx_survey_amt);
      gpstatement.bindColumn(36, idx_budget_amt);
      gpstatement.bindColumn(37, idx_bid_amt);
      gpstatement.bindColumn(38, idx_change_supply_amt);
      gpstatement.bindColumn(39, idx_change_vat_amt);
      gpstatement.bindColumn(40, idx_change_sum_amt);
      gpstatement.bindColumn(41, idx_tot_cont_amt);
      gpstatement.bindColumn(42, idx_const_outline1);
      gpstatement.bindColumn(43, idx_const_outline2);
      gpstatement.bindColumn(44, idx_limit_contents1);
      gpstatement.bindColumn(45, idx_limit_contents2);
      gpstatement.bindColumn(46, idx_use_seal_no);
      gpstatement.bindColumn(47, idx_order_charger);
      gpstatement.bindColumn(48, idx_order_tel);
      gpstatement.bindColumn(49, idx_order_remark);
      gpstatement.bindColumn(50, idx_demand_charger);
      gpstatement.bindColumn(51, idx_demand_tel);
      gpstatement.bindColumn(52, idx_demand_remark);
      gpstatement.bindColumn(53, idx_master_dept);
      gpstatement.bindColumn(54, idx_start_date);
      gpstatement.bindColumn(55, idx_completion_date);
      gpstatement.bindColumn(56, idx_completion_testdate);
      gpstatement.bindColumn(57, idx_delay_rate);
      gpstatement.bindColumn(58, idx_reserve_rate);
      gpstatement.bindColumn(59, idx_cont_rate);
      gpstatement.bindColumn(60, idx_warranty_rate);
      gpstatement.bindColumn(61, idx_warranty_amt);
      gpstatement.bindColumn(62, idx_warranty_start);
      gpstatement.bindColumn(63, idx_warranty_end);
      gpstatement.bindColumn(64, idx_control_tag);
      gpstatement.bindColumn(65, idx_bankname);
      gpstatement.bindColumn(66, idx_deposit_no);
      gpstatement.bindColumn(67, idx_constamt_paycond);
      gpstatement.bindColumn(68, idx_extablish_paycond);
      gpstatement.bindColumn(69, idx_completion_paycond);
      gpstatement.bindColumn(70, idx_deposit_paycond);
      gpstatement.bindColumn(71, idx_etc_paycond);
      gpstatement.bindColumn(72, idx_designer);
      gpstatement.bindColumn(73, idx_administer);
      gpstatement.bindColumn(74, idx_payment_condition);
      gpstatement.bindColumn(75, idx_payment_method);
      gpstatement.bindColumn(76, idx_change_status);
      gpstatement.bindColumn(77, idx_operation_rate);
      gpstatement.bindColumn(78, idx_operation_supply_amt);
      gpstatement.bindColumn(79, idx_operation_vat_amt);
      gpstatement.bindColumn(80, idx_operation_sum_amt);
      gpstatement.bindColumn(81, idx_operation_tot_cont_amt);
	  gpstatement.bindColumn(82, idx_proj_deputy);
	  gpstatement.bindColumn(83, idx_masterdept_tag);
	  gpstatement.bindColumn(84, idx_exempt_amt);
	  gpstatement.bindColumn(85, idx_etc_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update r_contract_register set " + 
                            "dept_code=?,  " + 
                            "cont_no=?,  " + 
                            "contract_year_tag=?,  " + 
                            "completion_tag=?,  " + 
                            "order_no=?,  " + 
                            "const_name=?,  " + 
                            "const_process_class=?,  " + 
                            "chg_degree=?,  " + 
                            "last_tag=?,  " + 
                            "receive_code=?,  " + 
                            "parent_dept_code=?,  " + 
                            "ledger_no=?,  " + 
                            "membership_no=?,  " + 
                            "const_shortname=?,  " + 
                            "region_code=?,  " + 
                            "position=?,  " + 
                            "position2=?,  " + 
                            "field_tel=?,  " + 
                            "charge_pm1=?,  " + 
                            "charge_pm2=?,  " + 
                            "constkind_tag=?,  " + 
                            "pq_tag=?,  " + 
                            "const_tag=?,  " + 
                            "receive_tag=?,  " + 
                            "tender_tag=?,  " + 
                            "order_tag=?,  " + 
                            "contract_tag=?,  " + 
                            "tax_tag=?,  " + 
                            "change_tag=?,  " + 
                            "up_date=?,  " + 
                            "change_kind=?,  " + 
                            "bid_date=?,  " + 
                            "cont_date=?,  " + 
                            "design_amt=?,  " + 
                            "survey_amt=?,  " + 
                            "budget_amt=?,  " + 
                            "bid_amt=?,  " + 
                            "change_supply_amt=?,  " + 
                            "change_vat_amt=?,  " + 
                            "change_sum_amt=?,  " + 
                            "tot_cont_amt=?,  " + 
                            "const_outline1=?,  " + 
                            "const_outline2=?,  " + 
                            "limit_contents1=?,  " + 
                            "limit_contents2=?,  " + 
                            "use_seal_no=?,  " + 
                            "order_charger=?,  " + 
                            "order_tel=?,  " + 
                            "order_remark=?,  " + 
                            "demand_charger=?,  " + 
                            "demand_tel=?,  " + 
                            "demand_remark=?,  " + 
                            "master_dept=?,  " + 
                            "start_date=?,  " + 
                            "completion_date=?,  " + 
                            "completion_testdate=?,  " + 
                            "delay_rate=?,  " + 
                            "reserve_rate=?,  " + 
                            "cont_rate=?,  " + 
                            "warranty_rate=?,  " + 
                            "warranty_amt=?,  " + 
                            "warranty_start=?,  " + 
                            "warranty_end=?,  " + 
                            "control_tag=?,  " + 
                            "bankname=?,  " + 
                            "deposit_no=?,  " + 
                            "constamt_paycond=?,  " + 
                            "extablish_paycond=?,  " + 
                            "completion_paycond=?,  " + 
                            "deposit_paycond=?,  " + 
                            "etc_paycond=?,  " + 
                            "designer=?,  " + 
                            "administer=?,  " + 
                            "payment_condition=?,  " + 
                            "payment_method=?,  " + 
                            "change_status=?,  " + 
                            "operation_rate=?,  " + 
                            "operation_supply_amt=?,  " + 
                            "operation_vat_amt=?,  " + 
                            "operation_sum_amt=?,  " + 
                            "operation_tot_cont_amt=?, "+
	                        "proj_deputy=?, masterdept_tag=?, exempt_amt=?, etc_amt=? where dept_code=? " +
                            " and cont_no=? " +
                            " and chg_degree=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cont_no);
      gpstatement.bindColumn(3, idx_contract_year_tag);
      gpstatement.bindColumn(4, idx_completion_tag);
      gpstatement.bindColumn(5, idx_order_no);
      gpstatement.bindColumn(6, idx_const_name);
      gpstatement.bindColumn(7, idx_const_process_class);
      gpstatement.bindColumn(8, idx_chg_degree);
      gpstatement.bindColumn(9, idx_last_tag);
      gpstatement.bindColumn(10, idx_receive_code);
      gpstatement.bindColumn(11, idx_parent_dept_code);
      gpstatement.bindColumn(12, idx_ledger_no);
      gpstatement.bindColumn(13, idx_membership_no);
      gpstatement.bindColumn(14, idx_const_shortname);
      gpstatement.bindColumn(15, idx_region_code);
      gpstatement.bindColumn(16, idx_position);
      gpstatement.bindColumn(17, idx_position2);
      gpstatement.bindColumn(18, idx_field_tel);
      gpstatement.bindColumn(19, idx_charge_pm1);
      gpstatement.bindColumn(20, idx_charge_pm2);
      gpstatement.bindColumn(21, idx_constkind_tag);
      gpstatement.bindColumn(22, idx_pq_tag);
      gpstatement.bindColumn(23, idx_const_tag);
      gpstatement.bindColumn(24, idx_receive_tag);
      gpstatement.bindColumn(25, idx_tender_tag);
      gpstatement.bindColumn(26, idx_order_tag);
      gpstatement.bindColumn(27, idx_contract_tag);
      gpstatement.bindColumn(28, idx_tax_tag);
      gpstatement.bindColumn(29, idx_change_tag);
      gpstatement.bindColumn(30, idx_up_date);
      gpstatement.bindColumn(31, idx_change_kind);
      gpstatement.bindColumn(32, idx_bid_date);
      gpstatement.bindColumn(33, idx_cont_date);
      gpstatement.bindColumn(34, idx_design_amt);
      gpstatement.bindColumn(35, idx_survey_amt);
      gpstatement.bindColumn(36, idx_budget_amt);
      gpstatement.bindColumn(37, idx_bid_amt);
      gpstatement.bindColumn(38, idx_change_supply_amt);
      gpstatement.bindColumn(39, idx_change_vat_amt);
      gpstatement.bindColumn(40, idx_change_sum_amt);
      gpstatement.bindColumn(41, idx_tot_cont_amt);
      gpstatement.bindColumn(42, idx_const_outline1);
      gpstatement.bindColumn(43, idx_const_outline2);
      gpstatement.bindColumn(44, idx_limit_contents1);
      gpstatement.bindColumn(45, idx_limit_contents2);
      gpstatement.bindColumn(46, idx_use_seal_no);
      gpstatement.bindColumn(47, idx_order_charger);
      gpstatement.bindColumn(48, idx_order_tel);
      gpstatement.bindColumn(49, idx_order_remark);
      gpstatement.bindColumn(50, idx_demand_charger);
      gpstatement.bindColumn(51, idx_demand_tel);
      gpstatement.bindColumn(52, idx_demand_remark);
      gpstatement.bindColumn(53, idx_master_dept);
      gpstatement.bindColumn(54, idx_start_date);
      gpstatement.bindColumn(55, idx_completion_date);
      gpstatement.bindColumn(56, idx_completion_testdate);
      gpstatement.bindColumn(57, idx_delay_rate);
      gpstatement.bindColumn(58, idx_reserve_rate);
      gpstatement.bindColumn(59, idx_cont_rate);
      gpstatement.bindColumn(60, idx_warranty_rate);
      gpstatement.bindColumn(61, idx_warranty_amt);
      gpstatement.bindColumn(62, idx_warranty_start);
      gpstatement.bindColumn(63, idx_warranty_end);
      gpstatement.bindColumn(64, idx_control_tag);
      gpstatement.bindColumn(65, idx_bankname);
      gpstatement.bindColumn(66, idx_deposit_no);
      gpstatement.bindColumn(67, idx_constamt_paycond);
      gpstatement.bindColumn(68, idx_extablish_paycond);
      gpstatement.bindColumn(69, idx_completion_paycond);
      gpstatement.bindColumn(70, idx_deposit_paycond);
      gpstatement.bindColumn(71, idx_etc_paycond);
      gpstatement.bindColumn(72, idx_designer);
      gpstatement.bindColumn(73, idx_administer);
      gpstatement.bindColumn(74, idx_payment_condition);
      gpstatement.bindColumn(75, idx_payment_method);
      gpstatement.bindColumn(76, idx_change_status);
      gpstatement.bindColumn(77, idx_operation_rate);
      gpstatement.bindColumn(78, idx_operation_supply_amt);
      gpstatement.bindColumn(79, idx_operation_vat_amt);
      gpstatement.bindColumn(80, idx_operation_sum_amt);
      gpstatement.bindColumn(81, idx_operation_tot_cont_amt);
	  gpstatement.bindColumn(82, idx_proj_deputy);
	  gpstatement.bindColumn(83, idx_masterdept_tag);
	  gpstatement.bindColumn(84, idx_exempt_amt);
	  gpstatement.bindColumn(85, idx_etc_amt);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(86, idx_dept_code);
      gpstatement.bindColumn(87, idx_cont_no);
      gpstatement.bindColumn(88, idx_chg_degree);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from r_contract_register where dept_code=? " +
      				" and cont_no=? " +
      				" and chg_degree=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_cont_no);
      gpstatement.bindColumn(3, idx_chg_degree);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>