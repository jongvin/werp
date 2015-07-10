<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_edu_year = req.getParameter("arg_edu_year");
     String arg_inst_no = req.getParameter("arg_inst_no") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("edu_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("inst_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("inst_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT distinct to_char(a.edu_year, 'YYYY.MM.DD') edu_year ," + 
     "          a.inst_no ," + 
     "          b.inst_name, " + 
     "          a.dept_code, " + 
     "          c.long_name dept_name, " + 
     "          a.grade_code, " + 
     "          d.grade_name " + 
     "     FROM p_edu_instructor a, p_edu_instructor b,  " +
     "			 z_code_dept c, p_code_grade d " +
     "  where a.inst_no = b.inst_no(+) " +
     "    and a.dept_code = c.dept_code(+) " +
     "    and a.grade_code = d.grade_code(+) " +
     "    and a.edu_year = '" + arg_edu_year + "' " +
     "  	 and (a.inst_no like '" + arg_inst_no+ "' " +
     "  	  or b.inst_name like '" + arg_inst_no + "'   )      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>