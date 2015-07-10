<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_prize_punish_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_rnp_code = dSet.indexOfColumn("rnp_code");
   	int idx_rnp_date = dSet.indexOfColumn("rnp_date");
   	int idx_enforce_office = dSet.indexOfColumn("enforce_office");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_grade_code = dSet.indexOfColumn("grade_code");
   	int idx_p_end_date = dSet.indexOfColumn("p_end_date");
   	int idx_eval_affect_yn = dSet.indexOfColumn("eval_affect_yn");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_prize_punish ( resident_no," + 
                    "spec_no_seq," + 
                    "seq," + 
                    "rnp_code," + 
                    "rnp_date," + 
                    "enforce_office," + 
                    "dept_code," + 
                    "grade_code," + 
                    "p_end_date," + 
                    "eval_affect_yn," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_rnp_code);
      gpstatement.bindColumn(5, idx_rnp_date);
      gpstatement.bindColumn(6, idx_enforce_office);
      gpstatement.bindColumn(7, idx_dept_code);
      gpstatement.bindColumn(8, idx_grade_code);
      gpstatement.bindColumn(9, idx_p_end_date);
      gpstatement.bindColumn(10, idx_eval_affect_yn);
      gpstatement.bindColumn(11, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_prize_punish set " + 
                            "resident_no=?,  " + 
                            "spec_no_seq=?,  " + 
                            "seq=?,  " + 
                            "rnp_code=?,  " + 
                            "rnp_date=?,  " + 
                            "enforce_office=?,  " + 
                            "dept_code=?,  " + 
                            "grade_code=?,  " + 
                            "p_end_date=?,  " + 
                            "eval_affect_yn=?,  " + 
                            "remark=?  where resident_no=? and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_rnp_code);
      gpstatement.bindColumn(5, idx_rnp_date);
      gpstatement.bindColumn(6, idx_enforce_office);
      gpstatement.bindColumn(7, idx_dept_code);
      gpstatement.bindColumn(8, idx_grade_code);
      gpstatement.bindColumn(9, idx_p_end_date);
      gpstatement.bindColumn(10, idx_eval_affect_yn);
      gpstatement.bindColumn(11, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_resident_no);
      gpstatement.bindColumn(13, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_prize_punish where resident_no=? and spec_no_seq=? "; 
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