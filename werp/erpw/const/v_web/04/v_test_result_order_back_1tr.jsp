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
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 
      String sSql = " update v_test_result set " + 
                            "  status = '2'  " + 
                            "where  " + 
                            "   yymm =?   " + 
                            "   and dept_code =? ";  

		stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* ���� ������ �ݵ�� �����Ͻÿ�(�������� ��ŭ) */ 
      gpstatement.bindColumn(1, idx_yymmdd);
      gpstatement.bindColumn(2, idx_dept_code);
		stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* ���� ������ �ݵ�� �����Ͻÿ� (where �Ʒ��� ���� ������ŭ */ 

    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>