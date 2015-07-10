<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_fb_intf_income_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_fb_seq = dSet.indexOfColumn("fb_seq");
		int idx_man_note = dSet.indexOfColumn("man_note");
		int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_dongho = dSet.indexOfColumn("dongho");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_deposit_no = dSet.indexOfColumn("deposit_no");
   	int idx_v_account_no = dSet.indexOfColumn("v_account_no");
   	int idx_ex_col1 = dSet.indexOfColumn("ex_col1");
   	int idx_ex_col2 = dSet.indexOfColumn("ex_col2");
   	int idx_ex_col3 = dSet.indexOfColumn("ex_col3");
   	int idx_ex_col4 = dSet.indexOfColumn("ex_col4");
   	int idx_work_seq = dSet.indexOfColumn("work_seq");
		int idx_apply_ok = dSet.indexOfColumn("apply_ok");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
	
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update H_FB_INTF_INCOME set " + 
                            "man_note=?,  " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "dongho=?,  " + 
                            "seq=?,  " + 
                            "deposit_no=?,  " + 
                            "v_account_no=?,  " + 
                            "ex_col1=?,  " + 
                            "ex_col2=?,  " + 
                            "ex_col3=?,  " + 
                            "ex_col4=?,  " + 
	                      	 "work_seq=?,  " +
	                         "apply_ok=?  " +
                            " where fb_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_man_note);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_sell_code);
      gpstatement.bindColumn(4, idx_dongho);
      gpstatement.bindColumn(5, idx_seq);
      gpstatement.bindColumn(6, idx_deposit_no);
      gpstatement.bindColumn(7, idx_v_account_no);
      gpstatement.bindColumn(8, idx_ex_col1);
      gpstatement.bindColumn(9, idx_ex_col2);
      gpstatement.bindColumn(10, idx_ex_col3);
      gpstatement.bindColumn(11, idx_ex_col4);
		gpstatement.bindColumn(12, idx_work_seq);
		gpstatement.bindColumn(13, idx_apply_ok);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(14, idx_fb_seq);
      stmt.executeUpdate();
      stmt.close();

   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>