<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
	  String arg_to_date = req.getParameter("arg_to_date");
	  String arg_from_date = req.getParameter("arg_from_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("receive_date",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("seq1",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("rqst_detail",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("bank_input",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bank_output",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bank_n",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cash_input",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cash_output",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cash_n",GauceDataColumn.TB_DECIMAL,18,0));
    String query = " select   a.dept_code,  " +
"			 							decode(a.input_tag, '00', '이전 누계', to_char(a.receive_date, 'yyyy.mm.dd')) receive_date, " +
"			 							a.seq,  " +
"			 							a.seq1,  " +
"			 							a.rqst_detail,  " +
"			 							decode(a.input_tag, '00', a.bank_amt, 1, a.bank_amt, 2, a.bank_amt, 0) bank_input,  " +
"			 							decode(a.input_tag, '00', a.cash_amt, 3, a.cash_amt, 4, a.cash_amt, 5, (0 - a.bank_amt), 0) bank_output,  " +
"                             decode(a.input_tag, '00', (a.bank_amt-a.cash_amt),f_get_balance(a.dept_code,to_char(a.receive_date, 'yyyy.mm.dd'), a.seq)) bank_n, " +
"			 							decode(a.input_tag, '00', a.cash_amt2, 3, a.cash_amt, 5, (0 - a.bank_amt), 0) cash_input,  " +
"			 							decode(a.input_tag, '00', a.amt, 9, a.amt, 0) cash_output,  " +
"										decode(a.input_tag, '00', (a.cash_amt2-a.amt),f_get_balance3(a.dept_code,to_char(a.receive_date, 'yyyy.mm.dd'), a.seq,a.seq1) - a.amt2) cash_n " +
"								from 			   " +
"										(select dept_code,  " +
"       										  receive_date,   " +
"			 									  seq,   " +
"			 									  seq1,   " +
"			 									  rqst_detail,  " +
"			                             bank_amt,  " +
"			 									  cash_amt,  " +
"			 									  cash_amt2,  " +
"												  amt, " +  // 공급가
"												  amt2, " +	// 기타
//"												  amt3, " +  // 부가세
//"												  amt4, " +	// 소득세
//"												  amt5, " + // 주민세
//"												  amt6, " +  // 원절사
"			 									  input_tag, " +
"			 									  st  " +
"											from   " +
"												  (select dept_code,   " +
"														    receive_date,   " +
"															 seq,  " +
"															 0 seq1,  " +
"															 rqst_detail,  " +
"															 bank_amt,  " +
"															 cash_amt,  " +
"															 0 cash_amt2,  " +
"															 0 amt, " +		// 공급가
"															 0 amt2, " +	// 기타
//"															 0 amt3, " +		// 부가세
//"															 0 amt4, " +		// 소득세
//"															 0 amt5, " +		// 주민세
//"															 0 amt6, " +		// 원절사
"															 input_tag,   " +
"															 1 st  " +
"													  from F_RECEIVE_AMT  " +
"													 where receive_date between '" + arg_from_date + "' and '" + arg_to_date + "' " +
"													union all  " +
"													select dept_code,   " +
"															 rqst_date,  " +
"															 994 seq,  " +
"															 seq seq1,  " +
"															 rqst_detail,  " +
"															 0,  " +
"															 0,  " +
"															 0,  " +
"															 cash_amt,  " + 	//공급가
"															 cash_amt,  " +				//기타
//"															 0,  " +				//부가세
//"															 0,  " +				//소득세
//"															 0,  " +				//주민세
//"															 0, " +				//원절사
"															 '9' input_tag,  " +
"															 2 st  " +
"													  from F_REQUEST where exe_type = '1' " +
"													 and dr_class = '1' " +
"													 and cash_amt <> 0 " +
"													 and rqst_date between '" + arg_from_date + "' and '" + arg_to_date + "' " +
"													union all  " +
"													select dept_code,   " +
"															 rqst_date,  " +
"															 995 seq,  " +
"															 seq seq1,  " +
"															 rqst_detail,  " +
"															 0,  " +
"															 0,  " +
"															 0,  " +
"															 nvl(bill_amt,0),  " +		// 공급가
"															 cash_amt + nvl(bill_amt,0),  " +	//기타
//"															 0, " +				//부가세
//"															 0,  " +				//소득세
//"															 0,  " +				//주민세
//"															 0, " +				//원절사
"															 '9' input_tag,  " +
"															 2 st  " +
"													  from F_REQUEST where exe_type = '1' " +
"													 and dr_class = '1' " +
"													 and bill_amt <> 0 " +
"													 and rqst_date between '" + arg_from_date + "' and '" + arg_to_date + "' " +
"													union all  " +
"													select dept_code,   " +
"															 rqst_date,  " +
"															 996 seq,  " +
"															 seq seq1,  " +
"															 rqst_detail,  " +
"															 0,  " +
"															 0,  " +
"															 0,  " +
"															 vat,  " +
"															 cash_amt + nvl(bill_amt,0) + vat, " +
"															 '9' input_tag,  " +
"															 2 st  " +
"													  from F_REQUEST where exe_type = '1' " +
"													 and dr_class = '1' " +
"													 and vat <> 0 " +
"													 and rqst_date between '" + arg_from_date + "' and '" + arg_to_date + "' " +
"													union all  " +
"													select dept_code,   " +
"															 rqst_date,  " +
"															 997 seq,  " +
"															 seq seq1,  " +
"															 rqst_detail,  " +
"															 0,  " +
"															 0,  " +
"															 0,  " +
"															 0 - nvl(income_amt,0),  " +
"															 cash_amt + nvl(bill_amt,0) + vat - nvl(income_amt,0),  " +
"															 '9' input_tag,  " +
"															 2 st  " +
"													  from F_REQUEST where exe_type = '1' " +
"													 and dr_class = '1' " +
"													 and income_amt <> 0 " +
"													 and rqst_date between '" + arg_from_date + "' and '" + arg_to_date + "' " +
"													union all  " +
"													select dept_code,   " +
"															 rqst_date,  " +
"															 998 seq,  " +
"															 seq seq1,  " +
"															 rqst_detail,  " +
"															 0,  " +
"															 0,  " +
"															 0,  " +
"															 0 - nvl(civi_amt,0),  " +
"															 cash_amt + nvl(bill_amt,0) + vat - nvl(income_amt,0) - nvl(civi_amt,0),  " +
"															 '9' input_tag,  " +
"															 2 st  " +
"													  from F_REQUEST where exe_type = '1' " +
"													 and dr_class = '1' " +
"													 and civi_amt <> 0 " +
"													 and rqst_date between '" + arg_from_date + "' and '" + arg_to_date + "' " +
"                                       union all " +
"													select dept_code,   " +
"															 rqst_date,  " +
"															 999 seq,  " +
"															 seq seq1,  " +
"															 rqst_detail,  " +
"															 0,  " +
"															 0,  " +
"															 0,  " +
"															 0 - nvl(deduct_amt,0),  " +
"															 cash_amt + nvl(bill_amt,0) + vat - nvl(income_amt,0) - nvl(civi_amt,0) - nvl(deduct_amt,0), " +
"															 '9' input_tag,  " +
"															 2 st  " +
"													  from F_REQUEST where exe_type = '1' " +
"													 and dr_class = '1' " +
"													 and deduct_amt <> 0 " +
"													 and rqst_date between '" + arg_from_date + "' and '" + arg_to_date + "' " +
"													union all  " +
"													select a.dept_code, " +
"															 to_date('19000101', 'yyyy.mm.dd'), " +
"															 0, " +
"															 0, " +
"															 '', " +
"															 sum(nvl(bank_amt,0)-decode(input_tag,5,bank_amt,0)), " +
"															 sum(nvl(cash_amt,0)-decode(input_tag,5,bank_amt,0)), " +
"															 sum(decode(input_tag, 3, nvl(cash_amt,0), 5, (0-nvl(bank_amt,0)), 0)), " +
"															 nvl(q.amt,0)-sum(decode(input_tag,5,bank_amt,0)), " +
"															 0, " +
"															 '00' input_tag, " +
"															 0 " +
"													 from  F_RECEIVE_AMT r, " +
"															 (select dept_code, " +
"															  			sum(amt)+sum(vat)-sum(deduct_amt)-sum(nvl(income_amt,0))-sum(nvl(civi_amt,0)) amt " +
"													   		 from F_REQUEST  " +
"																where exe_type = '1' and " +
"																		dr_class = '1' and " +
"																rqst_date < '" + arg_from_date + "'	" +
"																group by dept_code) q, " +
"															  (select '" + arg_dept_code + "' dept_code from dual) a " +
"													 where r.receive_date(+) <'" + arg_from_date + "' and " +
"															 a.dept_code = r.dept_code(+) and " +
"															 a.dept_code = q.dept_code(+) " +
"												    group by r.dept_code, q.amt " +
"													)  " +
"										order by dept_code,   " +
"													receive_date,   " +
"													seq1,  " +
"													seq,  " +
"													st) a " +
"								where a.dept_code = '" + arg_dept_code + "' ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>