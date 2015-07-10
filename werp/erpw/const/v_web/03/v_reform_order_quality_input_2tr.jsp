<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_reform_order_quality_input_2tr"); gpstatement.gp_dataset = dSet;
   	int idx_DEPT_CODE = dSet.indexOfColumn("DEPT_CODE");
   	int idx_YEAR = dSet.indexOfColumn("YEAR");
   	int idx_QUARTER_YEAR = dSet.indexOfColumn("QUARTER_YEAR");
   	int idx_QUALITY_SECTION = dSet.indexOfColumn("QUALITY_SECTION");
   	int idx_SEQ = dSet.indexOfColumn("SEQ");
		int idx_WBS_CODE = dSet.indexOfColumn("WBS_CODE");
   	int idx_REFORM_DT = dSet.indexOfColumn("REFORM_DT");
   	int idx_REFORM_ORDER = dSet.indexOfColumn("REFORM_ORDER");


    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO V_REFORM_ORDER_QUALITY ( DEPT_CODE," + 
                    "YEAR, " +
                    "QUARTER_YEAR, " +
						  "QUALITY_SECTION, " +
                    "SEQ, " +
                    "WBS_CODE, " +
						  "REFORM_DT, " +
                    "REFORM_ORDER ) " ;
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ,:7,:8  ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_DEPT_CODE);
      gpstatement.bindColumn(2, idx_YEAR);
      gpstatement.bindColumn(3, idx_QUARTER_YEAR);
      gpstatement.bindColumn(4, idx_QUALITY_SECTION);
      gpstatement.bindColumn(5, idx_SEQ);
      gpstatement.bindColumn(6, idx_WBS_CODE);
      gpstatement.bindColumn(7, idx_REFORM_DT);
		gpstatement.bindColumn(8, idx_REFORM_ORDER);
 
		stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update V_REFORM_ORDER_QUALITY set " + 
                    "	WBS_CODE =?, " +
						  "	REFORM_DT=?, " +
                    "	REFORM_ORDER=? " + 
						  " where DEPT_CODE=? " + 
						  "	and TO_CHAR(YEAR,'YYYY')=? " + 
						  "	and QUARTER_YEAR=? " + 
						  "	and QUALITY_SECTION=? " + 
						  "	and SEQ=? "	 ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_WBS_CODE);
      gpstatement.bindColumn(2, idx_REFORM_DT);
		gpstatement.bindColumn(3, idx_REFORM_ORDER);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_DEPT_CODE);
      gpstatement.bindColumn(5, idx_YEAR);
      gpstatement.bindColumn(6, idx_QUARTER_YEAR);
      gpstatement.bindColumn(7, idx_QUALITY_SECTION);
      gpstatement.bindColumn(8, idx_SEQ);
		stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from V_REFORM_ORDER_QUALITY  " +
						  " where DEPT_CODE=? " + 
						  " and TO_CHAR(YEAR,'YYYY')=? " + 
						  " and QUARTER_YEAR=? " + 
						  " and QUALITY_SECTION=? " + 
						  " and SEQ=? "	 ;  
		stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_DEPT_CODE);
      gpstatement.bindColumn(2, idx_YEAR);
      gpstatement.bindColumn(3, idx_QUARTER_YEAR);
      gpstatement.bindColumn(4, idx_QUALITY_SECTION);
      gpstatement.bindColumn(5, idx_SEQ);
		stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>