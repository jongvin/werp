<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_test_result_order_back_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_status = dSet.indexOfColumn("status");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");

    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){

 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = " update v_test_result set " + 
                            "  status = '2'  " + 
                            "where  " + 
                            "   yymm =?   " + 
                            "   and dept_code =? ";  

		stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_yymmdd);
      gpstatement.bindColumn(2, idx_dept_code);
		stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 

    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>