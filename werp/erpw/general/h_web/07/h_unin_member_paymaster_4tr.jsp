<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_unin_member_paymaster_4tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_union_code = dSet.indexOfColumn("union_code");
   	int idx_union_id = dSet.indexOfColumn("union_id");
   	int idx_union_seq = dSet.indexOfColumn("union_seq");
   	int idx_pay_degree = dSet.indexOfColumn("pay_degree");
   	int idx_degree_code = dSet.indexOfColumn("degree_code");
   	int idx_agree_date = dSet.indexOfColumn("agree_date");
   	int idx_agree_amt = dSet.indexOfColumn("agree_amt");
   	int idx_tot_amt = dSet.indexOfColumn("tot_amt");
   	int idx_f_pay_yn = dSet.indexOfColumn("f_pay_yn");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_UNIN_INTR_AGREE ( dept_code," + 
                    "sell_code," + 
                    "union_code," + 
                    "union_id," + 
                    "union_seq," + 
                    "pay_degree," + 
                    "degree_code," + 
                    "agree_date," + 
                    "agree_amt," + 
                    "tot_amt," + 
                    "f_pay_yn )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_union_id);
      gpstatement.bindColumn(5, idx_union_seq);
      gpstatement.bindColumn(6, idx_pay_degree);
      gpstatement.bindColumn(7, idx_degree_code);
      gpstatement.bindColumn(8, idx_agree_date);
      gpstatement.bindColumn(9, idx_agree_amt);
      gpstatement.bindColumn(10, idx_tot_amt);
      gpstatement.bindColumn(11, idx_f_pay_yn);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_unin_intr_agree set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "union_code=?,  " + 
                            "union_id=?,  " + 
                            "union_seq=?,  " + 
                            "pay_degree=?,  " + 
                            "degree_code=?,  " + 
                            "agree_date=?,  " + 
                            "agree_amt=?,  " + 
                            "tot_amt=?,  " + 
                            "f_pay_yn=?  where dept_code=? " +
                            "              and sell_code=? " +
                            "              and union_code=? " +
                            "              and union_id=? " +
                            "              and union_seq=? " +
                            "              and pay_degree=? " +
                            "              and degree_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_union_code);
      gpstatement.bindColumn(4, idx_union_id);
      gpstatement.bindColumn(5, idx_union_seq);
      gpstatement.bindColumn(6, idx_pay_degree);
      gpstatement.bindColumn(7, idx_degree_code);
      gpstatement.bindColumn(8, idx_agree_date);
      gpstatement.bindColumn(9, idx_agree_amt);
      gpstatement.bindColumn(10, idx_tot_amt);
      gpstatement.bindColumn(11, idx_f_pay_yn);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(12, idx_dept_code);
      gpstatement.bindColumn(13, idx_sell_code);
      gpstatement.bindColumn(14, idx_union_code);
      gpstatement.bindColumn(15, idx_union_id);
      gpstatement.bindColumn(16, idx_union_seq);
      gpstatement.bindColumn(17, idx_pay_degree);
      gpstatement.bindColumn(18, idx_degree_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_unin_intr_agree where dept_code=? " +
                            "              and sell_code=? " +
                            "              and union_code=? " +
                            "              and union_id=? " +
                            "              and union_seq=? " +
                            "              and pay_degree=? " +
                            "              and degree_code=? ";  
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
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>