<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_yymm = req.getParameter("arg_work_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("work_yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("div_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("receive_person",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("piety_relation",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("piety_bank",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("piety_account",GauceDataColumn.TB_STRING,30));
    String query = "  SELECT  to_char(a.work_yymm, 'YYYY.MM.DD') work_yymm ," + 
     "          a.emp_no ," + 
     "          c.emp_name ," + 
     "          a.div_tag ," + 
     "          a.comp_code ," + 
     "          d.comp_name ," + 
	  "          a.dept_code ," + 
     "          e.long_name dept_name ," + 
     "          a.grade_code ," + 
     "          f.grade_name ," + 
     "          a.amt ," + 
     "          a.remark,     " +
     "          b.receive_person,     " +
     "          b.piety_relation,     " +
     "          b.piety_bank,     " +
     "          b.piety_account     " +
     "      FROM p_gen_driver_filial_piety a, " +
     "			  p_pers_filial_piety b, " +
     "           p_pers_master c, " +
     "           z_code_comp   d, " +
     "           z_code_dept   e, " +
     "           p_code_grade  f " +
     "   WHERE a.emp_no = b.emp_no(+) " +
     "     and a.emp_no = c.emp_no " +
     "     and a.comp_code = d.comp_code(+) " +
     "     and a.dept_code = e.dept_code(+) " +
     "     and a.grade_code = f.grade_code(+) " +
     "     and a.work_yymm = '" + arg_work_yymm + "' " +
     "     and a.div_tag = '2'  " +
     " order by a.comp_code, a.dept_code, a.grade_code, c.emp_name ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>