<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_mssql_portal_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_emp_result_hp_plus_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_resident_no = dSet.indexOfColumn("resident_no");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
   /* ds_1(oracle)에서 최종승인하면 ds_hp(mssql)에서 이력서를 수정 가능하도록 close_tag를 'N'(으)로 셋팅 */ 
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
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