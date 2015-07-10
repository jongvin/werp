<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_base_ontime_agree_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
		int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_degree_code = dSet.indexOfColumn("degree_code");
   	int idx_agree_date = dSet.indexOfColumn("agree_date");
   	int idx_amt_per = dSet.indexOfColumn("amt_per");
   	int idx_note = dSet.indexOfColumn("note");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO H_BASE_ONTIME_AGREE ( dept_code, sell_code," + 
                    "degree_code," + 
                    "agree_date," + 
                    "amt_per," + 
                    "note )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
		gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_degree_code);
      gpstatement.bindColumn(4, idx_agree_date);
      gpstatement.bindColumn(5, idx_amt_per);
      gpstatement.bindColumn(6, idx_note);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_base_ontime_agree set " + 
                            "dept_code=?,  " + 
                            "degree_code=?,  " + 
                            "agree_date=?,  " + 
                            "amt_per=?,  " + 
                            "note=?  where dept_code=? and sell_code=? and degree_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_degree_code);
      gpstatement.bindColumn(3, idx_agree_date);
      gpstatement.bindColumn(4, idx_amt_per);
      gpstatement.bindColumn(5, idx_note);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_dept_code);
      gpstatement.bindColumn(7, idx_sell_code);
      gpstatement.bindColumn(8, idx_degree_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_base_ontime_agree where dept_code=? and sell_code=? and degree_code=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_degree_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>