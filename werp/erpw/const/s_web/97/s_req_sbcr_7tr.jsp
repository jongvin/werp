<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_req_sbcr_7tr");
     gpstatement.gp_dataset = dSet;
   	int idx_sbcr_unq_num = dSet.indexOfColumn("sbcr_unq_num");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_key_seq = dSet.indexOfColumn("key_seq");
   	int idx_grade = dSet.indexOfColumn("grade");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_age = dSet.indexOfColumn("age");
   	int idx_imp_process = dSet.indexOfColumn("imp_process");
   	int idx_our_career_year = dSet.indexOfColumn("our_career_year");
   	int idx_career_year = dSet.indexOfColumn("career_year");
   	int idx_representative_rel = dSet.indexOfColumn("representative_rel");
   	int idx_last_scholarship = dSet.indexOfColumn("last_scholarship");
   	int idx_imp_career = dSet.indexOfColumn("imp_career");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_REQ_MASTER ( sbcr_unq_num," + 
                    "seq," + 
                    "grade," + 
                    "name," + 
                    "age," + 
                    "imp_process," + 
                    "our_career_year," + 
                    "career_year," + 
                    "representative_rel," + 
                    "last_scholarship," + 
                    "imp_career )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_unq_num);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_grade);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_age);
      gpstatement.bindColumn(6, idx_imp_process);
      gpstatement.bindColumn(7, idx_our_career_year);
      gpstatement.bindColumn(8, idx_career_year);
      gpstatement.bindColumn(9, idx_representative_rel);
      gpstatement.bindColumn(10, idx_last_scholarship);
      gpstatement.bindColumn(11, idx_imp_career);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_req_master set " + 
                            "sbcr_unq_num=?,  " + 
                            "seq=?,  " + 
                            "grade=?,  " + 
                            "name=?,  " + 
                            "age=?,  " + 
                            "imp_process=?,  " + 
                            "our_career_year=?,  " + 
                            "career_year=?,  " + 
                            "representative_rel=?,  " + 
                            "last_scholarship=?,  " + 
                            "imp_career=?  where sbcr_unq_num=? " +
                            "                and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_unq_num);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_grade);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_age);
      gpstatement.bindColumn(6, idx_imp_process);
      gpstatement.bindColumn(7, idx_our_career_year);
      gpstatement.bindColumn(8, idx_career_year);
      gpstatement.bindColumn(9, idx_representative_rel);
      gpstatement.bindColumn(10, idx_last_scholarship);
      gpstatement.bindColumn(11, idx_imp_career);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_sbcr_unq_num);
      gpstatement.bindColumn(13, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_req_master where sbcr_unq_num=? " +
                                    "           and seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_sbcr_unq_num);
      gpstatement.bindColumn(2, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>