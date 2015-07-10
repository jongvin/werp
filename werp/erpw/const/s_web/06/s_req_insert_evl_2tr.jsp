<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_req_insert_evl_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_sbcr_unq_num = dSet.indexOfColumn("sbcr_unq_num");
   	int idx_profession_wbs_code = dSet.indexOfColumn("profession_wbs_code");
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_class = dSet.indexOfColumn("class");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_tot_score = dSet.indexOfColumn("tot_score");
   	int idx_spec_seq = dSet.indexOfColumn("spec_seq");
   	int idx_score = dSet.indexOfColumn("score");
   	int idx_evl_class = dSet.indexOfColumn("evl_class");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO S_REQ_EVL_PARENT ( sbcr_unq_num," + 
						  "profession_wbs_code," +
                    "emp_no," + 
                    "class," + 
                    "seq," + 
                    "name," + 
                    "tot_score," + 
                    "spec_seq," + 
                    "score," + 
                    "evl_class," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11  ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_unq_num);
      gpstatement.bindColumn(2, idx_profession_wbs_code);
      gpstatement.bindColumn(3, idx_emp_no);
      gpstatement.bindColumn(4, idx_class);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_name);
      gpstatement.bindColumn(7, idx_tot_score);
      gpstatement.bindColumn(8, idx_spec_seq);
      gpstatement.bindColumn(9, idx_score);
      gpstatement.bindColumn(10, idx_evl_class);
      gpstatement.bindColumn(11, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_req_evl_parent set " + 
                            "sbcr_unq_num=?,  " + 
                            "profession_wbs_code=?, " + 
                            "emp_no=?,  " + 
                            "class=?,  " + 
                            "seq=?,  " + 
                            "name=?,  " + 
                            "tot_score=?,  " + 
                            "spec_seq=?,  " + 
                            "score=?,  " + 
                            "evl_class=?,  " + 
                            "remark=?  where sbcr_unq_num=? " +
                            "            and profession_wbs_code=? " +
                            "            and emp_no=? " +
                            "            and class=? " +
                            "            and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_unq_num);
      gpstatement.bindColumn(2, idx_profession_wbs_code);
      gpstatement.bindColumn(3, idx_emp_no);
      gpstatement.bindColumn(4, idx_class);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_name);
      gpstatement.bindColumn(7, idx_tot_score);
      gpstatement.bindColumn(8, idx_spec_seq);
      gpstatement.bindColumn(9, idx_score);
      gpstatement.bindColumn(10, idx_evl_class);
      gpstatement.bindColumn(11, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_sbcr_unq_num);
      gpstatement.bindColumn(13, idx_profession_wbs_code);
      gpstatement.bindColumn(14, idx_emp_no);
      gpstatement.bindColumn(15, idx_class);
      gpstatement.bindColumn(16, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_req_evl_parent where sbcr_unq_num=? " +
                            "            and profession_wbs_code=? " +
                            "            and emp_no=? " +
                            "            and class=? " +
                            "            and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_sbcr_unq_num);
      gpstatement.bindColumn(2, idx_profession_wbs_code);
      gpstatement.bindColumn(3, idx_emp_no);
      gpstatement.bindColumn(4, idx_class);
      gpstatement.bindColumn(5, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>