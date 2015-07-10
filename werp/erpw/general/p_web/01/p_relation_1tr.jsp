<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_relation_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_relation_code = dSet.indexOfColumn("relation_code");
   	int idx_relation_name = dSet.indexOfColumn("relation_name");
   	int idx_old_relation_code = dSet.indexOfColumn("old_relation_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_code_relation ( relation_code," + 
                    "relation_name," + 
                    "old_relation_code )      ";
      sSql = sSql + " VALUES ( :1, :2, :3 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_relation_code);
      gpstatement.bindColumn(2, idx_relation_name);
      gpstatement.bindColumn(3, idx_old_relation_code);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_code_relation set " + 
                            "relation_code=?,  " + 
                            "relation_name=?,  " + 
                            "old_relation_code=?  where relation_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_relation_code);
      gpstatement.bindColumn(2, idx_relation_name);
      gpstatement.bindColumn(3, idx_old_relation_code);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_relation_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_code_relation where relation_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_relation_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>