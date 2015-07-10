<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_contract_detail_7tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_rate_kind = dSet.indexOfColumn("rate_kind");
   	int idx_key_rate_kind = dSet.indexOfColumn("key_rate_kind");
   	int idx_mnth = dSet.indexOfColumn("mnth");
   	int idx_key_mnth = dSet.indexOfColumn("key_mnth");
   	int idx_s_date = dSet.indexOfColumn("s_date");
   	int idx_key_s_date = dSet.indexOfColumn("key_s_date");
   	int idx_e_date = dSet.indexOfColumn("e_date");
   	int idx_rate = dSet.indexOfColumn("rate");
   	int idx_cutoff_std = dSet.indexOfColumn("cutoff_std");
   	int idx_cutoff_unit = dSet.indexOfColumn("cutoff_unit");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_SALE_DELAY_RATE ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "rate_kind," + 
                    "mnth," + 
                    "s_date," + 
                    "e_date," + 
                    "rate," + 
                    "cutoff_std," + 
                    "cutoff_unit )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_rate_kind);
      gpstatement.bindColumn(6, idx_mnth);
      gpstatement.bindColumn(7, idx_s_date);
      gpstatement.bindColumn(8, idx_e_date);
      gpstatement.bindColumn(9, idx_rate);
      gpstatement.bindColumn(10, idx_cutoff_std);
      gpstatement.bindColumn(11, idx_cutoff_unit);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sale_delay_rate set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "rate_kind=?,  " + 
                            "mnth=?,  " + 
                            "s_date=?,  " + 
                            "e_date=?,  " + 
                            "rate=?,  " + 
                            "cutoff_std=?,  " + 
                            "cutoff_unit=?  where dept_code=? " +
                            "                 and sell_code=? " +
                            "                 and dongho=? " +
                            "                 and seq=? " + 
                            "                 and rate_kind=? " +
                            "                 and mnth=? " +
                            "                 and s_date=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_rate_kind);
      gpstatement.bindColumn(6, idx_mnth);
      gpstatement.bindColumn(7, idx_s_date);
      gpstatement.bindColumn(8, idx_e_date);
      gpstatement.bindColumn(9, idx_rate);
      gpstatement.bindColumn(10, idx_cutoff_std);
      gpstatement.bindColumn(11, idx_cutoff_unit);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_dept_code);
      gpstatement.bindColumn(13, idx_sell_code);
      gpstatement.bindColumn(14, idx_dongho);
      gpstatement.bindColumn(15, idx_seq);
      gpstatement.bindColumn(16, idx_key_rate_kind);
      gpstatement.bindColumn(17, idx_key_mnth);
      gpstatement.bindColumn(18, idx_key_s_date);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sale_delay_rate where dept_code=? " + 
                            "                 and sell_code=? " +
                            "                 and dongho=? " +
                            "                 and seq=? " + 
                            "                 and rate_kind=? " +
                            "                 and mnth=? " +
                             "                 and s_date=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_key_rate_kind);
      gpstatement.bindColumn(6, idx_key_mnth);
      gpstatement.bindColumn(7, idx_key_s_date);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>