<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_sbcr_6tr");
     gpstatement.gp_dataset = dSet;
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_class = dSet.indexOfColumn("class");
   	int idx_spec_seq = dSet.indexOfColumn("spec_seq");
   	int idx_key_spec_seq = dSet.indexOfColumn("key_spec_seq");
   	int idx_scholarship_class = dSet.indexOfColumn("scholarship_class");
   	int idx_sch_date = dSet.indexOfColumn("sch_date");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_subject_name = dSet.indexOfColumn("subject_name");
   	int idx_graduation_class = dSet.indexOfColumn("graduation_class");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_SCHOLARSHIP ( sbcr_code," + 
                    "class," + 
                    "spec_seq," + 
                    "scholarship_class," + 
                    "sch_date, " + 
                    "name," + 
                    "subject_name," + 
                    "graduation_class," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_class);
      gpstatement.bindColumn(3, idx_spec_seq);
      gpstatement.bindColumn(4, idx_scholarship_class);
      gpstatement.bindColumn(5, idx_sch_date);
      gpstatement.bindColumn(6, idx_name);
      gpstatement.bindColumn(7, idx_subject_name);
      gpstatement.bindColumn(8, idx_graduation_class);
      gpstatement.bindColumn(9, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_scholarship set " + 
                            "sbcr_code=?,  " + 
                            "class=?,  " + 
                            "spec_seq=?,  " + 
                            "scholarship_class=?,  " + 
                            "sch_date=?, " +
                            "name=?,  " + 
                            "subject_name=?,  " + 
                            "graduation_class=?,  " + 
                            "remark=?  where sbcr_code=? " +
                            "            and class=? " +
                            "            and spec_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_class);
      gpstatement.bindColumn(3, idx_spec_seq);
      gpstatement.bindColumn(4, idx_scholarship_class);
      gpstatement.bindColumn(5, idx_sch_date);
      gpstatement.bindColumn(6, idx_name);
      gpstatement.bindColumn(7, idx_subject_name);
      gpstatement.bindColumn(8, idx_graduation_class);
      gpstatement.bindColumn(9, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(10, idx_sbcr_code);
      gpstatement.bindColumn(11, idx_class);
      gpstatement.bindColumn(12, idx_key_spec_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_scholarship where sbcr_code=? " +
                                         "           and class=? " +
                                         "           and spec_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_class);
      gpstatement.bindColumn(3, idx_key_spec_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>