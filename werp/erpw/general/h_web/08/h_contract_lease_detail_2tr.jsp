<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_contract_lease_detail_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_cont_date = dSet.indexOfColumn("cont_date");
   	int idx_cont_seq = dSet.indexOfColumn("cont_seq");
   	int idx_chg_seq = dSet.indexOfColumn("chg_seq");
   	int idx_chg_cont_date = dSet.indexOfColumn("chg_cont_date");
   	int idx_lease_s_date = dSet.indexOfColumn("lease_s_date");
   	int idx_lease_e_date = dSet.indexOfColumn("lease_e_date");
   	int idx_grt_amt = dSet.indexOfColumn("grt_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_lease_detail ( dept_code," + 
                    "sell_code," + 
                    "cont_date," + 
                    "cont_seq," + 
                    "chg_seq," + 
                    "chg_cont_date," + 
                    "lease_s_date," + 
                    "lease_e_date," + 
                    "grt_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_cont_date);
      gpstatement.bindColumn(4, idx_cont_seq);
      gpstatement.bindColumn(5, idx_chg_seq);
      gpstatement.bindColumn(6, idx_chg_cont_date);
      gpstatement.bindColumn(7, idx_lease_s_date);
      gpstatement.bindColumn(8, idx_lease_e_date);
      gpstatement.bindColumn(9, idx_grt_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_lease_detail set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "cont_date=?,  " + 
                            "cont_seq=?,  " + 
                            "chg_seq=?,  " + 
                            "chg_cont_date=?,  " + 
                            "lease_s_date=?,  " + 
                            "lease_e_date=?,  " + 
                            "grt_amt=?  where dept_code=?  and sell_code=? and cont_date=? and cont_seq=? and chg_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_cont_date);
      gpstatement.bindColumn(4, idx_cont_seq);
      gpstatement.bindColumn(5, idx_chg_seq);
      gpstatement.bindColumn(6, idx_chg_cont_date);
      gpstatement.bindColumn(7, idx_lease_s_date);
      gpstatement.bindColumn(8, idx_lease_e_date);
      gpstatement.bindColumn(9, idx_grt_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(10, idx_dept_code);
		gpstatement.bindColumn(11, idx_sell_code);
      gpstatement.bindColumn(12, idx_cont_date);
      gpstatement.bindColumn(13, idx_cont_seq);
		gpstatement.bindColumn(14, idx_chg_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_lease_detail where dept_code=?  and sell_code=? and cont_date=? and cont_seq=? and chg_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
		gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_cont_date);
      gpstatement.bindColumn(4, idx_cont_seq);
		gpstatement.bindColumn(5, idx_chg_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>