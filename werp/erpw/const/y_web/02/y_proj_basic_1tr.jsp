<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("y_proj_basic_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_long_name = dSet.indexOfColumn("long_name");
   	int idx_short_name = dSet.indexOfColumn("short_name");
   	int idx_english_name = dSet.indexOfColumn("english_name");
   	int idx_dept_seq_key = dSet.indexOfColumn("dept_seq_key");
   	int idx_dept_level_code = dSet.indexOfColumn("dept_level_code");
   	int idx_high_dept_code = dSet.indexOfColumn("high_dept_code");
   	int idx_dept_proj_tag = dSet.indexOfColumn("dept_proj_tag");
   	int idx_use_tag = dSet.indexOfColumn("use_tag");
   	int idx_home_foreign_tag = dSet.indexOfColumn("home_foreign_tag");
   	int idx_proj_name = dSet.indexOfColumn("proj_name");
   	int idx_process_code = dSet.indexOfColumn("process_code");
   	int idx_zipcode = dSet.indexOfColumn("zipcode");
   	int idx_proj_addr1 = dSet.indexOfColumn("proj_addr1");
   	int idx_proj_addr2 = dSet.indexOfColumn("proj_addr2");
   	int idx_proj_tel = dSet.indexOfColumn("proj_tel");
   	int idx_main_pos = dSet.indexOfColumn("main_pos");
   	int idx_main_charge = dSet.indexOfColumn("main_charge");
   	int idx_proj_pos = dSet.indexOfColumn("proj_pos");
   	int idx_proj_charge = dSet.indexOfColumn("proj_charge");
   	int idx_contract_date = dSet.indexOfColumn("contract_date");
   	int idx_chg_contract_date1 = dSet.indexOfColumn("chg_contract_date1");
   	int idx_last_degree = dSet.indexOfColumn("last_degree");
   	int idx_receive_code = dSet.indexOfColumn("receive_code");
   	int idx_owner = dSet.indexOfColumn("owner");
   	int idx_designer = dSet.indexOfColumn("designer");
   	int idx_supervisor = dSet.indexOfColumn("supervisor");
   	int idx_const_class = dSet.indexOfColumn("const_class");
   	int idx_constkind_tag = dSet.indexOfColumn("constkind_tag");
   	int idx_const_tag = dSet.indexOfColumn("const_tag");
   	int idx_const_rate = dSet.indexOfColumn("const_rate");
   	int idx_tax_rate = dSet.indexOfColumn("tax_rate");
   	int idx_free_rate = dSet.indexOfColumn("free_rate");
   	int idx_cnt_amt1 = dSet.indexOfColumn("cnt_amt1");
   	int idx_exe_amt1 = dSet.indexOfColumn("exe_amt1");
   	int idx_exe_rate1 = dSet.indexOfColumn("exe_rate1");
   	int idx_work_rate = dSet.indexOfColumn("work_rate");
   	int idx_const_start_date = dSet.indexOfColumn("const_start_date");
   	int idx_const_end_date = dSet.indexOfColumn("const_end_date");
   	int idx_const_term = dSet.indexOfColumn("const_term");
   	int idx_chg_const_start_date = dSet.indexOfColumn("chg_const_start_date");
   	int idx_chg_const_end_date = dSet.indexOfColumn("chg_const_end_date");
   	int idx_chg_const_term = dSet.indexOfColumn("chg_const_term");
   	int idx_guarantee_fault1 = dSet.indexOfColumn("guarantee_fault1");
   	int idx_guarantee_fault2 = dSet.indexOfColumn("guarantee_fault2");
   	int idx_area_pyung = dSet.indexOfColumn("area_pyung");
   	int idx_ground_area = dSet.indexOfColumn("ground_area");
   	int idx_build_area = dSet.indexOfColumn("build_area");
   	int idx_gross_floor_area_sum = dSet.indexOfColumn("gross_floor_area_sum");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_floor = dSet.indexOfColumn("floor");
   	int idx_py_cnt = dSet.indexOfColumn("py_cnt");
   	int idx_tot_cnt = dSet.indexOfColumn("tot_cnt");
   	int idx_dong_cnt = dSet.indexOfColumn("dong_cnt");
   	int idx_region_code = dSet.indexOfColumn("region_code");
   	int idx_ground_floor_area = dSet.indexOfColumn("ground_floor_area");
   	int idx_building_ratio = dSet.indexOfColumn("building_ratio");
   	int idx_volunetric_ratio = dSet.indexOfColumn("volunetric_ratio");
   	int idx_building_use = dSet.indexOfColumn("building_use");
   	int idx_complete_date = dSet.indexOfColumn("complete_date");
   	int idx_vattag = dSet.indexOfColumn("vattag");
   	int idx_test_exeamt = dSet.indexOfColumn("test_exeamt");
   	int idx_goal_const_st = dSet.indexOfColumn("goal_const_st");
   	int idx_goal_const_ed = dSet.indexOfColumn("goal_const_ed");
   	int idx_goal_const_term = dSet.indexOfColumn("goal_const_term");
   	int idx_class_tag = dSet.indexOfColumn("class_tag");
	int idx_area_pyung_m = dSet.indexOfColumn("area_pyung_m");
   	int idx_ground_area_m = dSet.indexOfColumn("ground_area_m");
   	int idx_build_area_m = dSet.indexOfColumn("build_area_m");
   	int idx_gross_floor_area_sum_m = dSet.indexOfColumn("gross_floor_area_sum_m");
	int idx_ground_floor_area_m = dSet.indexOfColumn("ground_floor_area_m");
	int idx_delay_rate = dSet.indexOfColumn("delay_rate");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO Z_CODE_DEPT ( dept_code," + 
                    "comp_code," + 
                    "long_name," + 
                    "short_name," + 
                    "english_name," + 
                    "dept_seq_key," + 
                    "dept_level_code," + 
                    "high_dept_code," + 
                    "dept_proj_tag," + 
                    "use_tag," + 
                    "home_foreign_tag," + 
                    "proj_name," + 
                    "process_code," + 
                    "zipcode," + 
                    "proj_addr1," + 
                    "proj_addr2," + 
                    "proj_tel," + 
                    "main_pos," + 
                    "main_charge," + 
                    "proj_pos," + 
                    "proj_charge," + 
                    "contract_date," + 
                    "chg_contract_date1," + 
                    "last_degree," + 
                    "receive_code," + 
                    "owner," + 
                    "designer," + 
                    "supervisor," + 
                    "const_class," + 
                    "constkind_tag," + 
                    "const_tag," + 
                    "const_rate," + 
                    "tax_rate," + 
                    "free_rate," + 
                    "cnt_amt1," + 
                    "exe_amt1," + 
                    "exe_rate1," + 
                    "work_rate," + 
                    "const_start_date," + 
                    "const_end_date," + 
                    "const_term," + 
                    "chg_const_start_date," + 
                    "chg_const_end_date," + 
                    "chg_const_term," + 
                    "guarantee_fault1," + 
                    "guarantee_fault2," + 
                    "area_pyung," + 
                    "ground_area," + 
                    "build_area," + 
                    "gross_floor_area_sum," + 
                    "remark, " +
                    "floor, " +
                    "py_cnt, " + 
                    "tot_cnt, " +
                    "dong_cnt, " +
                    "region_code, " +
                    "ground_floor_area, " + 
                    "building_ratio, " + 
                    "volunetric_ratio, " + 
                    "building_use, " +
                    "complete_date, " +
                    "vattag, " +
                    "test_exeamt, " +
                    "goal_const_st, " +
                    "goal_const_ed, " +
                    "goal_const_term, " +
                    "class_tag, "+
			        " area_pyung_m, "+
			        " ground_area_m, "+
					" build_area_m, "+
					" gross_floor_area_sum_m, "+
			        " ground_floor_area_m,"+
					" delay_rate)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, :31, :32, :33, :34, :35, :36, :37, :38, :39, :40, :41, :42, :43, :44, :45, :46, :47, :48, :49, :50, :51, :52, :53, :54, :55, :56, :57, :58, :59, :60, :61,:62, :63, :64, :65, :66, :67, :68, :69, :70, :71, :72, :73 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_comp_code);
      gpstatement.bindColumn(3, idx_long_name);
      gpstatement.bindColumn(4, idx_short_name);
      gpstatement.bindColumn(5, idx_english_name);
      gpstatement.bindColumn(6, idx_dept_seq_key);
      gpstatement.bindColumn(7, idx_dept_level_code);
      gpstatement.bindColumn(8, idx_high_dept_code);
      gpstatement.bindColumn(9, idx_dept_proj_tag);
      gpstatement.bindColumn(10, idx_use_tag);
      gpstatement.bindColumn(11, idx_home_foreign_tag);
      gpstatement.bindColumn(12, idx_proj_name);
      gpstatement.bindColumn(13, idx_process_code);
      gpstatement.bindColumn(14, idx_zipcode);
      gpstatement.bindColumn(15, idx_proj_addr1);
      gpstatement.bindColumn(16, idx_proj_addr2);
      gpstatement.bindColumn(17, idx_proj_tel);
      gpstatement.bindColumn(18, idx_main_pos);
      gpstatement.bindColumn(19, idx_main_charge);
      gpstatement.bindColumn(20, idx_proj_pos);
      gpstatement.bindColumn(21, idx_proj_charge);
      gpstatement.bindColumn(22, idx_contract_date);
      gpstatement.bindColumn(23, idx_chg_contract_date1);
      gpstatement.bindColumn(24, idx_last_degree);
      gpstatement.bindColumn(25, idx_receive_code);
      gpstatement.bindColumn(26, idx_owner);
      gpstatement.bindColumn(27, idx_designer);
      gpstatement.bindColumn(28, idx_supervisor);
      gpstatement.bindColumn(29, idx_const_class);
      gpstatement.bindColumn(30, idx_constkind_tag);
      gpstatement.bindColumn(31, idx_const_tag);
      gpstatement.bindColumn(32, idx_const_rate);
      gpstatement.bindColumn(33, idx_tax_rate);
      gpstatement.bindColumn(34, idx_free_rate);
      gpstatement.bindColumn(35, idx_cnt_amt1);
      gpstatement.bindColumn(36, idx_exe_amt1);
      gpstatement.bindColumn(37, idx_exe_rate1);
      gpstatement.bindColumn(38, idx_work_rate);
      gpstatement.bindColumn(39, idx_const_start_date);
      gpstatement.bindColumn(40, idx_const_end_date);
      gpstatement.bindColumn(41, idx_const_term);
      gpstatement.bindColumn(42, idx_chg_const_start_date);
      gpstatement.bindColumn(43, idx_chg_const_end_date);
      gpstatement.bindColumn(44, idx_chg_const_term);
      gpstatement.bindColumn(45, idx_guarantee_fault1);
      gpstatement.bindColumn(46, idx_guarantee_fault2);
      gpstatement.bindColumn(47, idx_area_pyung);
      gpstatement.bindColumn(48, idx_ground_area);
      gpstatement.bindColumn(49, idx_build_area);
      gpstatement.bindColumn(50, idx_gross_floor_area_sum);
      gpstatement.bindColumn(51, idx_remark);
      gpstatement.bindColumn(52, idx_floor);
      gpstatement.bindColumn(53, idx_py_cnt);
      gpstatement.bindColumn(54, idx_tot_cnt);
      gpstatement.bindColumn(55, idx_dong_cnt);
      gpstatement.bindColumn(56, idx_region_code);
      gpstatement.bindColumn(57, idx_ground_floor_area);
      gpstatement.bindColumn(58, idx_building_ratio);
      gpstatement.bindColumn(59, idx_volunetric_ratio);
      gpstatement.bindColumn(60, idx_building_use);
      gpstatement.bindColumn(61, idx_complete_date);
      gpstatement.bindColumn(62, idx_vattag);
      gpstatement.bindColumn(63, idx_test_exeamt);
      gpstatement.bindColumn(64, idx_goal_const_st);
      gpstatement.bindColumn(65, idx_goal_const_ed);
      gpstatement.bindColumn(66, idx_goal_const_term);
      gpstatement.bindColumn(67, idx_class_tag);
	  gpstatement.bindColumn(68, idx_area_pyung_m);
   	  gpstatement.bindColumn(69, idx_ground_area_m);
	  gpstatement.bindColumn(70, idx_build_area_m);
      gpstatement.bindColumn(71, idx_gross_floor_area_sum_m);
	  gpstatement.bindColumn(72, idx_ground_floor_area_m);
	  gpstatement.bindColumn(73, idx_delay_rate);
	  
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_code_dept set " + 
                            "dept_code=?,  " + 
                            "comp_code=?,  " + 
                            "long_name=?,  " + 
                            "short_name=?,  " + 
                            "english_name=?,  " + 
                            "dept_seq_key=?,  " + 
                            "dept_level_code=?,  " + 
                            "high_dept_code=?,  " + 
                            "dept_proj_tag=?,  " + 
                            "use_tag=?,  " + 
                            "home_foreign_tag=?,  " + 
                            "proj_name=?,  " + 
                            "process_code=?,  " + 
                            "zipcode=?,  " + 
                            "proj_addr1=?,  " + 
                            "proj_addr2=?,  " + 
                            "proj_tel=?,  " + 
                            "main_pos=?,  " + 
                            "main_charge=?,  " + 
                            "proj_pos=?,  " + 
                            "proj_charge=?,  " + 
                            "contract_date=?,  " + 
                            "chg_contract_date1=?,  " + 
                            "last_degree=?,  " + 
                            "receive_code=?,  " + 
                            "owner=?,  " + 
                            "designer=?,  " + 
                            "supervisor=?,  " + 
                            "const_class=?,  " + 
                            "constkind_tag=?,  " + 
                            "const_tag=?,  " + 
                            "const_rate=?,  " + 
                            "tax_rate=?,  " + 
                            "free_rate=?,  " + 
                            "cnt_amt1=?,  " + 
                            "exe_amt1=?,  " + 
                            "exe_rate1=?,  " + 
                            "work_rate=?,  " + 
                            "const_start_date=?,  " + 
                            "const_end_date=?,  " + 
                            "const_term=?,  " + 
                            "chg_const_start_date=?,  " + 
                            "chg_const_end_date=?,  " + 
                            "chg_const_term=?,  " + 
                            "guarantee_fault1=?,  " + 
                            "guarantee_fault2=?,  " + 
                            "area_pyung=?,  " + 
                            "ground_area=?,  " + 
                            "build_area=?,  " + 
                            "gross_floor_area_sum=?,  " + 
                            "remark=?, " +
                            "floor=?, " +
                            "py_cnt=?, " +
                            "tot_cnt=?, " +
                            "dong_cnt=?, " +
                            "region_code=?, " +
                            "ground_floor_area=?, " + 
                            "building_ratio=?, " + 
                            "volunetric_ratio=?, " + 
                            "building_use=?, " +
                            "complete_date=?, " +
                            "vattag=?, " +
                            "test_exeamt=?, " +
                            "goal_const_st=?, " +
                            "goal_const_ed=?, " +
                            "goal_const_term=?, " +
                            "class_tag=?, " +
							" area_pyung_m=?, "+
			        " ground_area_m=?, "+
					" build_area_m=?, "+
					" gross_floor_area_sum_m=?, "+
					" ground_floor_area_m=?, "+
					" delay_rate=? "+
									 " where dept_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_comp_code);
      gpstatement.bindColumn(3, idx_long_name);
      gpstatement.bindColumn(4, idx_short_name);
      gpstatement.bindColumn(5, idx_english_name);
      gpstatement.bindColumn(6, idx_dept_seq_key);
      gpstatement.bindColumn(7, idx_dept_level_code);
      gpstatement.bindColumn(8, idx_high_dept_code);
      gpstatement.bindColumn(9, idx_dept_proj_tag);
      gpstatement.bindColumn(10, idx_use_tag);
      gpstatement.bindColumn(11, idx_home_foreign_tag);
      gpstatement.bindColumn(12, idx_proj_name);
      gpstatement.bindColumn(13, idx_process_code);
      gpstatement.bindColumn(14, idx_zipcode);
      gpstatement.bindColumn(15, idx_proj_addr1);
      gpstatement.bindColumn(16, idx_proj_addr2);
      gpstatement.bindColumn(17, idx_proj_tel);
      gpstatement.bindColumn(18, idx_main_pos);
      gpstatement.bindColumn(19, idx_main_charge);
      gpstatement.bindColumn(20, idx_proj_pos);
      gpstatement.bindColumn(21, idx_proj_charge);
      gpstatement.bindColumn(22, idx_contract_date);
      gpstatement.bindColumn(23, idx_chg_contract_date1);
      gpstatement.bindColumn(24, idx_last_degree);
      gpstatement.bindColumn(25, idx_receive_code);
      gpstatement.bindColumn(26, idx_owner);
      gpstatement.bindColumn(27, idx_designer);
      gpstatement.bindColumn(28, idx_supervisor);
      gpstatement.bindColumn(29, idx_const_class);
      gpstatement.bindColumn(30, idx_constkind_tag);
      gpstatement.bindColumn(31, idx_const_tag);
      gpstatement.bindColumn(32, idx_const_rate);
      gpstatement.bindColumn(33, idx_tax_rate);
      gpstatement.bindColumn(34, idx_free_rate);
      gpstatement.bindColumn(35, idx_cnt_amt1);
      gpstatement.bindColumn(36, idx_exe_amt1);
      gpstatement.bindColumn(37, idx_exe_rate1);
      gpstatement.bindColumn(38, idx_work_rate);
      gpstatement.bindColumn(39, idx_const_start_date);
      gpstatement.bindColumn(40, idx_const_end_date);
      gpstatement.bindColumn(41, idx_const_term);
      gpstatement.bindColumn(42, idx_chg_const_start_date);
      gpstatement.bindColumn(43, idx_chg_const_end_date);
      gpstatement.bindColumn(44, idx_chg_const_term);
      gpstatement.bindColumn(45, idx_guarantee_fault1);
      gpstatement.bindColumn(46, idx_guarantee_fault2);
      gpstatement.bindColumn(47, idx_area_pyung);
      gpstatement.bindColumn(48, idx_ground_area);
      gpstatement.bindColumn(49, idx_build_area);
      gpstatement.bindColumn(50, idx_gross_floor_area_sum);
      gpstatement.bindColumn(51, idx_remark);
      gpstatement.bindColumn(52, idx_floor);
      gpstatement.bindColumn(53, idx_py_cnt);
      gpstatement.bindColumn(54, idx_tot_cnt);
      gpstatement.bindColumn(55, idx_dong_cnt);
      gpstatement.bindColumn(56, idx_region_code);
      gpstatement.bindColumn(57, idx_ground_floor_area);
      gpstatement.bindColumn(58, idx_building_ratio);
      gpstatement.bindColumn(59, idx_volunetric_ratio);
      gpstatement.bindColumn(60, idx_building_use);
      gpstatement.bindColumn(61, idx_complete_date);
      gpstatement.bindColumn(62, idx_vattag);
      gpstatement.bindColumn(63, idx_test_exeamt);
      gpstatement.bindColumn(64, idx_goal_const_st);
      gpstatement.bindColumn(65, idx_goal_const_ed);
      gpstatement.bindColumn(66, idx_goal_const_term);
      gpstatement.bindColumn(67, idx_class_tag);
	  gpstatement.bindColumn(68, idx_area_pyung_m);
   	  gpstatement.bindColumn(69, idx_ground_area_m);
	  gpstatement.bindColumn(70, idx_build_area_m);
      gpstatement.bindColumn(71, idx_gross_floor_area_sum_m);
	  gpstatement.bindColumn(72, idx_ground_floor_area_m);
	  gpstatement.bindColumn(73, idx_delay_rate);
/* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(74, idx_dept_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_code_dept where dept_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>