<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("v_tech_proposal_plan_2tr");
     gpstatement.gp_dataset = dSet;
   	int idx_YEAR = dSet.indexOfColumn("YEAR");
   	int idx_DEPT_CODE = dSet.indexOfColumn("DEPT_CODE");
   	int idx_SEQ_NUM = dSet.indexOfColumn("SEQ_NUM");
   	int idx_WBS_CODE = dSet.indexOfColumn("WBS_CODE");
   	int idx_THEME = dSet.indexOfColumn("THEME");
   	int idx_THEME_DETAIL = dSet.indexOfColumn("THEME_DETAIL");
   	int idx_SAVE_AMT = dSet.indexOfColumn("SAVE_AMT");
   	int idx_PROPOSAL_DATE = dSet.indexOfColumn("PROPOSAL_DATE");
   	int idx_RESULT_DATE = dSet.indexOfColumn("RESULT_DATE");
   	int idx_CHARGE_NAME = dSet.indexOfColumn("CHARGE_NAME");
   	int idx_REMARK = dSet.indexOfColumn("REMARK");
   	int idx_TEAM_NAME = dSet.indexOfColumn("TEAM_NAME");
   	int idx_TEAM_CHIEF = dSet.indexOfColumn("TEAM_CHIEF");
   	int idx_IMPROVE_NAME = dSet.indexOfColumn("IMPROVE_NAME");
   	int idx_BEFORE_MAP = dSet.indexOfColumn("BEFORE_MAP");
   	int idx_AFTER_MAP = dSet.indexOfColumn("AFTER_MAP");
   	int idx_BEFORE_RESULT_MAP = dSet.indexOfColumn("BEFORE_RESULT_MAP");
   	int idx_AFTER_RESULT_MAP = dSet.indexOfColumn("AFTER_RESULT_MAP");
   	int idx_ACT_FROM_DATE = dSet.indexOfColumn("ACT_FROM_DATE");
   	int idx_ACT_TO_DATE = dSet.indexOfColumn("ACT_TO_DATE");
   	int idx_BEFORE_MAT_AMT = dSet.indexOfColumn("BEFORE_MAT_AMT");
   	int idx_AFTER_MAT_AMT = dSet.indexOfColumn("AFTER_MAT_AMT");
   	int idx_BEFORE_LABOR_AMT = dSet.indexOfColumn("BEFORE_LABOR_AMT");
   	int idx_AFTER_LABOR_AMT = dSet.indexOfColumn("AFTER_LABOR_AMT");
   	int idx_BEFORE_EQUIP_AMT = dSet.indexOfColumn("BEFORE_EQUIP_AMT");
   	int idx_AFTER_EQUIP_AMT = dSet.indexOfColumn("AFTER_EQUIP_AMT");
   	int idx_BEFORE_ETC_AMT = dSet.indexOfColumn("BEFORE_ETC_AMT");
   	int idx_AFTER_ETC_AMT = dSet.indexOfColumn("AFTER_ETC_AMT");
   	int idx_SAVE_RATE_ORDER = dSet.indexOfColumn("SAVE_RATE_ORDER");
   	int idx_SAVE_RATE_HOME = dSet.indexOfColumn("SAVE_RATE_HOME");
   	int idx_SAVE_RATE_SBCR = dSet.indexOfColumn("SAVE_RATE_SBCR");
   	int idx_IMPROVE_MERIT = dSet.indexOfColumn("IMPROVE_MERIT");
   	int idx_IMPROVE_WEAK = dSet.indexOfColumn("IMPROVE_WEAK");
   	int idx_IMPROVE_ALERT = dSet.indexOfColumn("IMPROVE_ALERT");
   	int idx_IMPROVE_RESULT_MERIT = dSet.indexOfColumn("IMPROVE_RESULT_MERIT");
   	int idx_IMPROVE_RESULT_ALERT = dSet.indexOfColumn("IMPROVE_RESULT_ALERT");
   	int idx_CHARGE_OPINION = dSet.indexOfColumn("CHARGE_OPINION");
   	int idx_PART_OPINION = dSet.indexOfColumn("PART_OPINION");
   	int idx_BEFORE_MAT_AMT_RESULT = dSet.indexOfColumn("BEFORE_MAT_AMT_RESULT");
   	int idx_AFTER_MAT_AMT_RESULT = dSet.indexOfColumn("AFTER_MAT_AMT_RESULT");
   	int idx_BEFORE_LABOR_AMT_RESULT = dSet.indexOfColumn("BEFORE_LABOR_AMT_RESULT");
   	int idx_AFTER_LABOR_AMT_RESULT = dSet.indexOfColumn("AFTER_LABOR_AMT_RESULT");
   	int idx_BEFORE_EQUIP_AMT_RESULT = dSet.indexOfColumn("BEFORE_EQUIP_AMT_RESULT");
   	int idx_AFTER_EQUIP_AMT_RESULT = dSet.indexOfColumn("AFTER_EQUIP_AMT_RESULT");
   	int idx_BEFORE_ETC_AMT_RESULT = dSet.indexOfColumn("BEFORE_ETC_AMT_RESULT");
   	int idx_AFTER_ETC_AMT_RESULT = dSet.indexOfColumn("AFTER_ETC_AMT_RESULT");
   	int idx_PROPOSAL_MAKE_DATE = dSet.indexOfColumn("PROPOSAL_MAKE_DATE");
   	int idx_RESULT_MAKE_DATE  = dSet.indexOfColumn("RESULT_MAKE_DATE");
   	int idx_STATUS  = dSet.indexOfColumn("STATUS");
	 int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
	String sSql = " INSERT INTO v_tech_proposal_plan_detail ( " + 
                      "YEAR,  " + 
                      "DEPT_CODE,  " + 
                      "SEQ_NUM , " +
                      "WBS_CODE,  " + 
                      "THEME,  " + 
                      "THEME_DETAIL,  " + 
		                "SAVE_AMT , " +
							 "PROPOSAL_DATE,  " + 
                      "RESULT_DATE, " + 
                      "CHARGE_NAME, " + 
                      "REMARK, " + 
                      "TEAM_NAME, " + 
                      "TEAM_CHIEF, " + 
                      "IMPROVE_NAME, " + 
                      "BEFORE_MAP, " + 
                      "AFTER_MAP, " + 
                      "BEFORE_RESULT_MAP, " + 
                      "AFTER_RESULT_MAP , " + 
                      "ACT_FROM_DATE, " + 
                      "ACT_TO_DATE, " + 
                      "BEFORE_MAT_AMT, " + 
                      "AFTER_MAT_AMT, " + 
                      "BEFORE_LABOR_AMT , " + 
                      "AFTER_LABOR_AMT, " + 
                      "BEFORE_EQUIP_AMT, " + 
                      "AFTER_EQUIP_AMT, " + 
                      "BEFORE_ETC_AMT, " + 
                      "AFTER_ETC_AMT, " + 
                      "SAVE_RATE_ORDER, " + 
                      "SAVE_RATE_HOME, " + 
                      "SAVE_RATE_SBCR, " + 
							 "IMPROVE_MERIT, " + 
							 "IMPROVE_WEAK, " + 
                      "IMPROVE_ALERT, " + 
                      "IMPROVE_RESULT_MERIT, " + 
                      "IMPROVE_RESULT_ALERT, " + 
                      "CHARGE_OPINION, " + 
                      "PART_OPINION,  " + 
							 "BEFORE_MAT_AMT_RESULT, " + 
                      "AFTER_MAT_AMT_RESULT, " + 
							 "BEFORE_LABOR_AMT_RESULT, " + 
                      "AFTER_LABOR_AMT_RESULT, " + 
                      "BEFORE_EQUIP_AMT_RESULT, " + 
							 "AFTER_EQUIP_AMT_RESULT, " + 
						 	 "BEFORE_ETC_AMT_RESULT, " + 
                   	 "AFTER_ETC_AMT_RESULT, " +
  							 "PROPOSAL_MAKE_DATE, " + 
							 "RESULT_MAKE_DATE, " +
  							 "STATUS " + 
 						  " )";
      sSql = sSql + " VALUES ( :1, :2, :3 , :4, :5, :6 ,:7 ,:8 ,:9 ,:10 ,:11 ,:12 ,:13 ,:14 ,:15  " + 
				" ,:16 ,:17 ,:18 ,:19 ,:20 ,:21 ,:22 ,:23 ,:24 ,:25 ,:26 ,:27 ,:28 ,:29 ,:30 " +  
			   " ,:31 ,:32 ,:33 ,:34 ,:35 ,:36 ,:37 ,:38 ,'-1' ,'-1' ,'-1' ,'-1' ,'-1' ,'-1' ,'-1' ,'-1' ,:39 ,:40 ,'1' " + 
				"	) " ;  
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_YEAR);
      gpstatement.bindColumn(2, idx_DEPT_CODE);
      gpstatement.bindColumn(3, idx_SEQ_NUM);
      gpstatement.bindColumn(4, idx_WBS_CODE);
      gpstatement.bindColumn(5, idx_THEME);
      gpstatement.bindColumn(6, idx_THEME_DETAIL);
      gpstatement.bindColumn(7, idx_SAVE_AMT);
      gpstatement.bindColumn(8, idx_PROPOSAL_DATE);
		gpstatement.bindColumn(9, idx_RESULT_DATE);
      gpstatement.bindColumn(10, idx_CHARGE_NAME);
      gpstatement.bindColumn(11,idx_REMARK );		
      gpstatement.bindColumn(12,idx_TEAM_NAME );		
      gpstatement.bindColumn(13,idx_TEAM_CHIEF );		
      gpstatement.bindColumn(14,idx_IMPROVE_NAME );		
      gpstatement.bindColumn(15,idx_BEFORE_MAP );		
      gpstatement.bindColumn(16,idx_AFTER_MAP );		
		gpstatement.bindColumn(17,idx_BEFORE_RESULT_MAP );		
      gpstatement.bindColumn(18,idx_AFTER_RESULT_MAP );		
      gpstatement.bindColumn(19,idx_ACT_FROM_DATE );		
      gpstatement.bindColumn(20,idx_ACT_TO_DATE );		
      gpstatement.bindColumn(21,idx_BEFORE_MAT_AMT );		
      gpstatement.bindColumn(22,idx_AFTER_MAT_AMT );		
      gpstatement.bindColumn(23,idx_BEFORE_LABOR_AMT );		
      gpstatement.bindColumn(24,idx_AFTER_LABOR_AMT );		
      gpstatement.bindColumn(25,idx_BEFORE_EQUIP_AMT );		
      gpstatement.bindColumn(26,idx_AFTER_EQUIP_AMT );		
      gpstatement.bindColumn(27,idx_BEFORE_ETC_AMT );		
      gpstatement.bindColumn(28,idx_AFTER_ETC_AMT );		
      gpstatement.bindColumn(29,idx_SAVE_RATE_ORDER );		
      gpstatement.bindColumn(30,idx_SAVE_RATE_HOME );		
      gpstatement.bindColumn(31,idx_SAVE_RATE_SBCR );		
		gpstatement.bindColumn(32,idx_IMPROVE_MERIT );		
      gpstatement.bindColumn(33,idx_IMPROVE_WEAK );		
      gpstatement.bindColumn(34,idx_IMPROVE_ALERT );		
      gpstatement.bindColumn(35,idx_IMPROVE_RESULT_MERIT );		
      gpstatement.bindColumn(36,idx_IMPROVE_RESULT_ALERT );		
      gpstatement.bindColumn(37,idx_CHARGE_OPINION );		
		gpstatement.bindColumn(38,idx_PART_OPINION );		
