<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_eval_year = req.getParameter("arg_eval_year");
     String arg_self_evaluator = req.getParameter("arg_self_evaluator");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("eval_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("self_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("self_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("self_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("self_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("self_present_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("self_present_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("self_comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("self_dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("self_grade_name",GauceDataColumn.TB_STRING,20));     
     dSet.addDataColumn(new GauceDataColumn("fir_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("fir_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fir_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("fir_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("fir_agree_yn",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("fir_agree_date",GauceDataColumn.TB_STRING,18));
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
     dSet.addDataColumn(new GauceDataColumn("fir_ret_comment",GauceDataColumn.TB_STRING,400));     
     dSet.addDataColumn(new GauceDataColumn("url",GauceDataColumn.TB_STRING,250));  
     dSet.addDataColumn(new GauceDataColumn("cdir",GauceDataColumn.TB_URL,255));     
     dSet.addDataColumn(new GauceDataColumn("name_file",GauceDataColumn.TB_STRING,250));
     dSet.addDataColumn(new GauceDataColumn("file_name",GauceDataColumn.TB_STRING,50));   
     dSet.addDataColumn(new GauceDataColumn("upload_date",GauceDataColumn.TB_STRING,20));     
    String query = "  SELECT  a.eval_code ," + 
     "          to_char(a.eval_year,'yyyy.mm.dd') eval_year ," + 
     "          a.self_evaluator ," + 
     "          a.self_comp_code ," + 
     "          a.self_dept_code ," + 
     "          a.self_grade_code ," + 
     "          a.self_present_yn ," + 
     "          to_char(a.self_present_date,'yyyy.mm.dd') self_present_date ," + 
     "          self_b.comp_name self_comp_name ," + 
     "          self_c.long_name self_dept_name ," + 
     "          self_d.grade_name self_grade_name, " +      
     "          a.fir_evaluator ," + 
     "          a.fir_comp_code ," + 
     "          a.fir_dept_code ," + 
     "          a.fir_grade_code ," + 
     "          decode(a.fir_agree_yn,'Y','합의','') fir_agree_yn  ," +
     "          to_char(a.fir_agree_date,'yyyy.mm.dd') fir_agree_date ," + 
     "          fir_m.emp_name fir_evaluator_name ," + 
     "          fir_b.comp_name fir_comp_name ," + 
     "          fir_c.long_name fir_dept_name ," + 
     "          fir_d.grade_name fir_grade_name , " +      
     "          a.sec_evaluator ," + 
     "          a.sec_comp_code ," + 
     "          a.sec_dept_code ," + 
     "          a.sec_grade_code ," + 
     "          sec_m.emp_name   sec_evaluator_name ," + 
     "          sec_b.comp_name  sec_comp_name ," + 
     "          sec_c.long_name  sec_dept_name ," + 
     "          sec_d.grade_name sec_grade_name, " +           
     "			 a.fir_ret_comment,	" +
     "			 a.url,	" +
     "          a.url cdir," + 
     "          '' file_name," + 
     "          '                                                                                                         '  name_file,  " +      
     "			 to_char(upload_date,'yyyy.mm.dd hh24:mi:ss') upload_date	" +
     "	  FROM p_eval_mbo_setup_list   a,  " +
     "			 z_code_comp	self_b, " +
     "			 z_code_dept	self_c, " +
     "			 p_code_grade	self_d, " +
     "	       (select distinct resident_no, emp_name from p_pers_master) fir_m,   " +
     "			 z_code_comp	fir_b, " +
     "			 z_code_dept	fir_c, " +
     "			 p_code_grade	fir_d, " +
     "	       (select distinct resident_no, emp_name from p_pers_master) sec_m,   " +
     "			 z_code_comp	sec_b, " +
     "			 z_code_dept	sec_c, " +
     "			 p_code_grade	sec_d " +
     "	 where a.self_comp_code  = self_b.comp_code(+)	" +
     "		and a.self_dept_code  = self_c.dept_code(+) " +
     "		and a.self_grade_code = self_d.grade_code(+) " +
     "		and a.fir_evaluator  = fir_m.resident_no(+) " +
     "		and a.fir_comp_code  = fir_b.comp_code(+)	" +
     "		and a.fir_dept_code  = fir_c.dept_code(+) " +
     "		and a.fir_grade_code = fir_d.grade_code(+) " +
     "		and a.sec_evaluator  = sec_m.resident_no(+) " +
     "		and a.sec_comp_code  = sec_b.comp_code(+)	" +
     "		and a.sec_dept_code  = sec_c.dept_code(+) " +
     "		and a.sec_grade_code = sec_d.grade_code(+) " +
     "		and a.eval_code = '01'  " +
     "		and to_char(a.eval_year,'yyyy') = to_char(to_date('" + arg_eval_year + "'),'yyyy') " +
     "		and self_evaluator = '" + arg_self_evaluator + "'  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>