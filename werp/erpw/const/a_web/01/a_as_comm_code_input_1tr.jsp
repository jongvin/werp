<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("a_as_comm_code_input_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_class = dSet.indexOfColumn("class");
   	int idx_code = dSet.indexOfColumn("code");
   	int idx_pos_tag = dSet.indexOfColumn("pos_tag");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_remark = dSet.indexOfColumn("remark");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO a_as_comm_code ( class," + 
                    "code," + 
                    "pos_tag," + 
                    "name," + 
                    "remark )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_class);
      gpstatement.bindColumn(2, idx_code);
      gpstatement.bindColumn(3, idx_pos_tag);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_remark);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update a_as_comm_code set " + 
                            "class=?,  " + 
                            "code=?,  " + 
                            "pos_tag=?,  " + 
                            "name=?,  " + 
                            "remark=?  where class=? and code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_class);
      gpstatement.bindColumn(2, idx_code);
      gpstatement.bindColumn(3, idx_pos_tag);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_remark);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_class);      
      gpstatement.bindColumn(7, idx_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from a_as_comm_code where class=? and code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_class);      
      gpstatement.bindColumn(2, idx_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>