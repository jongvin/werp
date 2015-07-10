<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_eval_year = req.getParameter("arg_eval_year");
     String arg_sec_evaluator = req.getParameter("arg_sec_evaluator");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("self_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("self_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("self_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("self_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("self_present_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("self_present_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("self_evaluator_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("self_comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("self_dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("self_grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("fir_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("fir_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fir_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("fir_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("fir_agree_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("fir_agree_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("fir_comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("fir_dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("fir_grade_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT a.self_evaluator,   " + 
     "         a.self_comp_code,   " + 
     "         a.self_dept_code,   " + 
     "         a.self_grade_code,   " + 
     "         a.self_present_yn,   " + 
     "         to_char(a.self_present_date, 'yyyy.mm.dd') self_present_date," + 
     "         s_m.emp_name self_evaluator_name,   " + 
     "			s_b.comp_name self_comp_name," + 
     "			s_c.long_name self_dept_name," + 
     "			s_d.grade_name self_grade_name," + 
     "         a.fir_evaluator,   " + 
     "         a.fir_comp_code,   " + 
     "         a.fir_dept_code,   " + 
     "         a.fir_grade_code,   " + 
     "         a.fir_agree_yn,   " + 
     "         to_char(a.fir_agree_date, 'yyyy.mm.dd') fir_agree_date, " + 
     "			f_b.comp_name fir_comp_name," + 
     "			f_c.long_name fir_dept_name," + 
     "			f_d.grade_name fir_grade_name" + 
     "    FROM p_eval_mbo_setup_list   a," + 
     "			z_code_comp					s_b," + 
     "			z_code_dept					s_c," + 
     "			p_code_grade				s_d," + 
     "			(select distinct resident_no, emp_name from p_pers_master)				s_m," + 
     "			z_code_comp					f_b," + 
     "			z_code_dept					f_c," + 
     "			p_code_grade				f_d" + 
     "	where a.self_comp_code 	= s_b.comp_code(+)" + 
     "	  and a.self_dept_code  = s_c.dept_code(+)" + 
     "	  and a.self_grade_code = s_d.grade_code(+)" + 
     "	  and a.self_evaluator  = s_m.resident_no	(+)" + 
     "	  and a.fir_comp_code   = f_b.comp_code(+)" + 
     "	  and a.fir_dept_code   = f_c.dept_code(+)" + 
     "	  and a.fir_grade_code  = f_d.grade_code(+)" + 
     "	  and a.eval_code = '01'" + 
     " 	  and a.eval_year = '" + arg_eval_year + "'  " +
     "	  and a.sec_evaluator = '" + arg_sec_evaluator + "'   ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>