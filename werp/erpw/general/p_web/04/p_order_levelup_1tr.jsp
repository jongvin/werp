<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_order_levelup_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_work_year = dSet.indexOfColumn("work_year");
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_cur_level = dSet.indexOfColumn("cur_level");
   	int idx_cur_paystep = dSet.indexOfColumn("cur_paystep");
   	int idx_up_level = dSet.indexOfColumn("up_level");
   	int idx_up_paystep = dSet.indexOfColumn("up_paystep");
   	int idx_jobkind_code = dSet.indexOfColumn("jobkind_code");
   	int idx_dept_date = dSet.indexOfColumn("dept_date");
   	int idx_jobgroup_date = dSet.indexOfColumn("jobgroup_date");
   	int idx_last_levelup_date = dSet.indexOfColumn("last_levelup_date");
   	int idx_last_paystep_date = dSet.indexOfColumn("last_paystep_date");
   	int idx_school_career_code = dSet.indexOfColumn("school_career_code");
   	int idx_last_school = dSet.indexOfColumn("last_school");
   	int idx_year_level = dSet.indexOfColumn("year_level");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_order_obj_list ( work_year," + 
                    "emp_no," + 
                    "comp_code," + 
                    "dept_code," + 
                    "cur_level," + 
                    "cur_paystep," + 
                    "up_level," + 
                    "up_paystep," + 
                    "jobkind_code," + 
                    "dept_date," + 
                    "jobgroup_date," + 
                    "last_levelup_date," + 
                    "last_paystep_date," + 
                    "school_career_code," + 
                    "last_school," + 
                    "year_level )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_emp_no);
      gpstatement.bindColumn(3, idx_comp_code);
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_cur_level);
      gpstatement.bindColumn(6, idx_cur_paystep);
      gpstatement.bindColumn(7, idx_up_level);
      gpstatement.bindColumn(8, idx_up_paystep);
      gpstatement.bindColumn(9, idx_jobkind_code);
      gpstatement.bindColumn(10, idx_dept_date);
      gpstatement.bindColumn(11, idx_jobgroup_date);
      gpstatement.bindColumn(12, idx_last_levelup_date);
      gpstatement.bindColumn(13, idx_last_paystep_date);
      gpstatement.bindColumn(14, idx_school_career_code);
      gpstatement.bindColumn(15, idx_last_school);
      gpstatement.bindColumn(16, idx_year_level);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_order_obj_list set " + 
                            "work_year=?,  " + 
                            "emp_no=?,  " + 
                            "comp_code=?,  " + 
                            "dept_code=?,  " + 
                            "cur_level=?,  " + 
                            "cur_paystep=?,  " + 
                            "up_level=?,  " + 
                            "up_paystep=?,  " + 
                            "jobkind_code=?,  " + 
                            "dept_date=?,  " + 
                            "jobgroup_date=?,  " + 
                            "last_levelup_date=?,  " + 
                            "last_paystep_date=?,  " + 
                            "school_career_code=?,  " + 
                            "last_school=?,  " + 
                            "year_level=?  where work_year=? and emp_no=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_emp_no);
      gpstatement.bindColumn(3, idx_comp_code);
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_cur_level);
      gpstatement.bindColumn(6, idx_cur_paystep);
      gpstatement.bindColumn(7, idx_up_level);
      gpstatement.bindColumn(8, idx_up_paystep);
      gpstatement.bindColumn(9, idx_jobkind_code);
      gpstatement.bindColumn(10, idx_dept_date);
      gpstatement.bindColumn(11, idx_jobgroup_date);
      gpstatement.bindColumn(12, idx_last_levelup_date);
      gpstatement.bindColumn(13, idx_last_paystep_date);
      gpstatement.bindColumn(14, idx_school_career_code);
      gpstatement.bindColumn(15, idx_last_school);
      gpstatement.bindColumn(16, idx_year_level);      
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(17, idx_work_year);
      gpstatement.bindColumn(18, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_order_obj_list where work_year=? and emp_no=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_work_year);
      gpstatement.bindColumn(2, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>