<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("y_proj_vattag_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_long_name = dSet.indexOfColumn("long_name");
   	int idx_tax_rate = dSet.indexOfColumn("tax_rate");
   	int idx_free_rate = dSet.indexOfColumn("free_rate");
   	int idx_process_code = dSet.indexOfColumn("process_code");
   	int idx_chg_const_start_date = dSet.indexOfColumn("chg_const_start_date");
   	int idx_chg_const_end_date = dSet.indexOfColumn("chg_const_end_date");
   	int idx_chg_const_term = dSet.indexOfColumn("chg_const_term");
   	int idx_vattag = dSet.indexOfColumn("vattag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_code_dept set " + 
                            "dept_code=?,  " + 
                            "comp_code=?,  " + 
                            "long_name=?,  " + 
                            "tax_rate=?,  " + 
                            "free_rate=?,  " + 
                            "chg_const_start_date=?,  " + 
                            "chg_const_end_date=?,  " + 
                            "chg_const_term=?,  " + 
                            "vattag=? ,process_code=? where dept_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_comp_code);
      gpstatement.bindColumn(3, idx_long_name);
      gpstatement.bindColumn(4, idx_tax_rate);
      gpstatement.bindColumn(5, idx_free_rate);
      gpstatement.bindColumn(6, idx_chg_const_start_date);
      gpstatement.bindColumn(7, idx_chg_const_end_date);
      gpstatement.bindColumn(8, idx_chg_const_term);
      gpstatement.bindColumn(9, idx_vattag);
      gpstatement.bindColumn(10, idx_process_code);
/* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(11, idx_dept_code);
      stmt.executeUpdate();
      stmt.close();
   }
  }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>