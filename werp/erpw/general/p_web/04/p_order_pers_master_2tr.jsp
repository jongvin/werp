<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_order_pers_master_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_old_group_join_date = dSet.indexOfColumn("old_group_join_date");
   	int idx_old_join_date = dSet.indexOfColumn("old_join_date");
   	int idx_old_retire_date = dSet.indexOfColumn("old_retire_date");
   	int idx_old_gradeup_date = dSet.indexOfColumn("old_gradeup_date");
   	int idx_old_levelup_date = dSet.indexOfColumn("old_levelup_date");
   	int idx_old_dept_join_date = dSet.indexOfColumn("old_dept_join_date");
   	int idx_old_cost_dept_date = dSet.indexOfColumn("old_cost_dept_date");
   	int idx_old_layoff_date = dSet.indexOfColumn("old_layoff_date");
   	int idx_old_jobgroup_date = dSet.indexOfColumn("old_jobgroup_date");   	   	
   	int idx_order_old_comp_code = dSet.indexOfColumn("order_old_comp_code");
   	int idx_order_old_dept_code = dSet.indexOfColumn("order_old_dept_code");
   	int idx_order_old_cost_dept_code = dSet.indexOfColumn("order_old_cost_dept_code");
   	int idx_order_old_work_dept_code = dSet.indexOfColumn("order_old_work_dept_code");
   	int idx_order_old_grade_code = dSet.indexOfColumn("order_old_grade_code");
   	int idx_order_old_level_code = dSet.indexOfColumn("order_old_level_code");
   	int idx_order_old_paystep = dSet.indexOfColumn("order_old_paystep");
   	int idx_order_old_jobgroup_code = dSet.indexOfColumn("order_old_jobgroup_code");
   	int idx_order_old_jobkind_code = dSet.indexOfColumn("order_old_jobkind_code");
   	int idx_order_old_title_code = dSet.indexOfColumn("order_old_title_code");
   	int idx_order_old_duty = dSet.indexOfColumn("order_old_duty");
   	int idx_order_old_service_div = dSet.indexOfColumn("order_old_service_div");
   	int idx_order_service_div = dSet.indexOfColumn("order_service_div");
   	int idx_gjoin_date_yn = dSet.indexOfColumn("gjoin_date_yn");
   	int idx_join_date_yn = dSet.indexOfColumn("join_date_yn");
   	int idx_rest_date_yn = dSet.indexOfColumn("rest_date_yn");
   	int idx_reinst_date_yn = dSet.indexOfColumn("reinst_date_yn");
   	int idx_retire_date_yn = dSet.indexOfColumn("retire_date_yn");   	
   	int idx_dept_yn = dSet.indexOfColumn("dept_yn");
   	int idx_cost_dept_yn = dSet.indexOfColumn("cost_dept_yn");
   	int idx_add_dept_yn = dSet.indexOfColumn("add_dept_yn");
   	int idx_grade_yn = dSet.indexOfColumn("grade_yn");
   	int idx_level_yn = dSet.indexOfColumn("level_yn");
   	int idx_paystep_yn = dSet.indexOfColumn("paystep_yn");
   	int idx_jobgroup_yn = dSet.indexOfColumn("jobgroup_yn");
   	int idx_jobkind_yn = dSet.indexOfColumn("jobkind_yn");
   	int idx_title_yn = dSet.indexOfColumn("title_yn");
   	int idx_order_old_degree = dSet.indexOfColumn("order_old_degree");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
		if(rows.getJobType() ==  GauceDataRow.TB_JOB_INSERT){
			   String ls_dept_code = rows.getString(idx_order_old_dept_code);
			   String sSql = "";
			   if (ls_dept_code.equals("")) {}
			   else {
		         sSql = "update z_authority_user set " + 
		                            " dept_code=?  where empno=? ";  
		         stmt = conn.prepareStatement(sSql); 
		         gpstatement.gp_stmt = stmt;
		         gpstatement.bindColumn(1, idx_order_old_dept_code);
		         gpstatement.bindColumn(2, idx_emp_no);
		         stmt.executeUpdate();
		         stmt.close();
		      }   
			
			/* 입사발령 취소면 권한테이블의 근무구분을 'N'으로 Update */ 
	      String str_yn;
	      
	      str_yn = rows.getString(idx_join_date_yn);
	      if (str_yn.equals("T")) {
		      sSql = "update z_authority_user set " + 
		                            "using_tag='N'  where empno=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
	      }
	      
			/* 퇴직발령 취소면 권한테이블의 근무구분을 'Y'로 Update */ 
	      str_yn = rows.getString(idx_retire_date_yn);
       	if (str_yn.equals("T")) {            
		      
		      sSql = "update z_authority_user set " + 
		                            "using_tag='Y'  where empno=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
	      }
	      
	 		sSql = "update p_pers_master set " + 
	                            "emp_no=?,  " + 
	                            "comp_code=?,  " + 
	                            "dept_code=?,  " + 
	                            "cost_dept_code=?,  " + 
	                            "work_dept_code=?,  " + 
	                            "grade_code=?,  " + 
	                            "level_code=?,  " + 
	                            "paystep=?,  " + 
	                            "jobgroup_code=?,  " + 
	                            "jobkind_code=?,  " + 
	                            "title_code=?,  " + 
	                            "duty=?,  " + 
	                            "service_div_code=?, " +
	                            "group_join_date=?, " +
	                            "join_date=?, " +
	                            "retire_date=?, " +
	                            "gradeup_date=?, " +
	                            "levelup_date=?, " +
	                            "dept_join_date=?, " +
	                            "cost_dept_date=?, " +
	                            "layoff_date=?, " +
	                            "jobgroup_date=?, degree=? where emp_no=? ";  
	      stmt = conn.prepareStatement(sSql); 
	      gpstatement.gp_stmt = stmt;
	      gpstatement.bindColumn(1, idx_emp_no);
	      gpstatement.bindColumn(2, idx_order_old_comp_code);
	      gpstatement.bindColumn(3, idx_order_old_dept_code);
	      gpstatement.bindColumn(4, idx_order_old_cost_dept_code);
	      gpstatement.bindColumn(5, idx_order_old_work_dept_code);
	      gpstatement.bindColumn(6, idx_order_old_grade_code);
	      gpstatement.bindColumn(7, idx_order_old_level_code);
	      gpstatement.bindColumn(8, idx_order_old_paystep);
	      gpstatement.bindColumn(9, idx_order_old_jobgroup_code);
	      gpstatement.bindColumn(10, idx_order_old_jobkind_code);
	      gpstatement.bindColumn(11, idx_order_old_title_code);
	      gpstatement.bindColumn(12, idx_order_old_duty);
	      gpstatement.bindColumn(13, idx_order_old_service_div);	
	      gpstatement.bindColumn(14, idx_old_group_join_date);	
	      gpstatement.bindColumn(15, idx_old_join_date);	
	      gpstatement.bindColumn(16, idx_old_retire_date);	
	      gpstatement.bindColumn(17, idx_old_gradeup_date);	
	      gpstatement.bindColumn(18, idx_old_levelup_date);	
	      gpstatement.bindColumn(19, idx_old_dept_join_date);	
	      gpstatement.bindColumn(20, idx_old_cost_dept_date);	
	      gpstatement.bindColumn(21, idx_old_layoff_date);	
	      gpstatement.bindColumn(22, idx_old_jobgroup_date);	
	      gpstatement.bindColumn(23, idx_order_old_degree);		      
	 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
	      gpstatement.bindColumn(24, idx_emp_no);
	      stmt.executeUpdate();
	      stmt.close();
		}
   }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>