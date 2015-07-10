<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("V_INS_PLAN_2tr"); gpstatement.gp_dataset = dSet;
		int idx_YEAR = dSet.indexOfColumn("year");
   	int idx_QUARTER_YEAR = dSet.indexOfColumn("QUARTER_YEAR");
   	int idx_DEPT_CODE = dSet.indexOfColumn("DEPT_CODE");
   	int idx_QUALITY_SECTION = dSet.indexOfColumn("QUALITY_SECTION");
   	int idx_SEQ = dSet.indexOfColumn("SEQ");
   	int idx_D_SEQ = dSet.indexOfColumn("D_SEQ");
   	int idx_POSITION = dSet.indexOfColumn("POSITION");
   	int idx_POSITION_NAME = dSet.indexOfColumn("POSITION_NAME");
		int idx_EMP_NO = dSet.indexOfColumn("EMP_NO");
   	int idx_NAME = dSet.indexOfColumn("NAME");

		int  rowCnt = dSet.getDataRowCnt();
		for(int i=0; i< rowCnt; i++)
		{
    	GauceDataRow rows = dSet.getDataRow(i); gpstatement.gp_row = i;
		if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO V_INS_PLAN_PERSON ( YEAR," + 
                    "QUARTER_YEAR, " +
                    "DEPT_CODE, " +
                    "QUALITY_SECTION, " +
                    "SEQ, " +
                    "D_SEQ, " +
                    "POSITION, " +
                    "EMP_NO, " +
                    "NAME ) " ;
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ,:7 ,:8, :9 ) ";

		  stmt = conn.prepareStatement(sSql);
		  gpstatement.gp_stmt = stmt;
			gpstatement.bindColumn(1, idx_YEAR);
			gpstatement.bindColumn(2, idx_QUARTER_YEAR);
			gpstatement.bindColumn(3, idx_DEPT_CODE);
			gpstatement.bindColumn(4, idx_QUALITY_SECTION);
			gpstatement.bindColumn(5, idx_SEQ);
			gpstatement.bindColumn(6, idx_D_SEQ);
			gpstatement.bindColumn(7, idx_POSITION);
			gpstatement.bindColumn(8, idx_EMP_NO);
			gpstatement.bindColumn(9, idx_NAME);
		  stmt.executeUpdate();
		  stmt.close();
		}else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update V_INS_PLAN_PERSON set " + 
								  " POSITION=?, " +
								  " EMP_NO=?, " +
								  " NAME=? " +
								  " WHERE  YEAR =? " + 
								  " AND QUARTER_YEAR=? " +
								  " AND DEPT_CODE=? " +
								  " AND QUALITY_SECTION=? " + 
								  " AND SEQ=? " + 
								  " AND D_SEQ=? " ; 
		stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_POSITION);
      gpstatement.bindColumn(2, idx_EMP_NO);
      gpstatement.bindColumn(3, idx_NAME);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(4, idx_YEAR);
      gpstatement.bindColumn(5, idx_QUARTER_YEAR);
      gpstatement.bindColumn(6, idx_DEPT_CODE);
      gpstatement.bindColumn(7, idx_QUALITY_SECTION);
      gpstatement.bindColumn(8, idx_SEQ);
      gpstatement.bindColumn(9, idx_D_SEQ);
		stmt.executeUpdate();
      stmt.close();
		}else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from V_INS_PLAN_PERSON " +
								  " WHERE  YEAR =? " + 
								  " AND QUARTER_YEAR=? " +
								  " AND DEPT_CODE=? " +
								  " AND QUALITY_SECTION=? " + 
								  " AND SEQ=? " + 
								  " AND D_SEQ=? " ;  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_YEAR);
      gpstatement.bindColumn(2, idx_QUARTER_YEAR);
      gpstatement.bindColumn(3, idx_DEPT_CODE);
      gpstatement.bindColumn(4, idx_QUALITY_SECTION);
      gpstatement.bindColumn(5, idx_SEQ);
      gpstatement.bindColumn(6, idx_D_SEQ);
		stmt.executeUpdate();
      stmt.close();
    }
     }
%><%@ 
include file="../../../comm_function/conn_tr_end.jsp"%>