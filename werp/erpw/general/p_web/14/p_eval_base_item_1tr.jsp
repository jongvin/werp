<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_eval_base_item_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_eval_code = dSet.indexOfColumn("eval_code");
   	int idx_eval_degree = dSet.indexOfColumn("eval_degree");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_base_code = dSet.indexOfColumn("base_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_section_item = dSet.indexOfColumn("section_item");
   	int idx_detail_item = dSet.indexOfColumn("detail_item");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_eval_base_item ( eval_code," + 
                    "eval_degree," + 
                    "spec_no_seq," + 
                    "base_code," + 
                    "seq," + 
                    "section_item," + 
                    "detail_item )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_degree);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_base_code);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_section_item);
      gpstatement.bindColumn(7, idx_detail_item);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update p_eval_base_item set " + 
                            "eval_code=?,  " + 
                            "eval_degree=?,  " + 
                            "spec_no_seq=?,  " + 
                            "base_code=?,  " + 
                            "seq=?,  " + 
                            "section_item=?,  " + 
                            "detail_item=?  where eval_code=? and eval_degree=? and spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_degree);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      gpstatement.bindColumn(4, idx_base_code);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_section_item);
      gpstatement.bindColumn(7, idx_detail_item);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(8, idx_eval_code);
      gpstatement.bindColumn(9, idx_eval_degree);
      gpstatement.bindColumn(10, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from p_eval_base_item where eval_code=? and eval_degree=? and spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_eval_code);
      gpstatement.bindColumn(2, idx_eval_degree);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>