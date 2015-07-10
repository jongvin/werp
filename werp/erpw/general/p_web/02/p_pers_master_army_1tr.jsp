<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_army_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_end_army_code = dSet.indexOfColumn("end_army_code");
   	int idx_ssn = dSet.indexOfColumn("ssn");
   	int idx_kind_army_code = dSet.indexOfColumn("kind_army_code");
   	int idx_arm_code = dSet.indexOfColumn("arm_code");
   	int idx_class_code = dSet.indexOfColumn("class_code");
   	int idx_cmss_code = dSet.indexOfColumn("cmss_code");
   	int idx_discharge_code = dSet.indexOfColumn("discharge_code");
   	int idx_enroll_date = dSet.indexOfColumn("enroll_date");
   	int idx_discharge_date = dSet.indexOfColumn("discharge_date");
   	int idx_s_enroll_date = dSet.indexOfColumn("s_enroll_date");
   	int idx_s_discharge_date = dSet.indexOfColumn("s_discharge_date");
   	int idx_mos_code = dSet.indexOfColumn("mos_code");
   	int idx_incompl_reason = dSet.indexOfColumn("incompl_reason");
   	int idx_reserve_code = dSet.indexOfColumn("reserve_code");
   	int idx_rtd_code = dSet.indexOfColumn("rtd_code");
   	int idx_assign_code = dSet.indexOfColumn("assign_code");
   	int idx_platoon_code = dSet.indexOfColumn("platoon_code");
   	int idx_civil_defense_date = dSet.indexOfColumn("civil_defense_date");
   	int idx_civildef_code = dSet.indexOfColumn("civildef_code");
   	int idx_resource_code = dSet.indexOfColumn("resource_code");
   	int idx_reserve_forces_year = dSet.indexOfColumn("reserve_forces_year");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_army ( resident_no," + 
                    "end_army_code," + 
                    "ssn," + 
                    "kind_army_code," + 
                    "arm_code," + 
                    "class_code," + 
                    "cmss_code," + 
                    "discharge_code," + 
                    "enroll_date," + 
                    "discharge_date," + 
                    "s_enroll_date," + 
                    "s_discharge_date," + 
                    "mos_code," + 
                    "incompl_reason," + 
                    "reserve_code," + 
                    "rtd_code," + 
                    "assign_code," + 
                    "platoon_code," + 
                    "civil_defense_date," + 
                    "civildef_code," + 
                    "resource_code, " +
                    "reserve_forces_year )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_end_army_code);
      gpstatement.bindColumn(3, idx_ssn);
      gpstatement.bindColumn(4, idx_kind_army_code);
      gpstatement.bindColumn(5, idx_arm_code);
      gpstatement.bindColumn(6, idx_class_code);
      gpstatement.bindColumn(7, idx_cmss_code);
      gpstatement.bindColumn(8, idx_discharge_code);
      gpstatement.bindColumn(9, idx_enroll_date);
      gpstatement.bindColumn(10, idx_discharge_date);
      gpstatement.bindColumn(11, idx_s_enroll_date);
      gpstatement.bindColumn(12, idx_s_discharge_date);
      gpstatement.bindColumn(13, idx_mos_code);
      gpstatement.bindColumn(14, idx_incompl_reason);
      gpstatement.bindColumn(15, idx_reserve_code);
      gpstatement.bindColumn(16, idx_rtd_code);
      gpstatement.bindColumn(17, idx_assign_code);
      gpstatement.bindColumn(18, idx_platoon_code);
      gpstatement.bindColumn(19, idx_civil_defense_date);
      gpstatement.bindColumn(20, idx_civildef_code);
      gpstatement.bindColumn(21, idx_resource_code);
      gpstatement.bindColumn(22, idx_reserve_forces_year);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_army set " + 
                            "resident_no=?,  " + 
                            "end_army_code=?,  " + 
                            "ssn=?,  " + 
                            "kind_army_code=?,  " + 
                            "arm_code=?,  " + 
                            "class_code=?,  " + 
                            "cmss_code=?,  " + 
                            "discharge_code=?,  " + 
                            "enroll_date=?,  " + 
                            "discharge_date=?,  " + 
                            "s_enroll_date=?,  " + 
                            "s_discharge_date=?,  " + 
                            "mos_code=?,  " + 
                            "incompl_reason=?,  " + 
                            "reserve_code=?,  " + 
                            "rtd_code=?,  " + 
                            "assign_code=?,  " + 
                            "platoon_code=?,  " + 
                            "civil_defense_date=?,  " + 
                            "civildef_code=?,  " + 
                            "resource_code=?, " + 
                            "reserve_forces_year=?  where resident_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_end_army_code);
      gpstatement.bindColumn(3, idx_ssn);
      gpstatement.bindColumn(4, idx_kind_army_code);
      gpstatement.bindColumn(5, idx_arm_code);
      gpstatement.bindColumn(6, idx_class_code);
      gpstatement.bindColumn(7, idx_cmss_code);
      gpstatement.bindColumn(8, idx_discharge_code);
      gpstatement.bindColumn(9, idx_enroll_date);
      gpstatement.bindColumn(10, idx_discharge_date);
      gpstatement.bindColumn(11, idx_s_enroll_date);
      gpstatement.bindColumn(12, idx_s_discharge_date);
      gpstatement.bindColumn(13, idx_mos_code);
      gpstatement.bindColumn(14, idx_incompl_reason);
      gpstatement.bindColumn(15, idx_reserve_code);
      gpstatement.bindColumn(16, idx_rtd_code);
      gpstatement.bindColumn(17, idx_assign_code);
      gpstatement.bindColumn(18, idx_platoon_code);
      gpstatement.bindColumn(19, idx_civil_defense_date);
      gpstatement.bindColumn(20, idx_civildef_code);
      gpstatement.bindColumn(21, idx_resource_code);
      gpstatement.bindColumn(22, idx_reserve_forces_year);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(23, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_army where resident_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>