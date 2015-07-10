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
     dSet.addDataColumn(new GauceDataColumn("suc_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("suc_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("suc_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("suc_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("suc_present_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("suc_present_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("suc_evaluator_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("suc_dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("suc_grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("fir_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("fir_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fir_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("fir_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("fir_present_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("fir_present_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("fir_evaluator_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("fir_dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("fir_grade_name",GauceDataColumn.TB_STRING,20));     
    String query = "  SELECT  a.eval_code ," + 
     "          a.eval_degree ," + 
     "          a.self_evaluator ," + 
     "          a.self_comp_code ," + 
     "          a.self_dept_code ," + 
     "          a.self_grade_code ," + 
     "          self_b.emp_name   self_evaluator_name ," + 
     "          self_c.long_name  self_dept_name ," + 
     "          self_d.grade_name self_grade_name ," +      
     "          a.suc_evaluator ," + 
     "          a.suc_comp_code ," + 
     "          a.suc_dept_code ," + 
     "          a.suc_grade_code ," + 
     "          a.suc_present_yn ," + 
     "          to_char(a.suc_present_date,'yyyy.mm.dd') suc_present_date ," + 
     "          suc_b.emp_name   suc_evaluator_name ," + 
     "          suc_c.long_name  suc_dept_name ," + 
     "          suc_d.grade_name suc_grade_name ," +      
     "          a.fir_evaluator ," + 
     "          a.fir_comp_code ," + 
     "          a.fir_dept_code ," + 
     "          a.fir_grade_code ," + 
     "          a.fir_present_yn ," + 
     "          to_char(a.fir_present_date,'yyyy.mm.dd') fir_present_date ,  " +
     "          fir_b.emp_name   fir_evaluator_name ," + 
     "          fir_c.long_name  fir_dept_name ," + 
     "          fir_d.grade_name fir_grade_name " + 
     "     FROM p_eval_leadership  a,    " +
     "			 (select distinct resident_no, emp_name from p_pers_master)      self_b,  " +
     "          z_code_dept        self_c,  " +
     "			 p_code_grade       self_d,  " +
     "			 (select distinct resident_no, emp_name from p_pers_master)      suc_b,  " +
     "          z_code_dept        suc_c,   " +
     "			 p_code_grade       suc_d,  " +
     "			 (select distinct resident_no, emp_name from p_pers_master)      fir_b,  " +
     "          z_code_dept        fir_c,   " +
     "			 p_code_grade       fir_d  " +
     "    where a.self_evaluator  = self_b.resident_no " +
     "      and a.self_dept_code  = self_c.dept_code(+) " +
     "      and a.self_grade_code = self_d.grade_code(+) " +
     "      and a.suc_evaluator   = suc_b.resident_no(+) " +
     "      and a.suc_dept_code   = suc_c.dept_code(+) " +
     "      and a.suc_grade_code  = suc_d.grade_code(+) " +
     "      and a.fir_evaluator   = fir_b.resident_no(+) " +
     "      and a.fir_dept_code   = fir_c.dept_code(+) " +
     "      and a.fir_grade_code  = fir_d.grade_code(+) " +
     "      and a.eval_code = '03' " +
     "      and a.eval_degree = '" + arg_eval_degree + "' " +
     "  order by a.self_dept_code ," + 
     "           a.self_grade_code ," + 
     "           self_b.emp_name " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>