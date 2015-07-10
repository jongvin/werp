<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_empno_new_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_emp_name = dSet.indexOfColumn("emp_name");
   	int idx_resident_no = dSet.indexOfColumn("resident_no");   	
   	int idx_b_emp_no = dSet.indexOfColumn("b_emp_no");
   	int idx_b_regist_date = dSet.indexOfColumn("b_regist_date");
   	int idx_c_emp_no = dSet.indexOfColumn("c_emp_no");
   	int idx_c_user_id = dSet.indexOfColumn("c_user_id");
   	int idx_c_password = dSet.indexOfColumn("c_password");
   	int idx_c_name = dSet.indexOfColumn("c_name");
   	int idx_c_dept_code = dSet.indexOfColumn("c_dept_code");
   	int idx_ins_tag = dSet.indexOfColumn("ins_tag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
		if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
			
			/* 권한테이블에 데이터가 있는 경우 마스터에만 Insert함 
	 		String str_yn;	      
	 		str_yn = rows.getString(idx_ins_tag);
	      if (str_yn.equals("Y")) {
            String sSql = " INSERT INTO z_authority_user ( empno," + 
		                    "user_id, password, name, dept_code )      ";
		      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
		      stmt = conn.prepareStatement(sSql);
		      gpstatement.gp_stmt = stmt;
		      gpstatement.bindColumn(1, idx_c_emp_no);
		      gpstatement.bindColumn(2, idx_c_user_id);
		      gpstatement.bindColumn(3, idx_c_password);
		      gpstatement.bindColumn(4, idx_c_name);
		      gpstatement.bindColumn(5, idx_c_dept_code);
		      stmt.executeUpdate();
		      stmt.close();  
		   }
		   */ 
			String sSql = " INSERT INTO p_pers_master ( emp_no," + 
	                    "emp_name, resident_no )      ";
	      sSql = sSql + " VALUES ( :1, :2, :3 ) ";
	      stmt = conn.prepareStatement(sSql);
	      gpstatement.gp_stmt = stmt;
	      gpstatement.bindColumn(1, idx_emp_no);
	      gpstatement.bindColumn(2, idx_emp_name);
	      gpstatement.bindColumn(3, idx_resident_no);
	      stmt.executeUpdate();
	      stmt.close();
	 		
	 		sSql = " INSERT INTO p_pers_last_empno ( emp_no," + 
	                    "regist_date )      ";
	      sSql = sSql + " VALUES ( :1, :2 ) ";
	      stmt = conn.prepareStatement(sSql);
	      gpstatement.gp_stmt = stmt;
	      gpstatement.bindColumn(1, idx_b_emp_no);
	      gpstatement.bindColumn(2, idx_b_regist_date);
	      stmt.executeUpdate();
	      stmt.close();
	            
     }
   }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>