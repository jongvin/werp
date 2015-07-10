<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("z_code_etc_child_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_class_tag = dSet.indexOfColumn("class_tag");
   	int idx_etc_code = dSet.indexOfColumn("etc_code");
   	int idx_child_name = dSet.indexOfColumn("child_name");
   	int idx_old_etc_code = dSet.indexOfColumn("old_etc_code");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO z_code_etc_child ( class_tag," + 
                    "etc_code," + 
                    "child_name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_class_tag);
      gpstatement.bindColumn(2, idx_etc_code);
      gpstatement.bindColumn(3, idx_child_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update z_code_etc_child set " + 
                            "class_tag=?,  " + 
                            "etc_code=?,  " + 
                            "child_name=?  where (class_tag=? and etc_code=?)";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_class_tag);
      gpstatement.bindColumn(2, idx_etc_code);
      gpstatement.bindColumn(3, idx_child_name);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_class_tag);
      gpstatement.bindColumn(5, idx_old_etc_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from z_code_etc_child where (class_tag=? and etc_code=?) "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_class_tag);
      gpstatement.bindColumn(2, idx_old_etc_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../comm_function/conn_tr_end.jsp"%>