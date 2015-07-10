<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_edu_instructor_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_edu_year = dSet.indexOfColumn("edu_year");
   	int idx_inst_no = dSet.indexOfColumn("inst_no");
   	int idx_inst_name = dSet.indexOfColumn("inst_name");
   	int idx_io_tag = dSet.indexOfColumn("io_tag");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_grade_code = dSet.indexOfColumn("grade_code");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_edu_instructor ( edu_year," + 
                    "inst_no," + 
                    "inst_name," + 
                    "io_tag," + 
                    "comp_code," + 
                    "dept_code," + 
                    "grade_code," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_edu_year);
      gpstatement.bindColumn(2, idx_inst_no);
      gpstatement.bindColumn(3, idx_inst_name);
      gpstatement.bindColumn(4, idx_io_tag);
      gpstatement.bindColumn(5, idx_comp_code);
      gpstatement.bindColumn(6, idx_dept_code);
      gpstatement.bindColumn(7, idx_grade_code);
      gpstatement.bindColumn(8, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_edu_instructor set " + 
                            "edu_year=?,  " + 
                            "inst_no=?,  " + 
                            "inst_name=?,  " + 
                            "io_tag=?,  " + 
                            "comp_code=?,  " + 
                            "dept_code=?,  " + 
                            "grade_code=?,  " + 
                            "remark=?  where edu_year=? and inst_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_edu_year);
      gpstatement.bindColumn(2, idx_inst_no);
      gpstatement.bindColumn(3, idx_inst_name);
      gpstatement.bindColumn(4, idx_io_tag);
      gpstatement.bindColumn(5, idx_comp_code);
      gpstatement.bindColumn(6, idx_dept_code);
      gpstatement.bindColumn(7, idx_grade_code);
      gpstatement.bindColumn(8, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(9, idx_edu_year);
      gpstatement.bindColumn(10, idx_inst_no);      
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_edu_instructor where edu_year=? and inst_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_edu_year);
      gpstatement.bindColumn(2, idx_inst_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>