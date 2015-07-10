<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_school_car_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_school_name = dSet.indexOfColumn("school_name");
   	int idx_major_code = dSet.indexOfColumn("major_code");
   	int idx_school_car_code = dSet.indexOfColumn("school_car_code");
   	int idx_acq_div = dSet.indexOfColumn("acq_div");
   	int idx_enter_date = dSet.indexOfColumn("enter_date");
   	int idx_grad_date = dSet.indexOfColumn("grad_date");
   	int idx_last_school_yn = dSet.indexOfColumn("last_school_yn");
   	int idx_location = dSet.indexOfColumn("location");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_school_car ( resident_no," + 
                    "spec_no_seq," + 
                    "seq," + 
                    "school_name," + 
                    "major_code," + 
                    "school_car_code," + 
                    "acq_div," + 
                    "enter_date," + 
                    "grad_date," + 
                    "last_school_yn, location )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_school_name);
      gpstatement.bindColumn(5, idx_major_code);
      gpstatement.bindColumn(6, idx_school_car_code);
      gpstatement.bindColumn(7, idx_acq_div);
      gpstatement.bindColumn(8, idx_enter_date);
      gpstatement.bindColumn(9, idx_grad_date);
      gpstatement.bindColumn(10, idx_last_school_yn);
      gpstatement.bindColumn(11, idx_location);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_school_car set " + 
                            "resident_no=?,  " + 
                            "spec_no_seq=?,  " + 
                            "seq=?,  " + 
                            "school_name=?,  " + 
                            "major_code=?,  " + 
                            "school_car_code=?,  " + 
                            "acq_div=?,  " + 
                            "enter_date=?,  " + 
                            "grad_date=?,  " + 
                            "last_school_yn=?, location=?  where resident_no=? and spec_no_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_school_name);
      gpstatement.bindColumn(5, idx_major_code);
      gpstatement.bindColumn(6, idx_school_car_code);
      gpstatement.bindColumn(7, idx_acq_div);
      gpstatement.bindColumn(8, idx_enter_date);
      gpstatement.bindColumn(9, idx_grad_date);
      gpstatement.bindColumn(10, idx_last_school_yn);
      gpstatement.bindColumn(11, idx_location);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_resident_no);
      gpstatement.bindColumn(13, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_school_car where resident_no=? and spec_no_seq=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_resident_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>