/*		gpstatement.bindColumn(39,idx_BEFORE_MAT_AMT_RESULT );		
      gpstatement.bindColumn(40,idx_AFTER_MAT_AMT_RESULT );		
      gpstatement.bindColumn(41,idx_BEFORE_LABOR_AMT_RESULT );		
      gpstatement.bindColumn(42,idx_AFTER_LABOR_AMT_RESULT );	
      gpstatement.bindColumn(43,idx_BEFORE_EQUIP_AMT_RESULT );	
		gpstatement.bindColumn(44,idx_AFTER_EQUIP_AMT_RESULT );	
      gpstatement.bindColumn(45,idx_BEFORE_ETC_AMT_RESULT );	
      gpstatement.bindColumn(46,idx_AFTER_ETC_AMT_RESULT );	 */
      gpstatement.bindColumn(39,idx_PROPOSAL_MAKE_DATE );
      gpstatement.bindColumn(40,idx_RESULT_MAKE_DATE ); 
		stmt.executeUpdate();
      stmt.close();

   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
 String sSql = "update v_tech_proposal_plan_detail set " + 
                      "YEAR=?,  " + 
                      "DEPT_CODE=?,  " + 
                      "SEQ_NUM=?,  " + 
                      "WBS_CODE=?,  " + 
                      "THEME=?,  " + 
                      "THEME_DETAIL=?,  " + 
							 "SAVE_AMT=? ," +
                      "PROPOSAL_DATE=?,  " + 
                      "RESULT_DATE=?, " + 
                      "CHARGE_NAME=?, " + 
                      "REMARK=?, " + 
                      "TEAM_NAME=?, " + 
                      "TEAM_CHIEF=?, " + 
                      "IMPROVE_NAME=?, " + 
                      "BEFORE_MAP=?, " + 
                      "AFTER_MAP=?, " + 
                      "BEFORE_RESULT_MAP=?, " + 
                      "AFTER_RESULT_MAP =?, " + 
                      "ACT_FROM_DATE=?, " + 
                      "ACT_TO_DATE=?, " + 
                      "BEFORE_MAT_AMT=?, " + 
                      "AFTER_MAT_AMT=?, " + 
                      "BEFORE_LABOR_AMT =?, " + 
                      "AFTER_LABOR_AMT=?, " + 
                      "BEFORE_EQUIP_AMT=?, " + 
                      "AFTER_EQUIP_AMT=?, " + 
                      "BEFORE_ETC_AMT=?, " + 
                      "AFTER_ETC_AMT=?, " + 
                      "SAVE_RATE_ORDER=?, " + 
                      "SAVE_RATE_HOME=?, " + 
                      "SAVE_RATE_SBCR=?, " + 
                      "IMPROVE_MERIT=?, " + 
                      "IMPROVE_WEAK=?, " + 
                      "IMPROVE_ALERT=?, " + 
                      "IMPROVE_RESULT_MERIT=?, " + 
                      "IMPROVE_RESULT_ALERT=?, " + 
                      "CHARGE_OPINION=?, " + 
                      "PART_OPINION =?, " + 
                      "BEFORE_MAT_AMT_RESULT=?, " + 
                      "AFTER_MAT_AMT_RESULT=?, " + 
                      "BEFORE_LABOR_AMT_RESULT=?, " + 
                      "AFTER_LABOR_AMT_RESULT=?, " + 
                      "BEFORE_EQUIP_AMT_RESULT=?, " + 
                      "AFTER_EQUIP_AMT_RESULT=?, " + 
                      "BEFORE_ETC_AMT_RESULT=?, " + 
                      "AFTER_ETC_AMT_RESULT=?, " + 
                      "PROPOSAL_MAKE_DATE=?, " + 
                      "RESULT_MAKE_DATE=?, " + 
							 "STATUS=? " +
							 " where DEPT_CODE=? and YEAR=? AND seq_num=?  ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_YEAR);
      gpstatement.bindColumn(2, idx_DEPT_CODE);
      gpstatement.bindColumn(3, idx_SEQ_NUM);
      gpstatement.bindColumn(4, idx_WBS_CODE);
      gpstatement.bindColumn(5, idx_THEME);
      gpstatement.bindColumn(6, idx_THEME_DETAIL);
      gpstatement.bindColumn(7, idx_SAVE_AMT);
      gpstatement.bindColumn(8, idx_PROPOSAL_DATE);
		gpstatement.bindColumn(9, idx_RESULT_DATE);
      gpstatement.bindColumn(10,idx_CHARGE_NAME);
      gpstatement.bindColumn(11,idx_REMARK );		
      gpstatement.bindColumn(12,idx_TEAM_NAME );		
      gpstatement.bindColumn(13,idx_TEAM_CHIEF );		
      gpstatement.bindColumn(14,idx_IMPROVE_NAME );		
      gpstatement.bindColumn(15,idx_BEFORE_MAP );		
      gpstatement.bindColumn(16,idx_AFTER_MAP );		
		gpstatement.bindColumn(17,idx_BEFORE_RESULT_MAP );		
      gpstatement.bindColumn(18,idx_AFTER_RESULT_MAP );		
      gpstatement.bindColumn(19,idx_ACT_FROM_DATE );		
      gpstatement.bindColumn(20,idx_ACT_TO_DATE );		
      gpstatement.bindColumn(21,idx_BEFORE_MAT_AMT );		
      gpstatement.bindColumn(22,idx_AFTER_MAT_AMT );		
      gpstatement.bindColumn(23,idx_BEFORE_LABOR_AMT );		
      gpstatement.bindColumn(24,idx_AFTER_LABOR_AMT );		
      gpstatement.bindColumn(25,idx_BEFORE_EQUIP_AMT );		
      gpstatement.bindColumn(26,idx_AFTER_EQUIP_AMT );		
      gpstatement.bindColumn(27,idx_BEFORE_ETC_AMT );		
      gpstatement.bindColumn(28,idx_AFTER_ETC_AMT );		
      gpstatement.bindColumn(29,idx_SAVE_RATE_ORDER );		
      gpstatement.bindColumn(30,idx_SAVE_RATE_HOME );		
      gpstatement.bindColumn(31,idx_SAVE_RATE_SBCR );		
		gpstatement.bindColumn(32,idx_IMPROVE_MERIT );		
      gpstatement.bindColumn(33,idx_IMPROVE_WEAK );		
      gpstatement.bindColumn(34,idx_IMPROVE_ALERT );		
      gpstatement.bindColumn(35,idx_IMPROVE_RESULT_MERIT );		
      gpstatement.bindColumn(36,idx_IMPROVE_RESULT_ALERT );		
      gpstatement.bindColumn(37,idx_CHARGE_OPINION );		
		gpstatement.bindColumn(38,idx_PART_OPINION );		
		gpstatement.bindColumn(39,idx_BEFORE_MAT_AMT_RESULT );		
      gpstatement.bindColumn(40,idx_AFTER_MAT_AMT_RESULT );		
      gpstatement.bindColumn(41,idx_BEFORE_LABOR_AMT_RESULT );		
      gpstatement.bindColumn(42,idx_AFTER_LABOR_AMT_RESULT );	
      gpstatement.bindColumn(43,idx_BEFORE_EQUIP_AMT_RESULT );	
		gpstatement.bindColumn(44,idx_AFTER_EQUIP_AMT_RESULT );	
      gpstatement.bindColumn(45,idx_BEFORE_ETC_AMT_RESULT );	
      gpstatement.bindColumn(46,idx_AFTER_ETC_AMT_RESULT );	
      gpstatement.bindColumn(47,idx_PROPOSAL_MAKE_DATE );	
      gpstatement.bindColumn(48,idx_RESULT_MAKE_DATE );	
      gpstatement.bindColumn(49,idx_STATUS );	
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(50, idx_DEPT_CODE);
      gpstatement.bindColumn(51, idx_YEAR);
      gpstatement.bindColumn(52, idx_SEQ_NUM);
      stmt.executeUpdate();
      stmt.close(); 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from v_tech_proposal_plan_detail where DEPT_CODE=? and YEAR=? and seq_num=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_DEPT_CODE);
      gpstatement.bindColumn(2, idx_YEAR);
      gpstatement.bindColumn(3, idx_SEQ_NUM);
      stmt.executeUpdate();
      stmt.close();  
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>