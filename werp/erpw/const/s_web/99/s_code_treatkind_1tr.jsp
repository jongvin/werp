<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     conn.setAutoCommit(false);
     GauceDataSet dSet = req.getGauceDataSet("s_code_treatkind_1tr"); 
     gpstatement.gp_dataset = dSet;                                    // �̹����� �߰� 
   	int idx_treatkind_code = dSet.indexOfColumn("treatkind_code");
   	int idx_treatkind_name = dSet.indexOfColumn("treatkind_name");
   	int idx_key_treatkind_code = dSet.indexOfColumn("key_treatkind_code");     // key�� update�ϱ����� ����key
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); 
      gpstatement.gp_row = i;                                         // �̹��� �߰�
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_code_treatkind ( treatkind_code," + 
                    "treatkind_name )      ";
      sSql = sSql + " VALUES ( :1, :2 ) ";
      stmt = conn.prepareStatement(sSql);                             // ���� ���� 
      gpstatement.gp_stmt = stmt;                                     // ���� ����
      gpstatement.bindColumn(1, idx_treatkind_code);
      gpstatement.bindColumn(2, idx_treatkind_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update s_code_treatkind set " + 
                            "treatkind_code=?,  " + 
                            "treatkind_name=?  where treatkind_code=? ";  
      stmt = conn.prepareStatement(sSql);                            // ���� ���� 
      gpstatement.gp_stmt = stmt;                                    // ���� ���� 
      gpstatement.bindColumn(1, idx_treatkind_code);
      gpstatement.bindColumn(2, idx_treatkind_name);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(3, idx_key_treatkind_code);   // key�� update�ϱ����� ����key
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from s_code_treatkind where treatkind_code=? "; 
      stmt = conn.prepareStatement(sSql);                           // ���� ���� 
      gpstatement.gp_stmt = stmt;                                   // ���� ���� 
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_key_treatkind_code);      // key�� update�ϱ����� ����key
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>