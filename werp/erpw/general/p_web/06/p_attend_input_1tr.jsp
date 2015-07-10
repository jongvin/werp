<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_attend_input_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_attend_code = dSet.indexOfColumn("attend_code");
   	int idx_start_date = dSet.indexOfColumn("start_date");
   	int idx_end_date = dSet.indexOfColumn("end_date");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_holiday = dSet.indexOfColumn("holiday");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_grade_code = dSet.indexOfColumn("grade_code");
   	int idx_attend_day = dSet.indexOfColumn("attend_day");
   	int idx_attend_reason = dSet.indexOfColumn("attend_reason");
   	int idx_confirm_tag = dSet.indexOfColumn("confirm_tag");
   	int idx_input_date = dSet.indexOfColumn("input_date");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_attend_input ( emp_no," + 
                    "attend_code," + 
                    "start_date," + 
                    "end_date," + 
                    "seq," + 
                    "holiday," + 
                    "comp_code," + 
                    "dept_code," + 
                    "grade_code," + 
                    "attend_day," + 
                    "attend_reason," + 
                    "confirm_tag," + 
                    "input_date )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_attend_code);
      gpstatement.bindColumn(3, idx_start_date);
      gpstatement.bindColumn(4, idx_end_date);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_holiday);
      gpstatement.bindColumn(7, idx_comp_code);
      gpstatement.bindColumn(8, idx_dept_code);
      gpstatement.bindColumn(9, idx_grade_code);
      gpstatement.bindColumn(10, idx_attend_day);
      gpstatement.bindColumn(11, idx_attend_reason);
      gpstatement.bindColumn(12, idx_confirm_tag);
      gpstatement.bindColumn(13, idx_input_date);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_attend_input set " + 
                            "emp_no=?,  " + 
                            "attend_code=?,  " + 
                            "start_date=?,  " + 
                            "end_date=?,  " + 
                            "seq=?,  " + 
                            "holiday=?,  " + 
                            "comp_code=?,  " + 
                            "dept_code=?,  " + 
                            "grade_code=?,  " + 
                            "attend_day=?,  " + 
                            "attend_reason=?,  " + 
                            "confirm_tag=?,  " + 
                            "input_date=?  where emp_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_attend_code);
      gpstatement.bindColumn(3, idx_start_date);
      gpstatement.bindColumn(4, idx_end_date);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_holiday);
      gpstatement.bindColumn(7, idx_comp_code);
      gpstatement.bindColumn(8, idx_dept_code);
      gpstatement.bindColumn(9, idx_grade_code);
      gpstatement.bindColumn(10, idx_attend_day);
      gpstatement.bindColumn(11, idx_attend_reason);
      gpstatement.bindColumn(12, idx_confirm_tag);
      gpstatement.bindColumn(13, idx_input_date);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(14, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_attend_input where emp_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>