<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_plan_detail_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_mtrcode = dSet.indexOfColumn("mtrcode");
   	int idx_ditag = dSet.indexOfColumn("ditag");
   	int idx_month = dSet.indexOfColumn("month");
   	int idx_key_month = dSet.indexOfColumn("key_month");
   	int idx_pre_bd_qty = dSet.indexOfColumn("pre_bd_qty");
   	int idx_pre_bd_amt = dSet.indexOfColumn("pre_bd_amt");
   	int idx_this_bd_qty = dSet.indexOfColumn("this_bd_qty");
   	int idx_this_bd_amt = dSet.indexOfColumn("this_bd_amt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO M_MONTH_PLAN ( dept_code," + 
                    "mtrcode," + 
                    "ditag," + 
                    "month," + 
                    "pre_bd_qty," + 
                    "pre_bd_amt," + 
                    "this_bd_qty," + 
                    "this_bd_amt )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_mtrcode);
      gpstatement.bindColumn(3, idx_ditag);
      gpstatement.bindColumn(4, idx_month);
      gpstatement.bindColumn(5, idx_pre_bd_qty);
      gpstatement.bindColumn(6, idx_pre_bd_amt);
      gpstatement.bindColumn(7, idx_this_bd_qty);
      gpstatement.bindColumn(8, idx_this_bd_amt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_month_plan set " + 
                            "dept_code=?,  " + 
                            "mtrcode=?,  " + 
                            "ditag=?,  " + 
                            "month=?,  " + 
                            "pre_bd_qty=?,  " + 
                            "pre_bd_amt=?,  " + 
                            "this_bd_qty=?,  " + 
                            "this_bd_amt=?  where dept_code=? " +
                            " and mtrcode=? " +
                            " and ditag=? " +
                            " and month=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_mtrcode);
      gpstatement.bindColumn(3, idx_ditag);
      gpstatement.bindColumn(4, idx_month);
      gpstatement.bindColumn(5, idx_pre_bd_qty);
      gpstatement.bindColumn(6, idx_pre_bd_amt);
      gpstatement.bindColumn(7, idx_this_bd_qty);
      gpstatement.bindColumn(8, idx_this_bd_amt);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(9, idx_dept_code);
      gpstatement.bindColumn(10, idx_mtrcode);
      gpstatement.bindColumn(11, idx_ditag);
      gpstatement.bindColumn(12, idx_key_month);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_month_plan where dept_code=? " +
                            " and mtrcode=? " +
                            " and ditag=? " +
                            " and month=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_mtrcode);
      gpstatement.bindColumn(3, idx_ditag);
      gpstatement.bindColumn(4, idx_key_month);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>