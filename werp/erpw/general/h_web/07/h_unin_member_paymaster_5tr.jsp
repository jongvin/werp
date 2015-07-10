<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_unin_member_paymaster_5tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_union_code = dSet.indexOfColumn("union_code");
   	int idx_union_id = dSet.indexOfColumn("union_id");
   	int idx_union_seq = dSet.indexOfColumn("union_seq");
   	int idx_pay_degree = dSet.indexOfColumn("pay_degree");
   	int idx_degree_code = dSet.indexOfColumn("degree_code");
   	int idx_degree_seq = dSet.indexOfColumn("degree_seq");
   	int idx_receipt_date = dSet.indexOfColumn("receipt_date");
   	int idx_r_amt = dSet.indexOfColumn("r_amt");
   	int idx_delay_days = dSet.indexOfColumn("delay_days");
   	int idx_delay_amt = dSet.indexOfColumn("delay_amt");
   	int idx_discount_days = dSet.indexOfColumn("discount_days");
   	int idx_discount_amt = dSet.indexOfColumn("discount_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_UNIN_INTR_REPAY ( dept_code," + 
                    "sell_code," + 
                    "union_code," + 
                    "union_id," + 
                    "union_seq," + 
                    "pay_degree," + 
                    "degree_code," + 
                    "degree_seq," + 
                    "receipt_date," + 
                    "r_amt," + 
                    "delay_days," + 
                    "delay_amt," + 
                    "discount_days," + 
                    "discount_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_union_id);
      gpstatement.bindColumn(5, idx_union_seq);
      gpstatement.bindColumn(6, idx_pay_degree);
      gpstatement.bindColumn(7, idx_degree_code);
      gpstatement.bindColumn(8, idx_degree_seq);
      gpstatement.bindColumn(9, idx_receipt_date);
      gpstatement.bindColumn(10, idx_r_amt);
      gpstatement.bindColumn(11, idx_delay_days);
      gpstatement.bindColumn(12, idx_delay_amt);
      gpstatement.bindColumn(13, idx_discount_days);
      gpstatement.bindColumn(14, idx_discount_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_unin_intr_repay set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "union_code=?,  " + 
                            "union_id=?,  " + 
                            "union_seq=?,  " + 
                            "pay_degree=?,  " + 
                            "degree_code=?,  " + 
                            "degree_seq=?,  " + 
                            "receipt_date=?,  " + 
                            "r_amt=?,  " + 
                            "delay_days=?,  " + 
                            "delay_amt=?,  " + 
                            "discount_days=?,  " + 
                            "discount_amt=?  where dept_code=? " +
                            "                  and sell_code=? " +
                            "                  and union_code=? " +
                            "                  and union_id=? " +
                            "                  and union_seq=? " +
                            "                  and pay_degree=? " +
                            "                  and degree_code=? " +
                            "                  and degree_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_union_id);
      gpstatement.bindColumn(5, idx_union_seq);
      gpstatement.bindColumn(6, idx_pay_degree);
      gpstatement.bindColumn(7, idx_degree_code);
      gpstatement.bindColumn(8, idx_degree_seq);
      gpstatement.bindColumn(9, idx_receipt_date);
      gpstatement.bindColumn(10, idx_r_amt);
      gpstatement.bindColumn(11, idx_delay_days);
      gpstatement.bindColumn(12, idx_delay_amt);
      gpstatement.bindColumn(13, idx_discount_days);
      gpstatement.bindColumn(14, idx_discount_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(15, idx_dept_code);
      gpstatement.bindColumn(16, idx_sell_code);
      gpstatement.bindColumn(17, idx_union_code);
      gpstatement.bindColumn(18, idx_union_id);
      gpstatement.bindColumn(19, idx_union_seq);
      gpstatement.bindColumn(20, idx_pay_degree);
      gpstatement.bindColumn(21, idx_degree_code);
      gpstatement.bindColumn(22, idx_degree_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_unin_intr_repay where dept_code=? " +
                            "                  and sell_code=? " +
                            "                  and union_code=? " +
                            "                  and union_id=? " +
                            "                  and union_seq=? " +
                            "                  and pay_degree=? " +
                            "                  and degree_code=? " +
                            "                  and degree_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_union_id);
      gpstatement.bindColumn(5, idx_union_seq);
      gpstatement.bindColumn(6, idx_pay_degree);
      gpstatement.bindColumn(7, idx_degree_code);
      gpstatement.bindColumn(8, idx_degree_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>