<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_evl_proj_evlsbcr_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_evl_year = dSet.indexOfColumn("evl_year");
   	int idx_degree = dSet.indexOfColumn("degree");
   	int idx_evl_class = dSet.indexOfColumn("evl_class");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_order_number = dSet.indexOfColumn("order_number");
   	int idx_evl_desc1 = dSet.indexOfColumn("evl_desc1");
   	int idx_evl_desc2 = dSet.indexOfColumn("evl_desc2");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
  if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_evl_proj_evlsbcr set " + 
                            "evl_desc1=?,  " + 
                            "evl_desc2=?  where evl_year=? " +
                            "               and degree=? " +
                            "               and evl_class=? " +
                            "               and dept_code=? " +
                            "               and order_number=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_evl_desc1);
      gpstatement.bindColumn(2, idx_evl_desc2);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(3, idx_evl_year);
      gpstatement.bindColumn(4, idx_degree);
      gpstatement.bindColumn(5, idx_evl_class);
      gpstatement.bindColumn(6, idx_dept_code);
      gpstatement.bindColumn(7, idx_order_number);
      stmt.executeUpdate();
      stmt.close();
   }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>