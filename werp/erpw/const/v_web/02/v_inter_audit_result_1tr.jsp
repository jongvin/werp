<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_inter_audit_result_1tr"); gpstatement.gp_dataset = dSet;
   	int idx_part_code = dSet.indexOfColumn("part_code");
   	int idx_year = dSet.indexOfColumn("year");
   	int idx_half_year = dSet.indexOfColumn("half_year");
   	int idx_part_name = dSet.indexOfColumn("part_name");
		int idx_ins_dt = dSet.indexOfColumn("ins_dt");
   	int idx_position = dSet.indexOfColumn("position");
   	int idx_inspector = dSet.indexOfColumn("inspector");
   	int idx_review = dSet.indexOfColumn("review");
     int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt ; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
     String sSql = "update V_INTER_AUDIT_RESULT_MASTER set " + 
						  " INS_DT=? ,    " +
						  " POSITION=?  , " +
						  " INSPECTOR=? , " +
						  " REVIEW=?     " +
                    "WHERE PART_CODE =? " +
						  " AND to_char(YEAR,'yyyy')  =? " +
						  " AND HALF_YEAR =? " ;
		stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
		gpstatement.bindColumn(1, idx_ins_dt);
      gpstatement.bindColumn(2, idx_position);
      gpstatement.bindColumn(3, idx_inspector);
      gpstatement.bindColumn(4, idx_review);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
		gpstatement.bindColumn(5, idx_part_code);
		gpstatement.bindColumn(6, idx_year);
		gpstatement.bindColumn(7, idx_half_year);
		stmt.executeUpdate();
      stmt.close();

	}else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 

 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>