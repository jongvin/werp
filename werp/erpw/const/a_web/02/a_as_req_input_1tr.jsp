<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("a_as_req_input_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_req_useq = dSet.indexOfColumn("req_useq");
   	int idx_proc_code = dSet.indexOfColumn("proc_code");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_loc_useq = dSet.indexOfColumn("loc_useq");
   	int idx_dong = dSet.indexOfColumn("dong");
   	int idx_ho = dSet.indexOfColumn("ho");
   	int idx_floor = dSet.indexOfColumn("floor");
   	int idx_req_date = dSet.indexOfColumn("req_date");
   	int idx_req_name = dSet.indexOfColumn("req_name");
   	int idx_req_phone = dSet.indexOfColumn("req_phone");
   	int idx_req_desc = dSet.indexOfColumn("req_desc");
   	int idx_code_pos = dSet.indexOfColumn("code_pos");
   	int idx_code_wbs = dSet.indexOfColumn("code_wbs");
   	int idx_code_cat = dSet.indexOfColumn("code_cat");
   	int idx_code_cau = dSet.indexOfColumn("code_cau");
   	int idx_proc_status = dSet.indexOfColumn("proc_status");
   	int idx_plan_visit_date = dSet.indexOfColumn("plan_visit_date");
   	int idx_plan_proc_cat = dSet.indexOfColumn("plan_proc_cat");
   	int idx_plan_proc_date = dSet.indexOfColumn("plan_proc_date");
   	int idx_plan_proc_method = dSet.indexOfColumn("plan_proc_method");
   	int idx_sbcr_useq = dSet.indexOfColumn("sbcr_useq");
   	int idx_sbcr_useq_as = dSet.indexOfColumn("sbcr_useq_as");
   	int idx_sbcr_chrg_name = dSet.indexOfColumn("sbcr_chrg_name");
   	int idx_sbcr_chrg_phone = dSet.indexOfColumn("sbcr_chrg_phone");
   	int idx_res_comp_date = dSet.indexOfColumn("res_comp_date");
   	int idx_res_insu_yn = dSet.indexOfColumn("res_insu_yn");
   	int idx_res_desc = dSet.indexOfColumn("res_desc");
   	int idx_res_cost = dSet.indexOfColumn("res_cost");
   	int idx_res_cost_vat = dSet.indexOfColumn("res_cost_vat");
   	int idx_insert_date = dSet.indexOfColumn("insert_date");
   	int idx_update_date = dSet.indexOfColumn("update_date");
   	int idx_insert_user = dSet.indexOfColumn("insert_user");
   	int idx_update_user = dSet.indexOfColumn("update_user");
   	int idx_attrib1 = dSet.indexOfColumn("attrib1");
   	int idx_attrib2 = dSet.indexOfColumn("attrib2");
   	int idx_prog_st = dSet.indexOfColumn("prog_st");   	
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	String is_plan_visit_date;
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		is_plan_visit_date = rows.getString(idx_plan_visit_date);
		String is_insert_user = rows.getString(idx_insert_user);
		String sSql = "INSERT INTO a_as_req_master ( req_useq," + 
                    "proc_code," + 
                    "dept_code," + 
                    "loc_useq," + 
                    "dong, " +
                    "ho," +
                    "floor," +
                    "req_date," +
                    "req_name," +
                    "req_phone," +
                    "req_desc," +
                    "code_pos," +
                    "code_wbs," +
                    "code_cat," +
                    "code_cau," +
                    "proc_status," +
                    "plan_visit_date," +
                    "plan_proc_cat," +
                    "plan_proc_date," +
                    "plan_proc_method," +
                    "sbcr_useq," +
                    "sbcr_useq_as," +
                    "sbcr_chrg_name," +
                    "sbcr_chrg_phone," +
                    "res_comp_date," +
                    "res_insu_yn," +
                    "res_desc," +
                    "res_cost," +
                    "res_cost_vat," +
                    "insert_date," +
//                    "update_date," +
                    "insert_user," +
//                    "update_user," +
                    "attrib1," +
                    "attrib2," +
                    "prog_st )      ";
      sSql = sSql + " VALUES ( sq_a_as_req_useq.nextval, :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, to_date('" + is_plan_visit_date + "', 'yyyymmddhh24mi'), :16, :17, '1', :18 , :19, :20, :21, :22, :23, :24, :25, :26,  sysdate, (select name from z_authority_user where empno ='" + is_insert_user + "'), :27, :28, '1' ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_proc_code);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_loc_useq);
      gpstatement.bindColumn(4, idx_dong);
      gpstatement.bindColumn(5, idx_ho);
      gpstatement.bindColumn(6, idx_floor);
      gpstatement.bindColumn(7, idx_req_date);
      gpstatement.bindColumn(8, idx_req_name);
      gpstatement.bindColumn(9, idx_req_phone);
      gpstatement.bindColumn(10, idx_req_desc);
      gpstatement.bindColumn(11, idx_code_pos);
      gpstatement.bindColumn(12, idx_code_wbs);
      gpstatement.bindColumn(13, idx_code_cat);
      gpstatement.bindColumn(14, idx_code_cau);
      gpstatement.bindColumn(15, idx_proc_status);
      gpstatement.bindColumn(16, idx_plan_proc_cat);
      gpstatement.bindColumn(17, idx_plan_proc_date);
//      gpstatement.bindColumn(18, idx_plan_proc_method);
      gpstatement.bindColumn(18, idx_sbcr_useq);
      gpstatement.bindColumn(19, idx_sbcr_useq_as);
      gpstatement.bindColumn(20, idx_sbcr_chrg_name);
      gpstatement.bindColumn(21, idx_sbcr_chrg_phone);
      gpstatement.bindColumn(22, idx_res_comp_date);
      gpstatement.bindColumn(23, idx_res_insu_yn);
      gpstatement.bindColumn(24, idx_res_desc);
      gpstatement.bindColumn(25, idx_res_cost);
      gpstatement.bindColumn(26, idx_res_cost_vat);
//      gpstatement.bindColumn(28, idx_insert_date);
//      gpstatement.bindColumn(28, idx_update_date);
//      gpstatement.bindColumn(28, idx_insert_user);
//      gpstatement.bindColumn(30, idx_update_user);
      gpstatement.bindColumn(27, idx_attrib1);
      gpstatement.bindColumn(28, idx_attrib2);
      
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
 		is_plan_visit_date = rows.getString(idx_plan_visit_date);
      String sSql = "update a_as_req_master set " + 
                          "proc_code=?," + 
		                    "dept_code=?," + 
		                    "loc_useq=?," + 
		                    "dong=?, " +
		                    "ho=?," +
		                    "floor=?," +
		                    "req_date=?," +
		                    "req_name=?," +
		                    "req_phone=?," +
		                    "req_desc=?," +
		                    "code_pos=?," +
		                    "code_wbs=?," +
		                    "code_cat=?," +
		                    "code_cau=?," +
		                    "proc_status=?," +
		                    "plan_visit_date= TO_DATE('" + is_plan_visit_date + "','YYYYmmddHH24mi'), " +
		                    "update_date=sysdate, " +
		                    "update_user= (select name from z_authority_user where empno = ?) " +
		                    "where req_useq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_proc_code);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_loc_useq);
      gpstatement.bindColumn(4, idx_dong);
      gpstatement.bindColumn(5, idx_ho);
      gpstatement.bindColumn(6, idx_floor);
      gpstatement.bindColumn(7, idx_req_date);
      gpstatement.bindColumn(8, idx_req_name);
      gpstatement.bindColumn(9, idx_req_phone);
      gpstatement.bindColumn(10, idx_req_desc);
      gpstatement.bindColumn(11, idx_code_pos);
      gpstatement.bindColumn(12, idx_code_wbs);
      gpstatement.bindColumn(13, idx_code_cat);
      gpstatement.bindColumn(14, idx_code_cau);
      gpstatement.bindColumn(15, idx_proc_status);
      gpstatement.bindColumn(16, idx_update_user);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
 		gpstatement.bindColumn(17, idx_req_useq); 
		stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from a_as_req_master where req_useq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_req_useq); 
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>