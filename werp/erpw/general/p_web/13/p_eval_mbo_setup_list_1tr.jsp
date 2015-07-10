<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_eval_mbo_setup_list_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_eval_code = dSet.indexOfColumn("eval_code");
   	int idx_eval_year = dSet.indexOfColumn("eval_year");
   	int idx_self_evaluator = dSet.indexOfColumn("self_evaluator");
   	int idx_self_comp_code = dSet.indexOfColumn("self_comp_code");
   	int idx_self_dept_code = dSet.indexOfColumn("self_dept_code");
   	int idx_self_grade_code = dSet.indexOfColumn("self_grade_code");
   	int idx_self_present_yn = dSet.indexOfColumn("self_present_yn");
   	int idx_self_present_date = dSet.indexOfColumn("self_present_date");
   	int idx_fir_evaluator = dSet.indexOfColumn("fir_evaluator");
   	int idx_fir_comp_code = dSet.indexOfColumn("fir_comp_code");
   	int idx_fir_dept_code = dSet.indexOfColumn("fir_dept_code");
   	int idx_fir_grade_code = dSet.indexOfColumn("fir_grade_code");
   	int idx_fir_agree_yn = dSet.indexOfColumn("fir_agree_yn");
   	int idx_fir_agree_date = dSet.indexOfColumn("fir_agree_date");
   	int idx_sec_evaluator = dSet.indexOfColumn("sec_evaluator");
   	int idx_sec_comp_code = dSet.indexOfColumn("sec_comp_code");
   	int idx_sec_dept_code = dSet.indexOfColumn("sec_dept_code");
   	int idx_sec_grade_code = dSet.indexOfColumn("sec_grade_code");   	
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_eval_mbo_setup_list ( eval_code," + 
                    "eval_year," + 
                    "self_evaluator," + 
                    "self_comp_code," + 
                    "self_dept_code," + 
                    "self_grade_code," + 
                    "self_present_yn," + 
                    "self_present_date," + 
                    "fir_evaluator," + 
                    "fir_comp_code," + 
                    "fir_dept_code," + 
                    "fir_grade_code," + 
                    "fir_agree_yn," + 
                    "fir_agree_date," + 
                    "sec_evaluator," + 
                    "sec_comp_code," + 
                    "sec_dept_code," + 
                    "sec_grade_code )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_year);
      gpstatement.bindColumn(3, idx_self_evaluator);
      gpstatement.bindColumn(4, idx_self_comp_code);
      gpstatement.bindColumn(5, idx_self_dept_code);
      gpstatement.bindColumn(6, idx_self_grade_code);
      gpstatement.bindColumn(7, idx_self_present_yn);
      gpstatement.bindColumn(8, idx_self_present_date);
      gpstatement.bindColumn(9, idx_fir_evaluator);
      gpstatement.bindColumn(10, idx_fir_comp_code);
      gpstatement.bindColumn(11, idx_fir_dept_code);
      gpstatement.bindColumn(12, idx_fir_grade_code);
      gpstatement.bindColumn(13, idx_fir_agree_yn);
      gpstatement.bindColumn(14, idx_fir_agree_date);
      gpstatement.bindColumn(15, idx_sec_evaluator);
      gpstatement.bindColumn(16, idx_sec_comp_code);
      gpstatement.bindColumn(17, idx_sec_dept_code);
      gpstatement.bindColumn(18, idx_sec_grade_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_eval_mbo_setup_list set " + 
                            "eval_code=?,  " + 
                            "eval_year=?,  " + 
                            "self_evaluator=?,  " + 
                            "self_comp_code=?,  " + 
                            "self_dept_code=?,  " + 
                            "self_grade_code=?,  " + 
                            "self_present_yn=?,  " + 
                            "self_present_date=?,  " + 
                            "fir_evaluator=?,  " + 
                            "fir_comp_code=?,  " + 
                            "fir_dept_code=?,  " + 
                            "fir_grade_code=?,  " + 
                            "fir_agree_yn=?,  " + 
                            "fir_agree_date=?,  " + 
                            "sec_evaluator=?,  " + 
                            "sec_comp_code=?,  " + 
                            "sec_dept_code=?,  " + 
                            "sec_grade_code=?  where eval_code=? and eval_year=? and self_evaluator=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_year);
      gpstatement.bindColumn(3, idx_self_evaluator);
      gpstatement.bindColumn(4, idx_self_comp_code);
      gpstatement.bindColumn(5, idx_self_dept_code);
      gpstatement.bindColumn(6, idx_self_grade_code);
      gpstatement.bindColumn(7, idx_self_present_yn);
      gpstatement.bindColumn(8, idx_self_present_date);
      gpstatement.bindColumn(9, idx_fir_evaluator);
      gpstatement.bindColumn(10, idx_fir_comp_code);
      gpstatement.bindColumn(11, idx_fir_dept_code);
      gpstatement.bindColumn(12, idx_fir_grade_code);
      gpstatement.bindColumn(13, idx_fir_agree_yn);
      gpstatement.bindColumn(14, idx_fir_agree_date);
      gpstatement.bindColumn(15, idx_sec_evaluator);
      gpstatement.bindColumn(16, idx_sec_comp_code);
      gpstatement.bindColumn(17, idx_sec_dept_code);
      gpstatement.bindColumn(18, idx_sec_grade_code);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(19, idx_eval_code);
      gpstatement.bindColumn(20, idx_eval_year);
      gpstatement.bindColumn(21, idx_self_evaluator);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_eval_mbo_setup_list where eval_code=? and eval_year=? and self_evaluator=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_year);
      gpstatement.bindColumn(3, idx_self_evaluator);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>