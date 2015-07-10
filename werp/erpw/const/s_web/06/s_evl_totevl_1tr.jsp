<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_evl_totevl_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_evl_year = dSet.indexOfColumn("evl_year");
   	int idx_profession_wbs_code = dSet.indexOfColumn("profession_wbs_code");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_profession_wbs_name = dSet.indexOfColumn("profession_wbs_name");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_b_score = dSet.indexOfColumn("b_score");
   	int idx_a_score = dSet.indexOfColumn("a_score");
   	int idx_c_score = dSet.indexOfColumn("c_score");
   	int idx_eva_score = dSet.indexOfColumn("eva_score");
   	int idx_add_score1 = dSet.indexOfColumn("add_score1");
   	int idx_add_score2 = dSet.indexOfColumn("add_score2");
   	int idx_add_score3 = dSet.indexOfColumn("add_score3");
   	int idx_add_score4 = dSet.indexOfColumn("add_score4");
   	int idx_add_score5 = dSet.indexOfColumn("add_score5");
   	int idx_add_score6 = dSet.indexOfColumn("add_score6");
   	int idx_add_score_tot = dSet.indexOfColumn("add_score_tot");
   	int idx_tot_score = dSet.indexOfColumn("tot_score");
   	int idx_guarantee_yn = dSet.indexOfColumn("guarantee_yn");
   	int idx_proj_cnt = dSet.indexOfColumn("proj_cnt");
   	int idx_tot_close = dSet.indexOfColumn("tot_close");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_EVL_TOTEVL ( evl_year," + 
                    "profession_wbs_code," + 
                    "sbcr_code," + 
                    "profession_wbs_name," + 
                    "sbcr_name," + 
                    "b_score," + 
                    "a_score," + 
                    "c_score," + 
                    "eva_score," + 
                    "add_score1," + 
                    "add_score2," + 
                    "add_score3," + 
                    "add_score4," + 
                    "add_score5," + 
                    "add_score6," + 
                    "add_score_tot," + 
                    "tot_score," + 
                    "guarantee_yn," + 
                    "proj_cnt,tot_close )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_evl_year);
      gpstatement.bindColumn(2, idx_profession_wbs_code);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_profession_wbs_name);
      gpstatement.bindColumn(5, idx_sbcr_name);
      gpstatement.bindColumn(6, idx_b_score);
      gpstatement.bindColumn(7, idx_a_score);
      gpstatement.bindColumn(8, idx_c_score);
      gpstatement.bindColumn(9, idx_eva_score);
      gpstatement.bindColumn(10, idx_add_score1);
      gpstatement.bindColumn(11, idx_add_score2);
      gpstatement.bindColumn(12, idx_add_score3);
      gpstatement.bindColumn(13, idx_add_score4);
      gpstatement.bindColumn(14, idx_add_score5);
      gpstatement.bindColumn(15, idx_add_score6);
      gpstatement.bindColumn(16, idx_add_score_tot);
      gpstatement.bindColumn(17, idx_tot_score);
      gpstatement.bindColumn(18, idx_guarantee_yn);
      gpstatement.bindColumn(19, idx_proj_cnt);
      gpstatement.bindColumn(20, idx_tot_close);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_evl_totevl set " + 
                            "evl_year=?,  " + 
                            "profession_wbs_code=?,  " + 
                            "sbcr_code=?,  " + 
                            "profession_wbs_name=?,  " + 
                            "sbcr_name=?,  " + 
                            "b_score=?,  " + 
                            "a_score=?,  " + 
                            "c_score=?,  " + 
                            "eva_score=?,  " + 
                            "add_score1=?,  " + 
                            "add_score2=?,  " + 
                            "add_score3=?,  " + 
                            "add_score4=?,  " + 
                            "add_score5=?,  " + 
                            "add_score6=?,  " + 
                            "add_score_tot=?,  " + 
                            "tot_score=?,  " + 
                            "guarantee_yn=?,  " + 
                            "proj_cnt=?, tot_close=?  where evl_year=? " +
                            "              and profession_wbs_code=? " +
                            "              and sbcr_code=? " ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_evl_year);
      gpstatement.bindColumn(2, idx_profession_wbs_code);
      gpstatement.bindColumn(3, idx_sbcr_code);
      gpstatement.bindColumn(4, idx_profession_wbs_name);
      gpstatement.bindColumn(5, idx_sbcr_name);
      gpstatement.bindColumn(6, idx_b_score);
      gpstatement.bindColumn(7, idx_a_score);
      gpstatement.bindColumn(8, idx_c_score);
      gpstatement.bindColumn(9, idx_eva_score);
      gpstatement.bindColumn(10, idx_add_score1);
      gpstatement.bindColumn(11, idx_add_score2);
      gpstatement.bindColumn(12, idx_add_score3);
      gpstatement.bindColumn(13, idx_add_score4);
      gpstatement.bindColumn(14, idx_add_score5);
      gpstatement.bindColumn(15, idx_add_score6);
      gpstatement.bindColumn(16, idx_add_score_tot);
      gpstatement.bindColumn(17, idx_tot_score);
      gpstatement.bindColumn(18, idx_guarantee_yn);
      gpstatement.bindColumn(19, idx_proj_cnt);
      gpstatement.bindColumn(20, idx_tot_close);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(21, idx_evl_year);
      gpstatement.bindColumn(22, idx_profession_wbs_code);
      gpstatement.bindColumn(23, idx_sbcr_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_evl_totevl where evl_year=? " +
                            "              and profession_wbs_code=? " +
                            "              and sbcr_code=? " ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_evl_year);
      gpstatement.bindColumn(2, idx_profession_wbs_code);
      gpstatement.bindColumn(3, idx_sbcr_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>