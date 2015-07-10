<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_mssql_confirm_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_estimate_plan_01_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_unq_num = dSet.indexOfColumn("unq_num");
   	int idx_long_name = dSet.indexOfColumn("long_name");
   	int idx_cnt_amt = dSet.indexOfColumn("cnt_amt");
   	int idx_s_profession_wbs_name = dSet.indexOfColumn("s_profession_wbs_name");
   	int idx_exe_amt = dSet.indexOfColumn("exe_amt");
   	int idx_pr_date = dSet.indexOfColumn("pr_date");
   	int idx_exe_prof = dSet.indexOfColumn("exe_prof");
   	int idx_br_date = dSet.indexOfColumn("br_date");
   	int idx_choice_kind = dSet.indexOfColumn("choice_kind");
   	int idx_chg_start_dt = dSet.indexOfColumn("chg_start_dt");
   	int idx_chg_end_dt = dSet.indexOfColumn("chg_end_dt");
   	int idx_start_dt = dSet.indexOfColumn("start_dt");
   	int idx_end_dt = dSet.indexOfColumn("end_dt");
   	int idx_warrant_term = dSet.indexOfColumn("warrant_term");
   	int idx_warrant_guarantee_rt = dSet.indexOfColumn("warrant_guarantee_rt");
   	int idx_delay_rt2 = dSet.indexOfColumn("delay_rt2");
   	int idx_sbc_guarantee_rt = dSet.indexOfColumn("sbc_guarantee_rt");
   	int idx_previous_pay1 = dSet.indexOfColumn("previous_pay1");
   	int idx_cnt_previous_amt = dSet.indexOfColumn("cnt_previous_amt");
   	int idx_previous_pay2 = dSet.indexOfColumn("previous_pay2");
   	int idx_directamt_rt = dSet.indexOfColumn("directamt_rt");
   	int idx_bill_rt = dSet.indexOfColumn("bill_rt");
   	int idx_title = dSet.indexOfColumn("title");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_estimate_plan_01 ( unq_num," + 
                    "long_name," + 
                    "cnt_amt," + 
                    "s_profession_wbs_name," + 
                    "exe_amt," + 
                    "pr_date," + 
                    "exe_prof," + 
                    "br_date," + 
                    "choice_kind," + 
                    "chg_start_dt," + 
                    "chg_end_dt," + 
                    "start_dt," + 
                    "end_dt," + 
                    "warrant_term," + 
                    "warrant_guarantee_rt," + 
                    "delay_rt2," + 
                    "sbc_guarantee_rt," + 
                    "previous_pay1," + 
                    "cnt_previous_amt," + 
                    "previous_pay2," + 
                    "directamt_rt," + 
                    "bill_rt, title )      ";
      sSql = sSql + " VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,? ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_long_name);
      gpstatement.bindColumn(3, idx_cnt_amt);
      gpstatement.bindColumn(4, idx_s_profession_wbs_name);
      gpstatement.bindColumn(5, idx_exe_amt);
      gpstatement.bindColumn(6, idx_pr_date);
      gpstatement.bindColumn(7, idx_exe_prof);
      gpstatement.bindColumn(8, idx_br_date);
      gpstatement.bindColumn(9, idx_choice_kind);
      gpstatement.bindColumn(10, idx_chg_start_dt);
      gpstatement.bindColumn(11, idx_chg_end_dt);
      gpstatement.bindColumn(12, idx_start_dt);
      gpstatement.bindColumn(13, idx_end_dt);
      gpstatement.bindColumn(14, idx_warrant_term);
      gpstatement.bindColumn(15, idx_warrant_guarantee_rt);
      gpstatement.bindColumn(16, idx_delay_rt2);
      gpstatement.bindColumn(17, idx_sbc_guarantee_rt);
      gpstatement.bindColumn(18, idx_previous_pay1);
      gpstatement.bindColumn(19, idx_cnt_previous_amt);
      gpstatement.bindColumn(20, idx_previous_pay2);
      gpstatement.bindColumn(21, idx_directamt_rt);
      gpstatement.bindColumn(22, idx_bill_rt);
      gpstatement.bindColumn(23, idx_title);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_estimate_plan_01 set " + 
                            "unq_num=?,  " + 
                            "long_name=?,  " + 
                            "cnt_amt=?,  " + 
                            "s_profession_wbs_name=?,  " + 
                            "exe_amt=?,  " + 
                            "pr_date=?,  " + 
                            "exe_prof=?,  " + 
                            "br_date=?,  " + 
                            "choice_kind=?,  " + 
                            "chg_start_dt=?,  " + 
                            "chg_end_dt=?,  " + 
                            "start_dt=?,  " + 
                            "end_dt=?,  " + 
                            "warrant_term=?,  " + 
                            "warrant_guarantee_rt=?,  " + 
                            "delay_rt2=?,  " + 
                            "sbc_guarantee_rt=?,  " + 
                            "previous_pay1=?,  " + 
                            "cnt_previous_amt=?,  " + 
                            "previous_pay2=?,  " + 
                            "directamt_rt=?,  " + 
                            "bill_rt=?  where unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_long_name);
      gpstatement.bindColumn(3, idx_cnt_amt);
      gpstatement.bindColumn(4, idx_s_profession_wbs_name);
      gpstatement.bindColumn(5, idx_exe_amt);
      gpstatement.bindColumn(6, idx_pr_date);
      gpstatement.bindColumn(7, idx_exe_prof);
      gpstatement.bindColumn(8, idx_br_date);
      gpstatement.bindColumn(9, idx_choice_kind);
      gpstatement.bindColumn(10, idx_chg_start_dt);
      gpstatement.bindColumn(11, idx_chg_end_dt);
      gpstatement.bindColumn(12, idx_start_dt);
      gpstatement.bindColumn(13, idx_end_dt);
      gpstatement.bindColumn(14, idx_warrant_term);
      gpstatement.bindColumn(15, idx_warrant_guarantee_rt);
      gpstatement.bindColumn(16, idx_delay_rt2);
      gpstatement.bindColumn(17, idx_sbc_guarantee_rt);
      gpstatement.bindColumn(18, idx_previous_pay1);
      gpstatement.bindColumn(19, idx_cnt_previous_amt);
      gpstatement.bindColumn(20, idx_previous_pay2);
      gpstatement.bindColumn(21, idx_directamt_rt);
      gpstatement.bindColumn(22, idx_bill_rt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(23, idx_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_estimate_plan_01 where unq_num=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>