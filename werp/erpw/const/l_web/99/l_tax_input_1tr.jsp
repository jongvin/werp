<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("l_tax_input_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_apply_date = dSet.indexOfColumn("apply_date");
   	int idx_tax_tag = dSet.indexOfColumn("tax_tag");
   	int idx_degree = dSet.indexOfColumn("degree");
   	int idx_degree2 = dSet.indexOfColumn("degree2");
   	int idx_from_amt = dSet.indexOfColumn("from_amt");
   	int idx_to_amt = dSet.indexOfColumn("to_amt");
   	int idx_tax_amt = dSet.indexOfColumn("tax_amt");

   int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO L_TAX_DEGREE ( APPLY_DATE," + 
                    "TAX_TAG," + 
                    "DEGREE," + 
                    "FROM_AMT," + 
                    "TO_AMT," + 
                    "TAX_AMT )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_apply_date);
      gpstatement.bindColumn(2, idx_tax_tag);
      gpstatement.bindColumn(3, idx_degree);
      gpstatement.bindColumn(4, idx_from_amt);
      gpstatement.bindColumn(5, idx_to_amt);
      gpstatement.bindColumn(6, idx_tax_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update L_TAX_DEGREE set " + 
                            "DEGREE=?,  " + 
                            "FROM_AMT=?,  " + 
                            "TO_AMT=?,  " + 
                            "TAX_AMT=?  where to_char(APPLY_DATE,'yyyymmdd')=? and TAX_TAG=? and degree=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_degree);
      gpstatement.bindColumn(2, idx_from_amt);
      gpstatement.bindColumn(3, idx_to_amt);
      gpstatement.bindColumn(4, idx_tax_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(5, idx_apply_date);
      gpstatement.bindColumn(6, idx_tax_tag);
      gpstatement.bindColumn(7, idx_degree2);
		stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from L_TAX_DEGREE  where to_char(APPLY_DATE,'yyyymmdd')=? and TAX_TAG=? and degree=?  "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_apply_date);
      gpstatement.bindColumn(2, idx_tax_tag);
      gpstatement.bindColumn(3, idx_degree);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>