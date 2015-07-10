<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_eval_probation_fir_list_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_eval_code = dSet.indexOfColumn("eval_code");
   	int idx_eval_degree = dSet.indexOfColumn("eval_degree");
   	int idx_self_evaluator = dSet.indexOfColumn("self_evaluator");
   	int idx_fir_gen_eval_view = dSet.indexOfColumn("fir_gen_eval_view");   	
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_eval_probation set " + 
                            "fir_gen_eval_view=? where eval_code=? and eval_degree=? and self_evaluator=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_fir_gen_eval_view);      
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(2, idx_eval_code);
      gpstatement.bindColumn(3, idx_eval_degree);
      gpstatement.bindColumn(4, idx_self_evaluator);
      stmt.executeUpdate();
      stmt.close();
   }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>