<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_spec_class_parent_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_spec_no_seq = dSet.indexOfColumn("spec_no_seq");
   	int idx_no_seq = dSet.indexOfColumn("no_seq");
   	int idx_sum_code = dSet.indexOfColumn("sum_code");
   	int idx_parent_sum_code = dSet.indexOfColumn("parent_sum_code");
   	int idx_llevel = dSet.indexOfColumn("llevel");
   	int idx_name = dSet.indexOfColumn("name");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_spec_class_parent ( spec_no_seq," + 
                    "no_seq," + 
                    "sum_code," + 
                    "parent_sum_code," + 
                    "llevel," + 
                    "name )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_spec_no_seq);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_sum_code);
      gpstatement.bindColumn(4, idx_parent_sum_code);
      gpstatement.bindColumn(5, idx_llevel);
      gpstatement.bindColumn(6, idx_name);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_spec_class_parent set " + 
                            "spec_no_seq=?,  " + 
                            "no_seq=?,  " + 
                            "sum_code=?,  " + 
                            "parent_sum_code=?,  " + 
                            "llevel=?,  " + 
                            "name=?  where spec_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_spec_no_seq);
      gpstatement.bindColumn(2, idx_no_seq);
      gpstatement.bindColumn(3, idx_sum_code);
      gpstatement.bindColumn(4, idx_parent_sum_code);
      gpstatement.bindColumn(5, idx_llevel);
      gpstatement.bindColumn(6, idx_name);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(7, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_spec_class_parent where spec_no_seq=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_spec_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>