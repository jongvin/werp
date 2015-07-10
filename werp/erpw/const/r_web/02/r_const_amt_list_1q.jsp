<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("receive_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("pq_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("plan_year_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("month_plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("month_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("plan_sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  select (select a.child_name 														" +
   "									  from z_code_etc_child a 												" +
   "                           where a.class_tag='011' and a.etc_code=etc1 					" +
   "                         ) receive_name, 															" +
	"		 						  (select a.child_name	 													" +
	"                            from z_code_etc_child a 												" +
	"                           where a.class_tag='010' and a.etc_code=etc2 					" +
	"                         ) pq_name, 																	" +
	"		 						  plan_year_amt, 																" +
	"		 						  month_plan_amt,																" +
	"		 						  month_amt, 																	" +
	"		 				 		  plan_sum_amt, 																" +
	"		 						  sum_amt 																		" +
	"						   from (select st.etc1, 															" +
	"		 									 st.etc2, 															" +
	"		 									 nvl(a.plan_year_amt,0) plan_year_amt, 				" +
	"		 									 nvl(b.month_plan_amt,0) month_plan_amt, 			" +
	"		 									 nvl(d.month_amt,0) month_amt, 						" +
	"		 									 nvl(c.plan_sum_amt,0) plan_sum_amt, 				" +
	"		 									 nvl(e.sum_amt,0) sum_amt, 								" +
	"		 									 (nvl(c.plan_sum_amt,0) + nvl(e.sum_amt,0)) stand_amt " +
	
	"									  from 																		" +
	"											 (select (etc1 || etc2) etc_code, 							" +
	"		  												etc1, 													" +
	"		  												etc2 														" +
	"												 from (select a.etc_code etc1, 							" +
   "    															  b.etc_code etc2 							" +
  	"															from z_code_etc_child a, 						" +
	"     														  z_code_etc_child b 						" +
 	"														  where a.class_tag = '011' and 					" +
   "    															  b.class_tag = '010') 						" +
	"														  order by etc_code 									" +
	"														) st, 													" +
	"														(select receive_tag, 								" +
   "    															  pq_tag, 										" +
	"		 														  receive_tag || pq_tag etc_code, 		" +
	"		 														  sum(received_plan_amt) plan_year_amt " +
  	"															from R_RECEIVED_YEAR_PLAN 						" +
 	"														  where to_char(received_plan_year, 'yyyy') = substr('" + arg_date + "',0,4)	" +
 	"														  group by receive_tag, 							" +
   "       														  pq_tag 										" +
   "														) a, 														" +
	"														(select receive_tag, 								" +
   "    															  pq_tag, 										" +
	"		 														  receive_tag || pq_tag etc_code, 		" +
	"		 														  sum(received_plan_amt) month_plan_amt " +
  	"														   from R_RECEIVED_YEAR_PLAN 						" +
 	"														  where to_char(received_plan_year, 'yyyy.mm') = '" + arg_date + "' " +
 	"														  group by receive_tag, 							" +
   "       														  pq_tag 										" +
   "														) b, 														" +
	"														(select receive_tag, 								" +
   "    															  pq_tag, 										" +
	"		 														  receive_tag || pq_tag etc_code, 		" +
	"		 														  sum(received_plan_amt) plan_sum_amt 	" +
  	"															from R_RECEIVED_YEAR_PLAN 						" +
 	"														  where to_char(received_plan_year, 'yyyy.mm') <= '" + arg_date + "' " +
 	"														  group by receive_tag, 							" +
   "       														  pq_tag 										" +
   "														) c, 														" +
	
	"														(select sum(decode(b.chg_degree, 1, b.change_sum_amt,  " +
	"																			b.change_sum_amt - (select change_sum_amt  " +
	"																										 from R_CONTRACT_REGISTER  " +
	"																									   where dept_code = b.dept_code and  " +
	"																												cont_no = b.cont_no and " +
	"																												chg_degree=b.chg_degree-1) " +
	"																  )) month_amt, 								" +
//   "    															  b.chg_degree, 								" +
	"		 														  b.receive_tag, 								" +
	"		 														  b.pq_tag, 									" +
	"		 														  b.receive_tag || b.pq_tag etc_code 	" +
  	"															from R_CONTRACT_REGISTER b	      			" +
 	"														  where to_char(b.cont_date, 'yyyy.mm') = '" + arg_date + "' " +
 	"														group by b.receive_tag, b.pq_tag) d, 														" +
 	"														(select sum(decode(b.chg_degree, 1, b.change_sum_amt,  " +
 	"																			b.change_sum_amt - (select change_sum_amt  " +
 	"																										 from R_CONTRACT_REGISTER " + 
 	"																										where dept_code = b.dept_code and  " +
 	"																										cont_no = b.cont_no and  " +
 	"																										chg_degree=b.chg_degree-1) " +
 	"																	)) sum_amt, 									" +
//   "    																b.chg_degree,		 						" +
	"		 															b.receive_tag, 							" +
	"		 															b.pq_tag, 									" +
	"		 															b.receive_tag || b.pq_tag etc_code 	" +
  	"															from R_CONTRACT_REGISTER b 					" +
 	"														  where to_char(b.cont_date, 'yyyy.mm') <= '" + arg_date + "' and " +
   "    															  to_char(b.cont_date, 'yyyy') = substr('" + arg_date + "',0,4)	 " +
   "														group by b.receive_tag, b.pq_tag) e	 													" +

	"												where st.etc_code = a.etc_code(+) and				 	" +
	"														st.etc_code = b.etc_code(+) and 			 		" +
	"														st.etc_code = c.etc_code(+) and 					" +
	"														st.etc_code = d.etc_code(+) and 					" +
	"														st.etc_code = e.etc_code(+) 						" +

	"												) 										" +
	"									  where stand_amt <> 0	                    						";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>