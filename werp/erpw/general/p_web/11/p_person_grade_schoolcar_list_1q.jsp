<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
     String arg_grade_code = req.getParameter("arg_grade_code");     
     String arg_div = req.getParameter("arg_div");
     String arg_comp_code = req.getParameter("arg_comp_code") + "%";     
//---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("school_car_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("school_car_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("join_date",GauceDataColumn.TB_STRING,18));
    String query = "select a.grade_code," + 
     "		 c.grade_name, " + 
     "		 a.dept_code," + 
     "		 e.long_name dept_name," + 
     "   	 a.school_car_code, " + 
     "   	 d.school_car_name, " + 
     "       a.emp_no, " + 
     "       a.emp_name, " + 
     "       to_char(a.group_join_date,'yyyy.mm.dd') join_date " + 
     "  from " + 
     "		  p_pers_master a, " + 
     "		  p_code_grade c," + 
     "		  p_code_school_car  d, " + 
     "		  z_code_dept  e " + 
     "  where " + 
     "	  a.grade_code = c.grade_code(+)" + 
     "	 and a.dept_code  = e.dept_code" + 
     "	 and a.school_car_code  = d.school_car_code(+) " + 
     "	 and a.grade_code = '" + arg_grade_code + "' " + 
     "	 and a.comp_code like '" + arg_comp_code + "' " + 
     "    and a.service_div_code <> '3' " + 
     "	 " + arg_div + " " + 
     "     and not (a.comp_code = 'C0' and a.RESIDENT_NO = '700823-1055615' or  " +
     "        a.comp_code = 'B0' and a.RESIDENT_NO = '680823-1055615' or         " +
     " 		 a.comp_code = 'E0' and a.RESIDENT_NO = '680823-1055615')		    "  + 
     " order by a.school_car_code," + 
     "			 a.emp_name     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>