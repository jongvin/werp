<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_wealth_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_p_estate = dSet.indexOfColumn("p_estate");
   	int idx_r_estate = dSet.indexOfColumn("r_estate");
   	int idx_live_type_code = dSet.indexOfColumn("live_type_code");
   	int idx_house_type_code = dSet.indexOfColumn("house_type_code");
   	int idx_plottage = dSet.indexOfColumn("plottage");
   	int idx_floor_space = dSet.indexOfColumn("floor_space");
   	int idx_room_count = dSet.indexOfColumn("room_count");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_wealth ( emp_no," + 
                    "p_estate," + 
                    "r_estate," + 
                    "live_type_code," + 
                    "house_type_code," + 
                    "plottage," + 
                    "floor_space," + 
                    "room_count )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_p_estate);
      gpstatement.bindColumn(3, idx_r_estate);
      gpstatement.bindColumn(4, idx_live_type_code);
      gpstatement.bindColumn(5, idx_house_type_code);
      gpstatement.bindColumn(6, idx_plottage);
      gpstatement.bindColumn(7, idx_floor_space);
      gpstatement.bindColumn(8, idx_room_count);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_wealth set " + 
                            "emp_no=?,  " + 
                            "p_estate=?,  " + 
                            "r_estate=?,  " + 
                            "live_type_code=?,  " + 
                            "house_type_code=?,  " + 
                            "plottage=?,  " + 
                            "floor_space=?,  " + 
                            "room_count=?  where emp_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_p_estate);
      gpstatement.bindColumn(3, idx_r_estate);
      gpstatement.bindColumn(4, idx_live_type_code);
      gpstatement.bindColumn(5, idx_house_type_code);
      gpstatement.bindColumn(6, idx_plottage);
      gpstatement.bindColumn(7, idx_floor_space);
      gpstatement.bindColumn(8, idx_room_count);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(9, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_wealth where emp_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>