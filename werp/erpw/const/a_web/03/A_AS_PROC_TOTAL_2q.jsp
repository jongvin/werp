<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String arg_start_date = req.getParameter("arg_start_date");
      String arg_end_date = req.getParameter("arg_end_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,50));
	  dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("req",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("proc",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("not_proc",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("proc_date",GauceDataColumn.TB_STRING,10));
	  dSet.addDataColumn(new GauceDataColumn("proc_point",GauceDataColumn.TB_DECIMAL,13,2));
	  dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("contract_name",GauceDataColumn.TB_STRING,50));

	 String query = "select																	" +
	"			 temp.sbcr_code ,														" +
	"			 temp.sbcr_name ,            										 " +
	"			 temp.dept_name ,            										 " +
	"			temp.req ,                    									" +
	"			temp.proc ,                   									" + 
	"			temp.not_proc,                									" +
	"			temp.proc_date ,														" +
	"			temp.proc_point,													   " +
	"			 decode(temp.llevel,0,mod(rownum,2),3) llevel   ,        " +
	"			contract_name															" +
	"	from																				" +
	"	(																				   " +
	" select * from   " +
	"				(   " +
	"				select  bb.* , round(( bb.proc/bb.req*100),2) proc_point , '0' llevel	 " +		
	"				 from (																								" +				
	"				 select																									" +			
	"						 decode(a.sbcr_useq_as,null,a.sbcr_useq,a.sbcr_useq_as ) sbcr_code, 		" +
	"						 nvl((select sbcr_name from s_sbcr where sbcr_code = decode(a.sbcr_useq_as,null,a.sbcr_useq,a.sbcr_useq_as ) ),'[미정]') sbcr_name ,		  " +
	"						(select long_name from z_code_dept where dept_code = a.dept_code) dept_name , " +
	"						count(prog_st) req  ,	  " +
	"						sum(decode(prog_st,3,1,0)) proc ,  " +									
	"						sum(decode(prog_st,2,1,0)) not_proc ,  " +									 							
	"						round(avg( decode(prog_st,3,res_comp_date - req_date,null)),2) proc_date  ," +		
	"						contract_name																						" +					
	"				 from																											   " +	
	"					  a_as_req_master a																					" +		  
	"				 where																										" +		
			"		  a.req_date <= '"+arg_end_date+"' and a.req_date >= '"+arg_start_date+"'		" +			
	"				 group by  a.sbcr_useq_as , a.sbcr_useq	,a.dept_code ,contract_name ) bb                         " +
	"				union all                                                                           " +
	"				select  bb.* , round(( bb.proc/bb.req*100),2) proc_point , '1' llevel					" +						
	"				 from (																										" +		
	"				 select																										" +		
	"						 decode(a.sbcr_useq_as,null,a.sbcr_useq,a.sbcr_useq_as ) sbcr_code, 		      " +
	"						 nvl((select sbcr_name from s_sbcr where sbcr_code =                             decode(a.sbcr_useq_as,null,a.sbcr_useq,a.sbcr_useq_as ) ),'[미정]') sbcr_name ,		            " +
	"						'총계' dept_name ,                                                            " +
	"						count(prog_st) req  ,																			" +	
	"						sum(decode(prog_st,3,1,0)) proc ,															" +
	"						sum(decode(prog_st,2,1,0)) not_proc ,									 					" +		
	"						round(avg( decode(prog_st,3,res_comp_date - req_date,null)),2) proc_date,		" +	
	"						'' contract_name																						" +					
	"				 from																											" +	
	"					  a_as_req_master a																					" +		
	"				 where																										" +		
			"		  a.req_date <= '"+arg_end_date+"' and a.req_date >= '"+arg_start_date+"'		" +			
	"				 group by  a.sbcr_useq_as , a.sbcr_useq 	) bb													" +
	"				 )																												" +
	"				 order by sbcr_code , llevel																			" +
	" )temp			" ;

		
	
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>