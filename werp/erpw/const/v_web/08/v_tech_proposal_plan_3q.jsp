<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r

     String arg_year = req.getParameter("arg_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("LONG_NAME",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ADMIT",GauceDataColumn.TB_STRING,1));

	 String query=	" SELECT					                                             " +
						"   DEPT_CODE         ,                                           " +
						"   (SELECT LONG_NAME FROM Z_CODE_DEPT WHERE DEPT_CODE  = V_TECH_PROPOSAL_PLAN_MASTER.DEPT_CODE ) LONG_NAME,    " +
						" admit																				" +
						" FROM	                                                         " +
						"   V_TECH_PROPOSAL_PLAN_MASTER                                   " +
						" WHERE TO_CHAR(YEAR,'YYYY') = '"+arg_year+"'               " ;

      
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>