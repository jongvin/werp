<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
     String arg_master_emp_no = req.getParameter("arg_master_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("url",GauceDataColumn.TB_STRING,200));
    String query = "select a.dept_code,a.emp_no,b.emp_name,c.grade_name,d.url" + 
     "   				from (select a.dept_code," + 
     "   				             a.emp_no," + 
     "   				             a.apply_order_date, " +      
     "   				             a.order_code,  " +      
     "   				             RANK() OVER (PARTITION by a.emp_no" + 
     "   				                              ORDER BY a.emp_no asc, a.apply_order_date desc," + 
     "   				                                       a.seq desc, a.spec_no_seq desc) rk_1" + 
     "   				         from p_order_master a" +
	  "   				        where a.confirm_tag = '1'  " +
     //" 				             and a.dept_code = '" + arg_dept_code + "'" +
	  "	   				          and a.apply_order_date <= '" + arg_date + "') a," + 
     "   				     p_pers_master b," + 
     "   				     p_code_grade c," + 
     "   				     p_pers_picture d," + 
     "					     p_code_order  e " + 
     "              where (a.rk_1 = 1" + 
     "                and a.emp_no = b.emp_no" + 
     "                and a.emp_no <> '" + arg_master_emp_no + "' " + 
     "                and b.grade_code = c.grade_code	  (+)			" + 
     "                and b.resident_no = d.resident_no (+)     	" +
     "                and a.order_code = e.order_code   (+)		  	" +
     "                and a.dept_code = '" + arg_dept_code + "' 	" +
     "        				) " + 
     "                and not (  e.service_div =  '3' " + 
     "             	            and a.apply_order_date < '" + arg_date + "')  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>