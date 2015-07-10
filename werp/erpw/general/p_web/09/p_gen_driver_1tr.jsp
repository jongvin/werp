<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_gen_driver_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_work_yymm = dSet.indexOfColumn("work_yymm");
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_div_tag = dSet.indexOfColumn("div_tag");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_grade_code = dSet.indexOfColumn("grade_code");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_driver_amt = dSet.indexOfColumn("driver_amt");
   	int idx_parking_amt = dSet.indexOfColumn("parking_amt");
   	int idx_invoice_num = dSet.indexOfColumn("invoice_num");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_gen_driver_filial_piety ( work_yymm," + 
                    "emp_no," + 
                    "div_tag," + 
                    "comp_code," + 
                    "dept_code," + 
                    "grade_code," + 
                    "amt," + 
                    "remark," + 
                    "driver_amt," + 
                    "parking_amt," + 
                    "invoice_num )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_yymm);
      gpstatement.bindColumn(2, idx_emp_no);
      gpstatement.bindColumn(3, idx_div_tag);
      gpstatement.bindColumn(4, idx_comp_code);
      gpstatement.bindColumn(5, idx_dept_code);
      gpstatement.bindColumn(6, idx_grade_code);
      gpstatement.bindColumn(7, idx_amt);
      gpstatement.bindColumn(8, idx_remark);
      gpstatement.bindColumn(9, idx_driver_amt);
      gpstatement.bindColumn(10, idx_parking_amt);
      gpstatement.bindColumn(11, idx_invoice_num);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_gen_driver_filial_piety set " + 
                            "work_yymm=?,  " + 
                            "emp_no=?,  " + 
                            "div_tag=?,  " + 
                            "comp_code=?,  " + 
                            "dept_code=?,  " + 
                            "grade_code=?,  " + 
                            "amt=?,  " + 
                            "remark=?,  " + 
                            "driver_amt=?,  " + 
                            "parking_amt=?,  " + 
                            "invoice_num=?  where work_yymm=? and emp_no=? and div_tag=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_work_yymm);
      gpstatement.bindColumn(2, idx_emp_no);
      gpstatement.bindColumn(3, idx_div_tag);
      gpstatement.bindColumn(4, idx_comp_code);
      gpstatement.bindColumn(5, idx_dept_code);
      gpstatement.bindColumn(6, idx_grade_code);
      gpstatement.bindColumn(7, idx_amt);
      gpstatement.bindColumn(8, idx_remark);
      gpstatement.bindColumn(9, idx_driver_amt);
      gpstatement.bindColumn(10, idx_parking_amt);
      gpstatement.bindColumn(11, idx_invoice_num);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_work_yymm);
      gpstatement.bindColumn(13, idx_emp_no);
      gpstatement.bindColumn(14, idx_div_tag);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_gen_driver_filial_piety where work_yymm=? and emp_no=? and div_tag=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_work_yymm);
      gpstatement.bindColumn(2, idx_emp_no);
      gpstatement.bindColumn(3, idx_div_tag);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>