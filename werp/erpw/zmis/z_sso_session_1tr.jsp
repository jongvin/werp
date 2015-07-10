<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../comm_function/conn_mssql_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_sso_session_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_empno = dSet.indexOfColumn("sessionkey");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
      String sSql = "delete from sso_login where sessionkey=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_empno);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../comm_function/conn_tr_end.jsp"%>