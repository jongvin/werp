<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String arg_date = req.getParameter("arg_date");
      String arg_won = req.getParameter("arg_won");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("st",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("etc_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("receive_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("pq_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cont_no",GauceDataColumn.TB_STRING,10));
//     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("start_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("completion_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("last_year",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mon_01",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mon_02",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mon_03",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mon_04",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mon_05",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mon_06",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mon_07",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mon_08",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mon_09",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mon_10",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mon_11",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mon_12",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mon_st",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mon_sum",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("sum_all",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("mon_rate",GauceDataColumn.TB_DECIMAL,5,2));
    String query =" select *																					" +
"							 from (select decode(stand,0,'계획',1,'실적') st,							" +
"									st.etc_code,																	" +
"			 						(select a.child_name from z_code_etc_child a where a.class_tag='011' and a.etc_code=etc1) receive_name, " +
"			 						(select a.child_name from z_code_etc_child a where a.class_tag='010' and a.etc_code=etc2) pq_name, " +
"			 						(select long_name from z_code_dept where dept_code=r.dept_code) long_name, " +
"			 						decode(r.cont_no,0,null,r.cont_no) cont_no, 							" +
//"			 						decode(r.chg_degree,0,null,r.chg_degree) chg_degree, 				" +
"			 						start_date,																		" +
"			 						completion_date,																" +
"			 						nvl(r.last_year,0)/ " + arg_won + " last_year,												" +
"			 						nvl(r.mon_01,0)/ " + arg_won + " mon_01,														" +
"			 						nvl(r.mon_02,0)/ " + arg_won + " mon_02,														" +
"			 						nvl(r.mon_03,0)/ " + arg_won + " mon_03,														" +
"			 						nvl(r.mon_04,0)/ " + arg_won + " mon_04,														" +
"			 						nvl(r.mon_05,0)/ " + arg_won + " mon_05,														" +
"			 						nvl(r.mon_06,0)/ " + arg_won + " mon_06,														" +
"			 						nvl(r.mon_07,0)/ " + arg_won + " mon_07,														" +
"			 						nvl(r.mon_08,0)/ " + arg_won + " mon_08,														" +
"			 						nvl(r.mon_09,0)/ " + arg_won + " mon_09,														" +
"			 						nvl(r.mon_10,0)/ " + arg_won + " mon_10,														" +
"			 						nvl(r.mon_11,0)/ " + arg_won + " mon_11,														" +
"			 						nvl(r.mon_12,0)/ " + arg_won + " mon_12,														" +
"			 						nvl(r.mon_st,0)/ " + arg_won + " mon_st,														" +
"			 						nvl(r.mon_sum,0)/ " + arg_won + " mon_sum,													" +
"			 						(nvl(r.last_year,0) + nvl(r.mon_sum,0))/ " + arg_won + " sum_all,						" +
"                          '' mon_rate																								" +
"							from 																						" +
"			 						(select (etc1 || etc2) etc_code,											" +
"			  									etc1,																	" +
"			  									etc2																	" +
"										from (select a.etc_code etc1,											" +
"      		  			 							 b.etc_code etc2											" +
"  											  from z_code_etc_child a,										" +
"	     					  							 z_code_etc_child b										" +
"												 where a.class_tag = '011' and								" +
"       												 b.class_tag = '010')									" +
"									  order by etc_code) st,													" +
"																														" +
"									(select stand,																	" +
"			  								  etc_code,																" +
"			 								  receive_tag,															" +
"			 								  pq_tag,																" +
"			 								  dept_code,															" +
"			 								  cont_no,																" +
//"											  chg_degree,															" +
"			 								  start_date,															" +
"			 								  completion_date,													" +
"			 								  last_year,															" +
"			 								  mon_01,																" +
"			 								  mon_02,																" +
"			 								  mon_03,																" +
"			 								  mon_04,																" +
"			 								  mon_05,																" +
"			 								  mon_06,																" +
"			 								  mon_07,																" +
"			 							     mon_08,																" +
"			 								  mon_09,																" +
"			 								  mon_10,																" +
"			 								  mon_11,																" +
"			 								  mon_12,																" +
"			 								  mon_st,																" +
"			 								  mon_sum																" +
" 										from																			" +
"											  (select 0 stand,													" +
"			 											 a.receive_tag || a.pq_tag etc_code,				" +
"       												 a.receive_tag,											" +
"			 											 a.pq_tag,													" +
"			 											 '' dept_code,												" +
"			 											 0 cont_no,													" +
//"														 0 chg_degree,												" +
"			 											 '' start_date,											" +
"			 											 '' completion_date,										" +
"			 											 sum(case when to_char(a.received_plan_year, 'yyyy') = substr('" + arg_date + "',0,4)	" +
"			 			 											 then nvl(received_plan_amt,0) 			" +
"						 											 else 0											" +
"				  											  end) last_year,										" +
"			 											 sum(case when to_char(a.received_plan_year, 'yyyymm') = substr('" + arg_date + "',0,4) || '01'	" +
"			 			 											 then nvl(received_plan_amt,0)			" +
"						 											 else 0											" +
"				  											  end) mon_01,											" +
"			 											 sum(case when to_char(a.received_plan_year, 'yyyymm') = substr('" + arg_date + "',0,4) || '02'	" +
"			 			 											 then nvl(received_plan_amt,0)			" +
"						 											 else 0											" +
"				  											  end) mon_02,											" +
"			 											 sum(case when to_char(a.received_plan_year, 'yyyymm') = substr('" + arg_date + "',0,4) || '03'	" +
"			 			 											 then nvl(received_plan_amt,0)			" +
"						 											 else 0											" +
"				  											  end) mon_03,											" +
"			 											 sum(case when to_char(a.received_plan_year, 'yyyymm') = substr('" + arg_date + "',0,4) || '04'	" +
"			 			 											 then nvl(received_plan_amt,0)			" +
"						 											 else 0											" +
"				  											  end) mon_04,											" +
"			 											 sum(case when to_char(a.received_plan_year, 'yyyymm') = substr('" + arg_date + "',0,4) || '05'	" +
"			 			 											 then nvl(received_plan_amt,0)			" +
"						 											 else 0											" +
"				  											  end) mon_05,											" +
"			 											 sum(case when to_char(a.received_plan_year, 'yyyymm') = substr('" + arg_date + "',0,4) || '06' " +
"			 			 											 then nvl(received_plan_amt,0)			" +
"						 											 else 0											" +
"				  											  end) mon_06,											" +
"			 											 sum(case when to_char(a.received_plan_year, 'yyyymm') = substr('" + arg_date + "',0,4) || '07'	" +
"			 			 											 then nvl(received_plan_amt,0)			" +
"						 											 else 0											" +
"				  											  end) mon_07,											" +
"			 											 sum(case when to_char(a.received_plan_year, 'yyyymm') = substr('" + arg_date + "',0,4) || '08'	" +
"			 			 											 then nvl(received_plan_amt,0)			" +
"						 											 else 0											" +
"				  											  end) mon_08,											" +
"			 											 sum(case when to_char(a.received_plan_year, 'yyyymm') = substr('" + arg_date + "',0,4) || '09'	" +
"			 			 											 then nvl(received_plan_amt,0)			" +
"						 											 else 0											" +
"				  											  end) mon_09,											" +
"			 											 sum(case when to_char(a.received_plan_year, 'yyyymm') = substr('" + arg_date + "',0,4) || '10'	" +
"			 			 											 then nvl(received_plan_amt,0)			" +
"						 											 else 0											" +
"				  											  end) mon_10,											" +
"			 											 sum(case when to_char(a.received_plan_year, 'yyyymm') = substr('" + arg_date + "',0,4) || '11'	" +
"			 			 											 then nvl(received_plan_amt,0)			" +
"						 											 else 0											" +
"				  											  end) mon_11,											" +
"			 											 sum(case when to_char(a.received_plan_year, 'yyyymm') = substr('" + arg_date + "',0,4) || '12'	" +
"			 			 											 then nvl(received_plan_amt,0)			" +
"						 											 else 0											" +
"				  											  end) mon_12,											" +
"			 											 sum(case when to_char(a.received_plan_year, 'yyyy-mm') <= '" + arg_date + "'	" +
"			 			 											 then nvl(received_plan_amt,0)			" +
"						 											 else 0											" +
"				  											  end) mon_st,											" +
"			 											 sum(case when to_char(a.received_plan_year, 'yyyy') = substr('" + arg_date + "',0,4) " +
"			 			 											 then nvl(received_plan_amt,0)			" +
"						 											 else 0											" +
"				  											  end) mon_sum											" +
" 												  from r_received_year_plan a									" +
"  											 group by a.receive_tag, a.pq_tag							" +
"																														" +
"								union all																			" +
"																														" +
"											  	select 1 stand,													" +
"			 											 a.receive_tag || a.pq_tag etc_code,				" +
"			 											 a.receive_tag,											" +
"			 											 a.pq_tag,													" +
"			 											 a.dept_code,												" +
"			 										    a.cont_no,													" +
//"														 a.chg_degree,												" +
"			 											 (select to_char(start_date,'yyyy.mm.dd') 		" +
"															 from r_contract_register 							" +
"															where dept_code=a.dept_code and 					" +
"																	cont_no=a.cont_no and 						" +
"																	chg_degree=(select max(chg_degree) 		" +
"																					  from r_contract_register " +
"																					 where dept_code=a.dept_code and " +
"																							 cont_no=a.cont_no 	" +
"																					 group by dept_code,cont_no)) start_date,	" +
"			 											 (select to_char(completion_date,'yyyy.mm.dd') 	" +
"															 from r_contract_register 							" +
"															where dept_code=a.dept_code and 					" +
"																	cont_no=a.cont_no and 						" +
"																	chg_degree=(select max(chg_degree) 		" +
"																					  from r_contract_register " +
"																					 where dept_code=a.dept_code and " +
"																							 cont_no=a.cont_no 	" +
"																					 group by dept_code,cont_no)) completion_date,	" +
"			 											 sum(case when to_char(a.cont_date, 'yyyy') < substr('" + arg_date + "',0,4)	" +
"			 			 											 then nvl(a.change_sum_amt,0)				" +
"						 											 else 0											" +
"				  											  end) last_year,										" +
"			 											 sum(case when to_char(a.cont_date, 'yyyymm') = substr('" + arg_date + "',0,4) || '01'	" +
"			 			 											 then nvl(a.change_sum_amt,0)				" +
"						 											 else 0											" +
"				  											  end) mon_01,											" +
"			 											 sum(case when to_char(a.cont_date, 'yyyymm') = substr('" + arg_date + "',0,4) || '02'	" +
"			 			 											 then nvl(a.change_sum_amt,0)				" +
"						 											 else 0											" +
"				  											  end) mon_02,											" +
"			 											 sum(case when to_char(a.cont_date, 'yyyymm') = substr('" + arg_date + "',0,4) || '03'	" +
"			 			 											 then nvl(a.change_sum_amt,0)				" +
"						 											 else 0											" +
"				  											  end) mon_03,											" +
"			 											 sum(case when to_char(a.cont_date, 'yyyymm') = substr('" + arg_date + "',0,4) || '04' " +
"			 			 											 then nvl(a.change_sum_amt,0)				" +
"						 											 else 0											" +
"				  											  end) mon_04,											" +
"			 											 sum(case when to_char(a.cont_date, 'yyyymm') = substr('" + arg_date + "',0,4) || '05'	" +
"			 			 											 then nvl(a.change_sum_amt,0)				" +
"						 											 else 0											" +
"				  											  end) mon_05,											" +
"			 											 sum(case when to_char(a.cont_date, 'yyyymm') = substr('" + arg_date + "',0,4) || '06'	" +
"			 			 											 then nvl(a.change_sum_amt,0)				" +
"						 											 else 0											" +
"				  											  end) mon_06,											" +
"			 											 sum(case when to_char(a.cont_date, 'yyyymm') = substr('" + arg_date + "',0,4) || '07'	" +
"			 			 											 then nvl(a.change_sum_amt,0)				" +
"						 											 else 0											" +
"				  											  end) mon_07,											" +
"			 											 sum(case when to_char(a.cont_date, 'yyyymm') = substr('" + arg_date + "',0,4) || '08'	" +
"			 			 											 then nvl(a.change_sum_amt,0)				" +
"						 											 else 0											" +
"				  											  end) mon_08,											" +
"			 											 sum(case when to_char(a.cont_date, 'yyyymm') = substr('" + arg_date + "',0,4) || '09'	" +
"			 			 										    then nvl(a.change_sum_amt,0)				" +
"						 											 else 0											" +
"				  											  end) mon_09,											" +
"			 											 sum(case when to_char(a.cont_date, 'yyyymm') = substr('" + arg_date + "',0,4) || '10'	" +
"			 			 											 then nvl(a.change_sum_amt,0)				" +
"						 											 else 0											" +
"				  											  end) mon_10,											" +
"			 											 sum(case when to_char(a.cont_date, 'yyyymm') = substr('" + arg_date + "',0,4) || '11'	" +
"			 			 											 then nvl(a.change_sum_amt,0)				" +
"						 											 else 0											" +
"				  											  end) mon_11,											" +
"			 											 sum(case when to_char(a.cont_date, 'yyyymm') = substr('" + arg_date + "',0,4) || '12'	" +
"			 			 											 then nvl(a.change_sum_amt,0)				" +
"						 											 else 0											" +
"				  													 end) mon_12,									" +
"			 											 sum(case when to_char(a.cont_date, 'yyyy-mm') <= '" + arg_date + "'	" +
"			 			 											 then nvl(a.change_sum_amt,0)				" +
"						 											 else 0											" +
"				  											  end) mon_st,											" +
"			 											 sum(case when to_char(a.cont_date, 'yyyy') = substr('" + arg_date + "',0,4)	" +
"			 			 											 then nvl(a.change_sum_amt,0)				" +
"						 											 else 0											" +
"				  											  end) mon_sum											" +
" 												  from r_contract_register a									" +
" 												 group by a.receive_tag,										" +
"  		 	 											 a.pq_tag,												" +
"				 											 a.dept_code,											" +
"				 											 a.cont_no												" +
//"															 a.chg_degree,										   " +
"				 											 )									" +
"									order by etc_code, stand 	) 	r											" +
"																														" +
"							where st.etc_code = r.etc_code(+)		)										" +
"																														" +
"					where mon_sum <> 0	"  ;						
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>