<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_waste_matter_code_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_waste_matter_code = dSet.indexOfColumn("waste_matter_code");
   	int idx_key_waste_matter_code = dSet.indexOfColumn("key_waste_matter_code");
   	int idx_section = dSet.indexOfColumn("section");
   	int idx_waste_matter_name = dSet.indexOfColumn("waste_matter_name");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO v_waste_matter_code ( waste_matter_code," + 
                    "section," + 
                    "waste_matter_name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_waste_matter_code);
      gpstatement.bindColumn(2, idx_section);
      gpstatement.bindColumn(3, idx_waste_matter_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update v_waste_matter_code set " + 
                            "waste_matter_code=?,  " + 
                            "section=?,  " + 
                            "waste_matter_name=?  where waste_matter_code=? and section=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_waste_matter_code);
      gpstatement.bindColumn(2, idx_section);
      gpstatement.bindColumn(3, idx_waste_matter_name);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_key_waste_matter_code);
      gpstatement.bindColumn(5, idx_section);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from v_waste_matter_code where waste_matter_code=? and section=?";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_key_waste_matter_code);
      gpstatement.bindColumn(2, idx_section);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>