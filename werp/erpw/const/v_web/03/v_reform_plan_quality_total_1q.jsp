<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_quarter_year = req.getParameter("arg_quarter_year");
     String arg_quality_section = req.getParameter("arg_quality_section");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("DEPT_NAME",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("YEAR",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("QUARTER_YEAR",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("QUALITY_SECTION",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("CODE",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("ORDER_DT",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("REPORT_DT",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("INS_CHIEF",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ISSUE_DT",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ACTION_DT",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("COMPLETE_DT",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("DEPT_CHIEF",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("INSPECTOR",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("YN",GauceDataColumn.TB_STRING,1));  
     dSet.addDataColumn(new GauceDataColumn("REMARK",GauceDataColumn.TB_STRING,100));  

	 String query =" select  " + 
						"	a.dept_code , " +
						"	(select long_name from z_code_dept where dept_code = a.dept_code ) dept_name , " +
						"	a.year , " +
						"	a.quarter_year , " +
						"	a.quality_section , " +
						"	a.code , " +
						" 	to_char(order_dt,'yyyy.mm.dd')order_dt, " +
						" 	to_char(report_dt,'yyyy.mm.dd')report_dt, " +
						"	a.ins_chief, " +
						"	a.issue_dt , " +
						"	a.action_dt , " +
						"	a.complete_dt , " +
						"	a.dept_chief , " +
						"	a.inspector , " +
						"	a.yn , " +
						"	a.remark  " +
						"from  " +
						"	v_reform_order_quality_master a " +
						"where  " +
						"  to_char(year,'yyyy')= '"+arg_year+"'  and " +
						"	a.quarter_year = '"+arg_quarter_year+"' and" +
						"	a.quality_section = '"+arg_quality_section+"' " ;
							

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>