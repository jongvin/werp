<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_cer_req_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_certificate_div = dSet.indexOfColumn("certificate_div");
   	int idx_submit_year = dSet.indexOfColumn("submit_year");
   	int idx_certificate_no = dSet.indexOfColumn("certificate_no");
   	int idx_approve_date = dSet.indexOfColumn("approve_date");
   	int idx_address = dSet.indexOfColumn("address");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_grade_code = dSet.indexOfColumn("grade_code");
   	int idx_s_date = dSet.indexOfColumn("s_date");
   	int idx_e_date = dSet.indexOfColumn("e_date");
   	int idx_quantity = dSet.indexOfColumn("quantity");
   	int idx_purpose = dSet.indexOfColumn("purpose");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_requestor_name = dSet.indexOfColumn("requestor_name");
   	int idx_approve_div = dSet.indexOfColumn("approve_div");
   	int idx_approve_yn = dSet.indexOfColumn("approve_yn");
   	int idx_req_date = dSet.indexOfColumn("req_date");
   	int idx_write_date = dSet.indexOfColumn("write_date");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_certificate ( emp_no," + 
                    "spec_no_seq," + 
                    "certificate_div," + 
                    "submit_year," + 
                    "certificate_no," + 
                    "approve_date," + 
                    "address," + 
                    "comp_code," + 
                    "dept_code," + 
                    "grade_code," + 
                    "s_date," + 
                    "e_date," + 
                    "quantity," + 
                    "purpose," + 
                    "remark," + 
                    "requestor_name," + 
                    "approve_div," + 
                    "approve_yn, req_date, write_date )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_certificate_div);
      gpstatement.bindColumn(4, idx_submit_year);
      gpstatement.bindColumn(5, idx_certificate_no);
      gpstatement.bindColumn(6, idx_approve_date);
      gpstatement.bindColumn(7, idx_address);
      gpstatement.bindColumn(8, idx_comp_code);
      gpstatement.bindColumn(9, idx_dept_code);
      gpstatement.bindColumn(10, idx_grade_code);
      gpstatement.bindColumn(11, idx_s_date);
      gpstatement.bindColumn(12, idx_e_date);
      gpstatement.bindColumn(13, idx_quantity);
      gpstatement.bindColumn(14, idx_purpose);
      gpstatement.bindColumn(15, idx_remark);
      gpstatement.bindColumn(16, idx_requestor_name);
      gpstatement.bindColumn(17, idx_approve_div);
      gpstatement.bindColumn(18, idx_approve_yn);
      gpstatement.bindColumn(19, idx_req_date);
      gpstatement.bindColumn(20, idx_write_date);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_certificate set " + 
                            "emp_no=?,  " + 
                            "spec_no_seq=?,  " + 
                            "certificate_div=?,  " + 
                            "submit_year=?,  " + 
                            "certificate_no=?,  " + 
                            "approve_date=?,  " + 
                            "address=?,  " + 
                            "comp_code=?,  " + 
                            "dept_code=?,  " + 
                            "grade_code=?,  " + 
                            "s_date=?,  " + 
                            "e_date=?,  " + 
                            "quantity=?,  " + 
                            "purpose=?,  " + 
                            "remark=?,  " + 
                            "requestor_name=?,  " + 
                            "approve_div=?,  " + 
                            "approve_yn=?, req_date=?, write_date=?  where emp_no=? and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_certificate_div);
      gpstatement.bindColumn(4, idx_submit_year);
      gpstatement.bindColumn(5, idx_certificate_no);
      gpstatement.bindColumn(6, idx_approve_date);
      gpstatement.bindColumn(7, idx_address);
      gpstatement.bindColumn(8, idx_comp_code);
      gpstatement.bindColumn(9, idx_dept_code);
      gpstatement.bindColumn(10, idx_grade_code);
      gpstatement.bindColumn(11, idx_s_date);
      gpstatement.bindColumn(12, idx_e_date);
      gpstatement.bindColumn(13, idx_quantity);
      gpstatement.bindColumn(14, idx_purpose);
      gpstatement.bindColumn(15, idx_remark);
      gpstatement.bindColumn(16, idx_requestor_name);
      gpstatement.bindColumn(17, idx_approve_div);
      gpstatement.bindColumn(18, idx_approve_yn);
      gpstatement.bindColumn(19, idx_req_date);      
      gpstatement.bindColumn(20, idx_write_date);      
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(21, idx_emp_no);
      gpstatement.bindColumn(22, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_certificate where emp_no=? and spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>