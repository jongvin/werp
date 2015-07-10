<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_edu_curriculum_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_edu_code = dSet.indexOfColumn("edu_code");
   	int idx_edu_name = dSet.indexOfColumn("edu_name");
   	int idx_edu_part_code = dSet.indexOfColumn("edu_part_code");
   	int idx_edu_office_code = dSet.indexOfColumn("edu_office_code");
   	int idx_grade = dSet.indexOfColumn("grade");
   	int idx_level_year = dSet.indexOfColumn("level_year");
   	int idx_degree_sum = dSet.indexOfColumn("degree_sum");
   	int idx_edu_object = dSet.indexOfColumn("edu_object");
   	int idx_edu_remark = dSet.indexOfColumn("edu_remark");
   	int idx_io_tag = dSet.indexOfColumn("io_tag");   	
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_edu_curriculum ( edu_code," + 
                    "edu_name," + 
                    "edu_part_code," + 
                    "edu_office_code," + 
                    "grade," + 
                    "level_year," + 
                    "degree_sum," + 
                    "edu_object," + 
                    "edu_remark," +
                    "io_tag )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_edu_code);
      gpstatement.bindColumn(2, idx_edu_name);
      gpstatement.bindColumn(3, idx_edu_part_code);
      gpstatement.bindColumn(4, idx_edu_office_code);
      gpstatement.bindColumn(5, idx_grade);
      gpstatement.bindColumn(6, idx_level_year);
      gpstatement.bindColumn(7, idx_degree_sum);
      gpstatement.bindColumn(8, idx_edu_object);
      gpstatement.bindColumn(9, idx_edu_remark);
      gpstatement.bindColumn(10, idx_io_tag);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_edu_curriculum set " + 
                            "edu_code=?,  " + 
                            "edu_name=?,  " + 
                            "edu_part_code=?,  " + 
                            "edu_office_code=?,  " + 
                            "grade=?,  " + 
                            "level_year=?,  " + 
                            "degree_sum=?,  " + 
                            "edu_object=?,  " + 
                            "edu_remark=?,  " +
                            "io_tag=?  where edu_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_edu_code);
      gpstatement.bindColumn(2, idx_edu_name);
      gpstatement.bindColumn(3, idx_edu_part_code);
      gpstatement.bindColumn(4, idx_edu_office_code);
      gpstatement.bindColumn(5, idx_grade);
      gpstatement.bindColumn(6, idx_level_year);
      gpstatement.bindColumn(7, idx_degree_sum);
      gpstatement.bindColumn(8, idx_edu_object);
      gpstatement.bindColumn(9, idx_edu_remark);
      gpstatement.bindColumn(10, idx_io_tag);      
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_edu_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_edu_curriculum where edu_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_edu_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>