<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_start_date = req.getParameter("arg_start_date");
     String arg_end_date = req.getParameter("arg_end_date");
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("count_1",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("no_1",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("count_2",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("no_2",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("count_3",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("no_3",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("count_4",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("no_4",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("count_5",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("no_5",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("count_all",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("no_all",GauceDataColumn.TB_DECIMAL,5,0));
    String query = "select	ma.dept_code,																					" +
	"								(select long_name from z_code_dept where dept_code=ma.dept_code) long_name, " +
   "      						ma.code_cat,																					" +
	"								(select name from a_as_comm_code where code=ma.code_cat and class='3') code_name, " +
	"								a1.c1 count_1,																					" +
	"								a1.c2 no_1,																						" +
	"								a2.c1 count_2,																					" +
	"								a2.c2 no_2,																						" +
	"								a3.c1 count_3,																					" +
	"								a3.c2 no_3,																						" +
	"								a4.c1 count_4,																					" +
	"								a4.c2 no_4,																						" +
	"								a5.c1 count_5,																					" +
	"								a5.c2 no_5,																						" +
	"								ch.c1 count_all,																				" +
	"								ch.c2 no_all																					" +
	"						 from 																									" +
	"     						(select a.dept_code,																			" +
	"		         						a.code_cat,																			" +
	"											count(a.code_cat) c1,															" +
	"											count(b.code_cat) c2																" +
	"			 						 from a_as_req_master a,																" +
	"			      						(select req_useq, code_cat from a_as_req_master where prog_st in ('1', '2')) b " +
	"									where a.req_useq = b.req_useq(+) and													" +
	"			      						a.proc_code = '1' and													" +
	"											a.req_date >= '" + arg_start_date + "' and								" +
   "           							a.req_date <= '" + arg_end_date + "'										" +
	"								group by a.dept_code, a.proc_code, a.code_cat) a1,									" +
	"																																	" +
	"								(select a.dept_code,																			" +
	"		         						a.code_cat,																			" +
	"											count(a.code_cat) c1,															" +
	"											count(b.code_cat) c2																" +
	"			 						 from a_as_req_master a,																" +
	"			      						(select req_useq, code_cat from a_as_req_master where prog_st in ('1', '2')) b " +
	"									where a.req_useq = b.req_useq(+) and													" +
	"			      						a.proc_code = '2' and													" +
	"											a.req_date >= '" + arg_start_date + "' and 								" +
   "            							a.req_date <= '" + arg_end_date + "' 										" +
	"								group by a.dept_code, a.proc_code, a.code_cat) a2,									" +
	"																																	" +
	"								(select a.dept_code,																			" +
	"		         						a.code_cat,																			" +
	"											count(a.code_cat) c1,															" +
	"											count(b.code_cat) c2																" +
	"			 						 from a_as_req_master a,																" +
	"			      						(select req_useq, code_cat from a_as_req_master where prog_st in ('1', '2')) b " +
	"									where a.req_useq = b.req_useq(+) and													" +
	"			      						a.proc_code = '3' and														" +
	"											a.req_date >= '" + arg_start_date + "' and 								" +
   "            							a.req_date <= '" + arg_end_date + "' 										" +
	"								group by a.dept_code, a.proc_code, a.code_cat) a3,									" +
	"																																	" +
	"								(select a.dept_code,																			" +
	"		         						a.code_cat,																			" +
	"											count(a.code_cat) c1,															" +
	"											count(b.code_cat) c2																" +
	"			 						 from a_as_req_master a,																" +
	"			      						(select req_useq, code_cat from a_as_req_master where prog_st in ('1', '2')) b " +
	"									where a.req_useq = b.req_useq(+) and													" +
	"			      						a.proc_code = '4' and													" +
	"											a.req_date >= '" + arg_start_date + "' and 								" +
   "           							a.req_date <= '" + arg_end_date + "' 										" +
	"								group by a.dept_code, a.proc_code, a.code_cat) a4,									" +
	"																																	" +
	"								(select a.dept_code,																			" +
	"		         						a.code_cat,																			" +
	"											count(a.code_cat) c1,															" +
	"											count(b.code_cat) c2																" +
	"			 						 from a_as_req_master a,																" +
	"			      						(select req_useq, code_cat from a_as_req_master where prog_st in ('1', '2')) b " +
	"									where a.req_useq = b.req_useq(+) and													" +
	"			      						a.proc_code = '5' and														" +
	"											a.req_date >= '" + arg_start_date + "' and 								" +
   "           							a.req_date <= '" + arg_end_date + "' 										" +
	"								group by a.dept_code, a.proc_code, a.code_cat) a5,									" +
	"																																	" +
	"								(select a.dept_code,																			" +
	"		         						a.code_cat,																			" +
	"											count(a.code_cat) c1,															" +
	"											count(b.code_cat) c2																" +
	"			 						 from a_as_req_master a,																" +
	"			      						(select req_useq, code_cat from a_as_req_master where prog_st in ('1', '2')) b " +
	"									where a.req_useq = b.req_useq(+) and													" +
	"											a.req_date >= '" + arg_start_date + "' and 								" +
   "           							a.req_date <= '" + arg_end_date + "' 										" +
	"								group by a.dept_code, a.code_cat) ch,													" +
	"																																	" +
	"								(select dept_code, 																			" +
	"											code_cat 																			" +
	"									 from a_as_req_master 																	" +
	"                          where req_date >= '" + arg_start_date + "' and 									" +
   "            							req_date <= '" + arg_end_date + "' 											" +
   "								group by dept_code, code_cat) ma															" +
	"																																	" +
	"						where ma.dept_code = a1.dept_code(+) and														" +
	"			      			ma.dept_code = a2.dept_code(+) and														" +
	"			      			ma.dept_code = a3.dept_code(+) and														" +
	"								ma.dept_code = a4.dept_code(+) and														" +
	"								ma.dept_code = a5.dept_code(+) and														" +
	"								ma.dept_code = ch.dept_code(+) and														" +
	"			      			ma.code_cat = a1.code_cat(+) and															" +
	"								ma.code_cat = a2.code_cat(+) and															" +
	"								ma.code_cat = a3.code_cat(+) and															" +
	"								ma.code_cat = a4.code_cat(+) and															" +
	"								ma.code_cat = a5.code_cat(+) and															" +
	"								ma.code_cat = ch.code_cat(+) and															" +
	"								ma.dept_code like '%" + arg_dept_code + "%'											" +
	"					order by ma.dept_code, ma.code_cat																	" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>