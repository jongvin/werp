<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp_code = req.getParameter("arg_comp_code");
     String arg_start_date = req.getParameter("arg_start_date");
     String arg_last_date = req.getParameter("arg_last_date");
     String arg_dept_code = req.getParameter("arg_dept_code");     
     String arg_grade_code = req.getParameter("arg_grade_code");     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("join_date",GauceDataColumn.TB_STRING,18));
    String query = "        select  a.comp_code,        									" +
     "      		 a.dept_code,                                                     " +
     "      		 a.grade_code,                                                    " +
     "      		 a.emp_no,                                                        " +
     "      		 b.emp_name,                                                      " +
     "      		 dept.long_name dept_name,                                        " +
     "      		 grade.grade_name,                                                " +
     "      		 comp.comp_name,                                                  " +
     "      		 to_char(b.join_date,'yyyy.mm.dd') join_date                      " +
     "        from (select a.comp_code,                                             " +
     "      					  a.dept_code,                                           " +
     "      					  a.order_code,                                          " +
     "      					  a.grade_code,                                          " +
     "      					  a.emp_no,                                              " +
     "      					  a.apply_order_date,                                    " +
     "      					  RANK() OVER (PARTITION by a.emp_no                     " +
     "      								 ORDER BY a.emp_no asc, a.apply_order_date desc," +  
     "      										 a.seq desc, a.spec_no_seq desc) rk_1     " +
     "      			  from p_order_master a                                        " +
     "      			  where a.comp_code = '" + arg_comp_code + "'               	" +
     "      				 and a.apply_order_date <= '" + arg_last_date + "'           " +
     "						 and a.confirm_tag = '1'												" +
     "      		  ) a,                                                            " +
     "      		  p_pers_master b,                                                " +
     "      		  p_code_order c,                                                 " +
     "      		  z_code_dept dept,                                               " +
     "      		  p_code_grade grade,                                             " +
     "      		  z_code_comp  comp                                               " +
     "        where (a.rk_1 = 1                                                     " +
     "      	   and a.emp_no = b.emp_no                                           " +
     "      	   and a.order_code = c.order_code                                   " +
     "      	   and a.grade_code = '" + arg_grade_code + "'                       " +
     "      	   and a.dept_code = dept.dept_code (+)                              " +
     "      	   and a.grade_code = grade.grade_code (+)                           " +
     "      	   and a.comp_code = comp.comp_code (+)                              " +
     "      	   and a.dept_code = '" + arg_dept_code + "')                        " +
     "      	   and not (                                                         " +
     "      	       c.service_div =  '3'                                          " +
     "      	       and a.apply_order_date < '" + arg_start_date + "' )           " +
     " order by a.grade_code," + 
     "			 b.emp_name     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>