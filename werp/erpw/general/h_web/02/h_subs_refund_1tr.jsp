<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_subs_refund_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_subs_no = dSet.indexOfColumn("subs_no");
   	int idx_refund_date = dSet.indexOfColumn("refund_date");
   	int idx_receiver_name = dSet.indexOfColumn("receiver_name");
   	int idx_subs_relation = dSet.indexOfColumn("subs_relation");
   	int idx_bank_head_code = dSet.indexOfColumn("bank_head_code");
   	int idx_refund_deposit_no = dSet.indexOfColumn("refund_deposit_no");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_subs_master set " + 
                            "refund_date=?,  " + 
                            "receiver_name=?,  " + 
                            "subs_relation=?,  " + 
                            "bank_head_code=?,  " + 
                            "refund_deposit_no=?  where dept_code=? and sell_code=? and subs_no=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_refund_date);
      gpstatement.bindColumn(2, idx_receiver_name);
      gpstatement.bindColumn(3, idx_subs_relation);
      gpstatement.bindColumn(4, idx_bank_head_code);
      gpstatement.bindColumn(5, idx_refund_deposit_no);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_dept_code);
      gpstatement.bindColumn(7, idx_sell_code);
      gpstatement.bindColumn(8, idx_subs_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>