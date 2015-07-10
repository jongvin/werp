<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_resident_no = req.getParameter("arg_resident_no");
     String arg_attend_date = req.getParameter("arg_attend_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("attend_date",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("day_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("atnd_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("atnd_time",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("late_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("outw_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("trip_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("abse_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("educ_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("annu_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cong_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("etcc_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("reason",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("ip_addr",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("approv_emp",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("approv_emp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("approv_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,1));     
    String query = "    select a.resident_no , 																								" +
						 "	         a.attend_date ,                                                                        " +
						 "	         max(a.day_name ) day_name ,                                                            " +
						 "	         max(a.atnd_chk ) atnd_chk ,                                                            " +
						 "	         max(a.atnd_time) atnd_time,                                                            " +
						 "	         max(a.late_chk ) late_chk ,                                                            " +
						 "	         max(a.outw_chk ) outw_chk ,                                                            " +
						 "	         max(a.trip_chk ) trip_chk ,                                                            " +
						 "	         max(a.abse_chk ) abse_chk ,                                                            " +
						 "	         max(a.educ_chk ) educ_chk ,                                                            " +
						 "	         max(a.annu_chk ) annu_chk ,                                                            " +
						 "	         max(a.cong_chk ) cong_chk ,                                                            " +
						 "	         max(a.etcc_chk ) etcc_chk ,                                                            " +
						 "	         max(a.reason   ) reason ,                                                              " +
						 "	         max(a.ip_addr	) ip_addr ,                                                             " +
						 "	         max(a.approv_emp	) approv_emp ,                                                       " +
						 "	         max(a.approv_emp_name) approv_emp_name ,                                               " +
						 "	         max(a.approv_date	) approv_date ,                                                      " +
						 "				max(a.tag		) tag																							" +
						 "		from                                                                                         " +
						 "				(SELECT a.resident_no ,                                                                " +
						 "				        to_char(a.attend_date,'yyyy.mm.dd') attend_date ,                              " +
						 "				        decode(to_char(a.attend_date, 'd'), '1','일','2','월','3','화',                " +
						 "									'4','수','5','목','6','금','7','토') day_name,                          " +
						 "				         decode(a.atnd_chk,'T','T','') atnd_chk ,                                      " +
						 "				         to_char(a.atnd_time,'hh24:mi:ss') atnd_time ,  				                     " +
						 "				         decode(a.late_chk,'T','T','') late_chk ,                                      " +
						 "				         decode(a.outw_chk,'T','T','') outw_chk ,                                      " +
						 "				         decode(a.trip_chk,'T','T','') trip_chk ,                                      " +
						 "				         decode(a.abse_chk,'T','T','') abse_chk ,                                      " +
						 //"							decode(to_char(a.attend_date, 'd'), '1', '', '7', '', 								" +
						 //"		         	     decode(b.annu_chk, 'T', '', 																" +
						 //"		         	     decode(a.educ_chk, 'T', '', 																" +
						 //"							  decode(a.cong_chk, 'T', '',                                                 " +
						 //"							  decode(a.trip_chk, 'T', '',                                                 " +
						 //"				         	decode(sign(to_date(sysdate) - a.attend_date), 1, 									" +
						 //"									decode(a.atnd_chk,'F','T',null,'T',''), '')))))) abse_chk ,             " +
						 "				         decode(a.educ_chk,'T','T','') educ_chk ,                                      " +
						 "				         '' annu_chk ,                                      " +
						 "				         decode(a.cong_chk,'T','T','') cong_chk ,                                      " +
						 "				         decode(a.etcc_chk,'T','T','') etcc_chk ,                                      " +
						 "				         a.reason,                                                                     " +
						 "				         a.ip_addr,                                                                    " +
						 "				         a.approv_emp,                                                                 " +
						 "				         c.emp_name approv_emp_name,                                                   " +
						 "				         to_char(a.approv_date,'yyyy.mm.dd') approv_date,                              " +
						 "				         'A' tag                                                                       " +
						 "					 FROM p_attend_emp  a,                                                              " +
						 "					      (select distinct resident_no, emp_name from p_pers_master ) c,                " +
						 "							(select to_char(a.start_date - 1 + rn.rr,'yyyy.mm.dd') attend_date,           " +
						 "							        'T' annu_chk                                                          " +
						 "							   from p_attend_input a,                                                     " +
						 "								     dual,                                                                 " +
						 "									  (select rownum rr from user_objects) rn                               " +
						 "							  where a.attend_code = '01'                                                  " +
						 "			   			    and a.resident_no = '" + arg_resident_no + "'                             " +
						 "							    and to_char(a.start_date,'yyyy.mm') = to_char(to_date('"+arg_attend_date+"'),'yyyy.mm') " +
						 "							    and rn.rr < ((a.end_date+1) - (a.start_date-1))									" +
						 "							    and to_char( (to_date(a.start_date) - 1) + rn.rr, 'd') <> '7'             " +
						 "							    and to_char( (to_date(a.start_date) - 1) + rn.rr, 'd') <> '1'	            " +
						 "							) b 																									" +
						 "				   where a.attend_date = b.attend_date(+)                                              " +
						 "					  and a.approv_emp  = c.resident_no(+)                                              " +
						 "					  and a.resident_no = '" + arg_resident_no + "'                                     " +
						 "					  and to_char(a.attend_date,'yyyy.mm') = to_char(to_date('" + arg_attend_date + "'),'yyyy.mm') " + 
						 " 			union all																							" +
						 "				 select a.resident_no ,                                                                " +
						 "				        to_char(a.start_date - 1 + rn.rr,'yyyy.mm.dd') attend_date,           " +
						 "					 	  decode(to_char(a.start_date - 1 + rn.rr, 'd'), '1','일','2','월','3','화',     " +
						 "									'4','수','5','목','6','금','7','토') day_name,                          " +
						 "				        '','','','','','','',                                                          " +
						 "				        'T' , '','',a.attend_reason,'','','','','B'                                    " +
						 "				   from p_attend_input a,                                                     " +
						 "					     dual,                                                                 " +
						 "						  (select rownum rr from user_objects) rn                               " +
						 "				  where a.attend_code = '01'                                                  " +
						 "			       and a.resident_no = '" + arg_resident_no + "'                             " +
						 "				    and (to_char(a.start_date,'yyyy.mm') = to_char(to_date('"+arg_attend_date+"'),'yyyy.mm') " +
						 "				      or to_char(a.end_date,'yyyy.mm') = to_char(to_date('"+arg_attend_date+"'),'yyyy.mm')) " +
						 "				    and rn.rr < ((a.end_date+1) - (a.start_date-1))									" +
						 "				    and to_char( (to_date(a.start_date) - 1) + rn.rr, 'd') <> '7'             " +
						 "				    and to_char( (to_date(a.start_date) - 1) + rn.rr, 'd') <> '1'	            " +
						 "				)	a			                                                                           " +
						 "    where to_char(to_date(a.attend_date),'yyyy.mm') = to_char(to_date('"+arg_attend_date+"'),'yyyy.mm')   " +
						 "	group by a.resident_no ,                                                                        " +
						 "	         a.attend_date                                                                          " +
						 "	order by a.attend_date ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>