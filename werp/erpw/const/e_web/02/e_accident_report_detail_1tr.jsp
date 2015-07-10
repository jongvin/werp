<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("e_accident_report_detail_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_civil_register_number = dSet.indexOfColumn("civil_register_number");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_zip_number = dSet.indexOfColumn("zip_number");
   	int idx_address1 = dSet.indexOfColumn("address1");
   	int idx_address2 = dSet.indexOfColumn("address2");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_job_type = dSet.indexOfColumn("job_type");
   	int idx_result_type = dSet.indexOfColumn("result_type");
   	int idx_injure_code = dSet.indexOfColumn("injure_code");
   	int idx_injure_part_code = dSet.indexOfColumn("injure_part_code");
   	int idx_join_date = dSet.indexOfColumn("join_date");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_sex = dSet.indexOfColumn("sex");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO e_disaster_report_detail ( dept_code," + 
                    "seq," + 
                    "civil_register_number," + 
                    "name," + 
                    "zip_number," + 
                    "address1," + 
                    "address2," + 
                    "sbcr_name," + 
                    "job_type," + 
                    "result_type," + 
                    "injure_code," + 
                    "injure_part_code," + 
                    "join_date," + 
                    "remark , " +
						  "sex )    ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_civil_register_number);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_zip_number);
      gpstatement.bindColumn(6, idx_address1);
      gpstatement.bindColumn(7, idx_address2);
      gpstatement.bindColumn(8, idx_sbcr_name);
      gpstatement.bindColumn(9, idx_job_type);
      gpstatement.bindColumn(10, idx_result_type);
      gpstatement.bindColumn(11, idx_injure_code);
      gpstatement.bindColumn(12, idx_injure_part_code);
      gpstatement.bindColumn(13, idx_join_date);
      gpstatement.bindColumn(14, idx_remark);
      gpstatement.bindColumn(15, idx_sex);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update e_disaster_report_detail set " + 
                            "dept_code=?,  " + 
                            "seq=?,  " + 
                            "civil_register_number=?,  " + 
                            "name=?,  " + 
                            "zip_number=?,  " + 
                            "address1=?,  " + 
                            "address2=?,  " + 
                            "sbcr_name=?,  " + 
                            "job_type=?,  " + 
                            "result_type=?,  " + 
                            "injure_code=?,  " + 
                            "injure_part_code=?,  " + 
                            "join_date=?,  " + 
                            "remark=? ," +
									 "sex=? where dept_code=? and seq=? and civil_register_number=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_civil_register_number);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_zip_number);
      gpstatement.bindColumn(6, idx_address1);
      gpstatement.bindColumn(7, idx_address2);
      gpstatement.bindColumn(8, idx_sbcr_name);
      gpstatement.bindColumn(9, idx_job_type);
      gpstatement.bindColumn(10, idx_result_type);
      gpstatement.bindColumn(11, idx_injure_code);
      gpstatement.bindColumn(12, idx_injure_part_code);
      gpstatement.bindColumn(13, idx_join_date);
      gpstatement.bindColumn(14, idx_remark);
      gpstatement.bindColumn(15, idx_sex);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
 		gpstatement.bindColumn(16, idx_dept_code);
 		gpstatement.bindColumn(17, idx_seq);
      gpstatement.bindColumn(18, idx_civil_register_number);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from e_disaster_report_detail where dept_code=? and seq=? and civil_register_number=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
 		gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_civil_register_number);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>