<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("s_order_wbs_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_order_wbs_code = dSet.indexOfColumn("order_wbs_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_llevel = dSet.indexOfColumn("llevel");
   	int idx_parent_wbs_code = dSet.indexOfColumn("parent_wbs_code");
   	int idx_detail_yn = dSet.indexOfColumn("detail_yn");
   	int idx_name = dSet.indexOfColumn("name");
   	int idx_note = dSet.indexOfColumn("note");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO s_order_wbs ( order_wbs_code," + 
                    "seq," + 
                    "llevel," + 
                    "parent_wbs_code," + 
                    "detail_yn," + 
                    "name," + 
                    "note )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_order_wbs_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_llevel);
      gpstatement.bindColumn(4, idx_parent_wbs_code);
      gpstatement.bindColumn(5, idx_detail_yn);
      gpstatement.bindColumn(6, idx_name);
      gpstatement.bindColumn(7, idx_note);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update s_order_wbs set " + 
                            "order_wbs_code=?,  " + 
                            "seq=?,  " + 
                            "llevel=?,  " + 
                            "parent_wbs_code=?,  " + 
                            "detail_yn=?,  " + 
                            "name=?,  " + 
                            "note=?  where order_wbs_code=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_order_wbs_code);
      gpstatement.bindColumn(2, idx_seq);
      gpstatement.bindColumn(3, idx_llevel);
      gpstatement.bindColumn(4, idx_parent_wbs_code);
      gpstatement.bindColumn(5, idx_detail_yn);
      gpstatement.bindColumn(6, idx_name);
      gpstatement.bindColumn(7, idx_note);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(8, idx_order_wbs_code);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from s_order_wbs where order_wbs_code=? "; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_order_wbs_code);
      stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>