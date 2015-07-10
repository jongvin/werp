<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_iron_plan_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_month = dSet.indexOfColumn("month");
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_budget_qty = dSet.indexOfColumn("budget_qty");
   	int idx_input_qty = dSet.indexOfColumn("input_qty");
   	int idx_remaind_qty = dSet.indexOfColumn("remaind_qty");
   	int idx_send_yn = dSet.indexOfColumn("send_yn");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_IRON_PLAN ( dept_code," + 
                    "month," + 
                    "mtrcode," + 
                    "budget_qty," + 
                    "input_qty," + 
                    "remaind_qty," + 
                    "send_yn )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_month);
      gpstatement.bindColumn(3, idx_mtrcode);
      gpstatement.bindColumn(4, idx_budget_qty);
      gpstatement.bindColumn(5, idx_input_qty);
      gpstatement.bindColumn(6, idx_remaind_qty);
      gpstatement.bindColumn(7, idx_send_yn);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_iron_plan set " + 
                            "dept_code=?,  " + 
                            "month=?,  " + 
                            "mtrcode=?,  " + 
                            "budget_qty=?,  " + 
                            "input_qty=?,  " + 
                            "remaind_qty=?,  " + 
                            "send_yn=?  where dept_code=? " +
                            "             and month=? " +
                            "             and mtrcode=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_month);
      gpstatement.bindColumn(3, idx_mtrcode);
      gpstatement.bindColumn(4, idx_budget_qty);
      gpstatement.bindColumn(5, idx_input_qty);
      gpstatement.bindColumn(6, idx_remaind_qty);
      gpstatement.bindColumn(7, idx_send_yn);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_dept_code);
      gpstatement.bindColumn(9, idx_month);
      gpstatement.bindColumn(10, idx_mtrcode);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_iron_plan where dept_code=? " +
                            "             and month=? " +
                            "             and mtrcode=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_month);
      gpstatement.bindColumn(3, idx_mtrcode);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>