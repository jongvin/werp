<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_year = req.getParameter("arg_year");
     String arg_quarter_year = req.getParameter("arg_quarter_year");
	  String arg_quality_ins_code = req.getParameter("arg_quality_ins_code");
     String arg_quality_section = req.getParameter("arg_quality_section");
	  String arg_seq = req.getParameter("arg_seq");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("QUALITY_INS_CODE",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("QUALITY_SECTION",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("YEAR",GauceDataColumn.TB_STRING,4));
	  dSet.addDataColumn(new GauceDataColumn("QUARTER_YEAR",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("SEQ",GauceDataColumn.TB_NUMBER,13));
     dSet.addDataColumn(new GauceDataColumn("D_SEQ",GauceDataColumn.TB_NUMBER,13));
	  dSet.addDataColumn(new GauceDataColumn("CONTENTS",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("POINT",GauceDataColumn.TB_DECIMAL,4,1));
	  dSet.addDataColumn(new GauceDataColumn("SELECT_TYPE",GauceDataColumn.TB_STRING,1));

    String query = "select													" +
						 " QUALITY_INS_CODE	,								" +
						 " QUALITY_SECTION 	,								" +
						 " DEPT_CODE       	,								" +
						 " YEAR            	,								" +
						 " QUARTER_YEAR    	,								" +
						 " SEQ             	,								" +
						 " D_SEQ           	,								" +
						 " CONTENTS        	,								" +
						 " POINT           	,								" +
						 " SELECT_TYPE     									" +
						" from													" +	
						"    v_ins_point_detail								" +
						" where													" +
  						"  dept_code = '"+arg_dept_code+"' and			" +
  						"  to_char(year,'yyyy') = '"+arg_year+"' and	" +
 						"  quarter_year = '"+arg_quarter_year+"' and " +	
						"  QUALITY_INS_CODE = '"+arg_quality_ins_code+"' and " +	
						"  quality_section = '"+arg_quality_section+"' and"  +
						"  SEQ = '" +arg_seq+ "'							" +		
						" order by												" +
						"  POINT DESC											" ;



%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>