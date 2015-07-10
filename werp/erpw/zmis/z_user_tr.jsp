<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_user_tr"); gpstatement.gp_dataset = dSet;
   	int idx_user_key = dSet.indexOfColumn("user_key");
   	int idx_user_name = dSet.indexOfColumn("user_name");
   	int idx_empno = dSet.indexOfColumn("empno");
   	int idx_group_key = dSet.indexOfColumn("group_key");
   	int idx_key_empno = dSet.indexOfColumn("key_empno");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO z_user ( user_key," + 
                    "user_name," + 
                    "empno,group_key, no_seq )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_user_key);
      gpstatement.bindColumn(2, idx_user_name);
      gpstatement.bindColumn(3, idx_empno);
      gpstatement.bindColumn(4, idx_group_key);
      gpstatement.bindColumn(5, idx_no_seq);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_user set " + 
                            "user_key=?,  " + 
                            "user_name=?,  " + 
                            "empno=?,group_key=?, no_seq=?  where empno=? and user_key=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_user_key);
      gpstatement.bindColumn(2, idx_user_name);
      gpstatement.bindColumn(3, idx_empno);
      gpstatement.bindColumn(4, idx_group_key);
      gpstatement.bindColumn(5, idx_no_seq);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_key_empno);
      gpstatement.bindColumn(7, idx_user_key);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_user where empno=? and user_key=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_empno);
      gpstatement.bindColumn(2, idx_user_key);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../comm_function/conn_tr_end.jsp"%>