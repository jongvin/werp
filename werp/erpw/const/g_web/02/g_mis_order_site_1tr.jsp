<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("g_mis_order_site_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_work_yymm = dSet.indexOfColumn("work_yymm");
   	int idx_proj_bus_type = dSet.indexOfColumn("proj_bus_type");
   	int idx_proj_prog_type = dSet.indexOfColumn("proj_prog_type");
   	int idx_proj_unq_key = dSet.indexOfColumn("proj_unq_key");
   	int idx_ord_amt = dSet.indexOfColumn("ord_amt");
   	int idx_site_amt = dSet.indexOfColumn("site_amt");
   	int idx_cont_date = dSet.indexOfColumn("cont_date");
   	int idx_bus_grd_m2 = dSet.indexOfColumn("bus_grd_m2");
   	int idx_bus_const_tot_m2 = dSet.indexOfColumn("bus_const_tot_m2");
   	int idx_bus_sale_m2 = dSet.indexOfColumn("bus_sale_m2");
   	int idx_bus_hos_cnt = dSet.indexOfColumn("bus_hos_cnt");
   	int idx_bus_combi = dSet.indexOfColumn("bus_combi");
   	int idx_sal_tot_amt = dSet.indexOfColumn("sal_tot_amt");
   	int idx_sal_price_py = dSet.indexOfColumn("sal_price_py");
   	int idx_con_tot_amt = dSet.indexOfColumn("con_tot_amt");
   	int idx_con_price_py = dSet.indexOfColumn("con_price_py");
   	int idx_sale_date = dSet.indexOfColumn("sale_date");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_proj_name = dSet.indexOfColumn("proj_name");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO g_mis_order_site ( work_yymm," + 
                    "proj_bus_type," + 
                    "proj_prog_type," + 
                    "proj_unq_key," + 
                    "ord_amt," + 
                    "site_amt," + 
                    "cont_date," + 
                    "bus_grd_m2," + 
                    "bus_const_tot_m2," + 
                    "bus_sale_m2," + 
                    "bus_hos_cnt," + 
                    "bus_combi," + 
                    "sal_tot_amt," + 
                    "sal_price_py," + 
                    "con_tot_amt," + 
                    "con_price_py," + 
                    "sale_date," + 
                    "remark ,proj_name, no_seq)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18 , :19, :20) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_yymm);
      gpstatement.bindColumn(2, idx_proj_bus_type);
      gpstatement.bindColumn(3, idx_proj_prog_type);
      gpstatement.bindColumn(4, idx_proj_unq_key);
      gpstatement.bindColumn(5, idx_ord_amt);
      gpstatement.bindColumn(6, idx_site_amt);
      gpstatement.bindColumn(7, idx_cont_date);
      gpstatement.bindColumn(8, idx_bus_grd_m2);
      gpstatement.bindColumn(9, idx_bus_const_tot_m2);
      gpstatement.bindColumn(10, idx_bus_sale_m2);
      gpstatement.bindColumn(11, idx_bus_hos_cnt);
      gpstatement.bindColumn(12, idx_bus_combi);
      gpstatement.bindColumn(13, idx_sal_tot_amt);
      gpstatement.bindColumn(14, idx_sal_price_py);
      gpstatement.bindColumn(15, idx_con_tot_amt);
      gpstatement.bindColumn(16, idx_con_price_py);
      gpstatement.bindColumn(17, idx_sale_date);
      gpstatement.bindColumn(18, idx_remark);
      gpstatement.bindColumn(19, idx_proj_name);
      gpstatement.bindColumn(20, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update g_mis_order_site set " + 
                            "work_yymm=?,  " + 
                            "proj_bus_type=?,  " + 
                            "proj_prog_type=?,  " + 
                            "proj_unq_key=?,  " + 
                            "ord_amt=?,  " + 
                            "site_amt=?,  " + 
                            "cont_date=?,  " + 
                            "bus_grd_m2=?,  " + 
                            "bus_const_tot_m2=?,  " + 
                            "bus_sale_m2=?,  " + 
                            "bus_hos_cnt=?,  " + 
                            "bus_combi=?,  " + 
                            "sal_tot_amt=?,  " + 
                            "sal_price_py=?,  " + 
                            "con_tot_amt=?,  " + 
                            "con_price_py=?,  " + 
                            "sale_date=?,  " + 
                            "remark=?,proj_name=?,no_seq=? where work_yymm=? and proj_bus_type=? and proj_prog_type=? and proj_unq_key=? ";
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_yymm);
      gpstatement.bindColumn(2, idx_proj_bus_type);
      gpstatement.bindColumn(3, idx_proj_prog_type);
      gpstatement.bindColumn(4, idx_proj_unq_key);
      gpstatement.bindColumn(5, idx_ord_amt);
      gpstatement.bindColumn(6, idx_site_amt);
      gpstatement.bindColumn(7, idx_cont_date);
      gpstatement.bindColumn(8, idx_bus_grd_m2);
      gpstatement.bindColumn(9, idx_bus_const_tot_m2);
      gpstatement.bindColumn(10, idx_bus_sale_m2);
      gpstatement.bindColumn(11, idx_bus_hos_cnt);
      gpstatement.bindColumn(12, idx_bus_combi);
      gpstatement.bindColumn(13, idx_sal_tot_amt);
      gpstatement.bindColumn(14, idx_sal_price_py);
      gpstatement.bindColumn(15, idx_con_tot_amt);
      gpstatement.bindColumn(16, idx_con_price_py);
      gpstatement.bindColumn(17, idx_sale_date);
      gpstatement.bindColumn(18, idx_remark);
      gpstatement.bindColumn(19, idx_proj_name);
      gpstatement.bindColumn(20, idx_no_seq);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(21, idx_work_yymm);
      gpstatement.bindColumn(22, idx_proj_bus_type);
      gpstatement.bindColumn(23, idx_proj_prog_type);
      gpstatement.bindColumn(24, idx_proj_unq_key);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from g_mis_order_site where work_yymm=? and proj_bus_type=? and proj_prog_type=? and proj_unq_key=? ";
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