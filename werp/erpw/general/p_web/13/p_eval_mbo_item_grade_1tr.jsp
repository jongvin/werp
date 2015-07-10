<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_eval_mbo_item_grade_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_eval_grade = dSet.indexOfColumn("eval_grade");
   	int idx_eval_grade_name = dSet.indexOfColumn("eval_grade_name");
   	int idx_eval_grade_spec = dSet.indexOfColumn("eval_grade_spec");
   	int idx_exchange_score = dSet.indexOfColumn("exchange_score");
   	int idx_eval_grade_base = dSet.indexOfColumn("eval_grade_base");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_eval_mbo_item_grade ( eval_grade," + 
                    "eval_grade_name," + 
                    "eval_grade_spec," + 
                    "exchange_score," + 
                    "eval_grade_base )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_grade);
      gpstatement.bindColumn(2, idx_eval_grade_name);
      gpstatement.bindColumn(3, idx_eval_grade_spec);
      gpstatement.bindColumn(4, idx_exchange_score);
      gpstatement.bindColumn(5, idx_eval_grade_base);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_eval_mbo_item_grade set " + 
                            "eval_grade=?,  " + 
                            "eval_grade_name=?,  " + 
                            "eval_grade_spec=?,  " + 
                            "exchange_score=?,  " + 
                            "eval_grade_base=?  where eval_grade=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_grade);
      gpstatement.bindColumn(2, idx_eval_grade_name);
      gpstatement.bindColumn(3, idx_eval_grade_spec);
      gpstatement.bindColumn(4, idx_exchange_score);
      gpstatement.bindColumn(5, idx_eval_grade_base);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_eval_grade);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_eval_mbo_item_grade where eval_grade=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_eval_grade);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>