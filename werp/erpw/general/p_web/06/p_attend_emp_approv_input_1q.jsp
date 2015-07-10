<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approv_emp",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("att_exc_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approv_emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approv_dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("approv_grade_name",GauceDataColumn.TB_STRING,30));
    String query = "select a.emp_no," + 
     "           				a.emp_name," + 
     "    		 				a.dept_name," + 
     "    		 				a.grade_name," + 
     "    		 				a.approv_emp," + 
     "    		 				a.att_exc_yn," + 
     " 		 					b.emp_name   approv_emp_name," + 
     " 		 					c.short_name approv_dept_name," + 
     " 		 					d.grade_name approv_grade_name  " +
     "					 from (SELECT a.emp_no," + 
     "      							  a.emp_name," + 
     "    		         			  b.short_name dept_name," + 
     "    		         			  c.grade_name," + 
     "    		         			  a.approv_emp,  " +
     "    		         			  a.att_exc_yn  " +
     "				   		   FROM p_pers_master   a," + 
     " 			 						  z_code_dept		b," + 
     " 									  p_code_grade	 	c " +
     "	   		  		     where a.service_div_code = '2' " +
     "                			 and a.dept_code = b.dept_code(+)  " +
     "     			             and a.grade_code = c.grade_code(+)  ) a," + 
     " 		  					p_pers_master b," + 
     " 		  					z_code_dept	 c," + 
     " 		  					p_code_grade  d " +
     "				   where a.approv_emp = b.resident_no(+) " +
     "					  and b.service_div_code(+) = '2'        " +
     "				     and b.dept_code  = c.dept_code(+)   " +
     "					  and b.grade_code = d.grade_code(+)  " +
     "			   order by a.emp_name     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>