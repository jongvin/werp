<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_attend_emp_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_attend_date = dSet.indexOfColumn("attend_date");
   	int idx_atnd_chk = dSet.indexOfColumn("atnd_chk");
   	int idx_atnd_time = dSet.indexOfColumn("atnd_time");
   	int idx_late_chk = dSet.indexOfColumn("late_chk");
   	int idx_outw_chk = dSet.indexOfColumn("outw_chk");
   	int idx_trip_chk = dSet.indexOfColumn("trip_chk");
   	int idx_abse_chk = dSet.indexOfColumn("abse_chk");
   	int idx_educ_chk = dSet.indexOfColumn("educ_chk");
   	int idx_annu_chk = dSet.indexOfColumn("annu_chk");
   	int idx_cong_chk = dSet.indexOfColumn("cong_chk");
   	int idx_etcc_chk = dSet.indexOfColumn("etcc_chk");
   	int idx_reason = dSet.indexOfColumn("reason");
   	int idx_approv_emp = dSet.indexOfColumn("approv_emp");
   	int idx_approv_date = dSet.indexOfColumn("approv_date");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_attend_emp ( resident_no," + 
                    "attend_date," + 
                    "atnd_chk," + 
                    "late_chk," + 
                    "outw_chk," + 
                    "trip_chk," + 
                    "abse_chk," + 
                    "educ_chk," + 
                    "annu_chk," + 
                    "cong_chk," + 
                    "etcc_chk," + 
                    "reason," + 
                    "approv_emp," + 
                    "approv_date )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_attend_date);
      gpstatement.bindColumn(3, idx_atnd_chk);
      gpstatement.bindColumn(4, idx_late_chk);
      gpstatement.bindColumn(5, idx_outw_chk);
      gpstatement.bindColumn(6, idx_trip_chk);
      gpstatement.bindColumn(7, idx_abse_chk);
      gpstatement.bindColumn(8, idx_educ_chk);
      gpstatement.bindColumn(9, idx_annu_chk);
      gpstatement.bindColumn(10, idx_cong_chk);
      gpstatement.bindColumn(11, idx_etcc_chk);
      gpstatement.bindColumn(12, idx_reason);
      gpstatement.bindColumn(13, idx_approv_emp);
      gpstatement.bindColumn(14, idx_approv_date);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_attend_emp set " + 
                            "resident_no=?,  " + 
                            "attend_date=?,  " + 
                            "atnd_chk=?,  " + 
                            "late_chk=?,  " + 
                            "outw_chk=?,  " + 
                            "trip_chk=?,  " + 
                            "abse_chk=?,  " + 
                            "educ_chk=?,  " + 
                            "annu_chk=?,  " + 
                            "cong_chk=?,  " + 
                            "etcc_chk=?,  " + 
                            "reason=?,  " + 
                            "approv_emp=?,  " + 
                            "approv_date=?  where resident_no=? and attend_date=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_attend_date);
      gpstatement.bindColumn(3, idx_atnd_chk);
      gpstatement.bindColumn(4, idx_late_chk);
      gpstatement.bindColumn(5, idx_outw_chk);
      gpstatement.bindColumn(6, idx_trip_chk);
      gpstatement.bindColumn(7, idx_abse_chk);
      gpstatement.bindColumn(8, idx_educ_chk);
      gpstatement.bindColumn(9, idx_annu_chk);
      gpstatement.bindColumn(10, idx_cong_chk);
      gpstatement.bindColumn(11, idx_etcc_chk);
      gpstatement.bindColumn(12, idx_reason);
      gpstatement.bindColumn(13, idx_approv_emp);
      gpstatement.bindColumn(14, idx_approv_date);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_resident_no);
      gpstatement.bindColumn(16, idx_attend_date);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_attend_emp where resident_no=? and attend_date=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_attend_date);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>