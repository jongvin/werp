<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_gen_grade_driver_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_work_yymm = dSet.indexOfColumn("work_yymm");
   	int idx_grade_code = dSet.indexOfColumn("grade_code");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_driver_amt = dSet.indexOfColumn("driver_amt");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_parking_amt = dSet.indexOfColumn("parking_amt");   	
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_gen_grade_driver ( work_yymm," + 
                    "grade_code," + 
                    "comp_code," + 
                    "driver_amt," + 
                    "remark, parking_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_yymm);
      gpstatement.bindColumn(2, idx_grade_code);
      gpstatement.bindColumn(3, idx_comp_code);
      gpstatement.bindColumn(4, idx_driver_amt);
      gpstatement.bindColumn(5, idx_remark);
      gpstatement.bindColumn(6, idx_parking_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_gen_grade_driver set " + 
                            "work_yymm=?,  " + 
                            "grade_code=?,  " + 
                            "comp_code=?,  " + 
                            "driver_amt=?,  " + 
                            "remark=?, parking_amt=?  where work_yymm=? and grade_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_yymm);
      gpstatement.bindColumn(2, idx_grade_code);
      gpstatement.bindColumn(3, idx_comp_code);
      gpstatement.bindColumn(4, idx_driver_amt);
      gpstatement.bindColumn(5, idx_remark);
      gpstatement.bindColumn(6, idx_parking_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_work_yymm);
      gpstatement.bindColumn(8, idx_grade_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_gen_grade_driver where work_yymm=? and grade_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_work_yymm);
      gpstatement.bindColumn(2, idx_grade_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>