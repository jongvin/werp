<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_eval_mbo_detail_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_eval_code = dSet.indexOfColumn("eval_code");
   	int idx_eval_year = dSet.indexOfColumn("eval_year");
   	int idx_eval_degree = dSet.indexOfColumn("eval_degree");
   	int idx_self_evaluator = dSet.indexOfColumn("self_evaluator");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_self_attain_level = dSet.indexOfColumn("self_attain_level");
   	int idx_self_eval_view = dSet.indexOfColumn("self_eval_view");
   	int idx_self_eval_grade = dSet.indexOfColumn("self_eval_grade");
   	int idx_self_eval_score = dSet.indexOfColumn("self_eval_score");
   	int idx_fir_eval_view = dSet.indexOfColumn("fir_eval_view");
   	int idx_fir_eval_grade = dSet.indexOfColumn("fir_eval_grade");
   	int idx_fir_eval_score = dSet.indexOfColumn("fir_eval_score");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_eval_mbo_detail ( eval_code," + 
                    "eval_year," + 
                    "eval_degree," + 
                    "self_evaluator," + 
                    "spec_no_seq," + 
                    "self_attain_level," + 
                    "self_eval_view," + 
                    "self_eval_grade," + 
                    "self_eval_score," + 
                    "fir_eval_view," + 
                    "fir_eval_grade," + 
                    "fir_eval_score )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_year);
      gpstatement.bindColumn(3, idx_eval_degree);
      gpstatement.bindColumn(4, idx_self_evaluator);
      gpstatement.bindColumn(5, idx_spec_no_seq);
      gpstatement.bindColumn(6, idx_self_attain_level);
      gpstatement.bindColumn(7, idx_self_eval_view);
      gpstatement.bindColumn(8, idx_self_eval_grade);
      gpstatement.bindColumn(9, idx_self_eval_score);
      gpstatement.bindColumn(10, idx_fir_eval_view);
      gpstatement.bindColumn(11, idx_fir_eval_grade);
      gpstatement.bindColumn(12, idx_fir_eval_score);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_eval_mbo_detail set " + 
                            "eval_code=?,  " + 
                            "eval_year=?,  " + 
                            "eval_degree=?,  " + 
                            "self_evaluator=?,  " + 
                            "spec_no_seq=?,  " + 
                            "self_attain_level=?,  " + 
                            "self_eval_view=?,  " + 
                            "self_eval_grade=?,  " + 
                            "self_eval_score=?,  " + 
                            "fir_eval_view=?,  " + 
                            "fir_eval_grade=?,  " + 
                            "fir_eval_score=?  where eval_code=? and eval_year=? and eval_degree=? and self_evaluator=? and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_year);
      gpstatement.bindColumn(3, idx_eval_degree);
      gpstatement.bindColumn(4, idx_self_evaluator);
      gpstatement.bindColumn(5, idx_spec_no_seq);
      gpstatement.bindColumn(6, idx_self_attain_level);
      gpstatement.bindColumn(7, idx_self_eval_view);
      gpstatement.bindColumn(8, idx_self_eval_grade);
      gpstatement.bindColumn(9, idx_self_eval_score);
      gpstatement.bindColumn(10, idx_fir_eval_view);
      gpstatement.bindColumn(11, idx_fir_eval_grade);
      gpstatement.bindColumn(12, idx_fir_eval_score);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(13, idx_eval_code);
      gpstatement.bindColumn(14, idx_eval_year);
      gpstatement.bindColumn(15, idx_eval_degree);
      gpstatement.bindColumn(16, idx_self_evaluator);
      gpstatement.bindColumn(17, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>