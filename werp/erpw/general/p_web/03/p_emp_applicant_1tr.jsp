<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_emp_applicant_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_employ_degree = dSet.indexOfColumn("employ_degree");
   	int idx_appl_no = dSet.indexOfColumn("appl_no");
   	int idx_apply_code = dSet.indexOfColumn("apply_code");
   	int idx_appl_name = dSet.indexOfColumn("appl_name");
   	int idx_appl_part = dSet.indexOfColumn("appl_part");
   	int idx_appl_part2 = dSet.indexOfColumn("appl_part2");
   	int idx_birth_date = dSet.indexOfColumn("birth_date");
   	int idx_age = dSet.indexOfColumn("age");
   	int idx_sex = dSet.indexOfColumn("sex");
   	int idx_tel_no = dSet.indexOfColumn("tel_no");
   	int idx_addr = dSet.indexOfColumn("addr");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_emp_applicant ( employ_degree," + 
                    "appl_no," + 
                    "apply_code," + 
                    "appl_name," + 
                    "appl_part," + 
                    "appl_part2," + 
                    "birth_date," + 
                    "age," + 
                    "sex," + 
                    "tel_no," + 
                    "addr )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_employ_degree);
      gpstatement.bindColumn(2, idx_appl_no);
      gpstatement.bindColumn(3, idx_apply_code);
      gpstatement.bindColumn(4, idx_appl_name);
      gpstatement.bindColumn(5, idx_appl_part);
      gpstatement.bindColumn(6, idx_appl_part2);
      gpstatement.bindColumn(7, idx_birth_date);
      gpstatement.bindColumn(8, idx_age);
      gpstatement.bindColumn(9, idx_sex);
      gpstatement.bindColumn(10, idx_tel_no);
      gpstatement.bindColumn(11, idx_addr);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update p_emp_applicant set " + 
                            "employ_degree=?,  " + 
                            "appl_no=?,  " + 
                            "apply_code," + 
                            "appl_name=?,  " + 
                            "appl_part=?,  " + 
                            "appl_part2=?,  " + 
                            "birth_date=?,  " + 
                            "age=?,  " + 
                            "sex=?,  " + 
                            "tel_no=?,  " + 
                            "addr=?  where employ_degree=? and appl_no=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_employ_degree);
      gpstatement.bindColumn(2, idx_appl_no);
      gpstatement.bindColumn(3, idx_apply_code);
      gpstatement.bindColumn(4, idx_appl_name);
      gpstatement.bindColumn(5, idx_appl_part);
      gpstatement.bindColumn(6, idx_appl_part2);
      gpstatement.bindColumn(7, idx_birth_date);
      gpstatement.bindColumn(8, idx_age);
      gpstatement.bindColumn(9, idx_sex);
      gpstatement.bindColumn(10, idx_tel_no);
      gpstatement.bindColumn(11, idx_addr);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(12, idx_employ_degree);
      gpstatement.bindColumn(13, idx_appl_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from p_emp_applicant where employ_degree=? and appl_no=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_employ_degree);
      gpstatement.bindColumn(2, idx_appl_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>