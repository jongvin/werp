<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_year = req.getParameter("arg_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("YEAR",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("NUM",GauceDataColumn.TB_DECIMAL,18));
	  dSet.addDataColumn(new GauceDataColumn("SEQ_NUM",GauceDataColumn.TB_DECIMAL,18));
     dSet.addDataColumn(new GauceDataColumn("WBS_CODE",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("WBS_NAME",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("THEME",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("THEME_DETAIL",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("SAVE_AMT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("PROPOSAL_DATE",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("RESULT_DATE",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("CHARGE_NAME",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("REMARK",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("TEAM_NAME",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("TEAM_CHIEF",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("IMPROVE_NAME",GauceDataColumn.TB_STRING,60));
	  dSet.addDataColumn(new GauceDataColumn("BEFORE_MAP",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("AFTER_MAP",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("BEFORE_RESULT_MAP",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("AFTER_RESULT_MAP",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("ACT_FROM_DATE",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ACT_TO_DATE",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("BEFORE_MAT_AMT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("AFTER_MAT_AMT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("BEFORE_LABOR_AMT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("AFTER_LABOR_AMT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("BEFORE_EQUIP_AMT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("AFTER_EQUIP_AMT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("BEFORE_ETC_AMT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("AFTER_ETC_AMT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("SAVE_RATE_ORDER",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("SAVE_RATE_HOME",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("SAVE_RATE_SBCR",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("IMPROVE_MERIT",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("IMPROVE_WEAK",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("IMPROVE_ALERT",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("IMPROVE_RESULT_MERIT",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("IMPROVE_RESULT_ALERT",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("CHARGE_OPINION",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("PART_OPINION",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("BEFORE_MAT_AMT_RESULT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("AFTER_MAT_AMT_RESULT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("BEFORE_LABOR_AMT_RESULT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("AFTER_LABOR_AMT_RESULT",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("BEFORE_EQUIP_AMT_RESULT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("AFTER_EQUIP_AMT_RESULT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("BEFORE_ETC_AMT_RESULT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("AFTER_ETC_AMT_RESULT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("PROPOSAL_MAKE_DATE",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("RESULT_MAKE_DATE",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("STATUS",GauceDataColumn.TB_STRING,1));
	String query =" SELECT																			" +
							 "TO_CHAR(YEAR,'YYYY.MM.DD') YEAR,  " + 
                      "DEPT_CODE,  " + 
                      "ROWNUM NUM,  " + 
                      "SEQ_NUM,  " + 
							 "WBS_CODE,  " + 
                      "(select comm_name from v_comm_code where section = 1 and comm_code = v_tech_proposal_plan_detail.wbs_code )WBS_NAME,  " + 
							 "THEME,  " + 
                      "THEME_DETAIL,  " + 
							 "SAVE_AMT, " +
                      "TO_CHAR(PROPOSAL_DATE,'YYYY.MM.DD') PROPOSAL_DATE,  " + 
                      "TO_CHAR(RESULT_DATE,'YYYY.MM.DD') RESULT_DATE, " + 
                      "CHARGE_NAME, " + 
                      "REMARK, " + 
                      "TEAM_NAME, " + 
                      "TEAM_CHIEF, " + 
                      "IMPROVE_NAME, " + 
                      "BEFORE_MAP, " + 
                      "AFTER_MAP, " + 
                      "BEFORE_RESULT_MAP, " + 
                      "AFTER_RESULT_MAP, " + 
                      "TO_CHAR(ACT_FROM_DATE,'YYYY.MM.DD')ACT_FROM_DATE, " + 
                      "TO_CHAR(ACT_TO_DATE,'YYYY.MM.DD')ACT_TO_DATE, " + 
                      "BEFORE_MAT_AMT , " + 
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
                      "PART_OPINION , " + 
                      "BEFORE_MAT_AMT_RESULT, " + 
                      "AFTER_MAT_AMT_RESULT, " + 
                      "BEFORE_LABOR_AMT_RESULT, " + 
                      "AFTER_LABOR_AMT_RESULT, " + 
                      "BEFORE_EQUIP_AMT_RESULT, " + 
                      "AFTER_EQUIP_AMT_RESULT, " + 
                      "BEFORE_ETC_AMT_RESULT, " + 
                      "AFTER_ETC_AMT_RESULT, " + 
                      "TO_CHAR(PROPOSAL_MAKE_DATE,'YYYY.MM.DD') PROPOSAL_MAKE_DATE, " + 
                      "TO_CHAR(RESULT_MAKE_DATE,'YYYY.MM.DD') RESULT_MAKE_DATE ," + 
							 "STATUS " +
				 "from v_tech_proposal_plan_detail 															" +
				 "where DEPT_CODE = '"+arg_dept_code+"' AND											   " +
				 "      TO_CHAR(YEAR,'YYYY.MM.DD') = '"+arg_year+"'									" ;
  
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>