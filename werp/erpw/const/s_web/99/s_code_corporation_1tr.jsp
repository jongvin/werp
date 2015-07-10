<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     conn.setAutoCommit(false);
     GauceDataSet dSet = req.getGauceDataSet("s_code_corporation_1tr"); 
     gpstatement.gp_dataset = dSet;                                    // �̹����� �߰� 
   	int idx_corporation_section = dSet.indexOfColumn("corporation_section");
   	int idx_section_name = dSet.indexOfColumn("section_name");
   	int idx_register_chk = dSet.indexOfColumn("register_chk");
   	int idx_key_corporation_section = dSet.indexOfColumn("key_corporation_section");  // key�� update�ϱ����� ����key
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); 
      gpstatement.gp_row = i;                                         // �̹��� �߰�
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_code_corporation ( corporation_section," + 
                    "section_name," + 
                    "register_chk )      ";
      sSql = sSql + " VALUES ( :1, :2, :3 ) ";
      stmt = conn.prepareStatement(sSql);                             // ���� ���� 
      gpstatement.gp_stmt = stmt;                                     // ���� ����
      gpstatement.bindColumn(1, idx_corporation_section);
      gpstatement.bindColumn(2, idx_section_name);
      gpstatement.bindColumn(3, idx_register_chk);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update s_code_corporation set " + 
                            "corporation_section=?,  " + 
                            "section_name=?,  " + 
                            "register_chk=?  where corporation_section=? ";  
      stmt = conn.prepareStatement(sSql);                             // ���� ���� 
      gpstatement.gp_stmt = stmt;                                     // ���� ����
      gpstatement.bindColumn(1, idx_corporation_section);
      gpstatement.bindColumn(2, idx_section_name);
      gpstatement.bindColumn(3, idx_register_chk);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(4, idx_key_corporation_section);       // key�� update�ϱ����� ����key
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from s_code_corporation where corporation_section=? "; 
      stmt = conn.prepareStatement(sSql);                             // ���� ���� 
      gpstatement.gp_stmt = stmt;                                     // ���� ����
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_key_corporation_section);   // key�� update�ϱ����� ����key
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ include file="../../../comm_function/conn_tr_end.jsp"%>