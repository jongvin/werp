<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("m_code_material_heigh_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_mtrgrand = dSet.indexOfColumn("mtrgrand");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_llevel = dSet.indexOfColumn("llevel");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_note = dSet.indexOfColumn("note");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO m_code_material_high ( mtrgrand," + 
                    "seq," + 
                    "llevel," + 
                    "name," + 
                    "note )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_mtrgrand);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_llevel);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_note);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update m_code_material_high set " + 
                            "mtrgrand=?,  " + 
                            "seq=?,  " + 
                            "llevel=?,  " + 
                            "name=?,  " + 
                            "note=?  where mtrgrand=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_mtrgrand);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_llevel);
      gpstatement.bindColumn(4, idx_name);
      gpstatement.bindColumn(5, idx_note);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(6, idx_mtrgrand);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from m_code_material_high where mtrgrand=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_mtrgrand);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>