<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("g_mis_kpi_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_work_year = dSet.indexOfColumn("work_year");
   	int idx_unq_key = dSet.indexOfColumn("unq_key");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_desc1 = dSet.indexOfColumn("desc1");
   	int idx_desc2 = dSet.indexOfColumn("desc2");
   	int idx_plan_1 = dSet.indexOfColumn("plan_1");
   	int idx_plan_2 = dSet.indexOfColumn("plan_2");
   	int idx_plan_3 = dSet.indexOfColumn("plan_3");
   	int idx_plan_4 = dSet.indexOfColumn("plan_4");
   	int idx_plan_5 = dSet.indexOfColumn("plan_5");
   	int idx_plan_6 = dSet.indexOfColumn("plan_6");
   	int idx_plan_7 = dSet.indexOfColumn("plan_7");
   	int idx_plan_8 = dSet.indexOfColumn("plan_8");
   	int idx_plan_9 = dSet.indexOfColumn("plan_9");
   	int idx_plan_10 = dSet.indexOfColumn("plan_10");
   	int idx_plan_11 = dSet.indexOfColumn("plan_11");
   	int idx_plan_12 = dSet.indexOfColumn("plan_12");
   	int idx_result_1 = dSet.indexOfColumn("result_1");
   	int idx_result_2 = dSet.indexOfColumn("result_2");
   	int idx_result_3 = dSet.indexOfColumn("result_3");
   	int idx_result_4 = dSet.indexOfColumn("result_4");
   	int idx_result_5 = dSet.indexOfColumn("result_5");
   	int idx_result_6 = dSet.indexOfColumn("result_6");
   	int idx_result_7 = dSet.indexOfColumn("result_7");
   	int idx_result_8 = dSet.indexOfColumn("result_8");
   	int idx_result_9 = dSet.indexOfColumn("result_9");
   	int idx_result_10 = dSet.indexOfColumn("result_10");
   	int idx_result_11 = dSet.indexOfColumn("result_11");
   	int idx_result_12 = dSet.indexOfColumn("result_12");
   	int idx_calc_yn = dSet.indexOfColumn("calc_yn");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO G_MIS_KPI ( work_year," + 
                    "unq_key," + 
                    "no_seq," + 
                    "desc1," + 
                    "desc2," + 
                    "plan_1," + 
                    "plan_2," + 
                    "plan_3," + 
                    "plan_4," + 
                    "plan_5," + 
                    "plan_6," + 
                    "plan_7," + 
                    "plan_8," + 
                    "plan_9," + 
                    "plan_10," + 
                    "plan_11," + 
                    "plan_12," + 
                    "result_1," + 
                    "result_2," + 
                    "result_3," + 
                    "result_4," + 
                    "result_5," + 
                    "result_6," + 
                    "result_7," + 
                    "result_8," + 
                    "result_9," + 
                    "result_10," + 
                    "result_11," + 
                    "result_12, " +
                    "calc_yn )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_unq_key);
      gpstatement.bindColumn(3, idx_no_seq);
      gpstatement.bindColumn(4, idx_desc1);
      gpstatement.bindColumn(5, idx_desc2);
      gpstatement.bindColumn(6, idx_plan_1);
      gpstatement.bindColumn(7, idx_plan_2);
      gpstatement.bindColumn(8, idx_plan_3);
      gpstatement.bindColumn(9, idx_plan_4);
      gpstatement.bindColumn(10, idx_plan_5);
      gpstatement.bindColumn(11, idx_plan_6);
      gpstatement.bindColumn(12, idx_plan_7);
      gpstatement.bindColumn(13, idx_plan_8);
      gpstatement.bindColumn(14, idx_plan_9);
      gpstatement.bindColumn(15, idx_plan_10);
      gpstatement.bindColumn(16, idx_plan_11);
      gpstatement.bindColumn(17, idx_plan_12);
      gpstatement.bindColumn(18, idx_result_1);
      gpstatement.bindColumn(19, idx_result_2);
      gpstatement.bindColumn(20, idx_result_3);
      gpstatement.bindColumn(21, idx_result_4);
      gpstatement.bindColumn(22, idx_result_5);
      gpstatement.bindColumn(23, idx_result_6);
      gpstatement.bindColumn(24, idx_result_7);
      gpstatement.bindColumn(25, idx_result_8);
      gpstatement.bindColumn(26, idx_result_9);
      gpstatement.bindColumn(27, idx_result_10);
      gpstatement.bindColumn(28, idx_result_11);
      gpstatement.bindColumn(29, idx_result_12);
      gpstatement.bindColumn(30, idx_calc_yn);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update g_mis_kpi set " + 
                            "work_year=?,  " + 
                            "unq_key=?,  " + 
                            "no_seq=?,  " + 
                            "desc1=?,  " + 
                            "desc2=?,  " + 
                            "plan_1=?,  " + 
                            "plan_2=?,  " + 
                            "plan_3=?,  " + 
                            "plan_4=?,  " + 
                            "plan_5=?,  " + 
                            "plan_6=?,  " + 
                            "plan_7=?,  " + 
                            "plan_8=?,  " + 
                            "plan_9=?,  " + 
                            "plan_10=?,  " + 
                            "plan_11=?,  " + 
                            "plan_12=?,  " + 
                            "result_1=?,  " + 
                            "result_2=?,  " + 
                            "result_3=?,  " + 
                            "result_4=?,  " + 
                            "result_5=?,  " + 
                            "result_6=?,  " + 
                            "result_7=?,  " + 
                            "result_8=?,  " + 
                            "result_9=?,  " + 
                            "result_10=?,  " + 
                            "result_11=?,  " + 
                            "result_12=?, " +
                            "calc_yn=?  where work_year=? and unq_key=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_unq_key);
      gpstatement.bindColumn(3, idx_no_seq);
      gpstatement.bindColumn(4, idx_desc1);
      gpstatement.bindColumn(5, idx_desc2);
      gpstatement.bindColumn(6, idx_plan_1);
      gpstatement.bindColumn(7, idx_plan_2);
      gpstatement.bindColumn(8, idx_plan_3);
      gpstatement.bindColumn(9, idx_plan_4);
      gpstatement.bindColumn(10, idx_plan_5);
      gpstatement.bindColumn(11, idx_plan_6);
      gpstatement.bindColumn(12, idx_plan_7);
      gpstatement.bindColumn(13, idx_plan_8);
      gpstatement.bindColumn(14, idx_plan_9);
      gpstatement.bindColumn(15, idx_plan_10);
      gpstatement.bindColumn(16, idx_plan_11);
      gpstatement.bindColumn(17, idx_plan_12);
      gpstatement.bindColumn(18, idx_result_1);
      gpstatement.bindColumn(19, idx_result_2);
      gpstatement.bindColumn(20, idx_result_3);
      gpstatement.bindColumn(21, idx_result_4);
      gpstatement.bindColumn(22, idx_result_5);
      gpstatement.bindColumn(23, idx_result_6);
      gpstatement.bindColumn(24, idx_result_7);
      gpstatement.bindColumn(25, idx_result_8);
      gpstatement.bindColumn(26, idx_result_9);
      gpstatement.bindColumn(27, idx_result_10);
      gpstatement.bindColumn(28, idx_result_11);
      gpstatement.bindColumn(29, idx_result_12);
      gpstatement.bindColumn(30, idx_calc_yn);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(31, idx_work_year);
      gpstatement.bindColumn(32, idx_unq_key);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from g_mis_kpi where work_year=? and unq_key=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_unq_key);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>