<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_mssql_confirm_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_cn_approve_01_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_unq_num = dSet.indexOfColumn("unq_num");
   	int idx_long_name = dSet.indexOfColumn("long_name");
   	int idx_sbc_name = dSet.indexOfColumn("sbc_name");
   	int idx_start_dt = dSet.indexOfColumn("start_dt");
   	int idx_end_dt = dSet.indexOfColumn("end_dt");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_warrant_term = dSet.indexOfColumn("warrant_term");
   	int idx_delay_rt = dSet.indexOfColumn("delay_rt");
   	int idx_sbc_guarantee_rt = dSet.indexOfColumn("sbc_guarantee_rt");
   	int idx_warrant_guarantee_rt = dSet.indexOfColumn("warrant_guarantee_rt");
   	int idx_cnt_previous_amt = dSet.indexOfColumn("cnt_previous_amt");
   	int idx_previous_amt = dSet.indexOfColumn("previous_amt");
   	int idx_prgs_cash_rt = dSet.indexOfColumn("prgs_cash_rt");
   	int idx_prgs_bill_rt = dSet.indexOfColumn("prgs_bill_rt");
   	int idx_previous_amt_rt = dSet.indexOfColumn("previous_amt_rt");
   	int idx_previous_pay1 = dSet.indexOfColumn("previous_pay1");
   	int idx_sbc_guarantee_amt = dSet.indexOfColumn("sbc_guarantee_amt");
   	int idx_warrant_guarantee_amt = dSet.indexOfColumn("warrant_guarantee_amt");
   	int idx_title = dSet.indexOfColumn("title");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_CN_APPROVE_01 ( unq_num," + 
                    "long_name," + 
                    "sbc_name," + 
                    "start_dt," + 
                    "end_dt," + 
                    "sbcr_name," + 
                    "warrant_term," + 
                    "delay_rt," + 
                    "sbc_guarantee_rt," + 
                    "warrant_guarantee_rt," + 
                    "cnt_previous_amt," + 
                    "previous_amt," + 
                    "prgs_cash_rt," + 
                    "prgs_bill_rt," + 
                    "previous_amt_rt," + 
                    "previous_pay1," + 
                    "sbc_guarantee_amt," + 
                    "warrant_guarantee_amt," + 
                    "title )      ";
      sSql = sSql + " VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_long_name);
      gpstatement.bindColumn(3, idx_sbc_name);
      gpstatement.bindColumn(4, idx_start_dt);
      gpstatement.bindColumn(5, idx_end_dt);
      gpstatement.bindColumn(6, idx_sbcr_name);
      gpstatement.bindColumn(7, idx_warrant_term);
      gpstatement.bindColumn(8, idx_delay_rt);
      gpstatement.bindColumn(9, idx_sbc_guarantee_rt);
      gpstatement.bindColumn(10, idx_warrant_guarantee_rt);
      gpstatement.bindColumn(11, idx_cnt_previous_amt);
      gpstatement.bindColumn(12, idx_previous_amt);
      gpstatement.bindColumn(13, idx_prgs_cash_rt);
      gpstatement.bindColumn(14, idx_prgs_bill_rt);
      gpstatement.bindColumn(15, idx_previous_amt_rt);
      gpstatement.bindColumn(16, idx_previous_pay1);
      gpstatement.bindColumn(17, idx_sbc_guarantee_amt);
      gpstatement.bindColumn(18, idx_warrant_guarantee_amt);
      gpstatement.bindColumn(19, idx_title);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_cn_approve_01 set " + 
                            "unq_num=?,  " + 
                            "long_name=?,  " + 
                            "sbc_name=?,  " + 
                            "start_dt=?,  " + 
                            "end_dt=?,  " + 
                            "sbcr_name=?,  " + 
                            "warrant_term=?,  " + 
                            "delay_rt=?,  " + 
                            "sbc_guarantee_rt=?,  " + 
                            "warrant_guarantee_rt=?,  " + 
                            "cnt_previous_amt=?,  " + 
                            "previous_amt=?,  " + 
                            "prgs_cash_rt=?,  " + 
                            "prgs_bill_rt=?,  " + 
                            "previous_amt_rt=?,  " + 
                            "previous_pay1=?,  " + 
                            "sbc_guarantee_amt=?,  " + 
                            "warrant_guarantee_amt=?,  " + 
                            "title=?  where unq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_long_name);
      gpstatement.bindColumn(3, idx_sbc_name);
      gpstatement.bindColumn(4, idx_start_dt);
      gpstatement.bindColumn(5, idx_end_dt);
      gpstatement.bindColumn(6, idx_sbcr_name);
      gpstatement.bindColumn(7, idx_warrant_term);
      gpstatement.bindColumn(8, idx_delay_rt);
      gpstatement.bindColumn(9, idx_sbc_guarantee_rt);
      gpstatement.bindColumn(10, idx_warrant_guarantee_rt);
      gpstatement.bindColumn(11, idx_cnt_previous_amt);
      gpstatement.bindColumn(12, idx_previous_amt);
      gpstatement.bindColumn(13, idx_prgs_cash_rt);
      gpstatement.bindColumn(14, idx_prgs_bill_rt);
      gpstatement.bindColumn(15, idx_previous_amt_rt);
      gpstatement.bindColumn(16, idx_previous_pay1);
      gpstatement.bindColumn(17, idx_sbc_guarantee_amt);
      gpstatement.bindColumn(18, idx_warrant_guarantee_amt);
      gpstatement.bindColumn(19, idx_title);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(20, idx_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_cn_approve_01 where unq_num=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_unq_num);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>