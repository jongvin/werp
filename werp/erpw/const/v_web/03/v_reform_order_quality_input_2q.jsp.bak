<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_year = req.getParameter("arg_year");
     String arg_quarter_year = req.getParameter("arg_quarter_year");
     String arg_quality_section = req.getParameter("arg_quality_section");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("YEAR",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("QUARTER_YEAR",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("QUALITY_SECTION",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("SEQ",GauceDataColumn.TB_NUMBER,18));
	  dSet.addDataColumn(new GauceDataColumn("WBS_CODE",GauceDataColumn.TB_STRING,40));
	  dSet.addDataColumn(new GauceDataColumn("REFORM_DT",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("REFORM_ORDER",GauceDataColumn.TB_STRING,4000));
	  dSet.addDataColumn(new GauceDataColumn("BEFOR_REFORM",GauceDataColumn.TB_STRING,4000));
	  dSet.addDataColumn(new GauceDataColumn("AFTER_REFORM",GauceDataColumn.TB_STRING,4000));
	  dSet.addDataColumn(new GauceDataColumn("PIC_INFO",GauceDataColumn.TB_STRING,30));

    String query = " select dept_code ,  " +
						" 	   to_char(year,'yyyy') year, " +
						" 	   quarter_year, " +
						"     quality_section, " +
						" 	   seq , " +
						" 	   WBS_CODE, " +
						" 	   to_char(REFORM_DT,'yyyy.mm.dd') REFORM_DT, " +
						" 	   REFORM_ORDER ," +
						" 	   BEFOR_REFORM ," +
						" 	   AFTER_REFORM ," +
						" 	   PIC_INFO " +
						" from v_reform_order_quality " +
						" where dept_code  = '"+arg_dept_code+"' and " +
						" 	   to_char(year,'yyyy')= '"+arg_year+"'  and " +
						" 	   quarter_year = '"+arg_quarter_year+"' and " +
						"	   quality_section = '"+arg_quality_section+"' " ;


%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>