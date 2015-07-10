<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     	GauceDataSet mSet = req.getGauceDataSet("p_master_1tr");
		if (mSet != null) {
			gpstatement.gp_dataset = mSet;
			int idx_resident_no = mSet.indexOfColumn("resident_no");
			int idx_sex_div = mSet.indexOfColumn("sex");
			int idx_zip_code = mSet.indexOfColumn("zip");
			int idx_addr1 = mSet.indexOfColumn("addr1");
			int idx_addr2 = mSet.indexOfColumn("addr2");
			int idx_born_addr1 = mSet.indexOfColumn("origin_addr1");
			int idx_house_phone = mSet.indexOfColumn("tel");
			int idx_cell_phone = mSet.indexOfColumn("pcs");
			int idx_married_yn = mSet.indexOfColumn("marriage");
			int idx_birthday = mSet.indexOfColumn("birth");
			int idx_lunar_solar = mSet.indexOfColumn("birth_sl");
			int  rowCnt = mSet.getDataRowCnt();
			for(int i=0; i< rowCnt; i++){
			 	GauceDataRow rows = mSet.getDataRow(i);
			 	gpstatement.gp_row = i;
			 	
				if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
					String sSql = " INSERT INTO p_pers_address ( resident_no," + 
			                    "sex_div,  " +
			                    "zip_code,  " +
			                    "addr1,  " +
			                    "addr2,  " +
			                    "born_addr1,  " +
			                    "house_phone,  " +
			                    "cell_phone,  " +
			                    "married_yn,  " +
			                    "birthday,  " +
			                    "lunar_solar )      ";
			      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, TO_DATE(:10,'yyyy.mm.dd'), :11 ) ";
			      stmt = conn.prepareStatement(sSql); 
			      gpstatement.gp_stmt = stmt;
			      gpstatement.bindColumn(1, idx_resident_no);      
			      gpstatement.bindColumn(2, idx_sex_div);
			      gpstatement.bindColumn(3, idx_zip_code);
			      gpstatement.bindColumn(4, idx_addr1);
			      gpstatement.bindColumn(5, idx_addr2);
			      gpstatement.bindColumn(6, idx_born_addr1);
			      gpstatement.bindColumn(7, idx_house_phone);
			      gpstatement.bindColumn(8, idx_cell_phone);
			      gpstatement.bindColumn(9, idx_married_yn);
			      gpstatement.bindColumn(10, idx_birthday);
			      gpstatement.bindColumn(11, idx_lunar_solar);
			      stmt.executeUpdate();
					stmt.close();   
					mSet.flush();
			   }
			}
		}
		
		GauceDataSet sSet = req.getGauceDataSet("p_school_1tr");
		if (sSet != null) {
			gpstatement.gp_dataset = sSet;
			int idx_resident_no = sSet.indexOfColumn("resident_no");
			int idx_spec_no_seq = sSet.indexOfColumn("spec_no_seq");
			int idx_seq = sSet.indexOfColumn("seq");
			int idx_school_car_code = sSet.indexOfColumn("code2");
			int idx_school_name = sSet.indexOfColumn("school_name");
			int idx_location = sSet.indexOfColumn("school_location");
			int idx_major_code = sSet.indexOfColumn("major");
			int  rowCnt = sSet.getDataRowCnt();
			for(int i=0; i< rowCnt; i++){
			 	GauceDataRow rows = sSet.getDataRow(i);
			 	gpstatement.gp_row = i;
			 	
				if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
					String sSql = " INSERT INTO p_pers_school_car ( resident_no," + 
			                    "spec_no_seq,  " +
			                    "seq,  " +
			                    "school_car_code,  " +
			                    "school_name,  " +
			                    "location,  " +
			                    "major_code )      ";
			      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
			      stmt = conn.prepareStatement(sSql); 
			      gpstatement.gp_stmt = stmt;
			      gpstatement.bindColumn(1, idx_resident_no); 
			      gpstatement.bindColumn(2, idx_spec_no_seq);
			      gpstatement.bindColumn(3, idx_seq);
			      gpstatement.bindColumn(4, idx_school_car_code);
			      gpstatement.bindColumn(5, idx_school_name);
			      gpstatement.bindColumn(6, idx_location);
			      gpstatement.bindColumn(7, idx_major_code);
			      stmt.executeUpdate();
					stmt.close();  	
					sSet.flush();				
			   }
			}
		}
		
		GauceDataSet cSet = req.getGauceDataSet("p_career_1tr");
		if (cSet != null) {
			gpstatement.gp_dataset = cSet;
			int idx_resident_no = cSet.indexOfColumn("resident_no");
			int idx_spec_no_seq = cSet.indexOfColumn("spec_no_seq");
			int idx_seq = cSet.indexOfColumn("seq");
			int idx_comp_name = cSet.indexOfColumn("co_name");
			int idx_duty = cSet.indexOfColumn("depart");
			int idx_grade = cSet.indexOfColumn("jikwi");
			int  rowCnt = cSet.getDataRowCnt();
			for(int i=0; i< rowCnt; i++){
			 	GauceDataRow rows = cSet.getDataRow(i);
			 	gpstatement.gp_row = i;
			 	
				if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
					String sSql = " INSERT INTO p_pers_career ( resident_no," + 
			                    "spec_no_seq,  " +
			                    "seq,  " +
			                    "comp_name,  " +
			                    "duty,  " +
			                    "grade )      ";
			      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
			      stmt = conn.prepareStatement(sSql); 
			      gpstatement.gp_stmt = stmt;
			      gpstatement.bindColumn(1, idx_resident_no); 
			      gpstatement.bindColumn(2, idx_spec_no_seq);
			      gpstatement.bindColumn(3, idx_seq);
			      gpstatement.bindColumn(4, idx_comp_name);
			      gpstatement.bindColumn(5, idx_duty);
			      gpstatement.bindColumn(6, idx_grade);
			      stmt.executeUpdate();
					stmt.close();   
					cSet.flush();
			   }
			}
		}
		
		GauceDataSet dSet = req.getGauceDataSet("p_family_1tr");
		if (dSet != null) {
			gpstatement.gp_dataset = dSet;
			int idx_resident_no = dSet.indexOfColumn("resident_no");
			int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
			int idx_seq = dSet.indexOfColumn("seq");
			int idx_relation_code = dSet.indexOfColumn("code2");
			int idx_family_name = dSet.indexOfColumn("name");
			int  rowCnt = dSet.getDataRowCnt();
			for(int i=0; i< rowCnt; i++){
			 	GauceDataRow rows = dSet.getDataRow(i);
			 	gpstatement.gp_row = i;
			 	
				if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
					String sSql = " INSERT INTO p_pers_family ( resident_no," + 
			                    "spec_no_seq ,  " +
			                    "seq,  " +
			                    "relation_code,  " +
			                    "family_name )      ";
			      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
			      stmt = conn.prepareStatement(sSql); 
			      gpstatement.gp_stmt = stmt;
			      gpstatement.bindColumn(1, idx_resident_no); 
			      gpstatement.bindColumn(2, idx_spec_no_seq);
			      gpstatement.bindColumn(3, idx_seq);
			      gpstatement.bindColumn(4, idx_relation_code);
			      gpstatement.bindColumn(5, idx_family_name);;
			      stmt.executeUpdate();
					stmt.close();   
			   }
			}
		}
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>