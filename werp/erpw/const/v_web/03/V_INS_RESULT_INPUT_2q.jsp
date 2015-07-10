<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_year = req.getParameter("arg_year");
     String arg_quarter_year = req.getParameter("arg_quarter_year");
	  String arg_quality_ins_code = req.getParameter("arg_quality_ins_code");
     String arg_quality_section = req.getParameter("arg_quality_section");
	  String arg_part_code = req.getParameter("arg_part_code");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("QUALITY_INS_CODE",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("QUALITY_SECTION",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("YEAR",GauceDataColumn.TB_STRING,4));
	  dSet.addDataColumn(new GauceDataColumn("QUARTER_YEAR",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("SEQ",GauceDataColumn.TB_NUMBER,13));
	  dSet.addDataColumn(new GauceDataColumn("PART_CODE",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("WBS_CODE",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("wbs_name",GauceDataColumn.TB_STRING,30));
	  dSet.addDataColumn(new GauceDataColumn("SECTION",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("INS_ITEM",GauceDataColumn.TB_STRING,100));
	  dSet.addDataColumn(new GauceDataColumn("PLACE",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("REMARK",GauceDataColumn.TB_STRING,50));

    String query = "select													" +
						"  QUALITY_INS_CODE ,								" +
						"  QUALITY_SECTION  ,								" +
						"  DEPT_CODE        ,								" +
						"  YEAR             ,								" +
						"  QUARTER_YEAR     ,								" +
						"  SEQ				  ,								" +
						"  PART_CODE        ,								" +
						"  WBS_CODE			  ,								" +
						" (select comm_name from v_comm_code where comm_code = v_ins_point.wbs_code and part_code is not null) wbs_name,  " +
						"  SECTION			  ,								" +
						"  INS_ITEM         ,								" +
						"  PLACE				  ,								" +
						"  REMARK												" +
						" from													" +	
						"    v_ins_point										" +
						" where													" +
						"  dept_code = '"+arg_dept_code+"' and			" +
  						"  to_char(year,'yyyy') = '"+arg_year+"' and	" +
 						"  quarter_year = '"+arg_quarter_year+"' and " +	
						"  QUALITY_INS_CODE = '"+arg_quality_ins_code+"' and" +	
						"  quality_section = '"+arg_quality_section+"' " ;


	if ( arg_part_code.length() > 0 )
	 {	  query = query + " and part_code = '"+arg_part_code+"'	" ; }

	query = query +" order by												" +
						"    QUALITY_INS_CODE								" ;


%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>