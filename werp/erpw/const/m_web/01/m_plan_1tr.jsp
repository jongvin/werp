<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_plan_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_key_mtrcode = dSet.indexOfColumn("key_mtrcode");
   	int idx_ditag = dSet.indexOfColumn("ditag");
   	int idx_key_ditag = dSet.indexOfColumn("key_ditag");
   	int idx_bd_qty = dSet.indexOfColumn("bd_qty");
   	int idx_bd_amt = dSet.indexOfColumn("bd_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_PLAN ( dept_code," + 
                    "mtrcode," + 
                    "ditag," + 
                    "bd_qty," + 
                    "bd_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_mtrcode);
      gpstatement.bindColumn(3, idx_ditag);
      gpstatement.bindColumn(4, idx_bd_qty);
      gpstatement.bindColumn(5, idx_bd_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update m_plan set " + 
                            "dept_code=?,  " + 
                            "mtrcode=?,  " + 
                            "ditag=?,  " + 
                            "bd_qty=?,  " + 
                            "bd_amt=?  where dept_code=? " +
                            " and mtrcode=? " +
                            " and ditag=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_mtrcode);
      gpstatement.bindColumn(3, idx_ditag);
      gpstatement.bindColumn(4, idx_bd_qty);
      gpstatement.bindColumn(5, idx_bd_amt);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(6, idx_dept_code);
      gpstatement.bindColumn(7, idx_key_mtrcode);
      gpstatement.bindColumn(8, idx_key_ditag);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from m_plan where dept_code=? " + 
                            " and mtrcode=? " +
                            " and ditag=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_key_mtrcode);
      gpstatement.bindColumn(3, idx_key_ditag);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>