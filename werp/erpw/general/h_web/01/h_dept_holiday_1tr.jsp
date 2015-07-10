<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_dept_holiday_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_delay_discount_div = dSet.indexOfColumn("delay_discount_div");
   	int idx_yymmdd = dSet.indexOfColumn("yymmdd");
   	int idx_process_days = dSet.indexOfColumn("process_days");
   	int idx_process_div = dSet.indexOfColumn("process_div");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_old_delay_discount_div = dSet.indexOfColumn("old_delay_discount_div");
   	int idx_old_yymmdd = dSet.indexOfColumn("old_yymmdd");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_dept_holiday ( dept_code," + 
                    "sell_code," + 
                    "delay_discount_div," + 
                    "yymmdd," + 
                    "process_days," + 
                    "process_div," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_delay_discount_div);
      gpstatement.bindColumn(4, idx_yymmdd);
      gpstatement.bindColumn(5, idx_process_days);
      gpstatement.bindColumn(6, idx_process_div);
      gpstatement.bindColumn(7, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_dept_holiday set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "delay_discount_div=?,  " + 
                            "yymmdd=?,  " + 
                            "process_days=?,  " + 
                            "process_div=?,  " + 
                            "remark=?  where dept_code=? and sell_code=? and delay_discount_div=? and yymmdd=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_delay_discount_div);
      gpstatement.bindColumn(4, idx_yymmdd);
      gpstatement.bindColumn(5, idx_process_days);
      gpstatement.bindColumn(6, idx_process_div);
      gpstatement.bindColumn(7, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_dept_code);
      gpstatement.bindColumn(9, idx_sell_code);
      gpstatement.bindColumn(10, idx_old_delay_discount_div);
      gpstatement.bindColumn(11, idx_old_yymmdd);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_dept_holiday where dept_code=? and sell_code=? and delay_discount_div=? and yymmdd=?  "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_old_delay_discount_div);
      gpstatement.bindColumn(4, idx_old_yymmdd);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>