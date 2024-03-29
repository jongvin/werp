<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_job_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_job_code = dSet.indexOfColumn("job_code");
   	int idx_job_name = dSet.indexOfColumn("job_name");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_code_job ( job_code," + 
                    "job_name )      ";
      sSql = sSql + " VALUES ( :1, :2 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_job_code);
      gpstatement.bindColumn(2, idx_job_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_code_job set " + 
                            "job_code=?,  " + 
                            "job_name=?  where job_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_job_code);
      gpstatement.bindColumn(2, idx_job_name);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(3, idx_job_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_code_job where job_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_job_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>