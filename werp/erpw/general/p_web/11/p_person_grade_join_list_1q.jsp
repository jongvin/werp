<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
     String arg_mm = req.getParameter("arg_mm");     
     String arg_div = req.getParameter("arg_div");
     String arg_comp_code = req.getParameter("arg_comp_code") + "%";     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("join_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("group_join_date",GauceDataColumn.TB_STRING,18));
    String query = "   select a.grade_code, " +
		"		     		 b.grade_name,         " +
		"		 			 a.dept_code," + 
      "		 			 c.long_name dept_name," + 
     "       			 a.emp_no, " + 
      "       			 a.emp_name, " + 
      "					 to_char(a.join_date,'yyyy.mm.dd') join_date, " +
		"					 to_char(a.group_join_date,'yyyy.mm.dd') group_join_date " +
		"		       from p_pers_master a,    " +                                                        
		"			   	   p_code_grade b,      " +
		"			   	   z_code_dept  c      " +
		"		       where a.grade_code = b.grade_code             " +
		"		  		   and a.dept_code  = c.dept_code             " +
		"		  		   and a.comp_code  like '" + arg_comp_code	+ "'	     " +
		"		  		   and to_char(a.join_date,'yyyy') = to_char(to_date('" + arg_date + "'),'yyyy') " +
		"	 				and to_char(a.join_date,'mm') = '" + arg_mm + "' " + 
     "	 			   " + arg_div + " " + 
		"		      order by a.grade_code, a.dept_code,                         " +
		"							a.emp_name " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>