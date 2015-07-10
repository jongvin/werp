<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("e_accident_report_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_key_seq = dSet.indexOfColumn("key_seq");
   	int idx_accident_date = dSet.indexOfColumn("accident_date");
   	int idx_disaster_code = dSet.indexOfColumn("disaster_code");
   	int idx_dr_accident = dSet.indexOfColumn("dr_accident");
   	int idx_dr_solution = dSet.indexOfColumn("dr_solution");
   	int idx_etc = dSet.indexOfColumn("etc");
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_proj_charge = dSet.indexOfColumn("proj_charge");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_dis_cause = dSet.indexOfColumn("dis_cause");
   	int idx_dis_measures = dSet.indexOfColumn("dis_measures");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO e_disaster_report ( dept_code," + 
                    "seq," + 
                    "accident_date," + 
                    "disaster_code," + 
                    "dr_accident," + 
                    "dr_solution," + 
                    "etc," + 
                    "emp_no," + 
                    "proj_charge," + 
                    "remark," +
                    "dis_cause," +
                    "dis_measures )      ";
      sSql = sSql + " VALUES ( :1, :2, to_date(:3,'yyyymmddhh24mi'), :4, :5, :6, :7, :8, :9, :10, :11, :12 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_accident_date);
      gpstatement.bindColumn(4, idx_disaster_code);
      gpstatement.bindColumn(5, idx_dr_accident);
      gpstatement.bindColumn(6, idx_dr_solution);
      gpstatement.bindColumn(7, idx_etc);
      gpstatement.bindColumn(8, idx_emp_no);
      gpstatement.bindColumn(9, idx_proj_charge);
      gpstatement.bindColumn(10, idx_remark);
      gpstatement.bindColumn(11, idx_dis_cause);
      gpstatement.bindColumn(12, idx_dis_measures);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update e_disaster_report set " + 
                            "dept_code=?,  " + 
                            "seq=?,  " + 
                            "accident_date=to_date(?,'yyyymmddhh24mi') ,  " + 
                            "disaster_code=?,  " + 
                            "dr_accident=?,  " + 
                            "dr_solution=?,  " + 
                            "etc=?,  " + 
                            "emp_no=?,  " + 
                            "proj_charge=?,  " + 
                            "remark=?, " +
                            "dis_cause=?, " +
                            "dis_measures=?  where dept_code=? and seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_accident_date);
      gpstatement.bindColumn(4, idx_disaster_code);
      gpstatement.bindColumn(5, idx_dr_accident);
      gpstatement.bindColumn(6, idx_dr_solution);
      gpstatement.bindColumn(7, idx_etc);
      gpstatement.bindColumn(8, idx_emp_no);
      gpstatement.bindColumn(9, idx_proj_charge);
      gpstatement.bindColumn(10, idx_remark);
      gpstatement.bindColumn(11, idx_dis_cause);
      gpstatement.bindColumn(12, idx_dis_measures);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(13, idx_dept_code);
      gpstatement.bindColumn(14, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from e_disaster_report  where dept_code=? and seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>