<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_profession_wbs_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_profession_wbs_code = dSet.indexOfColumn("profession_wbs_code");
   	int idx_profession_wbs_name = dSet.indexOfColumn("profession_wbs_name");
   	int idx_insurance_yn = dSet.indexOfColumn("insurance_yn"); 
   	int idx_key_profession_wbs_code = dSet.indexOfColumn("key_profession_wbs_code");     // key를 update하기위한 보조key

    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_profession_wbs ( profession_wbs_code," + 
                    "profession_wbs_name," + 
                    "insurance_yn )      ";
      sSql = sSql + " VALUES ( :1, :2, :3 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_profession_wbs_code);
      gpstatement.bindColumn(2, idx_profession_wbs_name);
      gpstatement.bindColumn(3, idx_insurance_yn);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_profession_wbs set " + 
                            "profession_wbs_code=?,  " + 
                            "profession_wbs_name=?,  " + 
                            "insurance_yn=?  where profession_wbs_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_profession_wbs_code);
      gpstatement.bindColumn(2, idx_profession_wbs_name);
      gpstatement.bindColumn(3, idx_insurance_yn);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_key_profession_wbs_code);      // key를 update하기위한 보조key
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_profession_wbs where profession_wbs_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_profession_wbs_code);        // key를 update하기위한 보조key
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>