<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_attend_date = req.getParameter("arg_attend_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("atnd_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("late_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("outw_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("trip_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("abse_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("educ_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("annu_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cong_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("etcc_cnt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = " select a.resident_no, 																								" +
						 "        a.emp_no,																										" +
						 "			 a.emp_name,   																								" +
						 "			 a.dept_name,				 																					" +
						 "			 a.grade_name,   																								" +
						 "			 sum(a.atnd_cnt) atnd_cnt,																					" +
						 "			 sum(a.late_cnt) late_cnt,                                                             " +
						 "			 sum(a.outw_cnt) outw_cnt,                                                             " +
						 "			 sum(a.trip_cnt) trip_cnt,                                                             " +
						 "			 sum(a.abse_cnt) abse_cnt,                                                             " +
						 "			 sum(a.educ_cnt) educ_cnt,                                                             " +
						 "			 sum(a.annu_cnt) annu_cnt,                                                             " +
						 "			 sum(a.cong_cnt) cong_cnt,                                                             " +
						 "			 sum(a.etcc_cnt) etcc_cnt                                                              " +
						 "	  from (	select a.resident_no,                                                               " +
						 "        			 m.emp_no,																							" +
						 "			 			 m.emp_name,   																					" +
						 "			 			 c.short_name dept_name, 																		" +
						 "			 			 d.grade_name,   																					" +						 
						 "				       decode(a.atnd_chk, 'T', count(atnd_chk), 0) atnd_cnt,                        " +
						 "						 decode(a.late_chk, 'T', count(late_chk), 0) late_cnt,                        " +
						 "						 decode(a.outw_chk, 'T', count(outw_chk), 0) outw_cnt,                        " +
						 "						 decode(a.trip_chk, 'T', count(trip_chk), 0) trip_cnt,                        " +
						 "						 sum(decode(to_char(a.attend_date, 'd'), '1', 0, '7', 0, 							" +	
						 "		         	     decode(a.educ_chk, 'T', 0, 																" +
						 "							  decode(b.annu_chk, 'T', 0,                                               " +
						 "							  decode(a.cong_chk, 'T', 0,                                               " +
						 "							  decode(a.trip_chk, 'T', 0,                                               " +
						 "			         	     decode(sign(to_date(sysdate) - a.attend_date), 1, 							" +		
						 "								     decode(a.atnd_chk,'F',1,null,1,0),0))))))) abse_cnt,               " +
						 "						 decode(a.educ_chk, 'T', count(educ_chk), 0) educ_cnt,                        " +
						 "						 decode(b.annu_chk, 'T', count(b.annu_chk), 0) annu_cnt,                      " +
						 "						 decode(a.cong_chk, 'T', count(cong_chk), 0) cong_cnt,                        " +
						 "						 decode(a.etcc_chk, 'T', count(etcc_chk), 0) etcc_cnt                         " +
						 "				from p_attend_emp a,                                                                " +
						 " 				  p_pers_master m,                                                               " +
						 "			 		  z_code_dept   c,                                                               " +
						 "			 		  p_code_grade  d,                                                               " +
						 "			 			( select a.resident_no,																			" +
						 "							 	  to_char(a.start_date - 1 + rn.rr,'yyyy.mm.dd') attend_date,           " +
						 "							 	  'T' annu_chk                                                          " +
						 "						   from p_attend_input a,                                                     " +
						 "							     dual,                                                                 " +
						 "								  (select rownum rr from user_objects) rn                               " +
						 "						  where a.attend_code = '01'                                                  " +
						 "						    and to_char(a.start_date,'yyyy.mm') = to_char(to_date('"+arg_attend_date+"'),'yyyy.mm') " +
						 "						    and rn.rr < ((a.end_date+1) - (a.start_date-1))									" +
						 "						    and to_char( (to_date(a.start_date) - 1) + rn.rr, 'd') <> '7'             " +
						 "						    and to_char( (to_date(a.start_date) - 1) + rn.rr, 'd') <> '1'	            " +
						 "							) b																								" +
						 "				where a.resident_no = b.resident_no(+)  															" +
						 "            and a.attend_date = b.attend_date(+)  															" +
						 "            and to_char(a.attend_date,'yyyy.mm') = to_char(to_date('"+arg_attend_date+"'),'yyyy.mm')   " +
						 "            and a.resident_no = m.resident_no  																" +
						 "     		  and m.dept_code   = c.dept_code(+) 																" +
						 "     		  and m.grade_code  = d.grade_code(+)																" +
						 "     		  and m.service_div_code = '2' 																		" +
						 "				group by a.resident_no,                                                             " +
						 "        			   m.emp_no,																						" +
						 "			 			   m.emp_name,   																					" +
						 "			 			   c.short_name, 																					" +
						 "			 			   d.grade_name,   																				" +						 
						 "						   a.atnd_chk,                                                                " +
						 "							a.late_chk,                                                                " +
						 "							a.outw_chk,                                                                " +
						 "							a.trip_chk,                                                                " +
						 "							a.abse_chk,                                                                " +
						 "							a.educ_chk,                                                                " +
						 "							b.annu_chk,                                                                " +
						 "							a.cong_chk,                                                                " +
						 "							a.etcc_chk                                                                 " +
						 "			  ) a                                                                                  " +
						 "	group by a.resident_no, 																							" +
						 "			   a.emp_no,																									" +
						 "			   a.emp_name,   																								" +
						 "			   a.dept_name,				 																				" +
						 "			   a.grade_name   																							" +			 
						 " order by a.emp_name   ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>