<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_year = req.getParameter("arg_year");
     String arg_quarter_year = req.getParameter("arg_quarter_year");
     String arg_quality_section = req.getParameter("arg_quality_section");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("QUALITY_INS_CODE",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("QUALITY_SECTION",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("YEAR",GauceDataColumn.TB_STRING,4));
	  dSet.addDataColumn(new GauceDataColumn("QUARTER_YEAR",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("QUALITY_INS_NAME",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("WEIGHT_POINT",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("WEIGHT_POINT1",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("WEIGHT_POINT2",GauceDataColumn.TB_STRING,3));
	  dSet.addDataColumn(new GauceDataColumn("INS_DT",GauceDataColumn.TB_STRING,8));
	  dSet.addDataColumn(new GauceDataColumn("INSPECTOR",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("DEPT_CHARGE_PERSON",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("WORK_PERSON",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("REVIEW",GauceDataColumn.TB_STRING,100));
	  dSet.addDataColumn(new GauceDataColumn("COLUMN_SIZE",GauceDataColumn.TB_STRING,30));
	  dSet.addDataColumn(new GauceDataColumn("POSITION",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("NAME",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("OPINION_CHK",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("AVERAGE",GauceDataColumn.TB_DECIMAL,4,1));

    String query = "SELECT													" +
						"   QUALITY_INS_CODE ,								" + 
						"   QUALITY_SECTION  ,								" +
						"   DEPT_CODE        ,								" +
 						"   YEAR             ,								" +	
 						"   QUARTER_YEAR     ,								" +
						"   QUALITY_INS_NAME ,								" + 
						"   WEIGHT_POINT ,									" + 
						"   WEIGHT_POINT1  ,									" +		
						"   WEIGHT_POINT2  ,									" +		
						"   TO_CHAR(ins_dt,'YYYYMMDD') ins_dt  ,		" +		
						"   INSPECTOR        ,								" +
						"   DEPT_CHARGE_PERSON    ,						" +
						"   WORK_PERSON      ,								" +
						"   REVIEW				,								" +
						"   COLUMN_SIZE		,								" +
						"   POSITION		,									" +
						"   NAME		,											" +
						"   OPINION_CHK ,										" +
						"   (																	" +
						"	 SELECT round(avg(point),2) FROM v_ins_point_detail" +
						"		where select_type = 'T' and                     " +
						"			 dept_code = a.dept_code and                 " +
						"			quality_ins_code = a.quality_ins_code and    " +
						"			quality_section = a.quality_section and      " +
						"			year = a.year and                            " + 
						"			quarter_year = a.quarter_year                " +
						"	)                                         " +
						"	AVERAGE												" +
						" from													" +	
						"    v_ins_point_master	a							" +
						" where													" +
  						"  dept_code = '"+arg_dept_code+"' and			" +
  						"  to_char(year,'yyyy') = '"+arg_year+"' and	" +
 						"  quarter_year = '"+arg_quarter_year+"' and	" +
						"  quality_section = '"+arg_quality_section+"'" +
						" order by												" +
						"    QUALITY_INS_CODE								" ;



%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>