<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_license_type_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_license_type_code = dSet.indexOfColumn("license_type_code");
   	int idx_license_type_name = dSet.indexOfColumn("license_type_name");
   	int idx_license_amt = dSet.indexOfColumn("license_amt");
   	int idx_eval_score = dSet.indexOfColumn("eval_score");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_code_license_type ( license_type_code," + 
                    "license_type_name," + 
                    "license_amt," + 
                    "eval_score )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_license_type_code);
      gpstatement.bindColumn(2, idx_license_type_name);
      gpstatement.bindColumn(3, idx_license_amt);
      gpstatement.bindColumn(4, idx_eval_score);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_code_license_type set " + 
                            "license_type_code=?,  " + 
                            "license_type_name=?,  " + 
                            "license_amt=?,  " + 
                            "eval_score=?  where license_type_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_license_type_code);
      gpstatement.bindColumn(2, idx_license_type_name);
      gpstatement.bindColumn(3, idx_license_amt);
      gpstatement.bindColumn(4, idx_eval_score);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(5, idx_license_type_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_code_license_type where license_type_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_license_type_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>