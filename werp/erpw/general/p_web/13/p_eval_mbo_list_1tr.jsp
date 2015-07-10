<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_eval_mbo_list_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_eval_code = dSet.indexOfColumn("eval_code");
   	int idx_eval_year = dSet.indexOfColumn("eval_year");
   	int idx_eval_degree = dSet.indexOfColumn("eval_degree");
   	int idx_self_evaluator = dSet.indexOfColumn("self_evaluator");
   	int idx_self_comp_code = dSet.indexOfColumn("self_comp_code");
   	int idx_self_dept_code = dSet.indexOfColumn("self_dept_code");
   	int idx_self_grade_code = dSet.indexOfColumn("self_grade_code");
   	int idx_self_not_attain = dSet.indexOfColumn("self_not_attain");
   	int idx_self_support_req = dSet.indexOfColumn("self_support_req");
   	int idx_self_present_yn = dSet.indexOfColumn("self_present_yn");
   	int idx_self_present_date = dSet.indexOfColumn("self_present_date");
   	int idx_fir_evaluator = dSet.indexOfColumn("fir_evaluator");
   	int idx_fir_comp_code = dSet.indexOfColumn("fir_comp_code");
   	int idx_fir_dept_code = dSet.indexOfColumn("fir_dept_code");
   	int idx_fir_grade_code = dSet.indexOfColumn("fir_grade_code");
   	int idx_fir_gen_eval_view = dSet.indexOfColumn("fir_gen_eval_view");
   	int idx_fir_interview_yn = dSet.indexOfColumn("fir_interview_yn");
   	int idx_fir_interview_time = dSet.indexOfColumn("fir_interview_time");
   	int idx_fir_interview_place = dSet.indexOfColumn("fir_interview_place");
   	int idx_fir_suggest_grade = dSet.indexOfColumn("fir_suggest_grade");
   	int idx_fir_present_yn = dSet.indexOfColumn("fir_present_yn");
   	int idx_fir_present_date = dSet.indexOfColumn("fir_present_date");
   	int idx_sec_evaluator = dSet.indexOfColumn("sec_evaluator");
   	int idx_sec_comp_code = dSet.indexOfColumn("sec_comp_code");
   	int idx_sec_dept_code = dSet.indexOfColumn("sec_dept_code");
   	int idx_sec_grade_code = dSet.indexOfColumn("sec_grade_code");
   	int idx_sec_eval_grade = dSet.indexOfColumn("sec_eval_grade");
   	int idx_sec_present_yn = dSet.indexOfColumn("sec_present_yn");
   	int idx_sec_present_date = dSet.indexOfColumn("sec_present_date");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_eval_mbo_list ( eval_code," + 
                    "eval_year," + 
                    "eval_degree," + 
                    "self_evaluator," + 
                    "self_comp_code," + 
                    "self_dept_code," + 
                    "self_grade_code," + 
                    "self_not_attain," + 
                    "self_support_req," + 
                    "self_present_yn," + 
                    "self_present_date," + 
                    "fir_evaluator," + 
                    "fir_comp_code," + 
                    "fir_dept_code," + 
                    "fir_grade_code," + 
                    "fir_gen_eval_view," + 
                    "fir_interview_yn," + 
                    "fir_interview_time," + 
                    "fir_interview_place," + 
                    "fir_suggest_grade," + 
                    "fir_present_yn," + 
                    "fir_present_date," + 
                    "sec_evaluator," + 
                    "sec_comp_code," + 
                    "sec_dept_code," + 
                    "sec_grade_code," + 
                    "sec_eval_grade," + 
                    "sec_present_yn," +
                    "sec_present_date )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, TO_DATE(:18,'yyyy.mm.dd hh24:mi'), :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_year);
      gpstatement.bindColumn(3, idx_eval_degree);
      gpstatement.bindColumn(4, idx_self_evaluator);
      gpstatement.bindColumn(5, idx_self_comp_code);
      gpstatement.bindColumn(6, idx_self_dept_code);
      gpstatement.bindColumn(7, idx_self_grade_code);
      gpstatement.bindColumn(8, idx_self_not_attain);
      gpstatement.bindColumn(9, idx_self_support_req);
      gpstatement.bindColumn(10, idx_self_present_yn);
      gpstatement.bindColumn(11, idx_self_present_date);
      gpstatement.bindColumn(12, idx_fir_evaluator);
      gpstatement.bindColumn(13, idx_fir_comp_code);
      gpstatement.bindColumn(14, idx_fir_dept_code);
      gpstatement.bindColumn(15, idx_fir_grade_code);
      gpstatement.bindColumn(16, idx_fir_gen_eval_view);
      gpstatement.bindColumn(17, idx_fir_interview_yn);
      gpstatement.bindColumn(18, idx_fir_interview_time);
      gpstatement.bindColumn(19, idx_fir_interview_place);
      gpstatement.bindColumn(20, idx_fir_suggest_grade);
      gpstatement.bindColumn(21, idx_fir_present_yn);
      gpstatement.bindColumn(22, idx_fir_present_date);
      gpstatement.bindColumn(23, idx_sec_evaluator);
      gpstatement.bindColumn(24, idx_sec_comp_code);
      gpstatement.bindColumn(25, idx_sec_dept_code);
      gpstatement.bindColumn(26, idx_sec_grade_code);
      gpstatement.bindColumn(27, idx_sec_eval_grade);
      gpstatement.bindColumn(28, idx_sec_present_yn);
      gpstatement.bindColumn(29, idx_sec_present_date);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_eval_mbo_list set " + 
                            "eval_code=?,  " + 
                            "eval_year=?,  " + 
                            "eval_degree=?,  " + 
                            "self_evaluator=?,  " + 
                            "self_comp_code=?,  " + 
                            "self_dept_code=?,  " + 
                            "self_grade_code=?,  " + 
                            "self_not_attain=?,  " + 
                            "self_support_req=?,  " + 
                            "self_present_yn=?,  " + 
                            "self_present_date=?,  " + 
                            "fir_evaluator=?,  " + 
                            "fir_comp_code=?,  " + 
                            "fir_dept_code=?,  " + 
                            "fir_grade_code=?,  " + 
                            "fir_gen_eval_view=?,  " + 
                            "fir_interview_yn=?,  " + 
                            "fir_interview_time=TO_DATE(?,'yyyy.mm.dd hh24:mi'),  " + 
                            "fir_interview_place=?,  " + 
                            "fir_suggest_grade=?,  " + 
                            "fir_present_yn=?,  " + 
                            "fir_present_date=?,  " + 
                            "sec_evaluator=?,  " + 
                            "sec_comp_code=?,  " + 
                            "sec_dept_code=?,  " + 
                            "sec_grade_code=?,  " + 
                            "sec_eval_grade=?,  " + 
                            "sec_present_yn=?,  " + 
                            "sec_present_date=?  where eval_code=? and eval_year=? and eval_degree=? and self_evaluator=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_year);
      gpstatement.bindColumn(3, idx_eval_degree);
      gpstatement.bindColumn(4, idx_self_evaluator);
      gpstatement.bindColumn(5, idx_self_comp_code);
      gpstatement.bindColumn(6, idx_self_dept_code);
      gpstatement.bindColumn(7, idx_self_grade_code);
      gpstatement.bindColumn(8, idx_self_not_attain);
      gpstatement.bindColumn(9, idx_self_support_req);
      gpstatement.bindColumn(10, idx_self_present_yn);
      gpstatement.bindColumn(11, idx_self_present_date);
      gpstatement.bindColumn(12, idx_fir_evaluator);
      gpstatement.bindColumn(13, idx_fir_comp_code);
      gpstatement.bindColumn(14, idx_fir_dept_code);
      gpstatement.bindColumn(15, idx_fir_grade_code);
      gpstatement.bindColumn(16, idx_fir_gen_eval_view);
      gpstatement.bindColumn(17, idx_fir_interview_yn);
      gpstatement.bindColumn(18, idx_fir_interview_time);
      gpstatement.bindColumn(19, idx_fir_interview_place);
      gpstatement.bindColumn(20, idx_fir_suggest_grade);
      gpstatement.bindColumn(21, idx_fir_present_yn);
      gpstatement.bindColumn(22, idx_fir_present_date);
      gpstatement.bindColumn(23, idx_sec_evaluator);
      gpstatement.bindColumn(24, idx_sec_comp_code);
      gpstatement.bindColumn(25, idx_sec_dept_code);
      gpstatement.bindColumn(26, idx_sec_grade_code);
      gpstatement.bindColumn(27, idx_sec_eval_grade);
      gpstatement.bindColumn(28, idx_sec_present_yn);
      gpstatement.bindColumn(29, idx_sec_present_date);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(30, idx_eval_code);
      gpstatement.bindColumn(31, idx_eval_year);
      gpstatement.bindColumn(32, idx_eval_degree);
      gpstatement.bindColumn(33, idx_self_evaluator);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_eval_mbo_list where eval_code=? and eval_year=? and eval_degree=? and self_evaluator=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_year);
      gpstatement.bindColumn(3, idx_eval_degree);
      gpstatement.bindColumn(4, idx_self_evaluator);      
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>