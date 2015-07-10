<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pers_cont_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
   	int idx_emp_name = dSet.indexOfColumn("emp_name");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_grade_code = dSet.indexOfColumn("grade_code");
   	int idx_school_car_code = dSet.indexOfColumn("school_car_code");
   	int idx_last_school_name = dSet.indexOfColumn("last_school_name");
   	int idx_contract_sdate = dSet.indexOfColumn("contract_sdate");
   	int idx_contract_edate = dSet.indexOfColumn("contract_edate");
   	int idx_zip_code = dSet.indexOfColumn("zip_code");
   	int idx_addr1 = dSet.indexOfColumn("addr1");
   	int idx_addr2 = dSet.indexOfColumn("addr2");
   	int idx_house_phone = dSet.indexOfColumn("house_phone");
   	int idx_cell_phone = dSet.indexOfColumn("cell_phone");
   	int idx_e_mail = dSet.indexOfColumn("e_mail");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pers_cont ( emp_no," + 
                    "resident_no," + 
                    "emp_name," + 
                    "comp_code," + 
                    "dept_code," + 
                    "grade_code," + 
                    "school_car_code," + 
                    "last_school_name," + 
                    "contract_sdate," + 
                    "contract_edate," + 
                    "zip_code," + 
                    "addr1," + 
                    "addr2," + 
                    "house_phone," + 
                    "cell_phone," + 
                    "e_mail," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_resident_no);
      gpstatement.bindColumn(3, idx_emp_name);
      gpstatement.bindColumn(4, idx_comp_code);
      gpstatement.bindColumn(5, idx_dept_code);
      gpstatement.bindColumn(6, idx_grade_code);
      gpstatement.bindColumn(7, idx_school_car_code);
      gpstatement.bindColumn(8, idx_last_school_name);
      gpstatement.bindColumn(9, idx_contract_sdate);
      gpstatement.bindColumn(10, idx_contract_edate);
      gpstatement.bindColumn(11, idx_zip_code);
      gpstatement.bindColumn(12, idx_addr1);
      gpstatement.bindColumn(13, idx_addr2);
      gpstatement.bindColumn(14, idx_house_phone);
      gpstatement.bindColumn(15, idx_cell_phone);
      gpstatement.bindColumn(16, idx_e_mail);
      gpstatement.bindColumn(17, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_pers_cont set " + 
                            "emp_no=?,  " + 
                            "resident_no=?,  " + 
                            "emp_name=?,  " + 
                            "comp_code=?,  " + 
                            "dept_code=?,  " + 
                            "grade_code=?,  " + 
                            "school_car_code=?,  " + 
                            "last_school_name=?,  " + 
                            "contract_sdate=?,  " + 
                            "contract_edate=?,  " + 
                            "zip_code=?,  " + 
                            "addr1=?,  " + 
                            "addr2=?,  " + 
                            "house_phone=?,  " + 
                            "cell_phone=?,  " + 
                            "e_mail=?,  " + 
                            "remark=?  where emp_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_resident_no);
      gpstatement.bindColumn(3, idx_emp_name);
      gpstatement.bindColumn(4, idx_comp_code);
      gpstatement.bindColumn(5, idx_dept_code);
      gpstatement.bindColumn(6, idx_grade_code);
      gpstatement.bindColumn(7, idx_school_car_code);
      gpstatement.bindColumn(8, idx_last_school_name);
      gpstatement.bindColumn(9, idx_contract_sdate);
      gpstatement.bindColumn(10, idx_contract_edate);
      gpstatement.bindColumn(11, idx_zip_code);
      gpstatement.bindColumn(12, idx_addr1);
      gpstatement.bindColumn(13, idx_addr2);
      gpstatement.bindColumn(14, idx_house_phone);
      gpstatement.bindColumn(15, idx_cell_phone);
      gpstatement.bindColumn(16, idx_e_mail);
      gpstatement.bindColumn(17, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(18, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_pers_cont where emp_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_emp_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>