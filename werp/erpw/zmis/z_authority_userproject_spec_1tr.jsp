<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_authority_userproject_spec_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_empno = dSet.indexOfColumn("empno");
   	int idx_proj_unq_key = dSet.indexOfColumn("proj_unq_key");
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO z_authority_userproject_spec ( empno," + 
                    "proj_unq_key," + 
                    "spec_no_seq )      ";
      sSql = sSql + " VALUES ( :1, :2, :3 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_empno);
      gpstatement.bindColumn(2, idx_proj_unq_key);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_authority_userproject_spec set " + 
                            "empno=?,  " + 
                            "proj_unq_key=?,  " + 
                            "spec_no_seq=?  where empno=? and proj_unq_key=? and spec_no_seq=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_empno);
      gpstatement.bindColumn(2, idx_proj_unq_key);
      gpstatement.bindColumn(3, idx_spec_no_seq);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_empno);
      gpstatement.bindColumn(5, idx_proj_unq_key);
      gpstatement.bindColumn(6, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_authority_userproject_spec where empno=? and proj_unq_key=? and spec_no_seq=?";
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_empno);
      gpstatement.bindColumn(2, idx_proj_unq_key);
      gpstatement.bindColumn(3, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../comm_function/conn_tr_end.jsp"%>