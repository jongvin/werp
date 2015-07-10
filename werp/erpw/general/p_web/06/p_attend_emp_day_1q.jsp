<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_attend_date = req.getParameter("arg_attend_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,30));     
     dSet.addDataColumn(new GauceDataColumn("attend_date",GauceDataColumn.TB_STRING,20));
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
     dSet.addDataColumn(new GauceDataColumn("approv_emp",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("approv_emp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("approv_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,1));     
	 
    String query = "   select a.resident_no , 																					" +
						 "		      m.emp_name ,         																			" +
						 "		      c.short_name dept_name ,  																		" +
						 "		      d.grade_name,         																			" +
						 "	         a.attend_date ,                                                               " +
						 "	         max(a.atnd_chk ) atnd_chk ,                                                   " +
						 "	         max(a.atnd_time) atnd_time,                                                   " +
						 "	         max(a.late_chk ) late_chk ,                                                   " +
						 "	         max(a.outw_chk ) outw_chk ,                                                   " +
						 "	         max(a.trip_chk ) trip_chk ,                                                   " +
						 "	         max(a.abse_chk ) abse_chk ,                                                   " +
						 "	         max(a.educ_chk ) educ_chk ,                                                   " +
						 "	         max(a.annu_chk ) annu_chk ,                                                   " +
						 "	         max(a.cong_chk ) cong_chk ,                                                   " +
						 "	         max(a.etcc_chk ) etcc_chk ,                                                   " +
						 "	         max(a.reason   ) reason ,                                                     " +
						 "	         max(a.ip_addr	) ip_addr ,                                                    " +
						 "	         max(a.approv_emp) approv_emp ,                                               " +
						 "	         max(a.approv_name) approv_emp_name ,                                               " +
						 "	         max(a.approv_date) approv_date ,                                                      " +
						 "			 max(a.tag) tag													   	" +
						 "		from  p_pers_master m, z_code_dept c, p_code_grade d,			              				" +
						 "				(SELECT  a.resident_no ,                                                      " +
						 "	   			      to_char(a.attend_date,'yyyy.mm.dd') attend_date ,                    " +
						 "					      decode(a.atnd_chk,'T','T','') atnd_chk ,                             " +
						 "					      to_char(a.atnd_time,'hh24:mi:ss') atnd_time ,                        " +
						 "					      decode(a.late_chk,'T','T','') late_chk ,                             " +
						 "					      decode(a.outw_chk,'T','T','') outw_chk ,                             " +
						 "					      decode(a.trip_chk,'T','T','') trip_chk ,                             " +
						 "					      decode(a.abse_chk,'T','T','') abse_chk ,                             " +
						 "					      decode(a.educ_chk,'T','T','') educ_chk ,                             " +
						 "					      '' annu_chk ,                                      						" +
						 "					      decode(a.cong_chk,'T','T','') cong_chk ,                             " +
						 "					      decode(a.etcc_chk,'T','T','') etcc_chk ,                             " +
						 "					      a.reason,                                                            " +
						 "						   a.ip_addr, a.approv_emp, b.emp_name as approv_name,                  " +
						 "                         to_char(a.approv_date) as approv_date,  'A' tag                     " +
						 "					 FROM p_attend_emp  a,(select distinct resident_no, emp_name from p_pers_master) b	" +
						 "					where a.attend_date = '" + arg_attend_date + "'	and a.approv_emp = b.resident_no(+) " + 
						 " 			union all																							" +
						 "				 select a.resident_no ,                                                       " +
						 "	     		 		  a.attend_date ,														               " +
						 "		       		  '' atnd_chk ,                                      							" +
						 "		       		  '' atnd_time ,                         			 								" +
						 "		       		  '' late_chk ,                                      							" +
						 "		       		  '' outw_chk ,                                      							" +
						 "		       		  '' trip_chk ,                                      							" +
						 "		       		  '' abse_chk ,                                      							" +
						 "		       		  '' educ_chk ,                                      							" +
						 "		       		  'T' annu_chk ,                                     							" +
						 "		       		  '' cong_chk ,                                      							" +
						 "		       		  '' etcc_chk ,                                      							" +
						 "		       		  a.attend_reason,                                                      " +
						 "				 		  '' ip_addr,  '',  '', '',                                               " +
						 "		       		  'B' tag                                                               " +
						 "				   from ( select a.resident_no ,                                              " +         
						 "			 		       		  to_char(a.start_date - 1 + rn.rr,'yyyy.mm.dd') attend_date,  " +                    
						 "			 		       		  a.attend_reason                                              " +        
						 "			 				   from p_attend_input a,                                            " +         
						 "			 					     dual,                                                        " +         
						 "			 						  (select rownum rr from user_objects) rn                      " +         
						 "			 				  where a.attend_code = '01'                                         " +         
						 "			 			       and (to_char(a.start_date,'yyyy.mm') = to_char(to_date('" + arg_attend_date + "'),'yyyy.mm') " +
						 "				      		   or to_char(a.end_date,'yyyy.mm') = to_char(to_date('"+arg_attend_date+"'),'yyyy.mm')) " +
						 "			 				    and rn.rr < ((a.end_date+1) - (a.start_date-1))						" +			
						 "			 				    and to_char( (to_date(a.start_date) - 1) + rn.rr, 'd') <> '7'    " +         
						 "			 				    and to_char( (to_date(a.start_date) - 1) + rn.rr, 'd') <> '1'    " +
						 "							)	a                                                                 " +
						 "				  where attend_date = '" + arg_attend_date + "'           							" +
						 "				)	a			                                                                  " +
						 "		where a.resident_no = m.resident_no 																" +
						 "		  and m.service_div_code = '2'  		   															" +
						 "		  and m.att_exc_yn <> 'T'     		   															" +
						 "		  and m.dept_code = c.dept_code(+) 																	" +
						 "		  and m.grade_code = d.grade_code(+) 																" +
						 "	group by a.resident_no , 																					" +
						 "				m.emp_name ,         																		 	" +
						 "	   		c.short_name ,  																	 				" +
						 "	   		d.grade_name,         																			" +
						 "	         a.attend_date                                                                 " +
						 "	order by m.emp_name ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>