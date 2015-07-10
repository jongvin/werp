<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_career_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_org_div_code = dSet.indexOfColumn("org_div_code");
   	int idx_comp_name = dSet.indexOfColumn("comp_name");
   	int idx_in_out_div = dSet.indexOfColumn("in_out_div");
   	int idx_career_div_code = dSet.indexOfColumn("career_div_code");
   	int idx_join_date = dSet.indexOfColumn("join_date");
   	int idx_retire_date = dSet.indexOfColumn("retire_date");
   	int idx_permit_year_number = dSet.indexOfColumn("permit_year_number");
   	int idx_grade = dSet.indexOfColumn("grade");
   	int idx_duty = dSet.indexOfColumn("duty");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_career ( resident_no," + 
                    "spec_no_seq," + 
                    "seq," + 
                    "org_div_code," + 
                    "comp_name," + 
                    "in_out_div," + 
                    "career_div_code," + 
                    "join_date," + 
                    "retire_date," + 
                    "permit_year_number," + 
                    "grade," + 
                    "duty," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_org_div_code);
      gpstatement.bindColumn(5, idx_comp_name);
      gpstatement.bindColumn(6, idx_in_out_div);
      gpstatement.bindColumn(7, idx_career_div_code);
      gpstatement.bindColumn(8, idx_join_date);
      gpstatement.bindColumn(9, idx_retire_date);
      gpstatement.bindColumn(10, idx_permit_year_number);
      gpstatement.bindColumn(11, idx_grade);
      gpstatement.bindColumn(12, idx_duty);
      gpstatement.bindColumn(13, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_career set " + 
                            "resident_no=?,  " + 
                            "spec_no_seq=?,  " + 
                            "seq=?,  " + 
                            "org_div_code=?,  " + 
                            "comp_name=?,  " + 
                            "in_out_div=?,  " + 
                            "career_div_code=?,  " + 
                            "join_date=?,  " + 
                            "retire_date=?,  " + 
                            "permit_year_number=?,  " + 
                            "grade=?,  " + 
                            "duty=?,  " + 
                            "remark=?  where resident_no=? and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_org_div_code);
      gpstatement.bindColumn(5, idx_comp_name);
      gpstatement.bindColumn(6, idx_in_out_div);
      gpstatement.bindColumn(7, idx_career_div_code);
      gpstatement.bindColumn(8, idx_join_date);
      gpstatement.bindColumn(9, idx_retire_date);
      gpstatement.bindColumn(10, idx_permit_year_number);
      gpstatement.bindColumn(11, idx_grade);
      gpstatement.bindColumn(12, idx_duty);
      gpstatement.bindColumn(13, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(14, idx_resident_no);
      gpstatement.bindColumn(15, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_career where resident_no=? and spec_no_seq=? "; 
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