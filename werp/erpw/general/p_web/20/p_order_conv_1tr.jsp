<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_order_conv_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_apply_order_date = dSet.indexOfColumn("apply_order_date");
   	int idx_order_code = dSet.indexOfColumn("order_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_order_no = dSet.indexOfColumn("order_no");
   	int idx_real_order_date = dSet.indexOfColumn("real_order_date");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_cost_dept_code = dSet.indexOfColumn("cost_dept_code");
   	int idx_work_dept_code = dSet.indexOfColumn("work_dept_code");
   	int idx_grade_code = dSet.indexOfColumn("grade_code");
   	int idx_level_code = dSet.indexOfColumn("level_code");
   	int idx_paystep = dSet.indexOfColumn("paystep");
   	int idx_jobkind_code = dSet.indexOfColumn("jobkind_code");
   	int idx_jobgroup_code = dSet.indexOfColumn("jobgroup_code");
   	int idx_title_code = dSet.indexOfColumn("title_code");
   	int idx_duty = dSet.indexOfColumn("duty");
   	int idx_special_tag = dSet.indexOfColumn("special_tag");
   	int idx_old_comp_code = dSet.indexOfColumn("old_comp_code");
   	int idx_old_cost_dept_code = dSet.indexOfColumn("old_cost_dept_code");
   	int idx_old_work_dept_code = dSet.indexOfColumn("old_work_dept_code");
   	int idx_old_dept_code = dSet.indexOfColumn("old_dept_code");
   	int idx_old_grade_code = dSet.indexOfColumn("old_grade_code");
   	int idx_old_level_code = dSet.indexOfColumn("old_level_code");
   	int idx_old_paystep = dSet.indexOfColumn("old_paystep");
   	int idx_old_jobkind_code = dSet.indexOfColumn("old_jobkind_code");
   	int idx_old_jobgroup_code = dSet.indexOfColumn("old_jobgroup_code");
   	int idx_old_title_code = dSet.indexOfColumn("old_title_code");
   	int idx_old_duty = dSet.indexOfColumn("old_duty");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_confirm_tag = dSet.indexOfColumn("confirm_tag");
   	int idx_input_id = dSet.indexOfColumn("input_id");
   	int idx_input_date = dSet.indexOfColumn("input_date");   	
   	int idx_degree = dSet.indexOfColumn("degree");   	
   	int idx_old_degree = dSet.indexOfColumn("old_degree");      	
   	int idx_old_service_div = dSet.indexOfColumn("old_service_div");   	
   	int idx_mov_group_join_date = dSet.indexOfColumn("mov_group_join_date");   	
   	int idx_dept_short_name = dSet.indexOfColumn("dept_short_name");   	
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_order_master ( emp_no," + 
                    "spec_no_seq," + 
                    "apply_order_date," + 
                    "order_code," + 
                    "seq," + 
                    "order_no," + 
                    "real_order_date," + 
                    "comp_code," + 
                    "dept_code," + 
                    "cost_dept_code," + 
                    "work_dept_code," + 
                    "grade_code," + 
                    "level_code," + 
                    "paystep," + 
                    "jobkind_code," + 
                    "jobgroup_code," + 
                    "title_code," + 
                    "duty," +
                    "special_tag,"+ 
                    "old_comp_code," + 
                    "old_cost_dept_code," + 
                    "old_work_dept_code," + 
                    "old_dept_code," + 
                    "old_grade_code," + 
                    "old_level_code," + 
                    "old_paystep," + 
                    "old_jobkind_code," + 
                    "old_jobgroup_code," + 
                    "old_title_code," + 
                    "old_duty," + 
                    "remark," + 
                    "confirm_tag," + 
                    "input_id," + 
                    "input_date, degree, old_degree, old_service_div, mov_group_join_date, dept_short_name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, :31, :32, :33, :34, :35, :36, :37, :38, :39 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_apply_order_date);
      gpstatement.bindColumn(4, idx_order_code);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_order_no);
      gpstatement.bindColumn(7, idx_real_order_date);
      gpstatement.bindColumn(8, idx_comp_code);
      gpstatement.bindColumn(9, idx_dept_code);
      gpstatement.bindColumn(10, idx_cost_dept_code);
      gpstatement.bindColumn(11, idx_work_dept_code);
      gpstatement.bindColumn(12, idx_grade_code);
      gpstatement.bindColumn(13, idx_level_code);
      gpstatement.bindColumn(14, idx_paystep);
      gpstatement.bindColumn(15, idx_jobkind_code);
      gpstatement.bindColumn(16, idx_jobgroup_code);
      gpstatement.bindColumn(17, idx_title_code);
      gpstatement.bindColumn(18, idx_duty);
      gpstatement.bindColumn(19, idx_special_tag);
      gpstatement.bindColumn(20, idx_old_comp_code);
      gpstatement.bindColumn(21, idx_old_cost_dept_code);
      gpstatement.bindColumn(22, idx_old_work_dept_code);
      gpstatement.bindColumn(23, idx_old_dept_code);
      gpstatement.bindColumn(24, idx_old_grade_code);
      gpstatement.bindColumn(25, idx_old_level_code);
      gpstatement.bindColumn(26, idx_old_paystep);
      gpstatement.bindColumn(27, idx_old_jobkind_code);
      gpstatement.bindColumn(28, idx_old_jobgroup_code);
      gpstatement.bindColumn(29, idx_old_title_code);
      gpstatement.bindColumn(30, idx_old_duty);
      gpstatement.bindColumn(31, idx_remark);
      gpstatement.bindColumn(32, idx_confirm_tag);
      gpstatement.bindColumn(33, idx_input_id);
      gpstatement.bindColumn(34, idx_input_date);
      gpstatement.bindColumn(35, idx_degree);
      gpstatement.bindColumn(36, idx_old_degree);
      gpstatement.bindColumn(37, idx_old_service_div);
      gpstatement.bindColumn(38, idx_mov_group_join_date);      
      gpstatement.bindColumn(39, idx_dept_short_name);      
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_order_master set " + 
                            "emp_no=?,  " + 
                            "spec_no_seq=?,  " + 
                            "apply_order_date=?,  " + 
                            "order_code=?,  " + 
                            "seq=?,  " + 
                            "order_no=?,  " + 
                            "real_order_date=?,  " + 
                            "comp_code=?,  " + 
                            "dept_code=?,  " + 
                            "cost_dept_code=?,  " + 
                            "work_dept_code=?,  " + 
                            "grade_code=?,  " + 
                            "level_code=?,  " + 
                            "paystep=?,  " + 
                            "jobkind_code=?,  " + 
                            "jobgroup_code=?,  " + 
                            "title_code=?,  " + 
                            "duty=?, " +
                            "special_tag=?, " +
                            "old_comp_code=?,  " + 
                            "old_cost_dept_code=?,  " + 
                            "old_work_dept_code=?,  " + 
                            "old_dept_code=?,  " + 
                            "old_grade_code=?,  " + 
                            "old_level_code=?,  " + 
                            "old_paystep=?,  " + 
                            "old_jobkind_code=?,  " + 
                            "old_jobgroup_code=?,  " + 
                            "old_title_code=?,  " + 
                            "old_duty=?,  " + 
                            "remark=?,  " + 
                            "confirm_tag=?,  " + 
                            "input_id=?,  " + 
                            "input_date=?, " +
                            "degree=?, " +
                            "old_degree=?, " +
                            "old_service_div=?, " +
                            "mov_group_join_date=?, " +
                            "dept_short_name=?  where emp_no=? and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_apply_order_date);
      gpstatement.bindColumn(4, idx_order_code);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_order_no);
      gpstatement.bindColumn(7, idx_real_order_date);
      gpstatement.bindColumn(8, idx_comp_code);
      gpstatement.bindColumn(9, idx_dept_code);
      gpstatement.bindColumn(10, idx_cost_dept_code);
      gpstatement.bindColumn(11, idx_work_dept_code);
      gpstatement.bindColumn(12, idx_grade_code);
      gpstatement.bindColumn(13, idx_level_code);
      gpstatement.bindColumn(14, idx_paystep);
      gpstatement.bindColumn(15, idx_jobkind_code);
      gpstatement.bindColumn(16, idx_jobgroup_code);
      gpstatement.bindColumn(17, idx_title_code);
      gpstatement.bindColumn(18, idx_duty);
      gpstatement.bindColumn(19, idx_special_tag);
      gpstatement.bindColumn(20, idx_old_comp_code);
      gpstatement.bindColumn(21, idx_old_cost_dept_code);
      gpstatement.bindColumn(22, idx_old_work_dept_code);
      gpstatement.bindColumn(23, idx_old_dept_code);
      gpstatement.bindColumn(24, idx_old_grade_code);
      gpstatement.bindColumn(25, idx_old_level_code);
      gpstatement.bindColumn(26, idx_old_paystep);
      gpstatement.bindColumn(27, idx_old_jobkind_code);
      gpstatement.bindColumn(28, idx_old_jobgroup_code);
      gpstatement.bindColumn(29, idx_old_title_code);
      gpstatement.bindColumn(30, idx_old_duty);
      gpstatement.bindColumn(31, idx_remark);
      gpstatement.bindColumn(32, idx_confirm_tag);
      gpstatement.bindColumn(33, idx_input_id);
      gpstatement.bindColumn(34, idx_input_date);
      gpstatement.bindColumn(35, idx_degree);
      gpstatement.bindColumn(36, idx_old_degree); 
      gpstatement.bindColumn(37, idx_old_service_div);
      gpstatement.bindColumn(38, idx_mov_group_join_date);       
      gpstatement.bindColumn(39, idx_dept_short_name);       
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(40, idx_emp_no);
      gpstatement.bindColumn(41, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_order_master where emp_no=? and spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>