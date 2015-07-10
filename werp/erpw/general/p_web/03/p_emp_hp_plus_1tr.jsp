<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_mssql_portal_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_emp_hp_plus_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
   /* ds_1(mssql)에서 삭제되면 ds_2(oracle)에서 추가된 것이므로 close_tag를 'Y'(으)로 셋팅 */ 
   /* ds_1(mssql)에서 추가되면 ds_2(oracle)에서 삭제된 것이므로 close_tag를 'N'(으)로 셋팅 */ 
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