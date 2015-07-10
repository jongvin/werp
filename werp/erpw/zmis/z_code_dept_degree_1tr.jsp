<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_code_dept_degree_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_degree = dSet.indexOfColumn("degree");
   	int idx_apply_date = dSet.indexOfColumn("apply_date");
   	int idx_work_date = dSet.indexOfColumn("work_date");
   	int idx_request_date = dSet.indexOfColumn("request_date");
   	int idx_approve_date = dSet.indexOfColumn("approve_date");
   	int idx_title = dSet.indexOfColumn("title");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO z_code_dept_degree ( degree," + 
                    "apply_date," + 
                    "work_date," + 
                    "request_date," + 
                    "approve_date," + 
                    "title," + 
                    "approve_class )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_degree);
      gpstatement.bindColumn(2, idx_apply_date);
      gpstatement.bindColumn(3, idx_work_date);
      gpstatement.bindColumn(4, idx_request_date);
      gpstatement.bindColumn(5, idx_approve_date);
      gpstatement.bindColumn(6, idx_title);
      gpstatement.bindColumn(7, idx_approve_class);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_code_dept_degree set " + 
                            "degree=?,  " + 
                            "apply_date=?,  " + 
                            "work_date=?,  " + 
                            "request_date=?,  " + 
                            "approve_date=?,  " + 
                            "title=?,  " + 
                            "approve_class=?  where degree=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_degree);
      gpstatement.bindColumn(2, idx_apply_date);
      gpstatement.bindColumn(3, idx_work_date);
      gpstatement.bindColumn(4, idx_request_date);
      gpstatement.bindColumn(5, idx_approve_date);
      gpstatement.bindColumn(6, idx_title);
      gpstatement.bindColumn(7, idx_approve_class);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_degree);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_code_dept_degree where degree=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_degree);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../comm_function/conn_tr_end.jsp"%>