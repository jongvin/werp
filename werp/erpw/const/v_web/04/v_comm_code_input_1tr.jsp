<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_comm_code_input_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_comm_code = dSet.indexOfColumn("comm_code");
   	int idx_section = dSet.indexOfColumn("section");
   	int idx_part_code = dSet.indexOfColumn("part_code");
   	int idx_comm_name = dSet.indexOfColumn("comm_name");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO v_comm_code ( comm_code," + 
                    "section," + 
                    "part_code," + 
                    "comm_name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_comm_code);
      gpstatement.bindColumn(2, idx_section);
      gpstatement.bindColumn(3, idx_part_code);
      gpstatement.bindColumn(4, idx_comm_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update v_comm_code set " + 
                            "comm_code=?,  " + 
                            "section=?,  " + 
                            "part_code=?,  " + 
                            "comm_name=?  where comm_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_comm_code);
      gpstatement.bindColumn(2, idx_section);
      gpstatement.bindColumn(3, idx_part_code);
      gpstatement.bindColumn(4, idx_comm_name);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(5, idx_comm_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from v_comm_code where comm_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_comm_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>