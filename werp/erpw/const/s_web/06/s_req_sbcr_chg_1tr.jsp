<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_req_sbcr_chg_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_user_code = dSet.indexOfColumn("user_code");
   	int idx_sbcr_code = dSet.indexOfColumn("sbcr_code");
   	int idx_sbcr_name = dSet.indexOfColumn("sbcr_name");
   	int idx_gubun = dSet.indexOfColumn("gubun");
    	int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
 
	if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_webuser_code set " + 
                            "sbcr_code=?,  " + 
                            "sbcr_name=?,  " +
                            "gubun=? where user_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_sbcr_code);
      gpstatement.bindColumn(2, idx_sbcr_name);
      gpstatement.bindColumn(3, idx_gubun);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_user_code);
      stmt.executeUpdate();
      stmt.close();
   }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>