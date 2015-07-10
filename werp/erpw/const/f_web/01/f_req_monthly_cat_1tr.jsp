<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("f_req_monthly_cat_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
	int idx_req_mnth = dSet.indexOfColumn("req_mnth");
	int idx_approve_tag = dSet.indexOfColumn("approve_tag");
	int idx_trans_amt1 = dSet.indexOfColumn("trans_amt1");
	int idx_trans_amt2 = dSet.indexOfColumn("trans_amt2");
	int idx_memo = dSet.indexOfColumn("memo");
		
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update f_req_cat set " + 
					" approve_tag=?," + 
                    " trans_amt1=?," + 
                    " trans_amt2=?," + 
                    " memo=?" +
                            "  where dept_code=?  " + 
                            " and req_mnth=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_approve_tag);
      gpstatement.bindColumn(2, idx_trans_amt1);
      gpstatement.bindColumn(3, idx_trans_amt2);
      gpstatement.bindColumn(4, idx_memo);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(5, idx_dept_code);
      gpstatement.bindColumn(6, idx_req_mnth);
      stmt.executeUpdate();
      stmt.close();
   }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>