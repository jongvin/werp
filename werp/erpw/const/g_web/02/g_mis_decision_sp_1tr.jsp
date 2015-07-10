<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("g_mis_decision_sp_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_work_yymm = dSet.indexOfColumn("work_yymm");
   	int idx_proj_bus_type = dSet.indexOfColumn("proj_bus_type");
   	int idx_proj_prog_type = dSet.indexOfColumn("proj_prog_type");
   	int idx_proj_unq_key = dSet.indexOfColumn("proj_unq_key");
   	int idx_bus_sell_amt = dSet.indexOfColumn("bus_sell_amt");
   	int idx_bus_gen_mng = dSet.indexOfColumn("bus_gen_mng");
   	int idx_bus_ent_gain = dSet.indexOfColumn("bus_ent_gain");
   	int idx_bus_hos_gen = dSet.indexOfColumn("bus_hos_gen");
   	int idx_bus_hos_tot = dSet.indexOfColumn("bus_hos_tot");
   	int idx_py_price_sale = dSet.indexOfColumn("py_price_sale");
   	int idx_py_price_const = dSet.indexOfColumn("py_price_const");
   	int idx_sta_const_tot_m2 = dSet.indexOfColumn("sta_const_tot_m2");
   	int idx_sta_sale_m2 = dSet.indexOfColumn("sta_sale_m2");
   	int idx_con_sale_yymm = dSet.indexOfColumn("con_sale_yymm");
   	int idx_con_const_mon = dSet.indexOfColumn("con_const_mon");
   	int idx_proj_risk = dSet.indexOfColumn("proj_risk");
   	int idx_sale_rate_d1 = dSet.indexOfColumn("sale_rate_d1");
   	int idx_sale_rate_d3 = dSet.indexOfColumn("sale_rate_d3");
   	int idx_sale_rate_now = dSet.indexOfColumn("sale_rate_now");
   	int idx_no_sale_hos = dSet.indexOfColumn("no_sale_hos");
   	int idx_proj_remark = dSet.indexOfColumn("proj_remark");
   	int idx_proj_name = dSet.indexOfColumn("proj_name");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO g_mis_decision_sp ( work_yymm," + 
                    "proj_bus_type," + 
                    "proj_prog_type," + 
                    "proj_unq_key," + 
                    "bus_sell_amt," + 
                    "bus_gen_mng," + 
                    "bus_ent_gain," + 
                    "bus_hos_gen," + 
                    "bus_hos_tot," + 
                    "py_price_sale," + 
                    "py_price_const," + 
                    "sta_const_tot_m2," + 
                    "sta_sale_m2," + 
                    "con_sale_yymm," + 
                    "con_const_mon," + 
                    "proj_risk," + 
                    "sale_rate_d1," + 
                    "sale_rate_d3," + 
                    "sale_rate_now," + 
                    "no_sale_hos," + 
                    "proj_remark,proj_name,no_seq )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22 ,:23) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_yymm);
      gpstatement.bindColumn(2, idx_proj_bus_type);
      gpstatement.bindColumn(3, idx_proj_prog_type);
      gpstatement.bindColumn(4, idx_proj_unq_key);
      gpstatement.bindColumn(5, idx_bus_sell_amt);
      gpstatement.bindColumn(6, idx_bus_gen_mng);
      gpstatement.bindColumn(7, idx_bus_ent_gain);
      gpstatement.bindColumn(8, idx_bus_hos_gen);
      gpstatement.bindColumn(9, idx_bus_hos_tot);
      gpstatement.bindColumn(10, idx_py_price_sale);
      gpstatement.bindColumn(11, idx_py_price_const);
      gpstatement.bindColumn(12, idx_sta_const_tot_m2);
      gpstatement.bindColumn(13, idx_sta_sale_m2);
      gpstatement.bindColumn(14, idx_con_sale_yymm);
      gpstatement.bindColumn(15, idx_con_const_mon);
      gpstatement.bindColumn(16, idx_proj_risk);
      gpstatement.bindColumn(17, idx_sale_rate_d1);
      gpstatement.bindColumn(18, idx_sale_rate_d3);
      gpstatement.bindColumn(19, idx_sale_rate_now);
      gpstatement.bindColumn(20, idx_no_sale_hos);
      gpstatement.bindColumn(21, idx_proj_remark);
      gpstatement.bindColumn(22, idx_proj_name);
      gpstatement.bindColumn(23, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update g_mis_decision_sp set " + 
                            "work_yymm=?,  " + 
                            "proj_bus_type=?,  " + 
                            "proj_prog_type=?,  " + 
                            "proj_unq_key=?,  " + 
                            "bus_sell_amt=?,  " + 
                            "bus_gen_mng=?,  " + 
                            "bus_ent_gain=?,  " + 
                            "bus_hos_gen=?,  " + 
                            "bus_hos_tot=?,  " + 
                            "py_price_sale=?,  " + 
                            "py_price_const=?,  " + 
                            "sta_const_tot_m2=?,  " + 
                            "sta_sale_m2=?,  " + 
                            "con_sale_yymm=?,  " + 
                            "con_const_mon=?,  " + 
                            "proj_risk=?,  " + 
                            "sale_rate_d1=?,  " + 
                            "sale_rate_d3=?,  " + 
                            "sale_rate_now=?,  " + 
                            "no_sale_hos=?,  " + 
                            "proj_remark=?,proj_name=?,no_seq=?  where work_yymm=? and proj_bus_type=? and proj_prog_type=? and proj_unq_key=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_yymm);
      gpstatement.bindColumn(2, idx_proj_bus_type);
      gpstatement.bindColumn(3, idx_proj_prog_type);
      gpstatement.bindColumn(4, idx_proj_unq_key);
      gpstatement.bindColumn(5, idx_bus_sell_amt);
      gpstatement.bindColumn(6, idx_bus_gen_mng);
      gpstatement.bindColumn(7, idx_bus_ent_gain);
      gpstatement.bindColumn(8, idx_bus_hos_gen);
      gpstatement.bindColumn(9, idx_bus_hos_tot);
      gpstatement.bindColumn(10, idx_py_price_sale);
      gpstatement.bindColumn(11, idx_py_price_const);
      gpstatement.bindColumn(12, idx_sta_const_tot_m2);
      gpstatement.bindColumn(13, idx_sta_sale_m2);
      gpstatement.bindColumn(14, idx_con_sale_yymm);
      gpstatement.bindColumn(15, idx_con_const_mon);
      gpstatement.bindColumn(16, idx_proj_risk);
      gpstatement.bindColumn(17, idx_sale_rate_d1);
      gpstatement.bindColumn(18, idx_sale_rate_d3);
      gpstatement.bindColumn(19, idx_sale_rate_now);
      gpstatement.bindColumn(20, idx_no_sale_hos);
      gpstatement.bindColumn(21, idx_proj_remark);
      gpstatement.bindColumn(22, idx_proj_name);
      gpstatement.bindColumn(23, idx_no_seq);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(24, idx_work_yymm);
      gpstatement.bindColumn(25, idx_proj_bus_type);
      gpstatement.bindColumn(26, idx_proj_prog_type);
      gpstatement.bindColumn(27, idx_proj_unq_key);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from g_mis_decision_sp where work_yymm=? and proj_bus_type=? and proj_prog_type=? and proj_unq_key=? "; 
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