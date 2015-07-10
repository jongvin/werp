<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("l_taxrate_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_taxrate_apply_date = dSet.indexOfColumn("taxrate_apply_date");
   	int idx_key_taxrate_apply_date = dSet.indexOfColumn("key_taxrate_apply_date");
   	int idx_deduction_amt = dSet.indexOfColumn("deduction_amt");
   	int idx_income_taxrate = dSet.indexOfColumn("income_taxrate");
   	int idx_civil_taxrate = dSet.indexOfColumn("civil_taxrate");
   	int idx_deduction_taxrate = dSet.indexOfColumn("deduction_taxrate");
   	int idx_insurance_taxrate = dSet.indexOfColumn("insurance_taxrate");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO L_TAXRATE ( taxrate_apply_date," + 
                    "deduction_amt," + 
                    "income_taxrate," + 
                    "civil_taxrate," + 
                    "deduction_taxrate," + 
                    "insurance_taxrate )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_taxrate_apply_date);
      gpstatement.bindColumn(2, idx_deduction_amt);
      gpstatement.bindColumn(3, idx_income_taxrate);
      gpstatement.bindColumn(4, idx_civil_taxrate);
      gpstatement.bindColumn(5, idx_deduction_taxrate);
      gpstatement.bindColumn(6, idx_insurance_taxrate);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update l_taxrate set " + 
                            "taxrate_apply_date=?,  " + 
                            "deduction_amt=?,  " + 
                            "income_taxrate=?,  " + 
                            "civil_taxrate=?,  " + 
                            "deduction_taxrate=?,  " + 
                            "insurance_taxrate=?  where taxrate_apply_date=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_taxrate_apply_date);
      gpstatement.bindColumn(2, idx_deduction_amt);
      gpstatement.bindColumn(3, idx_income_taxrate);
      gpstatement.bindColumn(4, idx_civil_taxrate);
      gpstatement.bindColumn(5, idx_deduction_taxrate);
      gpstatement.bindColumn(6, idx_insurance_taxrate);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_key_taxrate_apply_date);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from l_taxrate where taxrate_apply_date=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_taxrate_apply_date);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>