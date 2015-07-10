<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("g_mis_forecast_est_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_work_yymm = dSet.indexOfColumn("work_yymm");
   	int idx_proj_bus_type = dSet.indexOfColumn("proj_bus_type");
   	int idx_proj_prog_type = dSet.indexOfColumn("proj_prog_type");
   	int idx_proj_unq_key = dSet.indexOfColumn("proj_unq_key");
   	int idx_ord_sell_amt = dSet.indexOfColumn("ord_sell_amt");
   	int idx_bef_amt = dSet.indexOfColumn("bef_amt");
   	int idx_rem_amt = dSet.indexOfColumn("rem_amt");
   	int idx_amt_1 = dSet.indexOfColumn("amt_1");
   	int idx_amt_2 = dSet.indexOfColumn("amt_2");
   	int idx_amt_3 = dSet.indexOfColumn("amt_3");
   	int idx_amt_4 = dSet.indexOfColumn("amt_4");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_proj_name = dSet.indexOfColumn("proj_name");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO g_mis_forecast_est ( work_yymm," + 
                    "proj_bus_type," + 
                    "proj_prog_type," + 
                    "proj_unq_key," + 
                    "ord_sell_amt," + 
                    "bef_amt," + 
                    "rem_amt," + 
                    "amt_1," + 
                    "amt_2," + 
                    "amt_3," + 
                    "amt_4," + 
                    "remark ,proj_name,no_seq)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_yymm);
      gpstatement.bindColumn(2, idx_proj_bus_type);
      gpstatement.bindColumn(3, idx_proj_prog_type);
      gpstatement.bindColumn(4, idx_proj_unq_key);
      gpstatement.bindColumn(5, idx_ord_sell_amt);
      gpstatement.bindColumn(6, idx_bef_amt);
      gpstatement.bindColumn(7, idx_rem_amt);
      gpstatement.bindColumn(8, idx_amt_1);
      gpstatement.bindColumn(9, idx_amt_2);
      gpstatement.bindColumn(10, idx_amt_3);
      gpstatement.bindColumn(11, idx_amt_4);
      gpstatement.bindColumn(12, idx_remark);
      gpstatement.bindColumn(13, idx_proj_name);
      gpstatement.bindColumn(14, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update g_mis_forecast_est set " + 
                            "work_yymm=?,  " + 
                            "proj_bus_type=?,  " + 
                            "proj_prog_type=?,  " + 
                            "proj_unq_key=?,  " + 
                            "ord_sell_amt=?,  " + 
                            "bef_amt=?,  " + 
                            "rem_amt=?,  " + 
                            "amt_1=?,  " + 
                            "amt_2=?,  " + 
                            "amt_3=?,  " + 
                            "amt_4=?,  " + 
                            "remark=? , proj_name=?, no_seq=? where work_yymm=? and proj_bus_type=? and proj_prog_type=? and proj_unq_key=? ";
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_yymm);
      gpstatement.bindColumn(2, idx_proj_bus_type);
      gpstatement.bindColumn(3, idx_proj_prog_type);
      gpstatement.bindColumn(4, idx_proj_unq_key);
      gpstatement.bindColumn(5, idx_ord_sell_amt);
      gpstatement.bindColumn(6, idx_bef_amt);
      gpstatement.bindColumn(7, idx_rem_amt);
      gpstatement.bindColumn(8, idx_amt_1);
      gpstatement.bindColumn(9, idx_amt_2);
      gpstatement.bindColumn(10, idx_amt_3);
      gpstatement.bindColumn(11, idx_amt_4);
      gpstatement.bindColumn(12, idx_remark);
      gpstatement.bindColumn(13, idx_proj_name);
      gpstatement.bindColumn(14, idx_no_seq);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_work_yymm);
      gpstatement.bindColumn(16, idx_proj_bus_type);
      gpstatement.bindColumn(17, idx_proj_prog_type);
      gpstatement.bindColumn(18, idx_proj_unq_key);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from g_mis_forecast_est where work_yymm=? and proj_bus_type=? and proj_prog_type=? and proj_unq_key=? ";
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_work_yymm);
      gpstatement.bindColumn(2, idx_proj_bus_type);
      gpstatement.bindColumn(3, idx_proj_prog_type);
      gpstatement.bindColumn(4, idx_proj_unq_key);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>