<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
     String arg_start_date = req.getParameter("arg_start_date");
     String arg_end_date = req.getParameter("arg_end_date");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("req_d40",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("not_proc_d40",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proc_point_d40",GauceDataColumn.TB_DECIMAL,13,2));
     dSet.addDataColumn(new GauceDataColumn("req_d30",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("not_proc_d30",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proc_point_d30",GauceDataColumn.TB_DECIMAL,13,2));
     dSet.addDataColumn(new GauceDataColumn("req_d20",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("not_proc_d20",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proc_point_d20",GauceDataColumn.TB_DECIMAL,13,2));	
     dSet.addDataColumn(new GauceDataColumn("req",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("not_proc",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proc_point",GauceDataColumn.TB_DECIMAL,13,2));
     dSet.addDataColumn(new GauceDataColumn("req_as",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("not_proc_as",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proc_point_as",GauceDataColumn.TB_DECIMAL,13,2));	  
     dSet.addDataColumn(new GauceDataColumn("req_tot",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("not_proc_tot",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proc_point_tot",GauceDataColumn.TB_DECIMAL,13,2));	
String query = "select 																														" +
"	 b.dept_code , b.dept_name ,																											" +
"	 b.req_d40 , nvl(b.not_proc_d40,0) not_proc_d40,((b.req_d40 - b.not_proc_d40)/b.req_d40*100) proc_point_d40," +
"	 b.req_d30 , nvl(b.not_proc_d30,0) not_proc_d30,((b.req_d30 - b.not_proc_d30)/b.req_d30*100) proc_point_d30," +
"	 b.req_d20 , nvl(b.not_proc_d20,0) not_proc_d20,((b.req_d20 - b.not_proc_d20)/b.req_d20*100) proc_point_d20," +
"	 b.req , nvl(b.not_proc,0) not_proc,((b.req - b.not_proc)/b.req*100) proc_point ,									" +
"	 b.req_as , nvl(b.not_proc_as,0)not_proc_as,((b.req_as - b.not_proc_as)/b.req_as*100) proc_point_as ,			" + 
"	 b.req_tot ,nvl( b.not_proc_tot,0)not_proc_tot,((b.req_tot - b.not_proc_tot)/b.req_tot*100) proc_point_tot	" +	
"from	 			  	 					 					  																					" +
"	(																																				" + 
"	select																																		" + 
"		a.dept_code ,																															" +
"		(select long_name from z_code_dept where dept_code = a.dept_code ) dept_name ,									" + 
"		(select count(req_useq) from a_as_req_master where dept_code = a.dept_code and proc_code = '1') req_d40, " +
"		(select sum(case when prog_st='3' then 0 else 1 end ) 		 						 			  	 					" + 
"		from a_as_req_master where dept_code = a.dept_code and proc_code = '1') not_proc_d40 ,							" + 
"		(select count(req_useq) from a_as_req_master where dept_code = a.dept_code and proc_code = '2') req_d30, " + 
"		(select sum(case when prog_st='3' then 0 else 1 end ) 		 						 			  	 					" +
"		from a_as_req_master where dept_code = a.dept_code and proc_code = '2') not_proc_d30 ,							" + 
"		(select count(req_useq) from a_as_req_master where dept_code = a.dept_code and proc_code = '3') req_d20,	" + 
"		(select sum(case when prog_st='3' then 0 else 1 end ) 		 						 			  	 					" + 
"		from a_as_req_master where dept_code = a.dept_code and proc_code = '3') not_proc_d20 ,							" + 
"		(select count(req_useq) from a_as_req_master where dept_code = a.dept_code and proc_code = '4') req  , 	" +
"		(select sum(case when prog_st='3' then 0 else 1 end ) 		 						 			  	 			  		" +
"		from a_as_req_master where dept_code = a.dept_code and proc_code = '4') not_proc ,								" +	
"		(select count(req_useq) from a_as_req_master where dept_code = a.dept_code and proc_code = '5') req_as,	" + 
"		(select sum(case when prog_st='3' then 0 else 1 end ) 		 						 			  	 				  	" +
"		from a_as_req_master where dept_code = a.dept_code and proc_code = '5') not_proc_as , 							" + 
"		(select count(req_useq) from a_as_req_master where dept_code = a.dept_code ) req_tot  , 						" + 
"				(select sum(case when prog_st='3' then 0 else 1 end ) 		 					  			  					" +
"				from a_as_req_master where dept_code = a.dept_code ) not_proc_tot												" + 
"	from 		  											 					  																	" + 
"	  a_as_req_master a 																														" +
"	where 																																		" +
"	  a.req_date >= '"+arg_start_date+"' and a.req_date <= '"+arg_end_date+"' 												" + 
"	group by a.dept_code				 	  				 																					" + 
"	) b	  	  																																	" ; 
			  
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>