<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
 
     String arg_year = req.getParameter("arg_year");
     String arg_quarter_year = req.getParameter("arg_quarter_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("DEPT_NAME",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("DEPT_NAME_DETAIL",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("LONG_NAME",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("YEAR",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("QUARTER_YEAR",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("FROM_YYMMDD",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("TO_YYMMDD",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("PART",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("WEIGHT_POINT",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("GOAL",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("ACTION_PLAN",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("POST",GauceDataColumn.TB_STRING,200));

	 String query =" SELECT																													" +
						"   DECODE( TAG,'H',DECODE(DEPT_DETAIL,NULL,LONG_NAME,DEPT_DETAIL),LONG_NAME ) DEPT_NAME ,	" + 
						"   DECODE( TAG,'H',LONG_NAME,' ') DEPT_NAME_DETAIL,														" +
						"   A.*																													" +
						"FROM																														" +
						"(																															" +
						"  SELECT																												" +
						"   A.DEPT_CODE    ,																									" +
						"   (SELECT LONG_NAME FROM Z_CODE_DEPT WHERE DEPT_CODE = A.DEPT_CODE) LONG_NAME ,				" +
						"   (SELECT DEPT_PROJ_TAG FROM Z_CODE_DEPT WHERE DEPT_CODE = A.DEPT_CODE) TAG,					" +
						"   (select long_name seq from z_code_dept where dept_code = substr(A.DEPT_CODE ,1,4) || '00' ) DEPT_DETAIL	,	   " +
						"   TO_CHAR(A.YEAR,'YYYY.MM.DD') YEAR,           " +           
						"   A.QUARTER_YEAR,								" +							
						"   TO_CHAR(FROM_YYMMDD,'YYYY.MM.DD') FROM_YYMMDD ,	" +		 
						"   TO_CHAR(TO_YYMMDD,'YYYY.MM.DD') TO_YYMMDD ,			" +	 
 						"  A.GOAL  MASTER_GOAL      ,						" +			 
 						"  A.ADMIT		  ,								" +				
 						"  B.PART         ,								" +				
 						"  B.WEIGHT_POINT ,									" +			
						"   B.GOAL         ,									" +			
						"   B.ACTION_PLAN  ,										" +		
						"   B.POST														" +	
						"FROM															   " +					
						"  V_GOAL_PLAN_MASTER A , 									   " +								
						"  V_GOAL_PLAN_DETAIL B									      " +
						" WHERE A.YEAR = B.YEAR AND								   " +
						"       A.DEPT_CODE = B.DEPT_CODE AND						" +
						"       A.QUARTER_YEAR = B.QUARTER_YEAR AND				" +
						" TO_CHAR(A.YEAR,'YYYY.MM.DD') = '"+arg_year+"'	AND	" +
						"     A.QUARTER_YEAR = '"+arg_quarter_year+"' AND " +
						"	   B.PART < '3'		  	) A			" +  
						"  ORDER BY TAG , DEPT_NAME , DEPT_NAME_DETAIL , PART , GOAL	" ;														

%><%@ include file="../../../comm_function/conn_q_end.jsp"%>