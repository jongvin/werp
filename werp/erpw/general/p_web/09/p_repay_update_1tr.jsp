<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_repay_update_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_repay_date = dSet.indexOfColumn("repay_date");
   	int idx_repay_amt = dSet.indexOfColumn("repay_amt");
   	int idx_interest_amt = dSet.indexOfColumn("interest_amt");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_b_loan_rem = dSet.indexOfColumn("b_loan_rem"); 	
   	int idx_b_repay_yn = dSet.indexOfColumn("b_repay_yn"); 	
   	
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
		if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
			String sSql = " INSERT INTO p_gen_repay ( " + 
	                    "spec_no_seq," + 
	                    "repay_date," + 
	                    "repay_amt," + 
	                    "interest_amt," + 
	                    "remark )      ";
	      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
	      stmt = conn.prepareStatement(sSql);
	      gpstatement.gp_stmt = stmt;
	      gpstatement.bindColumn(1, idx_spec_no_seq);
	      gpstatement.bindColumn(2, idx_repay_date);
	      gpstatement.bindColumn(3, idx_repay_amt);
	      gpstatement.bindColumn(4, idx_interest_amt);
	      gpstatement.bindColumn(5, idx_remark);
	      stmt.executeUpdate();
	      stmt.close();
	                         
	      sSql = " update p_gen_loan set  " +
	      				  " loan_rem=?, " +
	      				  " repay_yn=?  where  spec_no_seq=? " ; 
	      stmt = conn.prepareStatement(sSql); 
      	gpstatement.gp_stmt = stmt;
	      gpstatement.bindColumn(1, idx_b_loan_rem);
	      gpstatement.bindColumn(2, idx_b_repay_yn);
	   /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
	      gpstatement.bindColumn(3, idx_spec_no_seq);
	      stmt.executeUpdate();
	      stmt.close();
	    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>