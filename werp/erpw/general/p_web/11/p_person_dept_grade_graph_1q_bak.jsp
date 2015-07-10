<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_div = req.getParameter("arg_div");
     String arg_comp_code = req.getParameter("arg_comp_code") + "%";     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cnt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select a.dept_code," + 
     "		 d.long_name dept_name," + 
     "		 a.grade_code," + 
     "		 c.grade_name grade_name, " + 
     "       count(a.emp_no) cnt" + 
     "  from (select a.dept_code," + 
     "					a.grade_code, " + 
     "					  a.emp_no, " + 
     "                 a.apply_order_date, " +      
     "                 a.order_code,  " +      
     "					  RANK() OVER (PARTITION by a.emp_no " + 
     "								 ORDER BY a.emp_no asc, a.apply_order_date desc, " + 
     "										 a.seq desc, a.spec_no_seq desc) rk_1 " + 
     "			  from p_order_master a " + 
     "			  where a.comp_code like '" + arg_comp_code + "' " + 
     "				 and a.apply_order_date <= '" + arg_date + "' " + 
     "				 and a.confirm_tag = '1' " + 
     "		  ) a, " + 
     "		  p_code_grade c," + 
     "		  z_code_dept  d, " + 
     "		  p_code_order  e " + 
     "  where (a.rk_1 = 1 " + 
     "	 and a.dept_code  = d.dept_code (+)" + 
     "	 and a.grade_code = c.grade_code(+)" + 
     "	 and a.dept_code = '" + arg_dept_code + "' " + 
     "    and a.order_code = e.order_code ) " + 
     "    and not ( " + 
     "     	       e.service_div =  '3' " + 
     "     	       and a.apply_order_date < '" + arg_date + "')  " + 
     "	 " + arg_div + " " + 
     " group by a.dept_code," + 
     "		 d.long_name ," + 
     "		 a.grade_code," + 
     "		 c.grade_name  " +
     " order by grade_code ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>