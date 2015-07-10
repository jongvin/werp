<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_mssql_portal_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_emp_hp_plus_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
   /* ds_1(mssql)���� �����Ǹ� ds_2(oracle)���� �߰��� ���̹Ƿ� close_tag�� 'Y'(��)�� ���� */ 
   /* ds_1(mssql)���� �߰��Ǹ� ds_2(oracle)���� ������ ���̹Ƿ� close_tag�� 'N'(��)�� ���� */ 
	if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){		
      String sSql = "update recruit_resume set " + 
                            "close_tag='Y' where resident_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
   	String sSql = "update recruit_resume set " + 
                            "close_tag='N' where resident_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_resident_no);
      stmt.executeUpdate();
      stmt.close();
   }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>