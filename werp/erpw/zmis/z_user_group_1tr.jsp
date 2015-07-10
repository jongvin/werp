<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_user_group_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_user_key = dSet.indexOfColumn("user_key");
   	int idx_group_key = dSet.indexOfColumn("group_key");
   	int idx_user_group_name = dSet.indexOfColumn("user_group_name");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO z_user_group ( user_key," + 
                    "group_key," + 
                    "user_group_name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_user_key);
      gpstatement.bindColumn(2, idx_group_key);
      gpstatement.bindColumn(3, idx_user_group_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_user_group set " + 
                            "user_key=?,  " + 
                            "group_key=?,  " + 
                            "user_group_name=?  where user_key=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_user_key);
      gpstatement.bindColumn(2, idx_group_key);
      gpstatement.bindColumn(3, idx_user_group_name);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_user_key);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_user_group where user_key=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_user_key);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../comm_function/conn_tr_end.jsp"%>