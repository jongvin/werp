<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("p_rnp_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_rnp_code = dSet.indexOfColumn("rnp_code");
   	int idx_rnp_name = dSet.indexOfColumn("rnp_name");
   	int idx_in_out_div = dSet.indexOfColumn("in_out_div");
   	int idx_eval_score = dSet.indexOfColumn("eval_score");
   	int idx_rnp_div = dSet.indexOfColumn("rnp_div");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO p_code_rnp ( rnp_code," + 
                    "rnp_name," + 
                    "in_out_div," + 
                    "eval_score, rnp_div )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_rnp_code);
      gpstatement.bindColumn(2, idx_rnp_name);
      gpstatement.bindColumn(3, idx_in_out_div);
      gpstatement.bindColumn(4, idx_eval_score);
      gpstatement.bindColumn(5, idx_rnp_div);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update p_code_rnp set " + 
                            "rnp_code=?,  " + 
                            "rnp_name=?,  " + 
                            "in_out_div=?,  " + 
                            "eval_score=?, rnp_div=?  where rnp_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_rnp_code);
      gpstatement.bindColumn(2, idx_rnp_name);
      gpstatement.bindColumn(3, idx_in_out_div);
      gpstatement.bindColumn(4, idx_eval_score);
      gpstatement.bindColumn(5, idx_rnp_div);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_rnp_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from p_code_rnp where rnp_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_rnp_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>