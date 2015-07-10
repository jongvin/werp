<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no") + "%";
     String arg_service_div = req.getParameter("arg_service_div") + "%";
     String arg_comp_code = req.getParameter("arg_comp_code") + "%";     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("service_div_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("group_join_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("join_date",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT  a.emp_no ," + 
     "  		      a.emp_name ," + 
     "  		      a.comp_code ," + 
     "  		      a.cost_dept_code dept_code ," + 				// 원가부서 return(전표발생 기준 부서)
     "  		      a.grade_code, " + 
     "  		      d.comp_name ," + 
     "  		      b.long_name dept_name ," + 
     "  		      c.grade_name, " + 
     "  		      a.service_div_code, " + 
     "          	to_char(a.group_join_date, 'YYYY.MM.DD') group_join_date ," + 
     "          	to_char(a.join_date, 'YYYY.MM.DD') join_date " + 
     "  		FROM p_pers_master a, " +
     "			  z_code_dept b, " +
     "			  p_code_grade c, " +
     "			  z_code_comp d " +
     "  	where a.cost_dept_code  = b.dept_code(+) " +
     "  	  and a.grade_code = c.grade_code(+) " +
     "  	  and a.comp_code  = d.comp_code(+) " +
     "  	  and a.comp_code like '" + arg_comp_code + "' " +
     "  	  and (a.emp_no like '" + arg_emp_no+ "' " +
     "  	   or a.emp_name like '" + arg_emp_no + "'   )  " +
     "  	  and a.service_div_code like '" + arg_service_div + "' " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>