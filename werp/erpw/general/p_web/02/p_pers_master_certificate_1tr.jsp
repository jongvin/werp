<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_master_certificate_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_certificate_div = dSet.indexOfColumn("certificate_div");
   	int idx_work_year = dSet.indexOfColumn("work_year");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_certificate_no = dSet.indexOfColumn("certificate_no");
   	int idx_submit_date = dSet.indexOfColumn("submit_date");
   	int idx_address = dSet.indexOfColumn("address");
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_s_date = dSet.indexOfColumn("s_date");
   	int idx_e_date = dSet.indexOfColumn("e_date");
   	int idx_cer_grade = dSet.indexOfColumn("cer_grade");
   	int idx_quantity = dSet.indexOfColumn("quantity");
   	int idx_purpose = dSet.indexOfColumn("purpose");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_company_code = dSet.indexOfColumn("company_code");
   	int idx_requestor_name = dSet.indexOfColumn("requestor_name");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_certificate ( certificate_div," + 
                    "work_year," + 
                    "seq," + 
                    "certificate_no," + 
                    "submit_date," + 
                    "address," + 
                    "emp_no," + 
                    "s_date," + 
                    "e_date," + 
                    "cer_grade," + 
                    "quantity," + 
                    "purpose," + 
                    "remark," + 
                    "company_code," + 
                    "requestor_name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_certificate_div);
      gpstatement.bindColumn(2, idx_work_year);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_certificate_no);
      gpstatement.bindColumn(5, idx_submit_date);
      gpstatement.bindColumn(6, idx_address);
      gpstatement.bindColumn(7, idx_emp_no);
      gpstatement.bindColumn(8, idx_s_date);
      gpstatement.bindColumn(9, idx_e_date);
      gpstatement.bindColumn(10, idx_cer_grade);
      gpstatement.bindColumn(11, idx_quantity);
      gpstatement.bindColumn(12, idx_purpose);
      gpstatement.bindColumn(13, idx_remark);
      gpstatement.bindColumn(14, idx_company_code);
      gpstatement.bindColumn(15, idx_requestor_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_certificate set " + 
                            "certificate_div=?,  " + 
                            "work_year=?,  " + 
                            "seq=?,  " + 
                            "certificate_no=?,  " + 
                            "submit_date=?,  " + 
                            "address=?,  " + 
                            "emp_no=?,  " + 
                            "s_date=?,  " + 
                            "e_date=?,  " + 
                            "cer_grade=?,  " + 
                            "quantity=?,  " + 
                            "purpose=?,  " + 
                            "remark=?,  " + 
                            "company_code=?,  " + 
                            "requestor_name=?  where certificate_div=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_certificate_div);
      gpstatement.bindColumn(2, idx_work_year);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_certificate_no);
      gpstatement.bindColumn(5, idx_submit_date);
      gpstatement.bindColumn(6, idx_address);
      gpstatement.bindColumn(7, idx_emp_no);
      gpstatement.bindColumn(8, idx_s_date);
      gpstatement.bindColumn(9, idx_e_date);
      gpstatement.bindColumn(10, idx_cer_grade);
      gpstatement.bindColumn(11, idx_quantity);
      gpstatement.bindColumn(12, idx_purpose);
      gpstatement.bindColumn(13, idx_remark);
      gpstatement.bindColumn(14, idx_company_code);
      gpstatement.bindColumn(15, idx_requestor_name);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(16, idx_certificate_div);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_certificate where certificate_div=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_certificate_div);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>