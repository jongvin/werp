<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_staff_into_plan_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_position = dSet.indexOfColumn("position");
   	int idx_jik_jong = dSet.indexOfColumn("jik_jong");
   	int idx_in_plan_date = dSet.indexOfColumn("in_plan_date");
   	int idx_out_plan_date = dSet.indexOfColumn("out_plan_date");
   	int idx_man_month = dSet.indexOfColumn("man_month");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_staff_in_plan ( dept_code," + 
                    "seq," + 					
						  "position," + 			
						  "jik_jong," + 			
						  "in_plan_date," + 
						  "out_plan_date," +  
						  "man_month," +
						  "remark	 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_position);
      gpstatement.bindColumn(4, idx_jik_jong);
      gpstatement.bindColumn(5, idx_in_plan_date);
      gpstatement.bindColumn(6, idx_out_plan_date);
      gpstatement.bindColumn(7, idx_man_month);
      gpstatement.bindColumn(8, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_staff_in_plan set " + 
                    "dept_code=?," +
                    "seq=?," + 					
						  "position=?," + 			
						  "jik_jong=?," + 			
						  "in_plan_date=?," + 
						  "out_plan_date=?," +  
						  "man_month=?," +
						  "remark=?  where dept_code=? and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_position);
      gpstatement.bindColumn(4, idx_jik_jong);
      gpstatement.bindColumn(5, idx_in_plan_date);
      gpstatement.bindColumn(6, idx_out_plan_date);
      gpstatement.bindColumn(7, idx_man_month);
      gpstatement.bindColumn(8, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(9, idx_dept_code);
      gpstatement.bindColumn(10, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_staff_in_plan where dept_code=? and seq=? "; 
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