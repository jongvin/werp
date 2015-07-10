<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("l_nation_code_input_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_nation_code = dSet.indexOfColumn("nation_code");
   	int idx_nation_name_en = dSet.indexOfColumn("nation_name_en");
   	int idx_nation_name_kr = dSet.indexOfColumn("nation_name_kr");
    	int idx_nation_code_chk = dSet.indexOfColumn("nation_code_chk");

    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO l_nation_code ( nation_code," + 
                    "nation_name_en," + 
                    "nation_name_kr )      ";
      sSql = sSql + " VALUES ( :1, :2, :3 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_nation_code);
      gpstatement.bindColumn(2, idx_nation_name_en);
      gpstatement.bindColumn(3, idx_nation_name_kr);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update l_nation_code set " + 
                            "nation_code=?,  " + 
                            "nation_name_en=?,  " + 
									 "nation_name_kr=?   " +
                            "where nation_code=? " ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_nation_code);
      gpstatement.bindColumn(2, idx_nation_name_en);
      gpstatement.bindColumn(3, idx_nation_name_kr);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_nation_code_chk);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from l_nation_code where nation_code=? " ;
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_nation_code_chk);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>