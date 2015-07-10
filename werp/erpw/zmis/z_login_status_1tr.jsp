<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../comm_function/conn_gauce_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_login_status_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_seq_key = dSet.indexOfColumn("seq_key");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_login_status where seq_key=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_seq_key);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../comm_function/conn_tr_end.jsp"%>