<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_pay_slip_excel_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_paydate = dSet.indexOfColumn("paydate");
   	int idx_paykind = dSet.indexOfColumn("paykind");
   	int idx_comp_code = dSet.indexOfColumn("comp_code");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_total_amt = dSet.indexOfColumn("total_amt");
   	int idx_total_cnt = dSet.indexOfColumn("total_cnt");
   	int idx_real_amt = dSet.indexOfColumn("real_amt");
   	int idx_inco_tax = dSet.indexOfColumn("inco_tax");
   	int idx_resi_tax = dSet.indexOfColumn("resi_tax");
   	int idx_pens_amt = dSet.indexOfColumn("pens_amt");
   	int idx_medi_amt = dSet.indexOfColumn("medi_amt");
   	int idx_empl_amt = dSet.indexOfColumn("empl_amt");
   	int idx_etcx_amt = dSet.indexOfColumn("etcx_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_pay_payment ( paydate," + 
                    "paykind," + 
                    "comp_code," + 
                    "dept_code," + 
                    "total_amt," + 
                    "total_cnt," + 
                    "real_amt," + 
                    "inco_tax," + 
                    "resi_tax," + 
                    "pens_amt," + 
                    "medi_amt," + 
                    "empl_amt," + 
                    "etcx_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_paydate);
      gpstatement.bindColumn(2, idx_paykind);
      gpstatement.bindColumn(3, idx_comp_code);
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_total_amt);
      gpstatement.bindColumn(6, idx_total_cnt);
      gpstatement.bindColumn(7, idx_real_amt);
      gpstatement.bindColumn(8, idx_inco_tax);
      gpstatement.bindColumn(9, idx_resi_tax);
      gpstatement.bindColumn(10, idx_pens_amt);
      gpstatement.bindColumn(11, idx_medi_amt);
      gpstatement.bindColumn(12, idx_empl_amt);
      gpstatement.bindColumn(13, idx_etcx_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>