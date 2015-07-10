<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr.jsp"%><%
     conn.setAutoCommit(false);
     GauceDataSet dSet = req.getGauceDataSet("f_request_code_2tr"); 
     gpstatement.gp_dataset = dSet;                                    // 이문장을 추가 
   	int idx_code      = dSet.indexOfColumn("code");
   	int idx_det_code  = dSet.indexOfColumn("det_code");
   	int idx_name      = dSet.indexOfColumn("name");
   	int idx_key_value = dSet.indexOfColumn("key_value");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); 
      gpstatement.gp_row = i;                                         // 이문장 추가
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO f_request_acnt_det ( code," + 
		              "det_code, " +
                    "name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3 ) ";
      stmt = conn.prepareStatement(sSql);                             // 문장 변경 
      gpstatement.gp_stmt = stmt;                                     // 문장 변경
      gpstatement.bindColumn(1, idx_code);
      gpstatement.bindColumn(2, idx_det_code);
      gpstatement.bindColumn(3, idx_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update f_request_acnt_det set " + 
                            "code=?,  " + 
                            "det_code=?, " +
                            "name=? where code=? and det_code=? ";  
      stmt = conn.prepareStatement(sSql);                             // 문장 변경 
      gpstatement.gp_stmt = stmt;                                     // 문장 변경
      gpstatement.bindColumn(1, idx_code);
      gpstatement.bindColumn(2, idx_det_code);
      gpstatement.bindColumn(3, idx_name);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_code);
      gpstatement.bindColumn(5, idx_key_value);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from f_request_acnt_det where code=? and det_code=? "; 
      stmt = conn.prepareStatement(sSql);                             // 문장 변경 
      gpstatement.gp_stmt = stmt;                                     // 문장 변경
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_code);
      gpstatement.bindColumn(2, idx_key_value);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ include file="../../../comm_function/conn_tr_end.jsp"%>