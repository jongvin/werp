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
     dSet.addDataColumn(new GauceDataColumn("age",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("join_date",GauceDataColumn.TB_STRING,18));
    String query = "select master.grade_code," + 
     "		 c.grade_name, " + 
     "       master.dept_code, " +
     "       d.long_name dept_name, " +
     " 		 master.age, " + 
     "       master.emp_no, " + 
     "       master.emp_name, " + 
     "       to_char(master.group_join_date,'yyyy.mm.dd') join_date " + 
     "  from " + 
     " 		  ( select a.emp_no, a.emp_name, a.resident_no, a.dept_code, to_char(a.join_date,'yyyy.mm.dd') join_date,a.grade_code, " +
	  "		  	 		  a.service_div_code,a.comp_code,a.group_join_date,	to_char(to_date('" + arg_date + "'),'yyyy') - decode(substr(a.resident_no,8,1), " +
	  "												'1', to_number('19' || substr(a.resident_no,1,2)) - 1,   " +
	  "												'2', to_number('19' || substr(a.resident_no,1,2)) - 1,   " +
	  "												'3', to_number('20' || substr(a.resident_no,1,2)) - 1,   " +
	  "												'4', to_number('20' || substr(a.resident_no,1,2)) - 1,   " +
	  "												to_char(to_date('" + arg_date + "'),'yyyy')) age     " +
	  "		   from p_pers_master a                                                            " +
	  " 			) master, " +
     "		  p_code_grade c," + 
     "		  z_code_dept d " + 
     "  where " + 
     "	  master.grade_code = c.grade_code" + 
     "	 and master.dept_code = d.dept_code" + 
     "	 and master.grade_code = '" + arg_grade_code + "' " + 
     "    and master.service_div_code <> '3' " + 
     "	 and master.comp_code like '" + arg_comp_code + "' " + 
     "	 " + arg_div + " " + 
     "     and not (master.comp_code = 'C0' and master.RESIDENT_NO = '700823-1055615' or  " +
     "        master.comp_code = 'B0' and master.RESIDENT_NO = '680823-1055615' or         " +
     " 		 master.comp_code = 'E0' and master.RESIDENT_NO = '680823-1055615')		    "  + 
     " order by master.dept_code," + 
     "			 master.emp_name     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>