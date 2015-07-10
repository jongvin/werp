<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_test_plan_master_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_confirm_section = dSet.indexOfColumn("confirm_section");
   	int idx_key_confirm_section = dSet.indexOfColumn("key_confirm_section");
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_order_dt = dSet.indexOfColumn("order_dt");
   	int idx_confirm_dt = dSet.indexOfColumn("confirm_dt");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO v_test_plan_master ( confirm_section," + 
                    "dept_code," + 
                    "seq," + 
                    "order_dt," + 
                    "confirm_dt )   ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_confirm_section);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_seq);
      gpstatement.bindColumn(4, idx_order_dt);
      gpstatement.bindColumn(5, idx_confirm_dt);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
 		String ls_confirm_section = rows.getString(idx_confirm_section);
 		String ls_key_confirm_section = rows.getString(idx_key_confirm_section);
 		String ls_dept_code = rows.getString(idx_dept_code);
 		String ls_seq = rows.getString(idx_seq);
 		String ls_order_dt = rows.getString(idx_order_dt);
 		String ls_confirm_dt = rows.getString(idx_confirm_dt);
      
      String sSql = "update v_test_plan_master set																" +
			           "       confirm_section='" + ls_key_confirm_section + "',								" +
			           "       order_dt=to_date('"+ ls_order_dt + "','yyyy.mm.dd hh24:mi:ss'),		" +
			 			  "       confirm_dt=to_date('"+ ls_confirm_dt + "', 'yyyy.mm.dd hh24:mi:ss') " +
                    " where dept_code='" + ls_dept_code + "' and 										" +
                    "       seq='" + ls_seq + "' and 															" +
                    "       confirm_section='" + ls_confirm_section + "'								";  
                    
                    
	 try
		{
		  stmt = conn.prepareStatement(sSql);
		  gpstatement.gp_stmt = stmt;
		  stmt.executeUpdate();
		  stmt.close();
		}
		catch (Exception ex)
		{
			res.writeException("AA", "99999", "Query1 : " + ex.getMessage() + "\n쿼리:" + sSql);
		}
      
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from v_test_plan_master where confirm_section=? and dept_code=? and seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_confirm_section);
      gpstatement.bindColumn(2, idx_dept_code);
      gpstatement.bindColumn(3, idx_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>