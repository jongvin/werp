<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_inter_audit_result_2tr"); gpstatement.gp_dataset = dSet;
   	int idx_part_code = dSet.indexOfColumn("part_code");
   	int idx_year = dSet.indexOfColumn("year");
   	int idx_half_year = dSet.indexOfColumn("half_year");
   	int idx_comm_section = dSet.indexOfColumn("comm_section");
		int idx_seq = dSet.indexOfColumn("seq");
   	int idx_d_seq = dSet.indexOfColumn("d_seq");
   	int idx_section = dSet.indexOfColumn("section");
   	int idx_ins_contents = dSet.indexOfColumn("ins_contents");
   	int idx_ins_basis = dSet.indexOfColumn("ins_basis");
		int idx_opinion = dSet.indexOfColumn("opinion");

     int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = " update V_INTER_AUDIT_RESULT_ITEM set " + 
                    " opinion =? " + 
                    " WHERE part_code =? " +
						  " AND to_char(year,'yyyy') =? " +
						  " AND half_year =? " +
						  " AND comm_section =? " +
						  " AND section =? " ;

		stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_opinion);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
		gpstatement.bindColumn(2, idx_part_code);
		gpstatement.bindColumn(3, idx_year);
		gpstatement.bindColumn(4, idx_half_year);
		gpstatement.bindColumn(5, idx_comm_section);
		gpstatement.bindColumn(6, idx_section);

		stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 

 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>