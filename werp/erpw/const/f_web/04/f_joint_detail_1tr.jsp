<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("f_joint_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_rqst_date = dSet.indexOfColumn("rqst_date");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_cust_code = dSet.indexOfColumn("cust_code");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_vat = dSet.indexOfColumn("vat");
   	int idx_actual_inv_tag = dSet.indexOfColumn("actual_inv_tag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO F_JOINT_DISTRIBUTION ( dept_code," + 
                    "rqst_date," + 
                    "seq," + 
                    "cust_code," + 
                    "amt," + 
                    "vat," + 
                    "actual_inv_tag )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_rqst_date);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_cust_code);
      gpstatement.bindColumn(5, idx_amt);
      gpstatement.bindColumn(6, idx_vat);
      gpstatement.bindColumn(7, idx_actual_inv_tag);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update f_joint_distribution set " + 
                            "dept_code=?,  " + 
                            "rqst_date=?,  " + 
                            "seq=?,  " + 
                            "cust_code=?,  " + 
                            "amt=?,  " + 
                            "vat=?,  " + 
                            "actual_inv_tag=?  where dept_code=? " +
                            " and rqst_date=?  " + 
                            " and seq=?  " + 
                            " and cust_code=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_rqst_date);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_cust_code);
      gpstatement.bindColumn(5, idx_amt);
      gpstatement.bindColumn(6, idx_vat);
      gpstatement.bindColumn(7, idx_actual_inv_tag);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(8, idx_dept_code);
      gpstatement.bindColumn(9, idx_rqst_date);
      gpstatement.bindColumn(10, idx_seq);
      gpstatement.bindColumn(11, idx_cust_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from f_joint_distribution where dept_code=? " + 
                            " and rqst_date=?  " + 
                            " and seq=?  " + 
                            " and cust_code=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_rqst_date);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_cust_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>