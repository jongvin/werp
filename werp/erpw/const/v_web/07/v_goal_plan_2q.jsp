<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r

     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_year = req.getParameter("arg_year");
     String arg_quarter_year = req.getParameter("arg_quarter_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("YEAR",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("QUARTER_YEAR",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("SEQ_NUM",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("PART",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("GOAL",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("GOAL_DETAIL",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("ACTION_PLAN",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("CHARGE_NAME",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("FROM_ACTION_YYMM",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("TO_ACTION_YYMM",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("OPINION_STANDARD",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("ESTIMATE_AMT",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("WEIGHT_POINT",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("OPINION",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("STATUS",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("POST",GauceDataColumn.TB_STRING,200));


	 String query=	" SELECT					                                             " +
						"   DEPT_CODE         ,                                           " +
						"   TO_CHAR(YEAR,'YYYY.MM.DD') YEAR,                              " +
						"   QUARTER_YEAR ,																" + 
						"   SEQ_NUM           ,                                           " +
						"   PART              ,                                           " +
						"   GOAL              ,                                           " +
						"   GOAL_DETAIL       ,                                           " +
						"   ACTION_PLAN       ,                                           " +
						"   CHARGE_NAME       ,                                           " +
						"   TO_CHAR(FROM_ACTION_YYMM,'YYYY.MM.DD') FROM_ACTION_YYMM ,     " +
						"   TO_CHAR(TO_ACTION_YYMM,'YYYY.MM.DD') TO_ACTION_YYMM ,         " +
						"   OPINION_STANDARD  ,                                           " +
						"   ESTIMATE_AMT      ,                                           " +
						"   WEIGHT_POINT      ,                                           " +
						"   OPINION           ,                                           " +
						"   STATUS		       ,                                           " +
						"   POST			                                                   " +
						" FROM	                                                         " +
						"   V_GOAL_PLAN_DETAIL                                            " +
						" WHERE DEPT_CODE = '"+arg_dept_code+"' AND                       " +
						"       TO_CHAR(YEAR,'YYYY.MM.DD') = '"+arg_year+"' AND	         " +
						"       QUARTER_YEAR = '" +arg_quarter_year+ "'							" +
						" ORDER BY STATUS DESC , PART , GOAL , GOAL_DETAIL  ";
      
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>