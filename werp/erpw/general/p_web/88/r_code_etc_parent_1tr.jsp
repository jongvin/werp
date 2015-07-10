<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("r_code_etc_parent_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_class_tag = dSet.indexOfColumn("class_tag");
   	int idx_parent_name = dSet.indexOfColumn("parent_name");
   	int idx_length = dSet.indexOfColumn("length");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO r_code_etc_parent ( class_tag," + 
                    "parent_name," + 
                    "length )      ";
      sSql = sSql + " VALUES ( :1, :2, :3 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_class_tag);
      gpstatement.bindColumn(2, idx_parent_name);
      gpstatement.bindColumn(3, idx_length);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update r_code_etc_parent set " + 
                            "class_tag=?,  " + 
                            "parent_name=?,  " + 
                            "length=?  where class_tag=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_class_tag);
      gpstatement.bindColumn(2, idx_parent_name);
      gpstatement.bindColumn(3, idx_length);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_class_tag);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from r_code_etc_parent where class_tag=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_class_tag);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>