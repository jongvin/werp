<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("h_code_moveinto_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_sell_code = dSet.indexOfColumn("sell_code");
   	int idx_moveinto_code = dSet.indexOfColumn("moveinto_code");
   	int idx_moveinto_fr_time = dSet.indexOfColumn("moveinto_fr_time");
   	int idx_moveinto_to_time = dSet.indexOfColumn("moveinto_to_time");
   	int idx_remark = dSet.indexOfColumn("remark");
   	int idx_old_moveinto_code = dSet.indexOfColumn("old_moveinto_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO h_code_moveinto ( dept_code," + 
                    "sell_code," + 
                    "moveinto_code," + 
                    "moveinto_fr_time," + 
                    "moveinto_to_time," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_moveinto_code);
      gpstatement.bindColumn(4, idx_moveinto_fr_time);
      gpstatement.bindColumn(5, idx_moveinto_to_time);
      gpstatement.bindColumn(6, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update h_code_moveinto set " + 
                            "dept_code=?,  " + 
                            "sell_code=?,  " + 
                            "moveinto_code=?,  " + 
                            "moveinto_fr_time=?,  " + 
                            "moveinto_to_time=?,  " + 
                            "remark=?  where dept_code=? and sell_code=? and moveinto_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_moveinto_code);
      gpstatement.bindColumn(4, idx_moveinto_fr_time);
      gpstatement.bindColumn(5, idx_moveinto_to_time);
      gpstatement.bindColumn(6, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_dept_code);
      gpstatement.bindColumn(8, idx_sell_code);
      gpstatement.bindColumn(9, idx_old_moveinto_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from h_code_moveinto where dept_code=? and sell_code=? and moveinto_code=?  "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_sell_code);
      gpstatement.bindColumn(3, idx_old_moveinto_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>