<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_slip_acc_code_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_key					= dSet.indexOfColumn("key");
	int idx_old_key					= dSet.indexOfColumn("old_key");
	int idx_��ǥ����			= dSet.indexOfColumn("��ǥ����");
	int idx_��ǥ����			= dSet.indexOfColumn("��ǥ����");
	int idx_����_������Ī = dSet.indexOfColumn("����_������Ī");
	int idx_����_�����ڵ� = dSet.indexOfColumn("����_�����ڵ�");
	int idx_�뺯_������Ī = dSet.indexOfColumn("�뺯_������Ī");
	int idx_�뺯_�����ڵ� = dSet.indexOfColumn("�뺯_�����ڵ�");
   	
	int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_slip_acc_code_table "+
			        "				( key," + 
					"				 ��ǥ����," + 
					"				 ��ǥ����," + 
					"				 ����_������Ī," + 
					"				 ����_�����ڵ�," + 
					"				 �뺯_������Ī,"+
			        "				   �뺯_�����ڵ�)"      ;
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_key					);
      gpstatement.bindColumn(2, idx_��ǥ����			);
	  gpstatement.bindColumn(3, idx_��ǥ����			);
	  gpstatement.bindColumn(4, idx_����_������Ī);
	  gpstatement.bindColumn(5, idx_����_�����ڵ�);
	  gpstatement.bindColumn(6, idx_�뺯_������Ī);
	  gpstatement.bindColumn(7, idx_�뺯_�����ڵ�);
      stmt.executeUpdate();			
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update h_slip_acc_code_table set " + 
	                        " KEY                   =?,"+
							" ��ǥ����          =?,"+
							" ��ǥ����          =?,"+
	 						" ����_������Ī =?,"+
	 						" ����_�����ڵ� =?,"+
	 						" �뺯_������Ī =?,"+
	 						" �뺯_�����ڵ� =?"+
                            " where key=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_key					 );
      gpstatement.bindColumn(2, idx_��ǥ����			 );
	  gpstatement.bindColumn(3, idx_��ǥ����			 );
	  gpstatement.bindColumn(4, idx_����_������Ī );
	  gpstatement.bindColumn(5, idx_����_�����ڵ� );
	  gpstatement.bindColumn(6, idx_�뺯_������Ī );
	  gpstatement.bindColumn(7, idx_�뺯_�����ڵ� );
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(8, idx_old_key);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from h_slip_acc_code_table where key=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_key					 );
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>