<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_body_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_medical_date = dSet.indexOfColumn("medical_date");
   	int idx_height = dSet.indexOfColumn("height");
   	int idx_weight = dSet.indexOfColumn("weight");
   	int idx_sick_career = dSet.indexOfColumn("sick_career");
   	int idx_sight_l = dSet.indexOfColumn("sight_l");
   	int idx_sight_r = dSet.indexOfColumn("sight_r");
   	int idx_blind_code = dSet.indexOfColumn("blind_code");
   	int idx_hearing_l = dSet.indexOfColumn("hearing_l");
   	int idx_hearing_r = dSet.indexOfColumn("hearing_r");
   	int idx_blood = dSet.indexOfColumn("blood");
   	int idx_status = dSet.indexOfColumn("status");
   	int idx_blood_pressure_h = dSet.indexOfColumn("blood_pressure_h");
   	int idx_blood_pressure_l = dSet.indexOfColumn("blood_pressure_l");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_body ( resident_no," + 
                    "medical_date," + 
                    "height," + 
                    "weight," + 
                    "sick_career," + 
                    "sight_l," + 
                    "sight_r," + 
                    "blind_code," + 
                    "hearing_l," + 
                    "hearing_r," + 
                    "blood," + 
                    "status," + 
                    "blood_pressure_h," + 
                    "blood_pressure_l )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_medical_date);
      gpstatement.bindColumn(3, idx_height);
      gpstatement.bindColumn(4, idx_weight);
      gpstatement.bindColumn(5, idx_sick_career);
      gpstatement.bindColumn(6, idx_sight_l);
      gpstatement.bindColumn(7, idx_sight_r);
      gpstatement.bindColumn(8, idx_blind_code);
      gpstatement.bindColumn(9, idx_hearing_l);
      gpstatement.bindColumn(10, idx_hearing_r);
      gpstatement.bindColumn(11, idx_blood);
      gpstatement.bindColumn(12, idx_status);
      gpstatement.bindColumn(13, idx_blood_pressure_h);
      gpstatement.bindColumn(14, idx_blood_pressure_l);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_body set " + 
                            "resident_no=?,  " + 
                            "medical_date=?,  " + 
                            "height=?,  " + 
                            "weight=?,  " + 
                            "sick_career=?,  " + 
                            "sight_l=?,  " + 
                            "sight_r=?,  " + 
                            "blind_code=?,  " + 
                            "hearing_l=?,  " + 
                            "hearing_r=?,  " + 
                            "blood=?,  " + 
                            "status=?,  " + 
                            "blood_pressure_h=?,  " + 
                            "blood_pressure_l=?  where resident_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_medical_date);
      gpstatement.bindColumn(3, idx_height);
      gpstatement.bindColumn(4, idx_weight);
      gpstatement.bindColumn(5, idx_sick_career);
      gpstatement.bindColumn(6, idx_sight_l);
      gpstatement.bindColumn(7, idx_sight_r);
      gpstatement.bindColumn(8, idx_blind_code);
      gpstatement.bindColumn(9, idx_hearing_l);
      gpstatement.bindColumn(10, idx_hearing_r);
      gpstatement.bindColumn(11, idx_blood);
      gpstatement.bindColumn(12, idx_status);
      gpstatement.bindColumn(13, idx_blood_pressure_h);
      gpstatement.bindColumn(14, idx_blood_pressure_l);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_body where resident_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>