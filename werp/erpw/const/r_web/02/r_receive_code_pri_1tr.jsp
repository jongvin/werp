<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_receive_code_pri_1tr"); 
	  gpstatement.gp_dataset = dSet;
   	int idx_receive_code = dSet.indexOfColumn("receive_code");
   	int idx_key_receive_code = dSet.indexOfColumn("key_receive_code");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_const_shortname = dSet.indexOfColumn("const_shortname");
   	int idx_order_no = dSet.indexOfColumn("order_no");
   	int idx_order_no1 = dSet.indexOfColumn("order_no1");
   	int idx_region_code = dSet.indexOfColumn("region_code");
   	int idx_const_position = dSet.indexOfColumn("const_position");
   	int idx_constkind_tag = dSet.indexOfColumn("constkind_tag");
   	int idx_pq_tag = dSet.indexOfColumn("pq_tag");
   	int idx_join_cont_tag = dSet.indexOfColumn("join_cont_tag");
   	int idx_receive_tag = dSet.indexOfColumn("receive_tag");
   	int idx_receive_process_class = dSet.indexOfColumn("receive_process_class");
   	int idx_tender_tag = dSet.indexOfColumn("tender_tag");
   	int idx_order_tag = dSet.indexOfColumn("order_tag");
   	int idx_const_from = dSet.indexOfColumn("const_from");
   	int idx_const_to = dSet.indexOfColumn("const_to");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_parent_dept_code = dSet.indexOfColumn("parent_dept_code");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
   	int idx_siteexplan_date = dSet.indexOfColumn("siteexplan_date");
   	int idx_siteexplan_place = dSet.indexOfColumn("siteexplan_place");
   	int idx_siteexplan_cond = dSet.indexOfColumn("siteexplan_cond");
   	int idx_siteexplan_tag = dSet.indexOfColumn("siteexplan_tag");
   	int idx_siteexplan_name = dSet.indexOfColumn("siteexplan_name");
   	int idx_siteexplan_entrycompany = dSet.indexOfColumn("siteexplan_entrycompany");
   	int idx_siteexplan_memo = dSet.indexOfColumn("siteexplan_memo");
   	int idx_regist_date = dSet.indexOfColumn("regist_date");
   	int idx_regist_place = dSet.indexOfColumn("regist_place");
   	int idx_regist_tag = dSet.indexOfColumn("regist_tag");
   	int idx_tender_no = dSet.indexOfColumn("tender_no");
   	int idx_tender_date = dSet.indexOfColumn("tender_date");
   	int idx_tender_place = dSet.indexOfColumn("tender_place");
   	int idx_tender_cond = dSet.indexOfColumn("tender_cond");
   	int idx_tender_guarantee = dSet.indexOfColumn("tender_guarantee");
   	int idx_entry_tag = dSet.indexOfColumn("entry_tag");
   	int idx_entry_company = dSet.indexOfColumn("entry_company");
   	int idx_pq_limit_date = dSet.indexOfColumn("pq_limit_date");
   	int idx_res_end_date = dSet.indexOfColumn("res_end_date");
   	int idx_pro_end_date = dSet.indexOfColumn("pro_end_date");
   	int idx_design_amt = dSet.indexOfColumn("design_amt");
   	int idx_survey_amt = dSet.indexOfColumn("survey_amt");
   	int idx_office_amt = dSet.indexOfColumn("office_amt");
   	int idx_presume_amt = dSet.indexOfColumn("presume_amt");
   	int idx_presume_price = dSet.indexOfColumn("presume_price");
   	int idx_valuation_amt = dSet.indexOfColumn("valuation_amt");
   	int idx_budget_amt = dSet.indexOfColumn("budget_amt");
   	int idx_budget_rate = dSet.indexOfColumn("budget_rate");
   	int idx_budget_from_rate = dSet.indexOfColumn("budget_from_rate");
   	int idx_budget_to_rate = dSet.indexOfColumn("budget_to_rate");
   	int idx_bid_date = dSet.indexOfColumn("bid_date");
   	int idx_bid_amt = dSet.indexOfColumn("bid_amt");
   	int idx_bid_rate = dSet.indexOfColumn("bid_rate");
   	int idx_ocomp_rate = dSet.indexOfColumn("ocomp_rate");
   	int idx_ocomp_amt = dSet.indexOfColumn("ocomp_amt");
   	int idx_ocomp_consortium = dSet.indexOfColumn("ocomp_consortium");
   	int idx_const_outline1 = dSet.indexOfColumn("const_outline1");
   	int idx_const_outline2 = dSet.indexOfColumn("const_outline2");
   	int idx_limit_contents1 = dSet.indexOfColumn("limit_contents1");
   	int idx_limit_contents2 = dSet.indexOfColumn("limit_contents2");
   	int idx_year_area = dSet.indexOfColumn("year_area");
   	int idx_year_area_unit = dSet.indexOfColumn("year_area_unit");
   	int idx_volume_rt = dSet.indexOfColumn("volume_rt");
   	int idx_bulid_rt = dSet.indexOfColumn("bulid_rt");
   	int idx_const_area = dSet.indexOfColumn("const_area");
   	int idx_const_area_unit = dSet.indexOfColumn("const_area_unit");
   	int idx_comp_size = dSet.indexOfColumn("comp_size");
   	int idx_floor = dSet.indexOfColumn("floor");
   	int idx_approve_cond = dSet.indexOfColumn("approve_cond");
   	int idx_before_opinion = dSet.indexOfColumn("before_opinion");
   	int idx_after_opinion = dSet.indexOfColumn("after_opinion");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_input_name = dSet.indexOfColumn("input_name");
   	int idx_const_etc_remark = dSet.indexOfColumn("const_etc_remark");
   	int idx_business_remark = dSet.indexOfColumn("business_remark");
   	int idx_imp_supplier = dSet.indexOfColumn("imp_supplier");
   	int idx_cons_year = dSet.indexOfColumn("cons_year");
   	int idx_cons_no = dSet.indexOfColumn("cons_no");
   	int idx_masterdept_tag = dSet.indexOfColumn("masterdept_tag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO r_receive_code ( receive_code," + 
                    "name," + 
                    "const_shortname," + 
                    "order_no," + 
                    "order_no1," + 
                    "region_code," + 
                    "const_position," + 
                    "constkind_tag," + 
                    "pq_tag," + 
                    "join_cont_tag," + 
                    "receive_tag," + 
                    "receive_process_class," + 
                    "tender_tag," + 
                    "order_tag," + 
                    "const_from," + 
                    "const_to," + 
                    "dept_code," + 
                    "parent_dept_code," + 
                    "approve_class," + 
                    "siteexplan_date," + 
                    "siteexplan_place," + 
                    "siteexplan_cond," + 
                    "siteexplan_tag," + 
                    "siteexplan_name," + 
                    "siteexplan_entrycompany," + 
                    "siteexplan_memo," + 
                    "regist_date," + 
                    "regist_place," + 
                    "regist_tag," + 
                    "tender_no," + 
                    "tender_date," + 
                    "tender_place," + 
                    "tender_cond," + 
                    "tender_guarantee," + 
                    "entry_tag," + 
                    "entry_company," + 
                    "pq_limit_date," + 
                    "res_end_date," + 
                    "pro_end_date," + 
                    "design_amt," + 
                    "survey_amt," + 
                    "office_amt," + 
                    "presume_amt," + 
                    "presume_price," + 
                    "valuation_amt," + 
                    "budget_amt," + 
                    "budget_rate," + 
                    "budget_from_rate," + 
                    "budget_to_rate," + 
                    "bid_date," + 
                    "bid_amt," + 
                    "bid_rate," + 
                    "ocomp_rate," + 
                    "ocomp_amt," + 
                    "ocomp_consortium," + 
                    "const_outline1," + 
                    "const_outline2," + 
                    "limit_contents1," + 
                    "limit_contents2," + 
                    "year_area," + 
                    "year_area_unit," + 
                    "volume_rt," + 
                    "bulid_rt," + 
                    "const_area," + 
                    "const_area_unit," + 
                    "comp_size," + 
                    "floor," + 
                    "approve_cond," + 
                    "before_opinion," + 
                    "after_opinion," + 
                    "remark, " +
						  "imp_supplier , " +
						  "input_name , " + 	
						  "const_etc_remark , " +
						  "business_remark,   " +
						  "masterdept_tag )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, :31, :32, :33, :34, :35, :36, :37, :38, :39, :40, :41, :42, :43, :44, :45, :46, :47, :48, :49, :50, :51, :52, :53, :54, :55, :56, :57, :58, :59, :60, :61, :62, :63, :64, :65, :66, :67, :68, :69, :70, :71, :72 , :73 , :74 , :75, :76 ) ";

      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_receive_code);
      gpstatement.bindColumn(2, idx_name);
      gpstatement.bindColumn(3, idx_const_shortname);
      gpstatement.bindColumn(4, idx_order_no);
      gpstatement.bindColumn(5, idx_order_no1);
      gpstatement.bindColumn(6, idx_region_code);
      gpstatement.bindColumn(7, idx_const_position);
      gpstatement.bindColumn(8, idx_constkind_tag);
      gpstatement.bindColumn(9, idx_pq_tag);
      gpstatement.bindColumn(10, idx_join_cont_tag);
      gpstatement.bindColumn(11, idx_receive_tag);
      gpstatement.bindColumn(12, idx_receive_process_class);
      gpstatement.bindColumn(13, idx_tender_tag);
      gpstatement.bindColumn(14, idx_order_tag);
      gpstatement.bindColumn(15, idx_const_from);
      gpstatement.bindColumn(16, idx_const_to);
      gpstatement.bindColumn(17, idx_dept_code);
      gpstatement.bindColumn(18, idx_parent_dept_code);
      gpstatement.bindColumn(19, idx_approve_class);
      gpstatement.bindColumn(20, idx_siteexplan_date);
      gpstatement.bindColumn(21, idx_siteexplan_place);
      gpstatement.bindColumn(22, idx_siteexplan_cond);
      gpstatement.bindColumn(23, idx_siteexplan_tag);
      gpstatement.bindColumn(24, idx_siteexplan_name);
      gpstatement.bindColumn(25, idx_siteexplan_entrycompany);
      gpstatement.bindColumn(26, idx_siteexplan_memo);
      gpstatement.bindColumn(27, idx_regist_date);
      gpstatement.bindColumn(28, idx_regist_place);
      gpstatement.bindColumn(29, idx_regist_tag);
      gpstatement.bindColumn(30, idx_tender_no);
      gpstatement.bindColumn(31, idx_tender_date);
      gpstatement.bindColumn(32, idx_tender_place);
      gpstatement.bindColumn(33, idx_tender_cond);
      gpstatement.bindColumn(34, idx_tender_guarantee);
      gpstatement.bindColumn(35, idx_entry_tag);
      gpstatement.bindColumn(36, idx_entry_company);
      gpstatement.bindColumn(37, idx_pq_limit_date);
      gpstatement.bindColumn(38, idx_res_end_date);
      gpstatement.bindColumn(39, idx_pro_end_date);
      gpstatement.bindColumn(40, idx_design_amt);
      gpstatement.bindColumn(41, idx_survey_amt);
      gpstatement.bindColumn(42, idx_office_amt);
      gpstatement.bindColumn(43, idx_presume_amt);
      gpstatement.bindColumn(44, idx_presume_price);
      gpstatement.bindColumn(45, idx_valuation_amt);
      gpstatement.bindColumn(46, idx_budget_amt);
      gpstatement.bindColumn(47, idx_budget_rate);
      gpstatement.bindColumn(48, idx_budget_from_rate);
      gpstatement.bindColumn(49, idx_budget_to_rate);
      gpstatement.bindColumn(50, idx_bid_date);
      gpstatement.bindColumn(51, idx_bid_amt);
      gpstatement.bindColumn(52, idx_bid_rate);
      gpstatement.bindColumn(53, idx_ocomp_rate);
      gpstatement.bindColumn(54, idx_ocomp_amt);
      gpstatement.bindColumn(55, idx_ocomp_consortium);
      gpstatement.bindColumn(56, idx_const_outline1);
      gpstatement.bindColumn(57, idx_const_outline2);
      gpstatement.bindColumn(58, idx_limit_contents1);
      gpstatement.bindColumn(59, idx_limit_contents2);
      gpstatement.bindColumn(60, idx_year_area);
      gpstatement.bindColumn(61, idx_year_area_unit);
      gpstatement.bindColumn(62, idx_volume_rt);
      gpstatement.bindColumn(63, idx_bulid_rt);
      gpstatement.bindColumn(64, idx_const_area);
      gpstatement.bindColumn(65, idx_const_area_unit);
      gpstatement.bindColumn(66, idx_comp_size);
      gpstatement.bindColumn(67, idx_floor);
      gpstatement.bindColumn(68, idx_approve_cond);
      gpstatement.bindColumn(69, idx_before_opinion);
      gpstatement.bindColumn(70, idx_after_opinion);
      gpstatement.bindColumn(71, idx_remark);
		gpstatement.bindColumn(72, idx_imp_supplier);
		gpstatement.bindColumn(73, idx_input_name);
      gpstatement.bindColumn(74, idx_const_etc_remark);
      gpstatement.bindColumn(75, idx_business_remark);
      gpstatement.bindColumn(76, idx_masterdept_tag);
		stmt.executeUpdate();
      stmt.close();
 		
 		PreparedStatement stmt2 = null;
      String sSql2 = "update r_received_construction set " +
      								"receive_code=?,  " + 
      								"receive_process_class=? where date_year=? and no=? ";
     	stmt2 = conn.prepareStatement(sSql2);
     	gpstatement.gp_stmt = stmt2;
      gpstatement.bindColumn(1, idx_receive_code);
     	gpstatement.bindColumn(2, idx_receive_process_class);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
 		gpstatement.bindColumn(3, idx_cons_year);
 		gpstatement.bindColumn(4, idx_cons_no);
 		stmt2.executeUpdate();
      stmt2.close();
      
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update r_receive_code set " + 
                            "receive_code=?,  " + 
                            "name=?,  " + 
                            "const_shortname=?,  " + 
                            "order_no=?,  " + 
                            "order_no1=?,  " + 
                            "region_code=?,  " + 
                            "const_position=?,  " + 
                            "constkind_tag=?,  " + 
                            "pq_tag=?,  " + 
                            "join_cont_tag=?,  " + 
                            "receive_tag=?,  " + 
                            "receive_process_class=?,  " + 
                            "tender_tag=?,  " + 
                            "order_tag=?,  " + 
                            "const_from=?,  " + 
                            "const_to=?,  " + 
                            "dept_code=?,  " + 
                            "parent_dept_code=?,  " + 
                            "approve_class=?,  " + 
                            "siteexplan_date=?,  " + 
                            "siteexplan_place=?,  " + 
                            "siteexplan_cond=?,  " + 
                            "siteexplan_tag=?,  " + 
                            "siteexplan_name=?,  " + 
                            "siteexplan_entrycompany=?,  " + 
                            "siteexplan_memo=?,  " + 
                            "regist_date=?,  " + 
                            "regist_place=?,  " + 
                            "regist_tag=?,  " + 
                            "tender_no=?,  " + 
                            "tender_date=?,  " + 
                            "tender_place=?,  " + 
                            "tender_cond=?,  " + 
                            "tender_guarantee=?,  " + 
                            "entry_tag=?,  " + 
                            "entry_company=?,  " + 
                            "pq_limit_date=?,  " + 
                            "res_end_date=?,  " + 
                            "pro_end_date=?,  " + 
                            "design_amt=?,  " + 
                            "survey_amt=?,  " + 
                            "office_amt=?,  " + 
                            "presume_amt=?,  " + 
                            "presume_price=?,  " + 
                            "valuation_amt=?,  " + 
                            "budget_amt=?,  " + 
                            "budget_rate=?,  " + 
                            "budget_from_rate=?,  " + 
                            "budget_to_rate=?,  " + 
                            "bid_date=?,  " + 
                            "bid_amt=?,  " + 
                            "bid_rate=?,  " + 
                            "ocomp_rate=?,  " + 
                            "ocomp_amt=?,  " + 
                            "ocomp_consortium=?,  " + 
                            "const_outline1=?,  " + 
                            "const_outline2=?,  " + 
                            "limit_contents1=?,  " + 
                            "limit_contents2=?,  " + 
                            "year_area=?,  " + 
                            "year_area_unit=?,  " + 
                            "volume_rt=?,  " + 
                            "bulid_rt=?,  " + 
                            "const_area=?,  " + 
                            "const_area_unit=?,  " + 
                            "comp_size=?,  " + 
                            "floor=?,  " + 
                            "approve_cond=?,  " + 
                            "before_opinion=?,  " + 
                            "after_opinion=?,  " + 
                            "remark=?, " +
									 "imp_supplier=? , " +
									 "input_name=? , " + 	
                            "const_etc_remark=?, " +
                            "business_remark=?, " +
                            "masterdept_tag=? " +
									 "where receive_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_receive_code);
      gpstatement.bindColumn(2, idx_name);
      gpstatement.bindColumn(3, idx_const_shortname);
      gpstatement.bindColumn(4, idx_order_no);
      gpstatement.bindColumn(5, idx_order_no1);
      gpstatement.bindColumn(6, idx_region_code);
      gpstatement.bindColumn(7, idx_const_position);
      gpstatement.bindColumn(8, idx_constkind_tag);
      gpstatement.bindColumn(9, idx_pq_tag);
      gpstatement.bindColumn(10, idx_join_cont_tag);
      gpstatement.bindColumn(11, idx_receive_tag);
      gpstatement.bindColumn(12, idx_receive_process_class);
      gpstatement.bindColumn(13, idx_tender_tag);
      gpstatement.bindColumn(14, idx_order_tag);
      gpstatement.bindColumn(15, idx_const_from);
      gpstatement.bindColumn(16, idx_const_to);
      gpstatement.bindColumn(17, idx_dept_code);
      gpstatement.bindColumn(18, idx_parent_dept_code);
      gpstatement.bindColumn(19, idx_approve_class);
      gpstatement.bindColumn(20, idx_siteexplan_date);
      gpstatement.bindColumn(21, idx_siteexplan_place);
      gpstatement.bindColumn(22, idx_siteexplan_cond);
      gpstatement.bindColumn(23, idx_siteexplan_tag);
      gpstatement.bindColumn(24, idx_siteexplan_name);
      gpstatement.bindColumn(25, idx_siteexplan_entrycompany);
      gpstatement.bindColumn(26, idx_siteexplan_memo);
      gpstatement.bindColumn(27, idx_regist_date);
      gpstatement.bindColumn(28, idx_regist_place);
      gpstatement.bindColumn(29, idx_regist_tag);
      gpstatement.bindColumn(30, idx_tender_no);
      gpstatement.bindColumn(31, idx_tender_date);
      gpstatement.bindColumn(32, idx_tender_place);
      gpstatement.bindColumn(33, idx_tender_cond);
      gpstatement.bindColumn(34, idx_tender_guarantee);
      gpstatement.bindColumn(35, idx_entry_tag);
      gpstatement.bindColumn(36, idx_entry_company);
      gpstatement.bindColumn(37, idx_pq_limit_date);
      gpstatement.bindColumn(38, idx_res_end_date);
      gpstatement.bindColumn(39, idx_pro_end_date);
      gpstatement.bindColumn(40, idx_design_amt);
      gpstatement.bindColumn(41, idx_survey_amt);
      gpstatement.bindColumn(42, idx_office_amt);
      gpstatement.bindColumn(43, idx_presume_amt);
      gpstatement.bindColumn(44, idx_presume_price);
      gpstatement.bindColumn(45, idx_valuation_amt);
      gpstatement.bindColumn(46, idx_budget_amt);
      gpstatement.bindColumn(47, idx_budget_rate);
      gpstatement.bindColumn(48, idx_budget_from_rate);
      gpstatement.bindColumn(49, idx_budget_to_rate);
      gpstatement.bindColumn(50, idx_bid_date);
      gpstatement.bindColumn(51, idx_bid_amt);
      gpstatement.bindColumn(52, idx_bid_rate);
      gpstatement.bindColumn(53, idx_ocomp_rate);
      gpstatement.bindColumn(54, idx_ocomp_amt);
      gpstatement.bindColumn(55, idx_ocomp_consortium);
      gpstatement.bindColumn(56, idx_const_outline1);
      gpstatement.bindColumn(57, idx_const_outline2);
      gpstatement.bindColumn(58, idx_limit_contents1);
      gpstatement.bindColumn(59, idx_limit_contents2);
      gpstatement.bindColumn(60, idx_year_area);
      gpstatement.bindColumn(61, idx_year_area_unit);
      gpstatement.bindColumn(62, idx_volume_rt);
      gpstatement.bindColumn(63, idx_bulid_rt);
      gpstatement.bindColumn(64, idx_const_area);
      gpstatement.bindColumn(65, idx_const_area_unit);
      gpstatement.bindColumn(66, idx_comp_size);
      gpstatement.bindColumn(67, idx_floor);
      gpstatement.bindColumn(68, idx_approve_cond);
      gpstatement.bindColumn(69, idx_before_opinion);
      gpstatement.bindColumn(70, idx_after_opinion);
      gpstatement.bindColumn(71, idx_remark);
      gpstatement.bindColumn(72, idx_imp_supplier);
      gpstatement.bindColumn(73, idx_input_name);
      gpstatement.bindColumn(74, idx_const_etc_remark);
      gpstatement.bindColumn(75, idx_business_remark);
      gpstatement.bindColumn(76, idx_masterdept_tag);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(77, idx_key_receive_code);
      stmt.executeUpdate();
      stmt.close();
      
      PreparedStatement stmt2 = null;
      String sSql2 = "update r_received_construction set " +
      								"receive_code=?,  " + 
      								"receive_process_class=? where receive_code=?  ";
     	stmt2 = conn.prepareStatement(sSql2);
     	gpstatement.gp_stmt = stmt2;
      gpstatement.bindColumn(1, idx_receive_code);
     	gpstatement.bindColumn(2, idx_receive_process_class);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
 		gpstatement.bindColumn(3, idx_key_receive_code);
 		stmt2.executeUpdate();
      stmt2.close();
      
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_receive_code where receive_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_receive_code);
      stmt.executeUpdate();
      stmt.close();
      
      
      PreparedStatement stmt2 = null;
      String sSql2 = "update r_received_construction set " +
      								"receive_code='',  " + 
      								"receive_process_class='01' where receive_code=?  ";
     	stmt2 = conn.prepareStatement(sSql2);
     	gpstatement.gp_stmt = stmt2;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
 		gpstatement.bindColumn(1, idx_key_receive_code);
 		stmt2.executeUpdate();
      stmt2.close();
      
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>