<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_code_common_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_code_div = dSet.indexOfColumn("code_div");
   	int idx_code = dSet.indexOfColumn("code");
   	int idx_code_name = dSet.indexOfColumn("code_name");
   	int idx_old_code = dSet.indexOfColumn("old_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_code_common ( code_div," + 
                    "code," + 
                    "code_name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_code_div);
      gpstatement.bindColumn(2, idx_code);
      gpstatement.bindColumn(3, idx_code_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "update h_code_common set " + 
                            "code_div=?,  " + 
                            "code=?,  " + 
                            "code_name=?  where code_div=? and code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_code_div);
      gpstatement.bindColumn(2, idx_code);
      gpstatement.bindColumn(3, idx_code_name);
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(4, idx_code_div);
      gpstatement.bindColumn(5, idx_old_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = "delete from h_code_common where code_div=? and code=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_code_div);
      gpstatement.bindColumn(2, idx_old_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>