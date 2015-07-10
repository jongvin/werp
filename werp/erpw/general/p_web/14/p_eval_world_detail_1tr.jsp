<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_eval_world_detail_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_eval_code = dSet.indexOfColumn("eval_code");
   	int idx_eval_degree = dSet.indexOfColumn("eval_degree");
   	int idx_self_evaluator = dSet.indexOfColumn("self_evaluator");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_base_code = dSet.indexOfColumn("b_base_code");
   	int idx_seq = dSet.indexOfColumn("b_seq");
   	int idx_section_item = dSet.indexOfColumn("b_section_item");
   	int idx_detail_item = dSet.indexOfColumn("b_detail_item");
   	int idx_self_eval_score = dSet.indexOfColumn("self_eval_score");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_eval_world_detail ( eval_code," + 
                    "eval_degree," + 
                    "self_evaluator," + 
                    "spec_no_seq," +
                    "self_eval_score )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_degree);
      gpstatement.bindColumn(3, idx_self_evaluator);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_self_eval_score);
      stmt.executeUpdate();
      stmt.close();
 		
	 		String str_base_code;	      
	    	str_base_code = rows.getString(idx_base_code);
		   if (str_base_code.equals("99")) {
		 		sSql = " INSERT INTO p_eval_world_detail_99 ( eval_code," + 
		                    "eval_degree," + 
		                    "self_evaluator," + 
		                    "spec_no_seq," +
		                    "base_code," + 
		                    "seq," + 
		                    "section_item," + 
		                    "detail_item," + 
		                    "self_eval_score )      ";
		      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9 ) ";
		      stmt = conn.prepareStatement(sSql);
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_eval_code);
		      gpstatement.bindColumn(2, idx_eval_degree);
		      gpstatement.bindColumn(3, idx_self_evaluator);
		      gpstatement.bindColumn(4, idx_spec_no_seq);
		      gpstatement.bindColumn(5, idx_base_code);
		      gpstatement.bindColumn(6, idx_seq);
		      gpstatement.bindColumn(7, idx_section_item);
		      gpstatement.bindColumn(8, idx_detail_item);
		      gpstatement.bindColumn(9, idx_self_eval_score);
		      stmt.executeUpdate();
		      stmt.close();
		    }
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_eval_world_detail set " + 
                            "eval_code=?,  " + 
                            "eval_degree=?,  " + 
                            "self_evaluator=?,  " + 
                            "spec_no_seq=?,  " + 
                            "self_eval_score=?  where eval_code=? and eval_degree=? and self_evaluator=? and spec_no_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_degree);
      gpstatement.bindColumn(3, idx_self_evaluator);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_self_eval_score);      
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_eval_code);
      gpstatement.bindColumn(7, idx_eval_degree);
      gpstatement.bindColumn(8, idx_self_evaluator);
      gpstatement.bindColumn(9, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
      
      	String str_base_code;	      
	    	str_base_code = rows.getString(idx_base_code);
		   if (str_base_code.equals("99")) {
			 	sSql = "update p_eval_world_detail_99 set " + 
		                            "eval_code=?,  " + 
		                            "eval_degree=?,  " + 
		                            "self_evaluator=?,  " + 
		                            "spec_no_seq=?,  " + 
		                            "base_code=?,  " + 
		                            "seq=?,  " + 
		                            "section_item=?,  " + 
		                            "detail_item=?, " +
		                            "self_eval_score=?  where eval_code=? and eval_degree=? and self_evaluator=? and spec_no_seq=?";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_eval_code);
		      gpstatement.bindColumn(2, idx_eval_degree);
		      gpstatement.bindColumn(3, idx_self_evaluator);
		      gpstatement.bindColumn(4, idx_spec_no_seq);
		      gpstatement.bindColumn(5, idx_base_code);
		      gpstatement.bindColumn(6, idx_seq);
		      gpstatement.bindColumn(7, idx_section_item);
		      gpstatement.bindColumn(8, idx_detail_item);      
		      gpstatement.bindColumn(9, idx_self_eval_score);      
			 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
		      gpstatement.bindColumn(10, idx_eval_code);
		      gpstatement.bindColumn(11, idx_eval_degree);
		      gpstatement.bindColumn(12, idx_self_evaluator);
		      gpstatement.bindColumn(13, idx_spec_no_seq);
		      stmt.executeUpdate();
		      stmt.close();
		   }
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_eval_world_detail where eval_code=? and eval_degree=? and self_evaluator=? and spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_degree);
      gpstatement.bindColumn(3, idx_self_evaluator);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
      
      String str_base_code;	      
	    	str_base_code = rows.getString(idx_base_code);
		   if (str_base_code.equals("99")) {
				sSql = "delete from p_eval_world_detail_99 where eval_code=? and eval_degree=? and self_evaluator=? and spec_no_seq=? "; 
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
		      gpstatement.bindColumn(1, idx_eval_code);
		      gpstatement.bindColumn(2, idx_eval_degree);
		      gpstatement.bindColumn(3, idx_self_evaluator);
		      gpstatement.bindColumn(4, idx_spec_no_seq);
		      stmt.executeUpdate();
		      stmt.close();
		   }
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>