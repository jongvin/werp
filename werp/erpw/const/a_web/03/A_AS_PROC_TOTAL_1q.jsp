<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String arg_start_date = req.getParameter("arg_start_date");
      String arg_end_date = req.getParameter("arg_end_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sbcr_useq_as",GauceDataColumn.TB_STRING,7));
	  dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("req",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("proc",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("not_proc",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("proc_date",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("proc_point",GauceDataColumn.TB_DECIMAL,13,2));

	 String query =" select  aa.* , ( aa.proc/aa.req*100) proc_point														" +
						" from (																												" +
						" select																												" +	
						" a.dept_code ,																									" +
						"		(select long_name from z_code_dept where dept_code = a.dept_code ) dept_name ,		" +
						"	   a.sbcr_useq_as , 																						   " +		
						"	   (select sbcr_name from s_sbcr where sbcr_code = a.sbcr_useq_as ) sbcr_name ,		" +
						"		(select count(prog_st) from a_as_req_master where dept_code = a.dept_code ) req  ,	" +
						"		(select sum(case when prog_st='3' then 1 else 0 end )											" +
						"		from a_as_req_master where dept_code = a.dept_code ) proc ,									" +
						"		(select sum(case when prog_st='3' then 0 else 1 end )											" +
						"		from a_as_req_master where dept_code = a.dept_code ) not_proc ,							" +	
						"		(select avg(case when prog_st='3' then res_comp_date - req_date else null end )		" +
						"		from a_as_req_master where dept_code = a.dept_code ) proc_date								" +
						" from																												" +	
						"	  a_as_req_master a																							" +
						" where																												" +
						"	  a.req_date <= '"+arg_end_date+"' and a.req_date >= '"+arg_start_date+"'					" +
//						"    and a.sbcr_useq_as <> '0'																				" +
						" group by a.dept_code, a.sbcr_useq_as	 ) aa																" ;	
		
	
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>