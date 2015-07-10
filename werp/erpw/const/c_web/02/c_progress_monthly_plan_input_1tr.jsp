<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_progress_monthly_plan_input_1tr");
     gpstatement.gp_dataset = dSet;
   	
	int idx_dept_code = dSet.indexOfColumn("dept_code");
	int idx_chg_seq = dSet.indexOfColumn("chg_seq");
	int idx_chg_no_seq = dSet.indexOfColumn("chg_no_seq");
	int idx_spec_unq_num = dSet.indexOfColumn("spec_unq_num");
	int idx_year = dSet.indexOfColumn("year");
	int idx_year_org = dSet.indexOfColumn("year_org");
	int idx_plan_mm_qty = dSet.indexOfColumn("plan_mm_qty");
	int idx_plan_mm_amt = dSet.indexOfColumn("plan_mm_amt");
   	
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_progress_detail set " + 
                            "plan_mm_qty=?,  " + 
                            "plan_mm_amt=?  " + 
                            "where  dept_code=? and chg_seq=? and chg_no_seq=? and spec_unq_num=? and year=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_plan_mm_qty);
      gpstatement.bindColumn(2, idx_plan_mm_amt);

	  gpstatement.bindColumn(3, idx_dept_code);
	  gpstatement.bindColumn(4, idx_chg_seq);
	  gpstatement.bindColumn(5, idx_chg_no_seq);

	  gpstatement.bindColumn(6, idx_spec_unq_num);
	  gpstatement.bindColumn(7, idx_year_org);
      stmt.executeUpdate();
      stmt.close();
   }
  }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>