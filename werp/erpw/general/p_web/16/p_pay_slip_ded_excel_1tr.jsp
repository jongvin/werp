<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pay_slip_ded_excel_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_paydate = dSet.indexOfColumn("paydate");
   	int idx_ded_kind = dSet.indexOfColumn("ded_kind");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_self_amt = dSet.indexOfColumn("self_amt");
   	int idx_comp_amt = dSet.indexOfColumn("comp_amt");
   	int idx_real_amt = dSet.indexOfColumn("real_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pay_deduction ( paydate," + 
                    "ded_kind," + 
                    "comp_code," + 
                    "dept_code," + 
                    "self_amt," + 
                    "comp_amt," + 
                    "real_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_paydate);
      gpstatement.bindColumn(2, idx_ded_kind);
      gpstatement.bindColumn(3, idx_comp_code);
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_self_amt);
      gpstatement.bindColumn(6, idx_comp_amt);
      gpstatement.bindColumn(7, idx_real_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>