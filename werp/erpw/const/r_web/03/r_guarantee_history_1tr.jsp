<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_guarantee_history_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_guarantee_no = dSet.indexOfColumn("guarantee_no");
   	int idx_guarantee_time = dSet.indexOfColumn("guarantee_time");
   	int idx_key_guarantee_time = dSet.indexOfColumn("key_guarantee_time");
   	int idx_guarantee_kind = dSet.indexOfColumn("guarantee_kind");
   	int idx_guarantee_timeamt = dSet.indexOfColumn("guarantee_timeamt");
   	int idx_guarantee_amtchange = dSet.indexOfColumn("guarantee_amtchange");
   	int idx_guarantee_demand_date = dSet.indexOfColumn("guarantee_demand_date");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO R_GENERAL_GUARANTEE_HISTORY ( guarantee_no," + 
                    "guarantee_time," + 
                    "guarantee_kind," + 
                    "guarantee_timeamt," + 
                    "guarantee_amtchange," + 
                    "guarantee_demand_date )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_guarantee_no);
      gpstatement.bindColumn(2, idx_guarantee_time);
      gpstatement.bindColumn(3, idx_guarantee_kind);
      gpstatement.bindColumn(4, idx_guarantee_timeamt);
      gpstatement.bindColumn(5, idx_guarantee_amtchange);
      gpstatement.bindColumn(6, idx_guarantee_demand_date);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update r_general_guarantee_history set " + 
                            "guarantee_no=?,  " + 
                            "guarantee_time=?,  " + 
                            "guarantee_kind=?,  " + 
                            "guarantee_timeamt=?,  " + 
                            "guarantee_amtchange=?,  " + 
                            "guarantee_demand_date=?  where guarantee_no=? " + 
                            " and guarantee_time=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_guarantee_no);
      gpstatement.bindColumn(2, idx_guarantee_time);
      gpstatement.bindColumn(3, idx_guarantee_kind);
      gpstatement.bindColumn(4, idx_guarantee_timeamt);
      gpstatement.bindColumn(5, idx_guarantee_amtchange);
      gpstatement.bindColumn(6, idx_guarantee_demand_date);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_guarantee_no);
      gpstatement.bindColumn(8, idx_key_guarantee_time);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_general_guarantee_history where guarantee_no=? " +
      						 " and guarantee_time=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_guarantee_no);
      gpstatement.bindColumn(2, idx_key_guarantee_time);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>