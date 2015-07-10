<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_receive_code_input_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_receive_code = dSet.indexOfColumn("receive_code");
   	int idx_key_receive_code = dSet.indexOfColumn("key_receive_code");
   	int idx_cons_year = dSet.indexOfColumn("cons_year");
   	int idx_cons_no = dSet.indexOfColumn("cons_no");
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
   	int idx_receive_process_class = dSet.indexOfColumn("r_process_class");
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
   	int idx_bid_comp = dSet.indexOfColumn("bid_comp");
   	int idx_imp_supplier = dSet.indexOfColumn("imp_supplier");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
 		PreparedStatement r_stmt = null;
 		
 		String ls_receive_code = rows.getString(idx_receive_code);
 		String ls_receive_process_class = rows.getString(idx_receive_process_class);
 		String ls_cons_year = rows.getString(idx_cons_year);
 		String ls_cons_no = rows.getString(idx_cons_no);
 		
 		String sSql1 = "update r_receive_code set " +
 		               "       receive_process_class='" + ls_receive_process_class + "' " +
 		               " where receive_code='" + ls_receive_code + "' ";
 		               
		r_stmt = conn.prepareStatement(sSql1);
      r_stmt.executeUpdate();
      r_stmt.close(); 		               
 		
      String sSql = "update r_received_construction set " + 
                            "receive_code='" + ls_receive_code + "', " +
                            "receive_process_class='" + ls_receive_process_class + "' " +
                            "where date_year='" + ls_cons_year + "' and no='" + ls_cons_no + "' ";  
                            
      stmt = conn.prepareStatement(sSql);
      stmt.executeUpdate();
      stmt.close(); 
      
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_receive_code where receive_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_receive_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>