<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_eval_degree = req.getParameter("arg_eval_degree");
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
     dSet.addDataColumn(new GauceDataColumn("fir_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fir_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("fir_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("fir_gen_eval_view",GauceDataColumn.TB_STRING,400));
     dSet.addDataColumn(new GauceDataColumn("fir_suggest_grade",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fir_present_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("fir_present_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("fir_evaluator_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("fir_dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("fir_grade_name",GauceDataColumn.TB_STRING,20));     
     dSet.addDataColumn(new GauceDataColumn("sec_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("sec_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("sec_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sec_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("sec_eval_grade",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("sec_present_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sec_present_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sec_evaluator_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("sec_dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sec_grade_name",GauceDataColumn.TB_STRING,20));     
    String query = "  SELECT  a.eval_code ," + 
     "          a.eval_degree ," + 
     "          a.self_evaluator ," + 
     "          a.self_comp_code ," + 
     "          a.self_dept_code ," + 
     "          a.self_grade_code ," + 
     "          self_b.emp_name   self_evaluator_name ," + 
     "          self_c.long_name  self_dept_name ," + 
     "          self_d.grade_name self_grade_name ," +      
     "          a.fir_evaluator ," + 
     "          a.fir_comp_code ," + 
     "          a.fir_dept_code ," + 
     "          a.fir_grade_code ," + 
     "          a.fir_gen_eval_view ," + 
     "          a.fir_suggest_grade ," + 
     "          a.fir_present_yn ," + 
     "          to_char(a.fir_present_date,'yyyy.mm.dd') fir_present_date ,  " +
     "          fir_b.emp_name   fir_evaluator_name ," + 
     "          fir_c.long_name  fir_dept_name ," + 
     "          fir_d.grade_name fir_grade_name, " + 
     "          a.sec_evaluator ," + 
     "          a.sec_comp_code ," + 
     "          a.sec_dept_code ," + 
     "          a.sec_grade_code ," + 
     "          a.sec_eval_grade ," + 
     "          a.sec_present_yn ," + 
     "          to_char(a.sec_present_date,'yyyy.mm.dd') sec_present_date ," + 
     "          sec_b.emp_name   sec_evaluator_name ," + 
     "          sec_c.long_name  sec_dept_name ," + 
     "          sec_d.grade_name sec_grade_name " +      
     "	  FROM p_eval_probation   a, " +
     "			 (select distinct resident_no, emp_name from p_pers_master)      self_b,  " +
     "          z_code_dept        self_c,  " +
     "			 p_code_grade       self_d,  " +
     "			 (select distinct resident_no, emp_name from p_pers_master)      fir_b,  " +
     "          z_code_dept        fir_c,  " +
     "			 p_code_grade       fir_d,  " +
     "			 (select distinct resident_no, emp_name from p_pers_master)      sec_b,  " +
     "          z_code_dept        sec_c,  " +
     "			 p_code_grade       sec_d   " +
     "    where a.self_evaluator  = self_b.resident_no " +
     "      and a.self_dept_code  = self_c.dept_code(+) " +
     "      and a.self_grade_code = self_d.grade_code(+) " +
     "      and a.fir_evaluator   = fir_b.resident_no(+) " +
     "      and a.fir_dept_code   = fir_c.dept_code(+) " +
     "      and a.fir_grade_code  = fir_d.grade_code(+) " +
     "      and a.sec_evaluator   = sec_b.resident_no(+) " +
     "      and a.sec_dept_code   = sec_c.dept_code(+) " +
     "      and a.sec_grade_code  = sec_d.grade_code(+) " +
     "      and a.eval_code = '04' " +
     "      and a.eval_degree = '" + arg_eval_degree + "' " +
     "  order by a.self_dept_code ," + 
     "           a.self_grade_code ," + 
     "           self_b.emp_name " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>