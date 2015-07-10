<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_eval_world_detail_fir_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_eval_code = dSet.indexOfColumn("eval_code");
   	int idx_eval_degree = dSet.indexOfColumn("eval_degree");
   	int idx_self_evaluator = dSet.indexOfColumn("self_evaluator");
   	int idx_base_code = dSet.indexOfColumn("base_code");
   	int idx_fir_base_grade = dSet.indexOfColumn("fir_base_grade");
   	int idx_fir_comment = dSet.indexOfColumn("fir_comment");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_eval_world_fir ( eval_code," + 
                    "eval_degree," + 
                    "self_evaluator," + 
                    "base_code," + 
                    "fir_base_grade," + 
                    "fir_comment )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_degree);
      gpstatement.bindColumn(3, idx_self_evaluator);
      gpstatement.bindColumn(4, idx_base_code);
      gpstatement.bindColumn(5, idx_fir_base_grade);
      gpstatement.bindColumn(6, idx_fir_comment);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_eval_world_fir set " + 
                            "eval_code=?,  " + 
                            "eval_degree=?,  " + 
                            "self_evaluator=?,  " + 
                            "base_code=?,  " + 
                            "fir_base_grade=?,  " + 
                            "fir_comment=?  where eval_code=? and eval_degree=? and self_evaluator=? and base_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_degree);
      gpstatement.bindColumn(3, idx_self_evaluator);
      gpstatement.bindColumn(4, idx_base_code);
      gpstatement.bindColumn(5, idx_fir_base_grade);
      gpstatement.bindColumn(6, idx_fir_comment);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_eval_code);
      gpstatement.bindColumn(8, idx_eval_degree);
      gpstatement.bindColumn(9, idx_self_evaluator);
      gpstatement.bindColumn(10, idx_base_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_eval_world_fir where eval_code=? and eval_degree=? and self_evaluator=? and base_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_degree);
      gpstatement.bindColumn(3, idx_self_evaluator);
      gpstatement.bindColumn(4, idx_base_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>