<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%>><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp_code = req.getParameter("arg_comp_code") + "%" ;
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("b_resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("update_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("url",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("cdir",GauceDataColumn.TB_URL,255));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("temp_url",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  a.resident_no ," + 
     "          to_char(a.update_date,'yyyy.mm.dd') update_date," + 
     "          a.url ," + 
     "          a.url cdir," + 
     "          '                                                                                                         '  name,  " + 
     "          '                                                                                                         '  temp_url, " + 
     "          b.resident_no b_resident_no, " +
     "          b.emp_name, " +
     "          b.comp_code, " +
     "          e.comp_name, " +
     "          b.dept_code, " +
     "          c.long_name dept_name, " +
     "          b.grade_code, " +
     "          d.grade_name " +
     "        FROM p_pers_picture   a, " + 
     "             p_pers_master   	b, " + 
     "             z_code_dept		c, " + 
     "             p_code_grade	   d, " + 
     "             z_code_comp		e " + 
     "      WHERE ( b.comp_code = e.comp_code(+) ) " +
     "        and ( b.dept_code = c.dept_code(+) ) " +
     "        and ( b.grade_code = d.grade_code(+) ) " +
     "        and ( b.resident_no    = a.resident_no(+) ) "  +
     "		  and ( b.service_div_code <> '3' ) " +
     "		  and ( b.comp_code like '" + arg_comp_code + "') " +
     "	order by b.comp_code, " +
     "				b.dept_code, " +
     "				b.grade_code, b.emp_no " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>