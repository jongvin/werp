<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_user_project_connect_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_empno = dSet.indexOfColumn("empno");
   	int idx_proj_unq_key = dSet.indexOfColumn("proj_unq_key");
   	int idx_querytag = dSet.indexOfColumn("querytag");
   	int idx_old_proj_unq_key = dSet.indexOfColumn("old_proj_unq_key");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO z_authority_userproject ( empno," + 
                    "proj_unq_key," + 
                    "querytag )      ";
      sSql = sSql + " VALUES ( :1, :2, :3 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_empno);
      gpstatement.bindColumn(2, idx_proj_unq_key);
      gpstatement.bindColumn(3, idx_querytag);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_authority_userproject set " + 
                            "empno=?,  " + 
                            "proj_unq_key=?,  " + 
                            "querytag=?  where (empno=? and proj_unq_key=?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_empno);
      gpstatement.bindColumn(2, idx_proj_unq_key);
      gpstatement.bindColumn(3, idx_querytag);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_empno);
      gpstatement.bindColumn(5, idx_old_proj_unq_key);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_authority_userproject where (empno=? and proj_unq_key =?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_empno);
      gpstatement.bindColumn(2, idx_old_proj_unq_key);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../comm_function/conn_tr_end.jsp"%>