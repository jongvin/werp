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
    String query = " select  a.resident_no,																									" +			
						 "			  b.emp_no,                                                                               " +
						 "			  b.emp_name,                                                                             " +
						 "			  c.short_name dept_name,                                                                 " +
						 "			  d.grade_name,                                                                           " +
						 "				sum(a.atnd_cnt) atnd_cnt,                                                              " +
						 "	 			sum(a.late_cnt) late_cnt,                                                              " +
						 "	 			sum(a.outw_cnt) outw_cnt,                                                              " +
						 "	 			sum(a.trip_cnt) trip_cnt,                                                              " +
						 "				sum(a.abse_cnt) abse_cnt,			                                          				" +
						 "				sum(a.educ_cnt) educ_cnt,                                                              " +
						 "				sum(a.annu_cnt) annu_cnt,                                                              " +
						 "				sum(a.cong_cnt) cong_cnt,                                                              " +
						 "				sum(a.etcc_cnt) etcc_cnt                                                               " +
						 "	from p_pers_master b,                                                                           " +
						 "		  z_code_dept	 c,                                                                           " +
						 "		  p_code_grade	 d,                                                                           " +
						 "		  (                                                                                          " +
						 "				select a.resident_no,                                                      				" +       
						 "						 to_char(a.attend_date,'yyyy.mm') attend_yymm,												" +       
						 "						 sum(decode(a.atnd_chk, 'T', 1, 0)) atnd_cnt,                                    " +
						 "			 			 sum(decode(a.late_chk, 'T', 1, 0)) late_cnt,                                    " +
						 "			 			 sum(decode(a.outw_chk, 'T', 1, 0)) outw_cnt,                                    " +
						 "			 			 sum(decode(a.trip_chk, 'T', 1, 0)) trip_cnt,                                    " +
						 "						 sum(decode(a.educ_chk, 'T', 1, 0)) educ_cnt,                                    " +
						 "						 sum(decode(a.abse_chk, 'T', 1, 0)) abse_cnt,                                    " +
						 //"						 sum(decode(to_char(a.attend_date, 'd'), '1', 0, '7', 0, 								" +
						 //"			      	     decode(a.educ_chk, 'T', 0, 																   " +
						 //"							  decode(a.cong_chk, 'T', 0,                                                  " +
						 //"							  decode(a.trip_chk, 'T', 0,                                                  " +
						 //"			         	     decode(sign(to_date(sysdate) - a.attend_date), 1, 								" +	
						 //"								     decode(a.atnd_chk,'F',1,null,1,0),0)))))) abse_cnt,                   " +     
						 "						 0 annu_cnt,                                                                     " +
						 "						 sum(decode(a.cong_chk, 'T', 1, 0)) cong_cnt,                                    " +
						 "						 sum(decode(a.etcc_chk, 'T', 1, 0)) etcc_cnt,                                    " +
						 "						 0 sysa_cnt                                                                      " +
						 "				from p_attend_emp a                                                                   " +
						 "			  where to_char(a.attend_date,'yyyy.mm') = to_char(to_date('"+arg_attend_date+"'),'yyyy.mm')  " +
						 "			group by a.resident_no, to_char(a.attend_date,'yyyy.mm')                                  " +
						 "			union all                                                                                 " +
						 "			select a.resident_no,                                                                     " +
						 "			 		 to_char(a.start_date - 1 + rn.rr,'yyyy.mm') attend_yymm,  									" +
						 "					 0,0,0,0,0,0,                                                                       " +
						 "					 sum(1) annu_cnt,                                                                	" +
						 "					 0,0,                                                                               " +
						 "					 sum(decode( sign ( to_date(sysdate) - (a.start_date - 1 + rn.rr) ) ,1,1,0)) sysa_cnt" +                                                          
						 "			   from p_attend_input a,                                                                 " +
						 "				     dual,                                                                             " +
						 "					  (select rownum rr from user_objects) rn                                           " +
						 "			  where rn.rr < ((a.end_date+1) - (a.start_date-1))									            " +
						 "			    and to_char( (to_date(a.start_date) - 1) + rn.rr, 'd') <> '7'                         " +
						 "			    and to_char( (to_date(a.start_date) - 1) + rn.rr, 'd') <> '1'                         " +
						 "			    and a.attend_code = '01'                                                              " +
						 "			    and (to_char(a.start_date,'yyyy.mm') = to_char(to_date('"+arg_attend_date+"'),'yyyy.mm')    " +
						 "			      or to_char(a.end_date,'yyyy.mm') = to_char(to_date('"+arg_attend_date+"'),'yyyy.mm'))    " +
						 "			group by a.resident_no, to_char(a.start_date - 1 + rn.rr,'yyyy.mm')                       " +
						 "			) a                                                                                       " +
						 "	 where a.resident_no = b.resident_no                                                            " +
						 "	   and b.dept_code = c.dept_code                                                                " +
						 "		and b.grade_code = d.grade_code                                                              " +
						 "		and b.service_div_code = '2' and  b.att_exc_yn <> 'T'                                       " +
						 "    and a.attend_yymm = to_char(to_date('"+arg_attend_date+"'),'yyyy.mm')   							" +
						 "	group by a.resident_no,                                                                         " +
						 "			  b.emp_no,                                                                               " +
						 "			  b.emp_name,                                                                             " +
						 "			  c.short_name,                                                                           " +
						 "			  d.grade_name                                                                            " +
						 "	order by b.emp_name  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>