<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_year = req.getParameter("arg_year");
     String arg_quarter_year = req.getParameter("arg_quarter_year");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("YEAR",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("QUARTER_YEAR",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("ORDER_DT",GauceDataColumn.TB_STRING,8));
	  dSet.addDataColumn(new GauceDataColumn("REPORT_DT",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("INS_CHIEF",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("DEPT_CHIEF",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("INSPECTOR",GauceDataColumn.TB_STRING,10));


    String query = " select dept_code ,  " +
						" 	   to_char(year,'yyyy') year, " +
						" 	   quarter_year, " +
						" 	   to_char(order_dt,'yyyymmdd')order_dt, " +
						" 	   to_char(report_dt,'yyyymmdd')report_dt, " +
						" 	   ins_chief, " +
						" 	   dept_chief, " +
						" 	   inspector " +
						" from V_REFORM_ORDER_MASTER " +
						" where dept_code  = '"+arg_dept_code+"' and " +
						" 	   to_char(year,'yyyy')= '"+arg_year+"'  and " +
						" 	   quarter_year = '"+arg_quarter_year+"' " ;



%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>