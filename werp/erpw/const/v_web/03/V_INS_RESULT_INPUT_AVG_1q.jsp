<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r

	  String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_year = req.getParameter("arg_year");
     String arg_quarter_year = req.getParameter("arg_quarter_year");
     String arg_quality_section = req.getParameter("arg_quality_section");
     String arg_quality_ins_code = req.getParameter("arg_quality_ins_code");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("avg",GauceDataColumn.TB_DECIMAL,5,2));

    String query =" SELECT " +
	  					"    round(avg(point),3) avg FROM v_ins_point_detail  " +
						" WHERE 	" +
						"  select_type  = 'T' and " +
 						"  dept_code = '"+arg_dept_code+"' and	" +
  						"  to_char(year,'yyyy') = '"+arg_year+"' and	" +
						"  quarter_year = '"+arg_quarter_year+"' and	" +
						"  quality_section = '"+arg_quality_section+"' and"  +
						"  quality_ins_code	= '"+arg_quality_ins_code+"' " ;


%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>