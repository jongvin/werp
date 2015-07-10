<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_staff_into_result_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_emp_name = dSet.indexOfColumn("emp_name");
   	int idx_emp_position = dSet.indexOfColumn("emp_position");
   	int idx_emp_jik_jong = dSet.indexOfColumn("emp_jik_jong");
   	int idx_emp_in_date = dSet.indexOfColumn("emp_in_date");
   	int idx_emp_out_date = dSet.indexOfColumn("emp_out_date");
   	int idx_man_month = dSet.indexOfColumn("man_month");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_staff_in_result ( dept_code," + 
                    "seq," + 						
                    "emp_no," + 					
						  "emp_name," + 					
						  "emp_position," + 			
						  "emp_jik_jong," + 			
						  "emp_in_date," + 
						  "emp_out_date," +  
						  "man_month," +
						  "remark	 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_emp_no);
      gpstatement.bindColumn(4, idx_emp_name);
      gpstatement.bindColumn(5, idx_emp_position);
      gpstatement.bindColumn(6, idx_emp_jik_jong);
      gpstatement.bindColumn(7, idx_emp_in_date);
      gpstatement.bindColumn(8, idx_emp_out_date);
      gpstatement.bindColumn(9, idx_man_month);
      gpstatement.bindColumn(10, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_staff_in_result set " + 
                    "dept_code=?," +
                    "seq=?," + 						
                    "emp_no=?," + 					
						  "emp_name=?," + 					
						  "emp_position=?," + 			
						  "emp_jik_jong=?," + 			
						  "emp_in_date=?," + 
						  "emp_out_date=?," +  
						  "man_month=?," +
						  "remark=?  where dept_code=? and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_emp_no);
      gpstatement.bindColumn(4, idx_emp_name);
      gpstatement.bindColumn(5, idx_emp_position);
      gpstatement.bindColumn(6, idx_emp_jik_jong);
      gpstatement.bindColumn(7, idx_emp_in_date);
      gpstatement.bindColumn(8, idx_emp_out_date);
      gpstatement.bindColumn(9, idx_man_month);
      gpstatement.bindColumn(10, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_dept_code);
      gpstatement.bindColumn(12, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_staff_in_result where dept_code=? and seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>