<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_order_add_dept_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_emp_no = dSet.indexOfColumn("emp_no");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_add_dept_code = dSet.indexOfColumn("add_dept_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_start_date = dSet.indexOfColumn("start_date");
   	int idx_end_date = dSet.indexOfColumn("end_date");
   	int idx_cancel_tag = dSet.indexOfColumn("cancel_tag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_order_add_dept ( emp_no," + 
                    "spec_no_seq," + 
                    "add_dept_code," + 
                    "seq," + 
                    "start_date," + 
                    "end_date," + 
                    "cancel_tag )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_add_dept_code);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_start_date);
      gpstatement.bindColumn(6, idx_end_date);
      gpstatement.bindColumn(7, idx_cancel_tag);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update p_order_add_dept set " + 
                            "emp_no=?,  " + 
                            "spec_no_seq=?,  " + 
                            "add_dept_code=?,  " + 
                            "seq=?,  " + 
                            "start_date=?,  " + 
                            "end_date=?,  " + 
                            "cancel_tag=?  where emp_no=? and spec_no_seq=? and add_dept_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_add_dept_code);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_start_date);
      gpstatement.bindColumn(6, idx_end_date); 
      gpstatement.bindColumn(7, idx_cancel_tag);     
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(8, idx_emp_no);
      gpstatement.bindColumn(9, idx_spec_no_seq);
      gpstatement.bindColumn(10, idx_add_dept_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from p_order_add_dept where emp_no=? and spec_no_seq=? and add_dept_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_emp_no);
      gpstatement.bindColumn(2, idx_spec_no_seq);
      gpstatement.bindColumn(3, idx_add_dept_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>