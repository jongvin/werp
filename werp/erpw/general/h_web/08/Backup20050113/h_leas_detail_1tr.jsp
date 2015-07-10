<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_leas_detail_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_contract_date = dSet.indexOfColumn("contract_date");
   	int idx_degree_code = dSet.indexOfColumn("degree_code");
   	int idx_key_degree_code = dSet.indexOfColumn("key_degree_code");
   	int idx_agree_date = dSet.indexOfColumn("agree_date");
   	int idx_guarantee_amt = dSet.indexOfColumn("guarantee_amt");
   	int idx_f_pay_yn = dSet.indexOfColumn("f_pay_yn");
   	int idx_tot_amt = dSet.indexOfColumn("tot_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_LEAS_GUARANTEE_AGREE ( dept_code," + 
                    "sell_code," + 
                    "dongho," + 
                    "seq," + 
                    "contract_date," + 
                    "degree_code," + 
                    "agree_date," + 
                    "guarantee_amt," + 
                    "f_pay_yn," + 
                    "tot_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_contract_date);
      gpstatement.bindColumn(6, idx_degree_code);
      gpstatement.bindColumn(7, idx_agree_date);
      gpstatement.bindColumn(8, idx_guarantee_amt);
      gpstatement.bindColumn(9, idx_f_pay_yn);
      gpstatement.bindColumn(10, idx_tot_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_leas_guarantee_agree set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "contract_date=?,  " + 
                            "degree_code=?,  " + 
                            "agree_date=?,  " + 
                            "guarantee_amt=?,  " + 
                            "f_pay_yn=?,  " + 
                            "tot_amt=?  where dept_code=? " +
                            "             and sell_code=? " +
                            "             and dongho=? " +
                            "             and seq=? " +
                            "             and contract_date=? " +
                            "             and degree_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_contract_date);
      gpstatement.bindColumn(6, idx_degree_code);
      gpstatement.bindColumn(7, idx_agree_date);
      gpstatement.bindColumn(8, idx_guarantee_amt);
      gpstatement.bindColumn(9, idx_f_pay_yn);
      gpstatement.bindColumn(10, idx_tot_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_dept_code);
      gpstatement.bindColumn(12, idx_sell_code);
      gpstatement.bindColumn(13, idx_dongho);
      gpstatement.bindColumn(14, idx_seq);
      gpstatement.bindColumn(15, idx_contract_date);
      gpstatement.bindColumn(16, idx_key_degree_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_leas_guarantee_agree where dept_code=? " +
                            "             and sell_code=? " +
                            "             and dongho=? " +
                            "             and seq=? " +
                            "             and contract_date=? " +
                            "             and degree_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_dongho);
      gpstatement.bindColumn(4, idx_seq);
      gpstatement.bindColumn(5, idx_contract_date);
      gpstatement.bindColumn(6, idx_key_degree_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>