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
     dSet.addDataColumn(new GauceDataColumn("FROM_YYMMDD",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("TO_YYMMDD",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("GOAL",GauceDataColumn.TB_STRING,500));
     dSet.addDataColumn(new GauceDataColumn("ADMIT",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("ADMIT_CHK",GauceDataColumn.TB_STRING,1));

	 String query =" SELECT																				" +
						"   DEPT_CODE    ,																" +
						"   TO_CHAR(YEAR,'YYYY.MM.DD') YEAR,                              " +
						"   QUARTER_YEAR ,																" +
						"   TO_CHAR(FROM_YYMMDD,'YYYY.MM.DD') FROM_YYMMDD ,					" +
						"   TO_CHAR(TO_YYMMDD,'YYYY.MM.DD') TO_YYMMDD ,							" +
						"   GOAL         ,																" +
						"   ADMIT		  ,																" +
						"   ADMIT ADMIT_CHK   															" +
						" FROM																				" +
						"  V_GOAL_PLAN_MASTER															" +
						" WHERE DEPT_CODE = '"+arg_dept_code+"' AND                       " +
						"       TO_CHAR(YEAR,'YYYY.MM.DD') = '"+arg_year+"' AND	         " +
						"       QUARTER_YEAR = '" +arg_quarter_year+ "'							" ;
  
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>