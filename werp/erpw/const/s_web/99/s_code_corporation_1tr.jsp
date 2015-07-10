<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     conn.setAutoCommit(false);
     GauceDataSet dSet = req.getGauceDataSet("s_code_corporation_1tr"); 
     gpstatement.gp_dataset = dSet;                                    // 이문장을 추가 
   	int idx_corporation_section = dSet.indexOfColumn("corporation_section");
   	int idx_section_name = dSet.indexOfColumn("section_name");
   	int idx_register_chk = dSet.indexOfColumn("register_chk");
   	int idx_key_corporation_section = dSet.indexOfColumn("key_corporation_section");  // key를 update하기위한 보조key
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); 
      gpstatement.gp_row = i;                                         // 이문장 추가
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_code_corporation ( corporation_section," + 
                    "section_name," + 
                    "register_chk )      ";
      sSql = sSql + " VALUES ( :1, :2, :3 ) ";
      stmt = conn.prepareStatement(sSql);                             // 문장 변경 
      gpstatement.gp_stmt = stmt;                                     // 문장 변경
      gpstatement.bindColumn(1, idx_corporation_section);
      gpstatement.bindColumn(2, idx_section_name);
      gpstatement.bindColumn(3, idx_register_chk);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_code_corporation set " + 
                            "corporation_section=?,  " + 
                            "section_name=?,  " + 
                            "register_chk=?  where corporation_section=? ";  
      stmt = conn.prepareStatement(sSql);                             // 문장 변경 
      gpstatement.gp_stmt = stmt;                                     // 문장 변경
      gpstatement.bindColumn(1, idx_corporation_section);
      gpstatement.bindColumn(2, idx_section_name);
      gpstatement.bindColumn(3, idx_register_chk);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_key_corporation_section);       // key를 update하기위한 보조key
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_code_corporation where corporation_section=? "; 
      stmt = conn.prepareStatement(sSql);                             // 문장 변경 
      gpstatement.gp_stmt = stmt;                                     // 문장 변경
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_corporation_section);   // key를 update하기위한 보조key
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ include file="../../../comm_function/conn_tr_end.jsp"%>