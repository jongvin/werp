<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_goal_plan2_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_DEPT_CODE = dSet.indexOfColumn("DEPT_CODE");
   	int idx_YEAR = dSet.indexOfColumn("YEAR");
   	int idx_QUARTER_YEAR = dSet.indexOfColumn("QUARTER_YEAR");
   	int idx_FROM_YYMMDD = dSet.indexOfColumn("FROM_YYMMDD");
   	int idx_TO_YYMMDD = dSet.indexOfColumn("TO_YYMMDD");
   	int idx_GOAL = dSet.indexOfColumn("GOAL");
   	int idx_ADMIT = dSet.indexOfColumn("ADMIT");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO V_GOAL_PLAN_MASTER ( DEPT_CODE," + 
                    "YEAR," + 
                    "QUARTER_YEAR," + 
                    "FROM_YYMMDD," + 
                    "TO_YYMMDD," + 
                    "GOAL," + 
                    "ADMIT)    ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6 ,'1' ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_DEPT_CODE);
      gpstatement.bindColumn(2, idx_YEAR);
      gpstatement.bindColumn(3, idx_QUARTER_YEAR);
      gpstatement.bindColumn(4, idx_FROM_YYMMDD);
      gpstatement.bindColumn(5, idx_TO_YYMMDD);
      gpstatement.bindColumn(6, idx_GOAL);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update V_GOAL_PLAN_MASTER set " + 
                            "ADMIT=?  " + 
									 " where DEPT_CODE=? and TO_CHAR(YEAR,'YYYY.MM.DD')=? and QUARTER_YEAR=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_ADMIT);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(2, idx_DEPT_CODE);
      gpstatement.bindColumn(3, idx_YEAR);
      gpstatement.bindColumn(4, idx_QUARTER_YEAR);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from V_GOAL_PLAN_MASTER where where DEPT_CODE=? and TO_CHAR(YEAR,'YYYY.MM.DD')=? and QUARTER_YEAR=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_DEPT_CODE);
      gpstatement.bindColumn(2, idx_YEAR);
      gpstatement.bindColumn(3, idx_QUARTER_YEAR);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>