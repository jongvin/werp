<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_income_detail_10tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_unique_div = dSet.indexOfColumn("unique_div");
   	int idx_key_unique_div = dSet.indexOfColumn("key_unique_div");
   	int idx_effect_no = dSet.indexOfColumn("effect_no");
   	int idx_key_effect_no = dSet.indexOfColumn("key_effect_no");
   	int idx_delivery_date = dSet.indexOfColumn("delivery_date");
   	int idx_creditor = dSet.indexOfColumn("creditor");
   	int idx_bond_amt = dSet.indexOfColumn("bond_amt");
   	int idx_cancel_yn = dSet.indexOfColumn("cancel_yn");
   	int idx_cancel_date = dSet.indexOfColumn("cancel_date");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_input_id = dSet.indexOfColumn("input_id");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_SALE_ETC ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "unique_div," + 
                    "effect_no," + 
                    "delivery_date," + 
                    "creditor," + 
                    "bond_amt," + 
                    "cancel_yn," + 
                    "cancel_date," + 
                    "remark , " +
                    "input_id )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_unique_div);
      gpstatement.bindColumn(6, idx_effect_no);
      gpstatement.bindColumn(7, idx_delivery_date);
      gpstatement.bindColumn(8, idx_creditor);
      gpstatement.bindColumn(9, idx_bond_amt);
      gpstatement.bindColumn(10, idx_cancel_yn);
      gpstatement.bindColumn(11, idx_cancel_date);
      gpstatement.bindColumn(12, idx_remark);
      gpstatement.bindColumn(13, idx_input_id);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_sale_etc set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "unique_div=?,  " + 
                            "effect_no=?,  " + 
                            "delivery_date=?,  " + 
                            "creditor=?,  " + 
                            "bond_amt=?,  " + 
                            "cancel_yn=?,  " + 
                            "cancel_date=?,  " + 
                            "remark=?, " +
                            "input_id=?  where dept_code=? " +
                            "            and sell_code=? " +
                            "            and dongho=? " +
                            "            and seq=? " +
                            "            and unique_div=? " +
                            "            and effect_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_unique_div);
      gpstatement.bindColumn(6, idx_effect_no);
      gpstatement.bindColumn(7, idx_delivery_date);
      gpstatement.bindColumn(8, idx_creditor);
      gpstatement.bindColumn(9, idx_bond_amt);
      gpstatement.bindColumn(10, idx_cancel_yn);
      gpstatement.bindColumn(11, idx_cancel_date);
      gpstatement.bindColumn(12, idx_remark);
      gpstatement.bindColumn(13, idx_input_id);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(14, idx_dept_code);
      gpstatement.bindColumn(15, idx_sell_code);
      gpstatement.bindColumn(16, idx_dongho);
      gpstatement.bindColumn(17, idx_seq);
      gpstatement.bindColumn(18, idx_key_unique_div);
      gpstatement.bindColumn(19, idx_key_effect_no);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_sale_etc where dept_code=? " + 
                            "            and sell_code=? " +
                            "            and dongho=? " +
                            "            and seq=? " +
                            "            and unique_div=? " +
                            "            and effect_no=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_key_unique_div);
      gpstatement.bindColumn(6, idx_key_effect_no);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>