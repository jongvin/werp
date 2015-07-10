<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_order_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_order_code = dSet.indexOfColumn("order_code");
   	int idx_order_name = dSet.indexOfColumn("order_name");
   	int idx_service_div = dSet.indexOfColumn("service_div");
   	int idx_join_date_yn = dSet.indexOfColumn("join_date_yn");
   	int idx_rest_date_yn = dSet.indexOfColumn("rest_date_yn");
   	int idx_reinst_date_yn = dSet.indexOfColumn("reinst_date_yn");
   	int idx_retire_date_yn = dSet.indexOfColumn("retire_date_yn");
   	int idx_dept_yn = dSet.indexOfColumn("dept_yn");
   	int idx_work_dept_yn = dSet.indexOfColumn("work_dept_yn");
   	int idx_cost_dept_yn = dSet.indexOfColumn("cost_dept_yn");
   	int idx_add_dept_yn = dSet.indexOfColumn("add_dept_yn");
   	int idx_add_dept_off_yn = dSet.indexOfColumn("add_dept_off_yn");
   	int idx_grade_yn = dSet.indexOfColumn("grade_yn");
   	int idx_level_yn = dSet.indexOfColumn("level_yn");
   	int idx_paystep_yn = dSet.indexOfColumn("paystep_yn");
   	int idx_jobgroup_yn = dSet.indexOfColumn("jobgroup_yn");
   	int idx_jobkind_yn = dSet.indexOfColumn("jobkind_yn");
   	int idx_title_yn = dSet.indexOfColumn("title_yn");
   	int idx_gjoin_date_yn = dSet.indexOfColumn("gjoin_date_yn");
   	int idx_use_yn = dSet.indexOfColumn("use_yn");
   	int idx_sort = dSet.indexOfColumn("sort");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_code_order ( order_code," + 
                    "order_name," + 
                    "service_div," + 
                    "join_date_yn," + 
                    "rest_date_yn," + 
                    "reinst_date_yn," + 
                    "retire_date_yn," + 
                    "dept_yn," + 
                    "work_dept_yn," + 
                    "cost_dept_yn," + 
                    "add_dept_yn," + 
                    "add_dept_off_yn," + 
                    "grade_yn," + 
                    "level_yn," + 
                    "paystep_yn," + 
                    "jobgroup_yn," + 
                    "jobkind_yn," + 
                    "title_yn," + 
                    "gjoin_date_yn," + 
                    "use_yn," + 
                    "sort )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_order_code);
      gpstatement.bindColumn(2, idx_order_name);
      gpstatement.bindColumn(3, idx_service_div);
      gpstatement.bindColumn(4, idx_join_date_yn);
      gpstatement.bindColumn(5, idx_rest_date_yn);
      gpstatement.bindColumn(6, idx_reinst_date_yn);
      gpstatement.bindColumn(7, idx_retire_date_yn);
      gpstatement.bindColumn(8, idx_dept_yn);
      gpstatement.bindColumn(9, idx_work_dept_yn);
      gpstatement.bindColumn(10, idx_cost_dept_yn);
      gpstatement.bindColumn(11, idx_add_dept_yn);
      gpstatement.bindColumn(12, idx_add_dept_off_yn);
      gpstatement.bindColumn(13, idx_grade_yn);
      gpstatement.bindColumn(14, idx_level_yn);
      gpstatement.bindColumn(15, idx_paystep_yn);
      gpstatement.bindColumn(16, idx_jobgroup_yn);
      gpstatement.bindColumn(17, idx_jobkind_yn);
      gpstatement.bindColumn(18, idx_title_yn);
      gpstatement.bindColumn(19, idx_gjoin_date_yn);
      gpstatement.bindColumn(20, idx_use_yn);
      gpstatement.bindColumn(21, idx_sort);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_code_order set " + 
                            "order_code=?,  " + 
                            "order_name=?,  " + 
                            "service_div=?,  " + 
                            "join_date_yn=?,  " + 
                            "rest_date_yn=?,  " + 
                            "reinst_date_yn=?,  " + 
                            "retire_date_yn=?,  " + 
                            "dept_yn=?,  " + 
                            "work_dept_yn=?,  " + 
                            "cost_dept_yn=?,  " + 
                            "add_dept_yn=?,  " + 
                            "add_dept_off_yn=?,  " + 
                            "grade_yn=?,  " + 
                            "level_yn=?,  " + 
                            "paystep_yn=?,  " + 
                            "jobgroup_yn=?,  " + 
                            "jobkind_yn=?,  " + 
                            "title_yn=?,  " + 
                            "gjoin_date_yn=?,  " + 
                            "use_yn=?,  " + 
                            "sort=?  where order_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_order_code);
      gpstatement.bindColumn(2, idx_order_name);
      gpstatement.bindColumn(3, idx_service_div);
      gpstatement.bindColumn(4, idx_join_date_yn);
      gpstatement.bindColumn(5, idx_rest_date_yn);
      gpstatement.bindColumn(6, idx_reinst_date_yn);
      gpstatement.bindColumn(7, idx_retire_date_yn);
      gpstatement.bindColumn(8, idx_dept_yn);
      gpstatement.bindColumn(9, idx_work_dept_yn);
      gpstatement.bindColumn(10, idx_cost_dept_yn);
      gpstatement.bindColumn(11, idx_add_dept_yn);
      gpstatement.bindColumn(12, idx_add_dept_off_yn);
      gpstatement.bindColumn(13, idx_grade_yn);
      gpstatement.bindColumn(14, idx_level_yn);
      gpstatement.bindColumn(15, idx_paystep_yn);
      gpstatement.bindColumn(16, idx_jobgroup_yn);
      gpstatement.bindColumn(17, idx_jobkind_yn);
      gpstatement.bindColumn(18, idx_title_yn);
      gpstatement.bindColumn(19, idx_gjoin_date_yn);
      gpstatement.bindColumn(20, idx_use_yn);
      gpstatement.bindColumn(21, idx_sort);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(22, idx_order_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_code_order where order_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_order_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>