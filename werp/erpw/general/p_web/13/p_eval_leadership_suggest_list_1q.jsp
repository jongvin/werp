<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
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
     dSet.addDataColumn(new GauceDataColumn("fir_present_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("fir_present_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("suc_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("suc_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("suc_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("suc_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("suc_present_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("suc_present_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("suc_evaluator_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("suc_dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("suc_grade_name",GauceDataColumn.TB_STRING,20));
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
     "          a.fir_present_yn ," + 
     "          to_char(a.fir_present_date,'yyyy.mm.dd') fir_present_date," + 
     "          a.suc_evaluator ," + 
     "          a.suc_comp_code ," + 
     "          a.suc_dept_code ," + 
     "          a.suc_grade_code ," + 
     "          a.suc_present_yn ," + 
     "          to_char(a.suc_present_date,'yyyy.mm.dd') suc_present_date, " +
     "          suc_m.emp_name suc_evaluator_name ," + 
     "          suc_b.long_name suc_dept_name ," + 
     "          suc_c.grade_name suc_grade_name " + 
     "	  FROM p_eval_leadership     a, " +
     "			 z_code_dept			  b, " +
     "			 p_code_grade			  c,  " +
     "			 (select distinct resident_no, emp_name from p_pers_master)			  m,  " +
     "			 z_code_dept			  suc_b, " +
     "			 p_code_grade			  suc_c,  " +
     "			 (select distinct resident_no, emp_name from p_pers_master)			  suc_m  " +
     "	 where a.self_evaluator  = m.resident_no(+)	" +
     "	   and a.self_dept_code  = b.dept_code(+)	" +
     "	   and a.self_grade_code = c.grade_code(+)	" +
     "		and a.suc_evaluator  = suc_m.resident_no(+)	" +
     "	   and a.suc_dept_code  = suc_b.dept_code(+)	" +
     "	   and a.suc_grade_code = suc_c.grade_code(+)	" +
     "		and a.eval_code   = '" + arg_eval_code + "' " +
     "		and a.eval_degree = '" + arg_eval_degree + "' " +
     "		and a.fir_evaluator = '" + arg_fir_evaluator + "' ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>