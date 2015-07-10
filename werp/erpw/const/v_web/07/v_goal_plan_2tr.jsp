<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_goal_plan_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_DEPT_CODE = dSet.indexOfColumn("DEPT_CODE");
   	int idx_YEAR = dSet.indexOfColumn("YEAR");
   	int idx_QUARTER_YEAR = dSet.indexOfColumn("QUARTER_YEAR");
   	int idx_SEQ_NUM = dSet.indexOfColumn("SEQ_NUM");
   	int idx_PART = dSet.indexOfColumn("PART");
   	int idx_GOAL = dSet.indexOfColumn("GOAL");
   	int idx_GOAL_DETAIL = dSet.indexOfColumn("GOAL_DETAIL");
   	int idx_ACTION_PLAN = dSet.indexOfColumn("ACTION_PLAN");
   	int idx_CHARGE_NAME = dSet.indexOfColumn("CHARGE_NAME");
   	int idx_FROM_ACTION_YYMM = dSet.indexOfColumn("FROM_ACTION_YYMM");
   	int idx_TO_ACTION_YYMM = dSet.indexOfColumn("TO_ACTION_YYMM");
   	int idx_OPINION_STANDARD = dSet.indexOfColumn("OPINION_STANDARD");
   	int idx_ESTIMATE_AMT = dSet.indexOfColumn("ESTIMATE_AMT");
   	int idx_WEIGHT_POINT = dSet.indexOfColumn("WEIGHT_POINT");
   	int idx_OPINION = dSet.indexOfColumn("OPINION");
   	int idx_STATUS = dSet.indexOfColumn("STATUS");
   	int idx_POST = dSet.indexOfColumn("POST");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO V_GOAL_PLAN_DETAIL ( DEPT_CODE," + 
                    "YEAR," + 
                    "QUARTER_YEAR," + 
                    "SEQ_NUM," + 
                    "PART," + 
                    "GOAL," + 
                    "GOAL_DETAIL," + 
                    "ACTION_PLAN," + 
                    "CHARGE_NAME," + 
                    "FROM_ACTION_YYMM," + 
                    "TO_ACTION_YYMM," + 
                    "OPINION_STANDARD," + 
                    "ESTIMATE_AMT," + 
                    "WEIGHT_POINT," + 
                    "OPINION , " + 
						  "STATUS , " +
						  "POST )     ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10 ,:11 ,:12 , :13 ,:14 ,:15 ,:16 ,:17 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_DEPT_CODE);
      gpstatement.bindColumn(2, idx_YEAR);
      gpstatement.bindColumn(3, idx_QUARTER_YEAR);
      gpstatement.bindColumn(4, idx_SEQ_NUM);
      gpstatement.bindColumn(5, idx_PART);
      gpstatement.bindColumn(6, idx_GOAL);
      gpstatement.bindColumn(7, idx_GOAL_DETAIL);
      gpstatement.bindColumn(8, idx_ACTION_PLAN);
      gpstatement.bindColumn(9, idx_CHARGE_NAME);
      gpstatement.bindColumn(10, idx_FROM_ACTION_YYMM);
      gpstatement.bindColumn(11, idx_TO_ACTION_YYMM);
      gpstatement.bindColumn(12, idx_OPINION_STANDARD);
      gpstatement.bindColumn(13, idx_ESTIMATE_AMT);
      gpstatement.bindColumn(14, idx_WEIGHT_POINT);
      gpstatement.bindColumn(15, idx_OPINION);
      gpstatement.bindColumn(16, idx_STATUS);
      gpstatement.bindColumn(17, idx_POST);
      stmt.executeUpdate();
      stmt.close();
 

   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update V_GOAL_PLAN_DETAIL set " + 
                            "PART=?,  " + 
                            "GOAL=?,  " + 
                            "GOAL_DETAIL=?,  " + 
                            "ACTION_PLAN=?,  " + 
                            "CHARGE_NAME=?,  " + 
                            "FROM_ACTION_YYMM=?,  " + 
                            "TO_ACTION_YYMM=?,  " + 
                            "OPINION_STANDARD=?,  " + 
                            "ESTIMATE_AMT=?,  " + 
                            "WEIGHT_POINT=?,  " + 
                            "OPINION=? , " +
									 "STATUS=? , " +
									 "POST=? where DEPT_CODE=? and YEAR=?  AND QUARTER_YEAR=? AND SEQ_NUM =? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_PART);
      gpstatement.bindColumn(2, idx_GOAL);
      gpstatement.bindColumn(3, idx_GOAL_DETAIL);
      gpstatement.bindColumn(4, idx_ACTION_PLAN);
      gpstatement.bindColumn(5, idx_CHARGE_NAME);
      gpstatement.bindColumn(6, idx_FROM_ACTION_YYMM);
      gpstatement.bindColumn(7, idx_TO_ACTION_YYMM);
      gpstatement.bindColumn(8, idx_OPINION_STANDARD);
      gpstatement.bindColumn(9, idx_ESTIMATE_AMT);
      gpstatement.bindColumn(10, idx_WEIGHT_POINT);
      gpstatement.bindColumn(11, idx_OPINION);
      gpstatement.bindColumn(12, idx_STATUS);
      gpstatement.bindColumn(13, idx_POST);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(14, idx_DEPT_CODE);
      gpstatement.bindColumn(15, idx_YEAR);
      gpstatement.bindColumn(16, idx_QUARTER_YEAR);
      gpstatement.bindColumn(17, idx_SEQ_NUM);
		stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from V_GOAL_PLAN_DETAIL where DEPT_CODE=? and YEAR=? AND QUARTER_YEAR=? AND SEQ_NUM =? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_DEPT_CODE);
      gpstatement.bindColumn(2, idx_YEAR);
      gpstatement.bindColumn(3, idx_QUARTER_YEAR);
      gpstatement.bindColumn(4, idx_SEQ_NUM);
		stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>