<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_order_pers_master_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_apply_order_date = dSet.indexOfColumn("apply_order_date");   	
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_cost_dept_code = dSet.indexOfColumn("cost_dept_code");
   	int idx_work_dept_code = dSet.indexOfColumn("work_dept_code");
   	int idx_grade_code = dSet.indexOfColumn("grade_code");
   	int idx_level_code = dSet.indexOfColumn("level_code");
   	int idx_paystep = dSet.indexOfColumn("paystep");
   	int idx_jobgroup_code = dSet.indexOfColumn("jobgroup_code");
   	int idx_jobkind_code = dSet.indexOfColumn("jobkind_code");
   	int idx_title_code = dSet.indexOfColumn("title_code");
   	int idx_duty = dSet.indexOfColumn("duty");
   	int idx_service_div = dSet.indexOfColumn("service_div_code");
   	int idx_group_join_date = dSet.indexOfColumn("group_join_date");
   	int idx_join_date = dSet.indexOfColumn("join_date");
   	int idx_retire_date = dSet.indexOfColumn("retire_date");
   	int idx_gradeup_date = dSet.indexOfColumn("gradeup_date");
   	int idx_levelup_date = dSet.indexOfColumn("levelup_date");
   	int idx_dept_join_date = dSet.indexOfColumn("dept_join_date");
   	int idx_cost_dept_date = dSet.indexOfColumn("cost_dept_date");
   	int idx_layoff_date = dSet.indexOfColumn("layoff_date");
   	int idx_jobgroup_date = dSet.indexOfColumn("jobgroup_date");   	   	
   	int idx_order_comp_code = dSet.indexOfColumn("order_comp_code");
   	int idx_order_dept_code = dSet.indexOfColumn("order_dept_code");
   	int idx_order_cost_dept_code = dSet.indexOfColumn("order_cost_dept_code");
   	int idx_order_work_dept_code = dSet.indexOfColumn("order_work_dept_code");
   	int idx_order_grade_code = dSet.indexOfColumn("order_grade_code");
   	int idx_order_level_code = dSet.indexOfColumn("order_level_code");
   	int idx_order_paystep = dSet.indexOfColumn("order_paystep");
   	int idx_order_jobgroup_code = dSet.indexOfColumn("order_jobgroup_code");
   	int idx_order_jobkind_code = dSet.indexOfColumn("order_jobkind_code");
   	int idx_order_title_code = dSet.indexOfColumn("order_title_code");
   	int idx_order_duty = dSet.indexOfColumn("order_duty");
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
   	int idx_degree = dSet.indexOfColumn("degree");
   	int idx_order_degree = dSet.indexOfColumn("order_degree");
   	int idx_order_code = dSet.indexOfColumn("order_code");
   	int idx_mov_group_join_date = dSet.indexOfColumn("mov_group_join_date");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
		if(rows.getJobType() ==  GauceDataRow.TB_JOB_INSERT){
	 		  // password table에 항상 최종 부서로 update
		      String sSql = "update z_authority_user set " + 
		                            " dept_code=?  where empno=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_order_dept_code);
		      gpstatement.bindColumn(2, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
	 		
	 		/* 그룹입사일 */ 
	 		String str_yn;	      
	 		String str_order_code;
    		str_yn = rows.getString(idx_gjoin_date_yn);
    		str_order_code = rows.getString(idx_order_code);
    		if (str_order_code.equals("13")) {		/* 관계사전입 발령이면 그룹입사일 */
    			sSql = "update p_pers_master set " + 
		                            "group_join_date=?  where emp_no=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_mov_group_join_date);	      
		      gpstatement.bindColumn(2, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
    		}
	      else if (str_yn.equals("T")) {
            sSql = "update p_pers_master set " + 
		                            "group_join_date=?  where emp_no=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_apply_order_date);	      
		      gpstatement.bindColumn(2, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
		   }
		   
		   /* 입사일 */ 
	      str_yn = rows.getString(idx_join_date_yn);
	      if (str_yn.equals("T")) {
		      sSql = "update p_pers_master set " + 
		                            "join_date=?  where emp_no=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_apply_order_date);	      
		      gpstatement.bindColumn(2, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
		      
		      /* 입사면 권한테이블의 근무구분을 'Y'으로 Update */ 
		      sSql = "update z_authority_user set " + 
		                            "using_tag='Y'  where empno=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
	      }
	      
	      /* 휴직일 */ 
	      str_yn = rows.getString(idx_rest_date_yn);
       	if (str_yn.equals("T")) {
            sSql = "update p_pers_master set " + 
		                            "layoff_date=?  where emp_no=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_apply_order_date);	      
		      gpstatement.bindColumn(2, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
	      }
	      
	      /* 복직일 */ 
	      str_yn = rows.getString(idx_reinst_date_yn);
       	if (str_yn.equals("T")) {
            sSql = "update p_pers_master set " + 
		                            "reinst_date=?  where emp_no=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_apply_order_date);	      
		      gpstatement.bindColumn(2, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
	      }
	      
	      /* 퇴사일 */ 
	      str_yn = rows.getString(idx_retire_date_yn);
       	if (str_yn.equals("T")) {
            sSql = "update p_pers_master set " + 
		                            "retire_date=?  where emp_no=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_apply_order_date);	      
		      gpstatement.bindColumn(2, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
		      
		      /* 퇴직이면 권한테이블의 근무구분을 'N'으로 Update */ 
		      sSql = "update z_authority_user set " + 
		                            "using_tag='N'  where empno=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
	      }
	      
	      /* 부서보임일 */ 
	      str_yn = rows.getString(idx_dept_yn);
       	if (str_yn.equals("T")) {
            sSql = "update p_pers_master set " + 
		                            "dept_join_date=?  where emp_no=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_apply_order_date);	      
		      gpstatement.bindColumn(2, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
	      }
	      /* 관계사파견일 */ 
	      str_yn = rows.getString(idx_cost_dept_yn);
       	if (str_yn.equals("T")) {
            sSql = "update p_pers_master set " + 
		                            "cost_dept_date=?  where emp_no=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_apply_order_date);	      
		      gpstatement.bindColumn(2, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
	      }
	      /* 승급일 */ 
	      str_yn = rows.getString(idx_level_yn);
       	if (str_yn.equals("T")) {
            sSql = "update p_pers_master set " + 
		                            "gradeup_date=?  where emp_no=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_apply_order_date);	      
		      gpstatement.bindColumn(2, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
	      }
	      /* 승호일 */ 
	      str_yn = rows.getString(idx_paystep_yn);
       	if (str_yn.equals("T")) {
            sSql = "update p_pers_master set " + 
		                            "levelup_date=?  where emp_no=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_apply_order_date);	      
		      gpstatement.bindColumn(2, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
	      }	      
	      /* 직군갱신일 */ 
	      str_yn = rows.getString(idx_jobgroup_yn);
       	if (str_yn.equals("T")) {
            sSql = "update p_pers_master set " + 
		                            "jobgroup_date=?  where emp_no=? ";  
		      stmt = conn.prepareStatement(sSql); 
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_apply_order_date);	      
		      gpstatement.bindColumn(2, idx_emp_no);
		      stmt.executeUpdate();
		      stmt.close();
	      }
	      
	      /* 관계사전출이면 신규입력된 comp_code,dept_code는 전입대상이 되고 */
	      /*                조회된 comp_code,dept_code는 인사마스터로 update */ 	      
	      /*  취소는 인사마스터의 old_comp_code(발령전 인사마스터를 update한것이므로) 별도 처리 불필요함 */ 	
	      str_order_code = rows.getString(idx_order_code);
    		if (str_order_code.equals("12")) {		/* 관계사전출 발령 */
    			String str_comp_code;
    			idx_order_comp_code = dSet.indexOfColumn("comp_code");
    			idx_order_dept_code = dSet.indexOfColumn("dept_code");
    			idx_order_cost_dept_code = dSet.indexOfColumn("cost_dept_code");
    			idx_order_work_dept_code = dSet.indexOfColumn("work_dept_code");
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
	                            "old_group_join_date=?, " +
	                            "old_join_date=?, " +
	                            "old_retire_date=?, " +
	                            "old_gradeup_date=?, " +
	                            "old_levelup_date=?, " +
	                            "old_dept_join_date=?, " +
	                            "old_cost_dept_date=?, " +
	                            "old_layoff_date=?, " +
	                            "old_jobgroup_date=?, " +
	                            "degree=?  where emp_no=? ";  
	      stmt = conn.prepareStatement(sSql); 
	      gpstatement.gp_stmt = stmt;
	      gpstatement.bindColumn(1, idx_emp_no);
	      gpstatement.bindColumn(2, idx_order_comp_code);
	      gpstatement.bindColumn(3, idx_order_dept_code);
	      gpstatement.bindColumn(4, idx_order_cost_dept_code);
	      gpstatement.bindColumn(5, idx_order_work_dept_code);
	      gpstatement.bindColumn(6, idx_order_grade_code);
	      gpstatement.bindColumn(7, idx_order_level_code);
	      gpstatement.bindColumn(8, idx_order_paystep);
	      gpstatement.bindColumn(9, idx_order_jobgroup_code);
	      gpstatement.bindColumn(10, idx_order_jobkind_code);
	      gpstatement.bindColumn(11, idx_order_title_code);
	      gpstatement.bindColumn(12, idx_order_duty);
	      gpstatement.bindColumn(13, idx_order_service_div);	 
	      gpstatement.bindColumn(14, idx_group_join_date);	
	      gpstatement.bindColumn(15, idx_join_date);	
	      gpstatement.bindColumn(16, idx_retire_date);	
	      gpstatement.bindColumn(17, idx_gradeup_date);	
	      gpstatement.bindColumn(18, idx_levelup_date);	
	      gpstatement.bindColumn(19, idx_dept_join_date);	
	      gpstatement.bindColumn(20, idx_cost_dept_date);	
	      gpstatement.bindColumn(21, idx_layoff_date);	
	      gpstatement.bindColumn(22, idx_jobgroup_date);
	      gpstatement.bindColumn(23, idx_order_degree);
	 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
	      gpstatement.bindColumn(24, idx_emp_no);
	      stmt.executeUpdate();
	      stmt.close();
		}
   }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>