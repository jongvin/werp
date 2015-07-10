<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_sbcr_9tr");
     gpstatement.gp_dataset = dSet;
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_key_profession_wbs_code = dSet.indexOfColumn("key_profession_wbs_code");
   	int idx_profession_wbs_code = dSet.indexOfColumn("profession_wbs_code");
   	int idx_register_chk = dSet.indexOfColumn("register_chk");
   	int idx_register_req_date = dSet.indexOfColumn("register_req_date");
   	int idx_register_date = dSet.indexOfColumn("register_date");
   	int idx_profession_wbs_name = dSet.indexOfColumn("profession_wbs_name");
   	int idx_treatkind_code = dSet.indexOfColumn("treatkind_code");
   	int idx_rep_year = dSet.indexOfColumn("rep_year");
   	int idx_recommender_department = dSet.indexOfColumn("recommender_department");
   	int idx_recommender_grade = dSet.indexOfColumn("recommender_grade");
   	int idx_recommender_name = dSet.indexOfColumn("recommender_name");
   	int idx_recommender_rel = dSet.indexOfColumn("recommender_rel");
   	int idx_recommender_reson = dSet.indexOfColumn("recommender_reson");
   	int idx_our_const_proj = dSet.indexOfColumn("our_const_proj");
   	int idx_our_const_amt = dSet.indexOfColumn("our_const_amt");
   	int idx_grantee_rt = dSet.indexOfColumn("grantee_rt");
   	int idx_chrg_year = dSet.indexOfColumn("chrg_year");
   	int idx_note = dSet.indexOfColumn("note");
   	int idx_use_tag = dSet.indexOfColumn("use_tag");
   	int idx_end_dt = dSet.indexOfColumn("end_dt");
	int idx_inout_name = dSet.indexOfColumn("inout_name");
   	int idx_inout_tel = dSet.indexOfColumn("inout_tel");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_WBS_REQUEST ( sbcr_code," + 
                    "profession_wbs_code," + 
                    "register_chk," + 
                    "register_req_date," + 
                    "register_date," + 
                    "profession_wbs_name," + 
                    "treatkind_code," + 
                    "rep_year," + 
                    "recommender_department," + 
                    "recommender_grade," + 
                    "recommender_name," + 
                    "recommender_rel," + 
                    "recommender_reson," + 
                    "our_const_proj," + 
                    "our_const_amt,chrg_year ,grantee_rt, note,use_tag,end_dt,inout_name,inout_tel)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15 ,:16, :17,:18,:19,:20,:21,:22) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_profession_wbs_code);
      gpstatement.bindColumn(3, idx_register_chk);
      gpstatement.bindColumn(4, idx_register_req_date);
      gpstatement.bindColumn(5, idx_register_date);
      gpstatement.bindColumn(6, idx_profession_wbs_name);
      gpstatement.bindColumn(7, idx_treatkind_code);
      gpstatement.bindColumn(8, idx_rep_year);
      gpstatement.bindColumn(9, idx_recommender_department);
      gpstatement.bindColumn(10, idx_recommender_grade);
      gpstatement.bindColumn(11, idx_recommender_name);
      gpstatement.bindColumn(12, idx_recommender_rel);
      gpstatement.bindColumn(13, idx_recommender_reson);
      gpstatement.bindColumn(14, idx_our_const_proj);
      gpstatement.bindColumn(15, idx_our_const_amt);
      gpstatement.bindColumn(16, idx_chrg_year);
      gpstatement.bindColumn(17, idx_grantee_rt);
      gpstatement.bindColumn(18, idx_note);
      gpstatement.bindColumn(19, idx_use_tag);
      gpstatement.bindColumn(20, idx_end_dt);
	  gpstatement.bindColumn(21, idx_inout_name);
	  gpstatement.bindColumn(22, idx_inout_tel);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_wbs_request set " + 
                            "sbcr_code=?,  " + 
                            "profession_wbs_code=?,  " + 
                            "register_chk=?,  " + 
                            "register_req_date=?,  " + 
                            "register_date=?,  " + 
                            "profession_wbs_name=?,  " + 
                            "treatkind_code=?,  " + 
                            "rep_year=?,  " + 
                            "recommender_department=?,  " + 
                            "recommender_grade=?,  " + 
                            "recommender_name=?,  " + 
                            "recommender_rel=?,  " + 
                            "recommender_reson=?,  " + 
                            "our_const_proj=?,  " + 
                            "our_const_amt=?, chrg_year=?, grantee_rt=?,note=?,use_tag=? ,end_dt=?, " +
							"inout_name=?,inout_tel=? " +
							"where sbcr_code=? " +
                            "                   and profession_wbs_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_profession_wbs_code);
      gpstatement.bindColumn(3, idx_register_chk);
      gpstatement.bindColumn(4, idx_register_req_date);
      gpstatement.bindColumn(5, idx_register_date);
      gpstatement.bindColumn(6, idx_profession_wbs_name);
      gpstatement.bindColumn(7, idx_treatkind_code);
      gpstatement.bindColumn(8, idx_rep_year);
      gpstatement.bindColumn(9, idx_recommender_department);
      gpstatement.bindColumn(10, idx_recommender_grade);
      gpstatement.bindColumn(11, idx_recommender_name);
      gpstatement.bindColumn(12, idx_recommender_rel);
      gpstatement.bindColumn(13, idx_recommender_reson);
      gpstatement.bindColumn(14, idx_our_const_proj);
      gpstatement.bindColumn(15, idx_our_const_amt);
      gpstatement.bindColumn(16, idx_chrg_year);
      gpstatement.bindColumn(17, idx_grantee_rt);
      gpstatement.bindColumn(18, idx_note);
      gpstatement.bindColumn(19, idx_use_tag);
      gpstatement.bindColumn(20, idx_end_dt);
	  gpstatement.bindColumn(21, idx_inout_name);
	  gpstatement.bindColumn(22, idx_inout_tel);
/* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(23, idx_sbcr_code);
      gpstatement.bindColumn(24, idx_key_profession_wbs_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_wbs_request where sbcr_code=? " +
                                          " and profession_wbs_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_key_profession_wbs_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>