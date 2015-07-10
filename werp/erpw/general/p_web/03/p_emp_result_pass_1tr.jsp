<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_emp_result_pass_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_employ_degree = dSet.indexOfColumn("employ_degree");
   	int idx_interview_degree = dSet.indexOfColumn("interview_degree");   	
   	int idx_appl_no = dSet.indexOfColumn("appl_no");
   	int idx_last_approval = dSet.indexOfColumn("last_approval");
   	int idx_b_employ_degree = dSet.indexOfColumn("b_employ_degree");	/*응시자테이블*/
   	int idx_b_appl_no = dSet.indexOfColumn("b_appl_no");
   	int idx_b_emp_no = dSet.indexOfColumn("b_emp_no");
   	int idx_b_user_id = dSet.indexOfColumn("b_user_id");
   	int idx_b_last_pass_tag = dSet.indexOfColumn("b_last_pass_tag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_emp_pass set " + 
                            "last_approval=? where employ_degree=? and interview_degree=? and appl_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_last_approval);      
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(2, idx_employ_degree);
      gpstatement.bindColumn(3, idx_interview_degree);
      gpstatement.bindColumn(4, idx_appl_no);
      stmt.executeUpdate();
      stmt.close();
      
      sSql = "update p_emp_applicant set " + 
                            "employ_degree=?,  " + 
                            "appl_no=?,  " + 
                            "emp_no=?,  " + 
                            "user_id=?,  " + 
                            "last_pass_tag=? where employ_degree=? and appl_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_b_employ_degree);
      gpstatement.bindColumn(2, idx_b_appl_no);
      gpstatement.bindColumn(3, idx_b_emp_no);      
      gpstatement.bindColumn(4, idx_b_user_id);  
      gpstatement.bindColumn(5, idx_b_last_pass_tag);  
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_b_employ_degree);
      gpstatement.bindColumn(7, idx_b_appl_no);
      stmt.executeUpdate();
      stmt.close();
    }
   }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>