<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("g_mis_sale_plan_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_work_year = dSet.indexOfColumn("work_year");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_proj_bus_type = dSet.indexOfColumn("proj_bus_type");
   	int idx_proj_name = dSet.indexOfColumn("proj_name");
   	int idx_hos_cnt = dSet.indexOfColumn("hos_cnt");   	
   	int idx_gen_cnt = dSet.indexOfColumn("gen_cnt");
   	int idx_work_yymm = dSet.indexOfColumn("work_yymm");
   	int idx_plan_yymm = dSet.indexOfColumn("plan_yymm");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO g_mis_sale_plan ( work_year, " + 
                    "proj_bus_type," + 
                    "spec_no_seq," + 
                    "proj_name," + 
                    "hos_cnt," + 
                    "gen_cnt," + 
                    "work_yymm," + 
                    "plan_yymm," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_proj_bus_type);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_proj_name);
      gpstatement.bindColumn(5, idx_hos_cnt);
      gpstatement.bindColumn(6, idx_gen_cnt);
      gpstatement.bindColumn(7, idx_work_yymm);
      gpstatement.bindColumn(8, idx_plan_yymm);
      gpstatement.bindColumn(9, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update g_mis_sale_plan set " + 
                            "work_year=?,  " + 
                            "proj_bus_type=?,  " + 
                            "spec_no_seq=?,  " + 
                            "proj_name=?,  " + 
                            "hos_cnt=?,  " + 
                            "gen_cnt=?,  " + 
                            "work_yymm=?,  " + 
                            "plan_yymm=?,  " + 
                            "remark=?  where work_year=? and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_proj_bus_type);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_proj_name);
      gpstatement.bindColumn(5, idx_hos_cnt);
      gpstatement.bindColumn(6, idx_gen_cnt);
      gpstatement.bindColumn(7, idx_work_yymm);
      gpstatement.bindColumn(8, idx_plan_yymm);
      gpstatement.bindColumn(9, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(10, idx_work_year);
      gpstatement.bindColumn(11, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from g_mis_sale_plan where work_year=? and spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>