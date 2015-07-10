<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_code_special_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_special_agree = dSet.indexOfColumn("special_agree");
		int idx_special_agree2 = dSet.indexOfColumn("special_agree2");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
      if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_contract_special set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "special_agree=?, special_agree2=?  where dept_code=? " +
                            "           and sell_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_special_agree);
		gpstatement.bindColumn(4, idx_special_agree2);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(5, idx_dept_code);
      gpstatement.bindColumn(6, idx_sell_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_contract_special ( dept_code," + 
                    "sell_code," + 
                    "special_agree, special_agree2)      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_special_agree);
		gpstatement.bindColumn(4, idx_special_agree2);
      stmt.executeUpdate();
      stmt.close();
   }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>