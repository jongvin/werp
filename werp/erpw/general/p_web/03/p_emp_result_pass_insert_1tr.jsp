<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_emp_result_pass_insert_1tr");
     gpstatement.gp_dataset = dSet;
     int idx_emp_no = dSet.indexOfColumn("emp_no");
     int idx_resident_no = dSet.indexOfColumn("appl_no");
     int idx_emp_name = dSet.indexOfColumn("appl_name");
     int idx_b_regist_date = dSet.indexOfColumn("b_regist_date");
     int idx_tag = dSet.indexOfColumn("tag");     
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
		if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
			String str_yn;	      
		 		
	 		str_yn = rows.getString(idx_tag);
	      if (str_yn.equals("Y")) {
					String sSql = " INSERT INTO p_pers_master ( emp_no," + 
			                    " emp_name, resident_no )      ";
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
			      gpstatement.bindColumn(1, idx_emp_no);      
			      gpstatement.bindColumn(2, idx_b_regist_date);
			      stmt.executeUpdate();
	      		stmt.close();
			}
	   }
  }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>