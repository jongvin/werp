<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_eval_mbo_setup_detail_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_eval_code = dSet.indexOfColumn("eval_code");
   	int idx_eval_year = dSet.indexOfColumn("eval_year");
   	int idx_self_evaluator = dSet.indexOfColumn("self_evaluator");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_section_item = dSet.indexOfColumn("section_item");
   	int idx_important_service = dSet.indexOfColumn("important_service");
   	int idx_detail_service = dSet.indexOfColumn("detail_service");
   	int idx_result_index = dSet.indexOfColumn("result_index");
   	int idx_measure_base = dSet.indexOfColumn("measure_base");
   	int idx_object_value = dSet.indexOfColumn("object_value");
   	int idx_specific_gravity = dSet.indexOfColumn("specific_gravity");
   	int idx_attain_time = dSet.indexOfColumn("attain_time");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_eval_mbo_setup_detail ( eval_code," + 
                    "eval_year," + 
                    "self_evaluator," + 
                    "spec_no_seq," + 
                    "seq," + 
                    "section_item," + 
                    "important_service," + 
                    "detail_service," + 
                    "result_index," + 
                    "measure_base," + 
                    "object_value," + 
                    "specific_gravity," + 
                    "attain_time )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_year);
      gpstatement.bindColumn(3, idx_self_evaluator);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_section_item);
      gpstatement.bindColumn(7, idx_important_service);
      gpstatement.bindColumn(8, idx_detail_service);
      gpstatement.bindColumn(9, idx_result_index);
      gpstatement.bindColumn(10, idx_measure_base);
      gpstatement.bindColumn(11, idx_object_value);
      gpstatement.bindColumn(12, idx_specific_gravity);
      gpstatement.bindColumn(13, idx_attain_time);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_eval_mbo_setup_detail set " + 
                            "eval_code=?,  " + 
                            "eval_year=?,  " + 
                            "self_evaluator=?,  " + 
                            "spec_no_seq=?,  " + 
                            "seq=?,  " + 
                            "section_item=?,  " + 
                            "important_service=?,  " + 
                            "detail_service=?,  " + 
                            "result_index=?,  " + 
                            "measure_base=?,  " + 
                            "object_value=?,  " + 
                            "specific_gravity=?,  " + 
                            "attain_time=?  where eval_code=? and eval_year=? and self_evaluator=? and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_year);
      gpstatement.bindColumn(3, idx_self_evaluator);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_section_item);
      gpstatement.bindColumn(7, idx_important_service);
      gpstatement.bindColumn(8, idx_detail_service);
      gpstatement.bindColumn(9, idx_result_index);
      gpstatement.bindColumn(10, idx_measure_base);
      gpstatement.bindColumn(11, idx_object_value);
      gpstatement.bindColumn(12, idx_specific_gravity);
      gpstatement.bindColumn(13, idx_attain_time);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(14, idx_eval_code);
      gpstatement.bindColumn(15, idx_eval_year);
      gpstatement.bindColumn(16, idx_self_evaluator);
      gpstatement.bindColumn(17, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_eval_mbo_setup_detail where eval_code=? and eval_year=? and self_evaluator=? and spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_year);
      gpstatement.bindColumn(3, idx_self_evaluator);
      gpstatement.bindColumn(4, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>