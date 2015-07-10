<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_output_slip_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_output_unq_num = dSet.indexOfColumn("output_unq_num");
   	int idx_input_unq_num = dSet.indexOfColumn("input_unq_num");
   	int idx_amt = dSet.indexOfColumn("amt");
   	int idx_vat_amt = dSet.indexOfColumn("vat_amt");
   	int idx_vat_unq_num = dSet.indexOfColumn("vat_unq_num");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
   if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_output_detail set " + 
                            "amt=?,  " + 
                            "vat_amt=?,  " + 
                            "vat_unq_num=?  " + 
                            " where dept_code=? " +  
                            " and yymmdd=?  " + 
                            " and seq=?  " + 
                            " and output_unq_num=?  " ;
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_amt);
      gpstatement.bindColumn(2, idx_vat_amt);
      gpstatement.bindColumn(3, idx_vat_unq_num);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_dept_code);
      gpstatement.bindColumn(5, idx_yymmdd);
      gpstatement.bindColumn(6, idx_seq);
      gpstatement.bindColumn(7, idx_output_unq_num);
      stmt.executeUpdate();
      stmt.close();
   }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>