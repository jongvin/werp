<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_mssql_confirm_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_approval_03_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_unq_num = dSet.indexOfColumn("unq_num");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_ssize = dSet.indexOfColumn("ssize");
   	int idx_unitcode = dSet.indexOfColumn("unitcode");
   	int idx_qty = dSet.indexOfColumn("qty");
   	int idx_unitprice = dSet.indexOfColumn("unitprice");
   	int idx_amt = dSet.indexOfColumn("amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_APPROVAL_03 ( unq_num," + 
                    "no_seq," + 
                    "name," + 
                    "ssize," + 
                    "unitcode," + 
                    "qty," + 
                    "unitprice," + 
                    "amt )      ";
      sSql = sSql + " VALUES ( ?, ?, ?, ?, ?, ?, ?, ? ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_name);
      gpstatement.bindColumn(4, idx_ssize);
      gpstatement.bindColumn(5, idx_unitcode);
      gpstatement.bindColumn(6, idx_qty);
      gpstatement.bindColumn(7, idx_unitprice);
      gpstatement.bindColumn(8, idx_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update m_approval_03 set " + 
                            "unq_num=?,  " + 
                            "no_seq=?,  " + 
                            "name=?,  " + 
                            "ssize=?,  " + 
                            "unitcode=?,  " + 
                            "qty=?,  " + 
                            "unitprice=?,  " + 
                            "amt=?  where unq_num=? and no_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_name);
      gpstatement.bindColumn(4, idx_ssize);
      gpstatement.bindColumn(5, idx_unitcode);
      gpstatement.bindColumn(6, idx_qty);
      gpstatement.bindColumn(7, idx_unitprice);
      gpstatement.bindColumn(8, idx_amt);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(9, idx_unq_num);
      gpstatement.bindColumn(10, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from m_approval_03 where unq_num=? and no_seq=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_unq_num);
      gpstatement.bindColumn(2, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>