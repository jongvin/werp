<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("nullchk",GauceDataColumn.TB_STRING,1));
	 String query =  " select 	c.long_name,											" +
"         							a.dept_code, 											" +
"         							a.yymm, 													" +
"         							a.amt, 													" +
"         							b.sum_amt, 												" +
"         							nvl((select sum(amt) amt 							" +
"												from  y_budget_detail 						" +
"												where res_class='X' and 					" +
"														dept_code=a.dept_code 				" +
"												group by dept_code),0) exe_amt1 ,		" +
"										decode(mmax.amt,0,0, s.total_amt / mmax.amt * 100) rate ,      " +
"										decode(d.remark,null,0,1)	nullchk ,		   " +
"										d.remark													" +
"    							from  (select  dept_code, 									" +
"                      						yymm, 										" +
"                      						sum(amt) amt 								" +
"                  					from  e_safty_cost_total						" +
"	    									group by dept_code, yymm) a,					" +
"																									" +
"           						(select  dept_code, 									" +
"                      						sum(amt) sum_amt 							" +
"                  					from  e_safty_cost_total 						" +
"                  					where to_char(yymm,'yyyymmdd') <= '" + arg_yymm + "' 			" +
"                  					group by dept_code) b,							" +
"																									" +
"           						(select  long_name,									" +
"                      						dept_code, 									" +
"                      						exe_amt1, 									" +
"                      						process_code 								" +
"                 					from  z_code_dept) c	,							" +
"		  																							" +
"		/*실행실적 exes */															         " +
"		(		(select s.dept_code,															" +	   
" 				nvl(sum(s.result_amt),0) total_amt										" +	
"		from																						" +
" 			 c_spec_const_detail s															" +	
"		where s.yymm <= last_day(to_date('"+arg_yymm+"','yyyymmdd') )			" +
"																									" +
"		group by s.dept_code)  ) s ,														" +
"                                   													" +
"		/*준공추정 실행 */          															" +
"		 (select b.dept_code,			  													" +
"	 	 	     nvl(a.amt,0) amt		  													" +	
" 		  from y_chg_degree a,																" +
"	 		  (select max(chg_no_seq) max_seq ,dept_code								" +		
"	  		  from y_chg_degree																" +
"	          where approve_class='4'													" +
"	  		  group by dept_code																" +
"			  ) b		         																" +
" 		  where a.chg_no_seq = b.max_seq and											" +
" 	      		a.approve_class='4' and													" +
"					a.dept_code = b.dept_code												" +
"		  )  mmax,																				" +	
"    E_SAFTY_COST_MEASURE_DETAIL d														" +
"																									" +	
"where  a.yymm  = to_date('"+arg_yymm+"','yyyymmdd') 								" +
"		  and a.dept_code=b.dept_code 													" +
"		  and b.dept_code=c.dept_code														" + 
"		  and c.dept_code=mmax.dept_code(+)												" +
"		  and c.dept_code=s.dept_code(+)													" +
"	     and a.dept_code=d.dept_code(+)													" +	
"	  	  and d.yymm(+) = a.yymm															" ;

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>