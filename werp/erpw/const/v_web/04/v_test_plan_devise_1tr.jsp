<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_test_plan_devise_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_key_seq = dSet.indexOfColumn("key_seq");
   	int idx_d_seq = dSet.indexOfColumn("d_seq");
   	int idx_comm_wbs_code = dSet.indexOfColumn("comm_wbs_code");
   	int idx_branch_class = dSet.indexOfColumn("branch_class");
   	int idx_test_item = dSet.indexOfColumn("test_item");
   	int idx_test_method = dSet.indexOfColumn("test_method");
   	int idx_test_amt = dSet.indexOfColumn("test_amt");
   	int idx_test_frequency = dSet.indexOfColumn("test_frequency");
   	int idx_test_times = dSet.indexOfColumn("test_times");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO v_test_plan ( dept_code," + 
                    "seq," + 
                    "d_seq," + 
                    "comm_wbs_code," + 
                    "branch_class," + 
                    "test_item," + 
                    "test_method," + 
                    "test_amt," + 
                    "test_frequency," + 
                    "test_times," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
		stmt = conn.prepareStatement(sSql);
		gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_d_seq);
      gpstatement.bindColumn(4, idx_comm_wbs_code);
      gpstatement.bindColumn(5, idx_branch_class);
      gpstatement.bindColumn(6, idx_test_item);
      gpstatement.bindColumn(7, idx_test_method);
      gpstatement.bindColumn(8, idx_test_amt);
      gpstatement.bindColumn(9, idx_test_frequency);
      gpstatement.bindColumn(10, idx_test_times);
      gpstatement.bindColumn(11, idx_remark);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update v_test_plan set " + 
                            "dept_code=?,  " + 
                            "seq=?,  " + 
                            "d_seq=?,  " + 
                            "comm_wbs_code=?,  " + 
                            "branch_class=?,  " + 
                            "test_item=?,  " + 
                            "test_method=?,  " + 
                            "test_amt=?,  " + 
                            "test_frequency=?,  " + 
                            "test_times=?,  " + 
                            "remark=?  where dept_code=? and seq=? and d_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_d_seq);
      gpstatement.bindColumn(4, idx_comm_wbs_code);
      gpstatement.bindColumn(5, idx_branch_class);
      gpstatement.bindColumn(6, idx_test_item);
      gpstatement.bindColumn(7, idx_test_method);
      gpstatement.bindColumn(8, idx_test_amt);
      gpstatement.bindColumn(9, idx_test_frequency);
      gpstatement.bindColumn(10, idx_test_times);
      gpstatement.bindColumn(11, idx_remark);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(12, idx_dept_code);
      gpstatement.bindColumn(13, idx_key_seq);
      gpstatement.bindColumn(14, idx_d_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from v_test_plan where dept_code=? and seq=? and d_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_seq);
      gpstatement.bindColumn(3, idx_d_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>