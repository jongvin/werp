<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_to_po_manage_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_grade_code = dSet.indexOfColumn("grade_code");
   	int idx_work_year = dSet.indexOfColumn("work_year");
   	int idx_to_01 = dSet.indexOfColumn("to_01");
   	int idx_to_02 = dSet.indexOfColumn("to_02");
   	int idx_to_03 = dSet.indexOfColumn("to_03");
   	int idx_to_04 = dSet.indexOfColumn("to_04");
   	int idx_to_05 = dSet.indexOfColumn("to_05");
   	int idx_to_06 = dSet.indexOfColumn("to_06");
   	int idx_to_07 = dSet.indexOfColumn("to_07");
   	int idx_to_08 = dSet.indexOfColumn("to_08");
   	int idx_to_09 = dSet.indexOfColumn("to_09");
   	int idx_to_10 = dSet.indexOfColumn("to_10");
   	int idx_to_11 = dSet.indexOfColumn("to_11");
   	int idx_to_12 = dSet.indexOfColumn("to_12");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_to_po_manage ( comp_code," + 
                    "dept_code," + 
                    "grade_code," + 
                    "work_year," + 
                    "to_01," + 
                    "to_02," + 
                    "to_03," + 
                    "to_04," + 
                    "to_05," + 
                    "to_06," + 
                    "to_07," + 
                    "to_08," + 
                    "to_09," + 
                    "to_10," + 
                    "to_11," + 
                    "to_12 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_comp_code);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_grade_code);
      gpstatement.bindColumn(4, idx_work_year);
      gpstatement.bindColumn(5, idx_to_01);
      gpstatement.bindColumn(6, idx_to_02);
      gpstatement.bindColumn(7, idx_to_03);
      gpstatement.bindColumn(8, idx_to_04);
      gpstatement.bindColumn(9, idx_to_05);
      gpstatement.bindColumn(10, idx_to_06);
      gpstatement.bindColumn(11, idx_to_07);
      gpstatement.bindColumn(12, idx_to_08);
      gpstatement.bindColumn(13, idx_to_09);
      gpstatement.bindColumn(14, idx_to_10);
      gpstatement.bindColumn(15, idx_to_11);
      gpstatement.bindColumn(16, idx_to_12);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_to_po_manage set " + 
                            "comp_code=?,  " + 
                            "dept_code=?,  " + 
                            "grade_code=?,  " + 
                            "work_year=?,  " + 
                            "to_01=?,  " + 
                            "to_02=?,  " + 
                            "to_03=?,  " + 
                            "to_04=?,  " + 
                            "to_05=?,  " + 
                            "to_06=?,  " + 
                            "to_07=?,  " + 
                            "to_08=?,  " + 
                            "to_09=?,  " + 
                            "to_10=?,  " + 
                            "to_11=?,  " + 
                            "to_12=?  where comp_code=? and dept_code=? and grade_code=? and work_year=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_comp_code);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_grade_code);
      gpstatement.bindColumn(4, idx_work_year);
      gpstatement.bindColumn(5, idx_to_01);
      gpstatement.bindColumn(6, idx_to_02);
      gpstatement.bindColumn(7, idx_to_03);
      gpstatement.bindColumn(8, idx_to_04);
      gpstatement.bindColumn(9, idx_to_05);
      gpstatement.bindColumn(10, idx_to_06);
      gpstatement.bindColumn(11, idx_to_07);
      gpstatement.bindColumn(12, idx_to_08);
      gpstatement.bindColumn(13, idx_to_09);
      gpstatement.bindColumn(14, idx_to_10);
      gpstatement.bindColumn(15, idx_to_11);
      gpstatement.bindColumn(16, idx_to_12);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(17, idx_comp_code);
      gpstatement.bindColumn(18, idx_dept_code);
      gpstatement.bindColumn(19, idx_grade_code);
      gpstatement.bindColumn(20, idx_work_year);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_to_po_manage where comp_code=? and dept_code=? and grade_code=? and work_year=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_comp_code);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_grade_code);
      gpstatement.bindColumn(4, idx_work_year);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>