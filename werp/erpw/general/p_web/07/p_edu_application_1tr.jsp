<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_edu_application_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_edu_code = dSet.indexOfColumn("edu_code");
   	int idx_edu_year = dSet.indexOfColumn("edu_year");
   	int idx_edu_degree = dSet.indexOfColumn("edu_degree");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_grade_code = dSet.indexOfColumn("grade_code");
   	int idx_edu_name = dSet.indexOfColumn("edu_name");
   	int idx_edu_part = dSet.indexOfColumn("edu_part");
   	int idx_edu_office = dSet.indexOfColumn("edu_office");
   	int idx_edu_start_date = dSet.indexOfColumn("edu_start_date");
   	int idx_edu_end_date = dSet.indexOfColumn("edu_end_date");
   	int idx_edu_day = dSet.indexOfColumn("edu_day");
   	int idx_edu_time = dSet.indexOfColumn("edu_time");
   	int idx_edu_place = dSet.indexOfColumn("edu_place");
   	int idx_edu_comment = dSet.indexOfColumn("edu_comment");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_finish_tag = dSet.indexOfColumn("finish_tag");
   	int idx_result = dSet.indexOfColumn("result");
   	int idx_receipt_tag = dSet.indexOfColumn("receipt_tag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_edu_emp ( emp_no," + 
                    "edu_code," + 
                    "edu_year," + 
                    "edu_degree," + 
                    "spec_no_seq," + 
                    "comp_code," + 
                    "dept_code," + 
                    "grade_code," + 
                    "edu_name," + 
                    "edu_part," + 
                    "edu_office," + 
                    "edu_start_date," + 
                    "edu_end_date," + 
                    "edu_day," + 
                    "edu_time," + 
                    "edu_place," + 
                    "edu_comment," + 
                    "remark," + 
                    "finish_tag," + 
                    "result," + 
                    "receipt_tag )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_edu_code);
      gpstatement.bindColumn(3, idx_edu_year);
      gpstatement.bindColumn(4, idx_edu_degree);
      gpstatement.bindColumn(5, idx_spec_no_seq);
      gpstatement.bindColumn(6, idx_comp_code);
      gpstatement.bindColumn(7, idx_dept_code);
      gpstatement.bindColumn(8, idx_grade_code);
      gpstatement.bindColumn(9, idx_edu_name);
      gpstatement.bindColumn(10, idx_edu_part);
      gpstatement.bindColumn(11, idx_edu_office);
      gpstatement.bindColumn(12, idx_edu_start_date);
      gpstatement.bindColumn(13, idx_edu_end_date);
      gpstatement.bindColumn(14, idx_edu_day);
      gpstatement.bindColumn(15, idx_edu_time);
      gpstatement.bindColumn(16, idx_edu_place);
      gpstatement.bindColumn(17, idx_edu_comment);
      gpstatement.bindColumn(18, idx_remark);
      gpstatement.bindColumn(19, idx_finish_tag);
      gpstatement.bindColumn(20, idx_result);
      gpstatement.bindColumn(21, idx_receipt_tag);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_edu_emp set " + 
                            "emp_no=?,  " + 
                            "edu_code=?,  " + 
                            "edu_year=?,  " + 
                            "edu_degree=?,  " + 
                            "spec_no_seq=?,  " + 
                            "comp_code=?,  " + 
                            "dept_code=?,  " + 
                            "grade_code=?,  " + 
                            "edu_name=?,  " + 
                            "edu_part=?,  " + 
                            "edu_office=?,  " + 
                            "edu_start_date=?,  " + 
                            "edu_end_date=?,  " + 
                            "edu_day=?,  " + 
                            "edu_time=?,  " + 
                            "edu_place=?,  " + 
                            "edu_comment=?,  " + 
                            "remark=?,  " + 
                            "finish_tag=?,  " + 
                            "result=?,  " + 
                            "receipt_tag=?  where emp_no=? and edu_code=? and edu_year=? and edu_degree=? and spec_no_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_edu_code);
      gpstatement.bindColumn(3, idx_edu_year);
      gpstatement.bindColumn(4, idx_edu_degree);
      gpstatement.bindColumn(5, idx_spec_no_seq);
      gpstatement.bindColumn(6, idx_comp_code);
      gpstatement.bindColumn(7, idx_dept_code);
      gpstatement.bindColumn(8, idx_grade_code);
      gpstatement.bindColumn(9, idx_edu_name);
      gpstatement.bindColumn(10, idx_edu_part);
      gpstatement.bindColumn(11, idx_edu_office);
      gpstatement.bindColumn(12, idx_edu_start_date);
      gpstatement.bindColumn(13, idx_edu_end_date);
      gpstatement.bindColumn(14, idx_edu_day);
      gpstatement.bindColumn(15, idx_edu_time);
      gpstatement.bindColumn(16, idx_edu_place);
      gpstatement.bindColumn(17, idx_edu_comment);
      gpstatement.bindColumn(18, idx_remark);
      gpstatement.bindColumn(19, idx_finish_tag);
      gpstatement.bindColumn(20, idx_result);
      gpstatement.bindColumn(21, idx_receipt_tag);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(22, idx_emp_no);
      gpstatement.bindColumn(23, idx_edu_code);
      gpstatement.bindColumn(24, idx_edu_year);
      gpstatement.bindColumn(25, idx_edu_degree);
      gpstatement.bindColumn(26, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_edu_emp where emp_no=? and edu_code=? and edu_year=? and edu_degree=? and spec_no_seq=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_edu_code);
      gpstatement.bindColumn(3, idx_edu_year);
      gpstatement.bindColumn(4, idx_edu_degree);
      gpstatement.bindColumn(5, idx_spec_no_seq);
       stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>