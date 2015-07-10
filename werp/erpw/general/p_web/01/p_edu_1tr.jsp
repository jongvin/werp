<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_edu_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_edu_code = dSet.indexOfColumn("edu_code");
   	int idx_edu_name = dSet.indexOfColumn("edu_name");
   	int idx_edu_part_code = dSet.indexOfColumn("edu_part_code");
   	int idx_edu_tag = dSet.indexOfColumn("edu_tag");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_code_edu ( edu_code," + 
                    "edu_name," + 
                    "edu_part_code, edu_tag )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_edu_code);
      gpstatement.bindColumn(2, idx_edu_name);
      gpstatement.bindColumn(3, idx_edu_part_code);
      gpstatement.bindColumn(4, idx_edu_tag);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_code_edu set " + 
                            "edu_code=?,  " + 
                            "edu_name=?,  " + 
                            "edu_part_code=?, edu_tag=?  where edu_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_edu_code);
      gpstatement.bindColumn(2, idx_edu_name);
      gpstatement.bindColumn(3, idx_edu_part_code);
      gpstatement.bindColumn(4, idx_edu_tag);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(5, idx_edu_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_code_edu where edu_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_edu_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>