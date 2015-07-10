<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_gen_loan_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_loan_date = dSet.indexOfColumn("loan_date");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_grade_code = dSet.indexOfColumn("grade_code");
   	int idx_last_repay_date = dSet.indexOfColumn("last_repay_date");
   	int idx_loan_amt = dSet.indexOfColumn("loan_amt");
   	int idx_loan_rem = dSet.indexOfColumn("loan_rem");
   	int idx_interest = dSet.indexOfColumn("interest");
   	int idx_repay_method = dSet.indexOfColumn("repay_method");
   	int idx_repay_yn = dSet.indexOfColumn("repay_yn");
   	int idx_surety = dSet.indexOfColumn("surety");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_gen_loan ( " + 
                    "comp_code," + 
                    "emp_no," + 
                    "spec_no_seq," + 
                    "loan_date," + 
                    "dept_code," + 
                    "grade_code," + 
                    "last_repay_date," + 
                    "loan_amt," + 
                    "loan_rem," + 
                    "interest," + 
                    "repay_method," + 
                    "repay_yn," + 
                    "surety," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_comp_code);
      gpstatement.bindColumn(2, idx_emp_no);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_loan_date);
      gpstatement.bindColumn(5, idx_dept_code);
      gpstatement.bindColumn(6, idx_grade_code);
      gpstatement.bindColumn(7, idx_last_repay_date);
      gpstatement.bindColumn(8, idx_loan_amt);
      gpstatement.bindColumn(9, idx_loan_rem);
      gpstatement.bindColumn(10, idx_interest);
      gpstatement.bindColumn(11, idx_repay_method);
      gpstatement.bindColumn(12, idx_repay_yn);
      gpstatement.bindColumn(13, idx_surety);
      gpstatement.bindColumn(14, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_gen_loan set " + 
                            "comp_code=?,  " + 
                            "emp_no=?,  " + 
                            "spec_no_seq=?,  " + 
                            "loan_date=?,  " + 
                            "dept_code=?,  " + 
                            "grade_code=?,  " + 
                            "last_repay_date=?,  " + 
                            "loan_amt=?,  " + 
                            "loan_rem=?,  " + 
                            "interest=?,  " + 
                            "repay_method=?,  " + 
                            "repay_yn=?,  " + 
                            "surety=?,  " + 
                            "remark=?  where  spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_comp_code);
      gpstatement.bindColumn(2, idx_emp_no);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_loan_date);
      gpstatement.bindColumn(5, idx_dept_code);
      gpstatement.bindColumn(6, idx_grade_code);
      gpstatement.bindColumn(7, idx_last_repay_date);
      gpstatement.bindColumn(8, idx_loan_amt);
      gpstatement.bindColumn(9, idx_loan_rem);
      gpstatement.bindColumn(10, idx_interest);
      gpstatement.bindColumn(11, idx_repay_method);
      gpstatement.bindColumn(12, idx_repay_yn);
      gpstatement.bindColumn(13, idx_surety);
      gpstatement.bindColumn(14, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_gen_loan where  spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>