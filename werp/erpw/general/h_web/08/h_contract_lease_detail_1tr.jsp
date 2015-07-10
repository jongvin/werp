<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_contract_lease_detail_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_cont_date = dSet.indexOfColumn("cont_date");
   	int idx_cont_seq = dSet.indexOfColumn("cont_seq");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
		int idx_note = dSet.indexOfColumn("note");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_lease_cont_dongho ( dept_code," + 
                    "sell_code," + 
                    "cont_date," + 
                    "cont_seq," + 
                    "dongho," + 
                    "seq,"+
			           "note )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_cont_date);
      gpstatement.bindColumn(4, idx_cont_seq);
      gpstatement.bindColumn(5, idx_dongho);
      gpstatement.bindColumn(6, idx_seq);
		gpstatement.bindColumn(7, idx_note);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_lease_cont_dongho set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "cont_date=?,  " + 
                            "cont_seq=?,  " + 
                            "dongho=?,  " + 
                            "seq=?, note=?  where dept_code=? and sell_code=? and cont_date=? and cont_seq=?  and dongho=? and seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_cont_date);
      gpstatement.bindColumn(4, idx_cont_seq);
      gpstatement.bindColumn(5, idx_dongho);
      gpstatement.bindColumn(6, idx_seq);
		gpstatement.bindColumn(7, idx_note);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_dept_code);
      gpstatement.bindColumn(9, idx_sell_code);
      gpstatement.bindColumn(10, idx_cont_date);
      gpstatement.bindColumn(11, idx_cont_seq);
		gpstatement.bindColumn(12, idx_dongho);
      gpstatement.bindColumn(13, idx_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_lease_cont_dongho where dept_code=? and sell_code=? and cont_date=? and cont_seq=?  and dongho=? and seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_cont_date);
      gpstatement.bindColumn(4, idx_cont_seq);
		gpstatement.bindColumn(5, idx_dongho);
      gpstatement.bindColumn(6, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>