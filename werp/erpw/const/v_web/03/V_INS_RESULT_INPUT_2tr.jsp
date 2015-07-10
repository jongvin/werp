<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("V_INS_RESULT_INPUT_2tr"); gpstatement.gp_dataset = dSet;
   	int idx_quality_ins_code = dSet.indexOfColumn("QUALITY_INS_CODE");
   	int idx_quality_section = dSet.indexOfColumn("QUALITY_SECTION");
   	int idx_DEPT_CODE = dSet.indexOfColumn("DEPT_CODE");
   	int idx_YEAR = dSet.indexOfColumn("YEAR");
   	int idx_QUARTER_YEAR = dSet.indexOfColumn("QUARTER_YEAR");
   	int idx_SEQ = dSet.indexOfColumn("SEQ");
   	int idx_D_SEQ = dSet.indexOfColumn("D_SEQ");
   	int idx_CONTENTS = dSet.indexOfColumn("CONTENTS");
   	int idx_POINT = dSet.indexOfColumn("POINT");
   	int idx_SELECT_TYPE = dSet.indexOfColumn("SELECT_TYPE");

  
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO V_INS_POINT_DETAIL ( QUALITY_INS_CODE," + 
                    "QUALITY_SECTION, " +
                    "DEPT_CODE, " +
                    "YEAR, " +
                    "QUARTER_YEAR, " +
                    "SEQ, " +
                    "D_SEQ, " +
                    "CONTENTS, " +
                    "POINT, " +
                    "SELECT_TYPE  ) " ;
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ,:7 ,:8, :9, :10 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_quality_ins_code);
      gpstatement.bindColumn(2, idx_quality_section);
      gpstatement.bindColumn(3, idx_DEPT_CODE);
      gpstatement.bindColumn(4, idx_YEAR);
      gpstatement.bindColumn(5, idx_QUARTER_YEAR);
      gpstatement.bindColumn(6, idx_SEQ);
		gpstatement.bindColumn(7, idx_D_SEQ);
      gpstatement.bindColumn(8, idx_CONTENTS);
		gpstatement.bindColumn(9, idx_POINT);
      gpstatement.bindColumn(10, idx_SELECT_TYPE);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update v_ins_point_detail set					" + 
						  " SELECT_TYPE=?										" + 
						  "where quality_ins_code =? " +
						  " and quality_section=? " +  
						  " and DEPT_CODE=? " +  
						  " and to_char(YEAR,'yyyy')=? " +  
						  " and QUARTER_YEAR=? " +  
 						  " and SEQ=? " +  
						  " and D_SEQ=? " ;  
		stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_SELECT_TYPE);
/* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(2, idx_quality_ins_code);
      gpstatement.bindColumn(3, idx_quality_section);
      gpstatement.bindColumn(4, idx_DEPT_CODE);
      gpstatement.bindColumn(5, idx_YEAR);
      gpstatement.bindColumn(6, idx_QUARTER_YEAR);
      gpstatement.bindColumn(7, idx_SEQ);
		gpstatement.bindColumn(8, idx_D_SEQ);
		stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from V_INS_POINT_DETAIL  " + 
						  "where quality_ins_code =? " +
						  " and quality_section=? " +  
						  " and DEPT_CODE=? " +  
						  " and YEAR=? " +  
						  " and QUARTER_YEAR=? " +  
 						  " and SEQ=? " +  
						  " and D_SEQ=? " ;  
		stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_quality_ins_code);
      gpstatement.bindColumn(2, idx_quality_section);
		stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>