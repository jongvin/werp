<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_eval_code = req.getParameter("arg_eval_code");
     String arg_eval_degree = req.getParameter("arg_eval_degree");
     String arg_fir_evaluator = req.getParameter("arg_fir_evaluator");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("eval_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("self_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("self_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("self_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("self_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("self_evaluator_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("self_dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("self_grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("fir_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("fir_suggest_grade",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fir_present_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("fir_present_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sec_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("sec_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("sec_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sec_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("sec_eval_grade",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sec_present_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sec_present_date",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT  a.eval_code ," + 
     "          a.eval_degree ," + 
     "          a.self_evaluator ," + 
     "          a.self_comp_code ," + 
     "          a.self_dept_code ," + 
     "          a.self_grade_code ," + 
     "          m.emp_name self_evaluator_name ," + 
     "          b.long_name self_dept_name ," + 
     "          c.grade_name self_grade_name ," + 
     "          a.fir_evaluator ," + 
     "          a.fir_suggest_grade ," + 
     "          a.fir_present_yn ," + 
     "          to_char(a.fir_present_date,'yyyy.mm.dd') fir_present_date," + 
     "          a.sec_evaluator ," + 
     "          a.sec_comp_code ," + 
     "          a.sec_dept_code ," + 
     "          a.sec_grade_code ," + 
     "          a.sec_eval_grade ," + 
     "          a.sec_present_yn ," + 
     "          to_char(a.sec_present_date,'yyyy.mm.dd') sec_present_date " +
     "	  FROM p_eval_probation      a, " +
     "			 z_code_dept			  b, " +
     "			 p_code_grade			  c,  " +
     "			 (select distinct resident_no, emp_name from p_pers_master)			  m  " +
     "	 where a.self_evaluator = m.resident_no(+)	" +
     "	   and a.self_dept_code = b.dept_code(+)	" +
     "	   and a.self_grade_code = c.grade_code(+)	" +
     "		and a.eval_code   = '" + arg_eval_code + "' " +
     "		and a.eval_degree = '" + arg_eval_degree + "' " +
     "		and a.fir_evaluator = '" + arg_fir_evaluator + "' ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>