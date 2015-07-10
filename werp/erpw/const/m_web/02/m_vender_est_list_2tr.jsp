<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_vender_est_list_2tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_requestseq = dSet.indexOfColumn("requestseq");
   	int idx_chg_cnt = dSet.indexOfColumn("chg_cnt");
   	int idx_approve_class = dSet.indexOfColumn("approve_class");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_request set " + 
                            "approve_class=?  " + 
                            " where dept_code=? " +
                            " and requestseq=? " +
                            " and chg_cnt=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_approve_class);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_requestseq);
      gpstatement.bindColumn(4, idx_chg_cnt);
      stmt.executeUpdate();
      stmt.close();
   }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>