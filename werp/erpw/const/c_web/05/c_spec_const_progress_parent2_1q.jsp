<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	  dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,8));
	  dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("col_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("cat_text",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("seq_num",GauceDataColumn.TB_STRING,3));

	 String query = "select llevel ,col_tag, name , dept_code , yymm , cat_text , seq , rownum seq_num from ( " +
	 " select llevel , col_tag , name , '"+arg_dept_code+"' dept_code , '"+arg_yymm+"' yymm , cat_text , seq , rownum seq_num from " +
							" (select llevel, col_tag , " +
							"        decode(col_tag,'L','노무','M','재료','X','경비','S','외주',null,'[미연계]') name , cat_text , seq from " +
							"(SELECT  '2' llevel , b.col_tag , '' cat_text  , decode(col_tag,'L','13','M','12','X','14','S','11',null,'999' ) seq " +
							"from " +
							"	c_spec_const_detail a, " +
							"	y_budget_detail b " +
							"WHERE ( a.dept_code = b.dept_code ) and " +
							"	( a.spec_no_seq = b.spec_no_seq ) and " +
							"	( ( a.dept_code = '"+arg_dept_code+"') and " +
							"	  ( a.yymm = '"+arg_yymm+"') ) and " +
							"	a.spec_no_seq = b.spec_no_seq " +
							"group by   b.col_tag ) " +
							"union all " +
							"select '1' llevel , '' col_tag , long_name name , '' cat_text ,'1' seq  from z_code_dept " +
							"where dept_code =  '"+arg_dept_code+"' " +
							"union all " +
							"select llevel, col_tag , nvl(cat_text,'[미연계]') name, cat_text , decode(col_tag,'L','13','M','12','X','14','S','11',null,'999' ) seq from " +
							"(SELECT  '3' llevel , b.col_tag , cat_text " +
							"from " +
							"	c_spec_const_detail a, " +
							"	y_budget_detail b " +
							"WHERE ( a.dept_code = b.dept_code ) and " +
							"	( a.spec_no_seq = b.spec_no_seq ) and " +
							"	( ( a.dept_code = '"+arg_dept_code+"') and " +
							"	  ( a.yymm = '"+arg_yymm+"') ) and " +
							"	a.spec_no_seq = b.spec_no_seq " +
							" group by col_tag , b.cat_text	) " +
							")  " +
							"order by  seq , col_tag  , llevel , name )  " ;
	

/*
	 String query =  " select llevel , col_tag , name , '"+arg_dept_code+"' dept_code , '"+arg_yymm+"' yymm from " +
							" (select llevel, col_tag ,  " +
							"        decode(col_tag,'L','노무','M','재료','X','경비','S','외주',null,'[미연계]') name from " +
							"(SELECT  '2' llevel , b.col_tag , b.cat_text  " +
							"from  " +
							"	c_spec_const_detail a,  " +
							"	y_budget_detail b  " +
							"WHERE ( a.dept_code = b.dept_code ) and  " +
							"	( a.spec_no_seq = b.spec_no_seq ) and  " +
							"	( ( a.dept_code = '"+arg_dept_code+"') and  " +
							"	  ( a.yymm = '"+arg_yymm+"') ) and  " +
							"	a.spec_no_seq = b.spec_no_seq   " +
							"group by   b.col_tag )  " +
							"union all	 " +
							"select '1' llevel , '0' col_tag , long_name name from z_code_dept  " +
							"where dept_code =  '"+arg_dept_code+"'	 " +
							"union all  " +
							"select llevel, col_tag , cat_text  name from  " +
							"(SELECT  '3' llevel , b.col_tag , decode(b.cat_text,null,'[미연계]',b.cat_text)cat_text " +
							"from  " +
							"	c_spec_const_detail a,  " +
							"	y_budget_detail b  " +
							"WHERE ( a.dept_code = b.dept_code ) and  " +
							"	( a.spec_no_seq = b.spec_no_seq ) and  " +
							"	( ( a.dept_code = '"+arg_dept_code+"') and  " +
							"	  ( a.yymm = '"+arg_yymm+"') ) and  " +
							"	a.spec_no_seq = b.spec_no_seq  "+
							" group by col_tag , b.cat_text	)   " +
							")  " +
							"order by  col_tag  , llevel , name  " ;
*/
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>