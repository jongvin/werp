<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("a_as_location_input_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_loc_useq = dSet.indexOfColumn("loc_useq");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_dong = dSet.indexOfColumn("dong");
   	int idx_ho = dSet.indexOfColumn("ho");
   	int idx_floor = dSet.indexOfColumn("floor");
   	int idx_res_name = dSet.indexOfColumn("res_name");
   	int idx_res_reg_no = dSet.indexOfColumn("res_reg_no");
   	int idx_res_phone = dSet.indexOfColumn("res_phone");
   	int idx_res_cell = dSet.indexOfColumn("res_cell");
   	int idx_res_mvin_date = dSet.indexOfColumn("res_mvin_date");
   	int idx_note = dSet.indexOfColumn("note");
   	int idx_attrib1 = dSet.indexOfColumn("attrib1");
   	int idx_attrib2 = dSet.indexOfColumn("attrib2");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO a_as_location ( loc_useq," + 
                    "dept_code," + 
                    "dong," + 
                    "ho," + 
                    "floor, " +
                    "res_name," +
                    "res_reg_no," +
                    "res_phone," +
                    "res_cell," +
                    "res_mvin_date," +
                    "note," +
                    "attrib1," +
                    "attrib2 )      ";
      sSql = sSql + " VALUES ( sq_a_as_loc_useq.nextval, :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_dong);
      gpstatement.bindColumn(3, idx_ho);
      gpstatement.bindColumn(4, idx_floor);
      gpstatement.bindColumn(5, idx_res_name);
      gpstatement.bindColumn(6, idx_res_reg_no);
      gpstatement.bindColumn(7, idx_res_phone);
      gpstatement.bindColumn(8, idx_res_cell);
      gpstatement.bindColumn(9, idx_res_mvin_date);
      gpstatement.bindColumn(10, idx_note);
      gpstatement.bindColumn(11, idx_attrib1);
      gpstatement.bindColumn(12, idx_attrib2);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update a_as_location set " + 
                            "loc_useq=?,  " + 
                            "dept_code=?,  " + 
                            "res_name=?,  " + 
                            "res_reg_no=?,  " + 
                            "res_phone=?,  " + 
                            "res_cell=?,  " + 
                            "res_mvin_date=?,  " + 
                            "note=?,  " + 
                            "attrib1=?,  " +
                            "attrib2=?  where loc_useq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_loc_useq);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_res_name);
      gpstatement.bindColumn(4, idx_res_reg_no);
      gpstatement.bindColumn(5, idx_res_phone);
      gpstatement.bindColumn(6, idx_res_cell);
      gpstatement.bindColumn(7, idx_res_mvin_date);
      gpstatement.bindColumn(8, idx_note);
      gpstatement.bindColumn(9, idx_attrib1);
      gpstatement.bindColumn(10, idx_attrib2);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_loc_useq); 
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from a_as_location where loc_useq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_loc_useq); 
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>