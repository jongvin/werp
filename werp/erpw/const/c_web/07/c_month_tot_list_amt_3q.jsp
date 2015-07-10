<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     //String arg_yymm = req.getParameter("arg_yymm");
     String arg_won = req.getParameter("arg_won");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("cont_no",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("issue_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("supply_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("request_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("received_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("s_supply_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select e.cont_no,																				" +
      "  						to_char(e.issue_date, 'yyyy.mm.dd') issue_date,								" +
		"	 						(select nvl(sum(supply_amt),0) 													" +
		"								from r_contract_time_extablished 											" +
		"							  where dept_code = '" + arg_dept_code + "' and 							" +
		"									  extablish_tag <> '4' 														" +
		"							  group by dept_code																	" +
		"							)/" + arg_won + " as supply_amt,													" +
		"	 						to_char(e.request_dt, 'yyyy.mm.dd')	request_dt,								" +
		"	 						(select nvl(sum(cnt_result_amt) + sum(ls_cnt_result_amt), 0) cnt_amt	" +
		"	   						from c_spec_const_parent a,													" +
		"		     						  y_budget_parent b															" +
      " 							  where a.dept_code = b.dept_code and											" +
		"	        						  a.spec_no_seq = b.spec_no_seq and										" +
		"			  						  b.llevel = '1' and															" +
		"			  						  a.yymm=e.request_dt														" +
		"							)/" + arg_won + " as cnt_amt,														" +
		"	  						to_char(m.received_date, 'yyyy.mm.dd')	received_date,						" +
		"	  						m.supply_amt/" + arg_won + " as s_supply_amt									" +
  		"				  	 from r_contract_time_extablished e,													" +
		"	 						(select dept_code, 																	" +
		"									  max(received_date) received_date, 									" +
		"									  nvl(sum(supply_amt),0) supply_amt 									" +
		"                       from r_contract_time_collection 												" +
		"                      where dept_code = '" + arg_dept_code + "' 									" +
		"                      group by dept_code																	" +
		"                    ) m																						" +
 		"					where e.dept_code = '" + arg_dept_code + "' and										" +
      " 							e.dept_code = m.dept_code and														" +
      " 							e.cont_no = (select max(cont_no) 												" +
      "                                   from r_contract_time_extablished 							" +
      "                                  where dept_code = '" + arg_dept_code + "' 					" +
      "                                  group by dept_code													" +
      "                                ) and																		" +
		"	 						e.issue_date = (select max(issue_date) 										" +
		"                                      from r_contract_time_extablished 						" +
		"                                     where dept_code = '" + arg_dept_code + "' 				" +
		"                                     group by dept_code)											" ;
			 	
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>					