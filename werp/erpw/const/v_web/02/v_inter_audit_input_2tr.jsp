<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_inter_audit_input_2tr"); gpstatement.gp_dataset = dSet;
   	int idx_part_code = dSet.indexOfColumn("part_code");
   	int idx_seq = dSet.indexOfColumn("seq");
   	int idx_section = dSet.indexOfColumn("section");
   	int idx_ins_contents = dSet.indexOfColumn("ins_contents");
   	int idx_ins_basis = dSet.indexOfColumn("ins_basis");
   	int idx_weight_point = dSet.indexOfColumn("weight_point");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO V_INTER_AUDIT_ITEM ( part_code," + 
                    "seq," + 
                    "section," + 
                    "ins_contents," + 
                    "ins_basis," + 
                    "weight_point )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_part_code);
      gpstatement.bindColumn(2, idx_seq );
		gpstatement.bindColumn(3, idx_section);
      gpstatement.bindColumn(4, idx_ins_contents);
      gpstatement.bindColumn(5, idx_ins_basis);
      gpstatement.bindColumn(6, idx_weight_point);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
 String sSql = "update V_INTER_AUDIT_ITEM set " + 
                            "section=?,  " + 
                            "ins_contents=?,  " + 
                            "ins_basis=?,  " + 
                            "weight_point=?  " + 
                            "where part_code=? " +
                            " and SEQ=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_section);
      gpstatement.bindColumn(2, idx_ins_contents);
      gpstatement.bindColumn(3, idx_ins_basis);
      gpstatement.bindColumn(4, idx_weight_point);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
		gpstatement.bindColumn(5, idx_part_code);
      gpstatement.bindColumn(6, idx_seq);
      stmt.executeUpdate();
      stmt.close();
	}else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
		String sSql = "delete from V_INTER_AUDIT_ITEM where part_code=? " +
                   " and SEQ=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
		gpstatement.bindColumn(1, idx_part_code);
      gpstatement.bindColumn(2, idx_seq);
      stmt.executeUpdate();
      stmt.close();
	 }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>