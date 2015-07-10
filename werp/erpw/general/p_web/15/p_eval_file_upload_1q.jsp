<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_eval_code = req.getParameter("arg_eval_code");
     String arg_eval_degree = req.getParameter("arg_eval_degree");
     String arg_self_evaluator = req.getParameter("arg_self_evaluator");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("eval_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("self_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("self_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("self_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("self_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("file_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fir_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("fir_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fir_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("fir_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("fir_evaluator_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("fir_comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("fir_dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("fir_grade_name",GauceDataColumn.TB_STRING,20));     
     dSet.addDataColumn(new GauceDataColumn("sec_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("sec_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("sec_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sec_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("sec_evaluator_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("sec_comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sec_dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sec_grade_name",GauceDataColumn.TB_STRING,20));     
     dSet.addDataColumn(new GauceDataColumn("write_date",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("url",GauceDataColumn.TB_STRING,250));
     dSet.addDataColumn(new GauceDataColumn("cdir",GauceDataColumn.TB_URL,255));     
     dSet.addDataColumn(new GauceDataColumn("name_file",GauceDataColumn.TB_STRING,250));
     dSet.addDataColumn(new GauceDataColumn("file_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  a.eval_code ," + 
     "          a.eval_degree ," + 
     "          a.self_evaluator ," + 
     "          a.self_comp_code ," + 
     "          a.self_dept_code ," + 
     "          a.self_grade_code ," + 
     "          a.file_code," + 
     "          a.fir_evaluator ," + 
     "          a.fir_comp_code ," + 
     "          a.fir_dept_code ," + 
     "          a.fir_grade_code ," + 
     "          fir_m.emp_name   fir_evaluator_name ," + 
     "          fir_b.comp_name  fir_comp_name ," + 
     "          fir_c.long_name  fir_dept_name ," + 
     "          fir_d.grade_name fir_grade_name, " +      
     "          a.sec_evaluator ," + 
     "          a.sec_comp_code ," + 
     "          a.sec_dept_code ," + 
     "          a.sec_grade_code ," + 
     "          sec_m.emp_name   sec_evaluator_name ," + 
     "          sec_b.comp_name  sec_comp_name ," + 
     "          sec_c.long_name  sec_dept_name ," + 
     "          sec_d.grade_name sec_grade_name, " +      
     "          to_char(write_date,'yyyy.mm.dd hh24:mi:ss') write_date," + 
     "          a.url,  " +
     "          a.url cdir," + 
     "          '' file_name," + 
     "          '                                                                                                         '  name_file  " +      
     "	   FROM p_eval_file_upload    a,   " +
     "			  z_code_comp			   fir_b, " +
     "			  z_code_dept			   fir_c, " +
     "			  p_code_grade			   fir_d, " +
     "			  (select distinct resident_no, emp_name from p_pers_master)			fir_m, " +
     "			  z_code_comp			   sec_b, " +
     "			  z_code_dept			   sec_c, " +
     "			  p_code_grade			   sec_d, " +
     "			  (select distinct resident_no, emp_name from p_pers_master)			sec_m " +
     "	  where a.fir_comp_code  = fir_b.comp_code(+)	" +
     "		 and a.fir_dept_code  = fir_c.dept_code(+) " +
     "		 and a.fir_grade_code = fir_d.grade_code(+) " +     
     "		 and a.fir_evaluator  = fir_m.resident_no(+) " +
     "	    and a.sec_comp_code  = sec_b.comp_code(+)	" +
     "		 and a.sec_dept_code  = sec_c.dept_code(+) " +
     "		 and a.sec_grade_code = sec_d.grade_code(+) " +     
     "		 and a.sec_evaluator  = sec_m.resident_no(+) " +     
     "		 and a.eval_code  = '" + arg_eval_code + "' " +
     "	    and a.eval_degree  = '" + arg_eval_degree + "' " +
     "	    and a.self_evaluator  = '" + arg_self_evaluator + "' ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>