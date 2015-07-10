<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_unin_loan_master_3tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_union_code = dSet.indexOfColumn("union_code");
   	int idx_pay_degree = dSet.indexOfColumn("pay_degree");
   	int idx_degree_seq = dSet.indexOfColumn("degree_seq");
   	int idx_refund_date = dSet.indexOfColumn("refund_date");
   	int idx_refund_amt = dSet.indexOfColumn("refund_amt");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_UNIN_LOAN_REPAY ( dept_code," + 
                    "sell_code," + 
                    "union_code," + 
                    "pay_degree," + 
                    "degree_seq," + 
                    "refund_date," + 
                    "refund_amt," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_pay_degree);
      gpstatement.bindColumn(5, idx_degree_seq);
      gpstatement.bindColumn(6, idx_refund_date);
      gpstatement.bindColumn(7, idx_refund_amt);
      gpstatement.bindColumn(8, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_unin_loan_repay set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "union_code=?,  " + 
                            "pay_degree=?,  " + 
                            "degree_seq=?,  " + 
                            "refund_date=?,  " + 
                            "refund_amt=?,  " + 
                            "remark=?  where dept_code=? " +
                            "            and sell_code=? " +
                            "            and union_code=? " +
                            "            and pay_degree=? " +
                            "            and degree_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_pay_degree);
      gpstatement.bindColumn(5, idx_degree_seq);
      gpstatement.bindColumn(6, idx_refund_date);
      gpstatement.bindColumn(7, idx_refund_amt);
      gpstatement.bindColumn(8, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(9, idx_dept_code);
      gpstatement.bindColumn(10, idx_sell_code);
      gpstatement.bindColumn(11, idx_union_code);
      gpstatement.bindColumn(12, idx_pay_degree);
      gpstatement.bindColumn(13, idx_degree_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_unin_loan_repay where dept_code=? " +
                            "            and sell_code=? " +
                            "            and union_code=? " +
                            "            and pay_degree=? " +
                            "            and degree_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_pay_degree);
      gpstatement.bindColumn(5, idx_degree_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>