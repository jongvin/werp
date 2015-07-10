<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_gen_welfare_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_welfare_code = dSet.indexOfColumn("welfare_code");
   	int idx_welfare_date = dSet.indexOfColumn("welfare_date");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_welfare_amt = dSet.indexOfColumn("welfare_amt");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_grade_code = dSet.indexOfColumn("grade_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_gen_welfare (  " +
						  "emp_no," + 
                    "spec_no_seq," + 
                    "seq," + 
                    "welfare_code," + 
                    "welfare_date," + 
                    "comp_code," + 
                    "dept_code," + 
                    "welfare_amt," + 
                    "remark," + 
                    "grade_code )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_welfare_code);
      gpstatement.bindColumn(5, idx_welfare_date);
      gpstatement.bindColumn(6, idx_comp_code);
      gpstatement.bindColumn(7, idx_dept_code);
      gpstatement.bindColumn(8, idx_welfare_amt);
      gpstatement.bindColumn(9, idx_remark);
      gpstatement.bindColumn(10, idx_grade_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_gen_welfare set " + 
                            "emp_no=?,  " + 
                            "spec_no_seq=?,  " + 
                            "seq=?,  " + 
                            "welfare_code=?,  " + 
                            "welfare_date=?,  " + 
                            "comp_code=?,  " + 
                            "dept_code=?,  " + 
                            "welfare_amt=?,  " + 
                            "remark=?,  " + 
                            "grade_code=?  where  spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_welfare_code);
      gpstatement.bindColumn(5, idx_welfare_date);
      gpstatement.bindColumn(6, idx_comp_code);
      gpstatement.bindColumn(7, idx_dept_code);
      gpstatement.bindColumn(8, idx_welfare_amt);
      gpstatement.bindColumn(9, idx_remark);
      gpstatement.bindColumn(10, idx_grade_code);      
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_gen_welfare where  spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>