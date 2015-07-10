<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_attend_annual_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_work_year = dSet.indexOfColumn("work_year");
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_group_join_date = dSet.indexOfColumn("group_join_date");
   	int idx_join_date = dSet.indexOfColumn("join_date");
   	int idx_annual_day = dSet.indexOfColumn("annual_day");
   	int idx_create_date = dSet.indexOfColumn("create_date");
   	int idx_confirm_tag = dSet.indexOfColumn("confirm_tag");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_grade_code = dSet.indexOfColumn("grade_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_attend_annual ( work_year," + 
                    "resident_no," + 
                    "emp_no," + 
                    "group_join_date," + 
                    "join_date," + 
                    "annual_day," + 
                    "create_date," + 
                    "confirm_tag," + 
                    "comp_code," + 
                    "dept_code," + 
                    "grade_code )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_resident_no);
      gpstatement.bindColumn(3, idx_emp_no);
      gpstatement.bindColumn(4, idx_group_join_date);
      gpstatement.bindColumn(5, idx_join_date);
      gpstatement.bindColumn(6, idx_annual_day);
      gpstatement.bindColumn(7, idx_create_date);
      gpstatement.bindColumn(8, idx_confirm_tag);
      gpstatement.bindColumn(9, idx_comp_code);
      gpstatement.bindColumn(10, idx_dept_code);
      gpstatement.bindColumn(11, idx_grade_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_attend_annual set " + 
                            "work_year=?,  " + 
                            "resident_no=?,  " + 
                            "emp_no=?,  " + 
                            "group_join_date=?,  " + 
                            "join_date=?,  " + 
                            "annual_day=?,  " + 
                            "create_date=?,  " + 
                            "confirm_tag=?,  " + 
                            "comp_code=?,  " + 
                            "dept_code=?,  " + 
                            "grade_code=?  where work_year=? and resident_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_resident_no);
      gpstatement.bindColumn(3, idx_emp_no);
      gpstatement.bindColumn(4, idx_group_join_date);
      gpstatement.bindColumn(5, idx_join_date);
      gpstatement.bindColumn(6, idx_annual_day);
      gpstatement.bindColumn(7, idx_create_date);
      gpstatement.bindColumn(8, idx_confirm_tag);
      gpstatement.bindColumn(9, idx_comp_code);
      gpstatement.bindColumn(10, idx_dept_code);
      gpstatement.bindColumn(11, idx_grade_code);      
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_work_year);
      gpstatement.bindColumn(13, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_attend_annual where work_year=? and resident_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>