<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_emp_pass_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_employ_degree = dSet.indexOfColumn("employ_degree");
   	int idx_interview_degree = dSet.indexOfColumn("interview_degree");
   	int idx_appl_no = dSet.indexOfColumn("appl_no");
   	int idx_pass_tag = dSet.indexOfColumn("pass_tag");
   	int idx_last_approval = dSet.indexOfColumn("last_approval");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_emp_pass ( employ_degree," + 
                    "interview_degree," + 
                    "appl_no," + 
                    "pass_tag," + 
                    "last_approval )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_employ_degree);
      gpstatement.bindColumn(2, idx_interview_degree);
      gpstatement.bindColumn(3, idx_appl_no);
      gpstatement.bindColumn(4, idx_pass_tag);
      gpstatement.bindColumn(5, idx_last_approval);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update p_emp_pass set " + 
                            "employ_degree=?,  " + 
                            "interview_degree=?,  " + 
                            "appl_no=?,  " + 
                            "pass_tag=?,  " + 
                            "last_approval=?  where employ_degree=? and interview_degree=? and appl_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_employ_degree);
      gpstatement.bindColumn(2, idx_interview_degree);
      gpstatement.bindColumn(3, idx_appl_no);
      gpstatement.bindColumn(4, idx_pass_tag);
      gpstatement.bindColumn(5, idx_last_approval);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(6, idx_employ_degree);
      gpstatement.bindColumn(7, idx_interview_degree);
      gpstatement.bindColumn(8, idx_appl_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from p_emp_pass where employ_degree=? and interview_degree=? and appl_no=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_employ_degree);
      gpstatement.bindColumn(2, idx_interview_degree);
      gpstatement.bindColumn(3, idx_appl_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>