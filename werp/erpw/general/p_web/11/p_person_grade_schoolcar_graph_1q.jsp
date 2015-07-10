<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
     String arg_grade_code = req.getParameter("arg_grade_code");
     String arg_div = req.getParameter("arg_div");     
     String arg_comp_code = req.getParameter("arg_comp_code") + "%";     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("school_car_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("school_car_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cnt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select b.school_car_code," + 
     "		 c.school_car_name, " + 
     "       count(a.emp_no) cnt" + 
     "  from (select a.grade_code, " + 
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
     "		  p_pers_master b, " + 
     "		  p_code_school_car  c, " + 
     "		  p_code_order  e " + 
     "  where (a.rk_1 = 1 " + 
     "	 and a.emp_no = b.emp_no " + 
     "	 and a.grade_code = b.grade_code " + 
     "	 and b.school_car_code = c.school_car_code(+) " + 
     "    and a.order_code = e.order_code ) " + 
     "    and not ( " + 
     "     	       e.service_div =  '3' " + 
     "     	       and a.apply_order_date < '" + arg_date + "')  " + 
     "	 and a.grade_code = '" + arg_grade_code + "' " + 
     "	 " + arg_div + " " + 
     " group by b.school_car_code," + 
     "		 	 c.school_car_name  " +
     " order by b.school_car_code ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>