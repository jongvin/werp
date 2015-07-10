<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_license_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_license_code = dSet.indexOfColumn("license_code");
   	int idx_license_no = dSet.indexOfColumn("license_no");
   	int idx_gain_date = dSet.indexOfColumn("gain_date");
   	int idx_ioffice = dSet.indexOfColumn("ioffice");
   	int idx_last_update_date = dSet.indexOfColumn("last_update_date");
   	int idx_career_s_date = dSet.indexOfColumn("career_s_date");
   	int idx_print_order = dSet.indexOfColumn("print_order");
   	int idx_license_years = dSet.indexOfColumn("license_years");
   	int idx_license_order = dSet.indexOfColumn("license_order");
   	int idx_tech_level = dSet.indexOfColumn("tech_level");
   	int idx_con_license_yn = dSet.indexOfColumn("con_license_yn");
   	int idx_license_type_code = dSet.indexOfColumn("license_type_code");
   	int idx_chg_year_date = dSet.indexOfColumn("chg_year_date");
   	int idx_chg_next_date = dSet.indexOfColumn("chg_next_date");
   	int idx_license_yn = dSet.indexOfColumn("license_yn");
   	int idx_allow = dSet.indexOfColumn("allow");
   	int idx_validity_date = dSet.indexOfColumn("validity_date");
   	int idx_eval_score = dSet.indexOfColumn("eval_score");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_repair_edu_sdate = dSet.indexOfColumn("repair_edu_sdate");
   	int idx_repair_edu_edate = dSet.indexOfColumn("repair_edu_edate");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_license ( resident_no," + 
                    "spec_no_seq," + 
                    "license_code," + 
                    "license_no," + 
                    "gain_date," + 
                    "ioffice," + 
                    "last_update_date," + 
                    "career_s_date," + 
                    "print_order," + 
                    "license_years," + 
                    "license_order," + 
                    "tech_level," + 
                    "con_license_yn," + 
                    "license_type_code," + 
                    "chg_year_date," + 
                    "chg_next_date," + 
                    "license_yn," + 
                    "allow," + 
                    "validity_date," + 
                    "eval_score," + 
                    "remark," + 
                    "repair_edu_sdate," + 
                    "repair_edu_edate )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_license_code);
      gpstatement.bindColumn(4, idx_license_no);
      gpstatement.bindColumn(5, idx_gain_date);
      gpstatement.bindColumn(6, idx_ioffice);
      gpstatement.bindColumn(7, idx_last_update_date);
      gpstatement.bindColumn(8, idx_career_s_date);
      gpstatement.bindColumn(9, idx_print_order);
      gpstatement.bindColumn(10, idx_license_years);
      gpstatement.bindColumn(11, idx_license_order);
      gpstatement.bindColumn(12, idx_tech_level);
      gpstatement.bindColumn(13, idx_con_license_yn);
      gpstatement.bindColumn(14, idx_license_type_code);
      gpstatement.bindColumn(15, idx_chg_year_date);
      gpstatement.bindColumn(16, idx_chg_next_date);
      gpstatement.bindColumn(17, idx_license_yn);
      gpstatement.bindColumn(18, idx_allow);
      gpstatement.bindColumn(19, idx_validity_date);
      gpstatement.bindColumn(20, idx_eval_score);
      gpstatement.bindColumn(21, idx_remark);
      gpstatement.bindColumn(22, idx_repair_edu_sdate);
      gpstatement.bindColumn(23, idx_repair_edu_edate);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_license set " + 
                            "resident_no=?,  " + 
                            "spec_no_seq=?,  " + 
                            "license_code=?,  " + 
                            "license_no=?,  " + 
                            "gain_date=?,  " + 
                            "ioffice=?,  " + 
                            "last_update_date=?,  " + 
                            "career_s_date=?,  " + 
                            "print_order=?,  " + 
                            "license_years=?,  " + 
                            "license_order=?,  " + 
                            "tech_level=?,  " + 
                            "con_license_yn=?,  " + 
                            "license_type_code=?,  " + 
                            "chg_year_date=?,  " + 
                            "chg_next_date=?,  " + 
                            "license_yn=?,  " + 
                            "allow=?,  " + 
                            "validity_date=?,  " + 
                            "eval_score=?,  " + 
                            "remark=?,  " + 
                            "repair_edu_sdate=?,  " + 
                            "repair_edu_edate=?  where resident_no=? and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_license_code);
      gpstatement.bindColumn(4, idx_license_no);
      gpstatement.bindColumn(5, idx_gain_date);
      gpstatement.bindColumn(6, idx_ioffice);
      gpstatement.bindColumn(7, idx_last_update_date);
      gpstatement.bindColumn(8, idx_career_s_date);
      gpstatement.bindColumn(9, idx_print_order);
      gpstatement.bindColumn(10, idx_license_years);
      gpstatement.bindColumn(11, idx_license_order);
      gpstatement.bindColumn(12, idx_tech_level);
      gpstatement.bindColumn(13, idx_con_license_yn);
      gpstatement.bindColumn(14, idx_license_type_code);
      gpstatement.bindColumn(15, idx_chg_year_date);
      gpstatement.bindColumn(16, idx_chg_next_date);
      gpstatement.bindColumn(17, idx_license_yn);
      gpstatement.bindColumn(18, idx_allow);
      gpstatement.bindColumn(19, idx_validity_date);
      gpstatement.bindColumn(20, idx_eval_score);
      gpstatement.bindColumn(21, idx_remark);
      gpstatement.bindColumn(22, idx_repair_edu_sdate);
      gpstatement.bindColumn(23, idx_repair_edu_edate);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(24, idx_resident_no);
      gpstatement.bindColumn(25, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_license where resident_no=? and spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>