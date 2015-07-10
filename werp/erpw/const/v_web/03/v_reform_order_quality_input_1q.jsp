<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
	  String arg_year = req.getParameter("arg_year");
     String arg_quarter_year = req.getParameter("arg_quarter_year");
     String arg_quality_section = req.getParameter("arg_quality_section");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("LONG_NAME",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("YEAR",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("QUARTER_YEAR",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("QUALITY_SECTION",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("CODE",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("ORDER_DT",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("REPORT_DT",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("INS_CHIEF",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("COMPLETE_DT",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("DEPT_CHIEF",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("INSPECTOR",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("YN",GauceDataColumn.TB_STRING,1));  
	 String query =" select  " + 
						"	a.dept_code , " +
						"	(select long_name from z_code_dept where dept_code = a.dept_code ) long_name , " +
						" 	to_char(year,'yyyy') year, " +
						"	a.quarter_year , " +
						"	a.quality_section , " +
						"	a.code , " +
						"	to_char(a.order_dt,'YYYY.MM.DD')order_dt , " +
						"	to_char(a.report_dt,'YYYY.MM.DD')report_dt, " +
						"	a.ins_chief, " +
						"	to_char(a.complete_dt,'YYYY.MM.DD') complete_dt," +
						"	a.dept_chief , " +
						"	a.inspector , " +
						"	a.yn  " +
						"from  " +
						"	v_reform_order_quality_master a " +
						"where  " +
						"  a.dept_code = '"+arg_dept_code+"' and " +
						"  to_char(a.year,'yyyy')= '"+arg_year+"'  and " +
						"	a.quarter_year = '"+arg_quarter_year+"' and" +
						"	a.quality_section = '"+arg_quality_section+"' " ;
						

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>