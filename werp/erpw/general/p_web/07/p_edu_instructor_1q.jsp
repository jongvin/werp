<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 	  String arg_edu_year = req.getParameter("arg_edu_year");     
 	  String arg_comp_code = req.getParameter("arg_comp_code") + "%";         
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("edu_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("inst_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("inst_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("io_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("ret_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  to_char(a.edu_year, 'YYYY.MM.DD') edu_year ," + 
     "          a.inst_no ," + 
     "          a.inst_name ," + 
     "          a.io_tag ," + 
     "          a.comp_code ," + 
     "          b.comp_name ," + 
     "          a.dept_code ," + 
     "          c.long_name dept_name ," + 
     "          a.grade_code ," + 
     "          d.grade_name ," + 
     "          a.remark,     " +
     "			 'Y' ret_tag	" +
     "     FROM p_edu_instructor a, z_code_comp b, z_code_dept c, p_code_grade d  " +
     "  where a.comp_code = b.comp_code(+) " +
     "    and a.dept_code = c.dept_code(+) " +
     "    and a.grade_code = d.grade_code(+) " +
     "    and a.edu_year = '" + arg_edu_year + "' " +
     "    and (a.comp_code like '" + arg_comp_code + "' " +
     "     or ('" + arg_comp_code + "' = '%' and a.comp_code is null)) " +
     " order by a.io_tag, a.inst_name ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>