<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_inter_audit_result_3tr"); gpstatement.gp_dataset = dSet;
   	int idx_part_code = dSet.indexOfColumn("part_code");
   	int idx_year = dSet.indexOfColumn("year");
   	int idx_half_year = dSet.indexOfColumn("half_year");
   	int idx_comm_section = dSet.indexOfColumn("comm_section");
		int idx_seq = dSet.indexOfColumn("seq");
   	int idx_d_seq = dSet.indexOfColumn("d_seq");
   	int idx_contents = dSet.indexOfColumn("contents");
   	int idx_point = dSet.indexOfColumn("point");
   	int idx_select_type = dSet.indexOfColumn("select_type");
     int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update V_INTER_AUDIT_RESULT_DETAIL set " + 
                    " select_type=? " + 
                    " WHERE part_code =? " +
						  " AND to_char(year,'yyyy') =? " +
						  " AND half_year =? " +
						  " AND comm_section =? " +
						  " AND seq =? " +
						  " AND d_seq =? " ;
		stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_select_type);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
		gpstatement.bindColumn(2, idx_part_code);
		gpstatement.bindColumn(3, idx_year);
		gpstatement.bindColumn(4, idx_half_year);
		gpstatement.bindColumn(5, idx_comm_section);
		gpstatement.bindColumn(6, idx_seq);
		gpstatement.bindColumn(7, idx_d_seq);
			
		stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 

 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>