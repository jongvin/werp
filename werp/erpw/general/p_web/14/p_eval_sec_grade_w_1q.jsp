<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_eval_code = req.getParameter("arg_eval_code");
     String arg_eval_degree = req.getParameter("arg_eval_degree");
     String arg_sec_evaluator = req.getParameter("arg_sec_evaluator");
     String arg_grade = req.getParameter("arg_grade");
     String arg_title = req.getParameter("arg_title");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("eval_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("self_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("self_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("self_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("self_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("self_present_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("self_present_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("self_evaluator_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("self_dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("self_grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("fir_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("fir_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fir_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("fir_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("fir_interview_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("fir_interview_time",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("fir_interview_place",GauceDataColumn.TB_STRING,50));
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
     dSet.addDataColumn(new GauceDataColumn("sec_eval_grade",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sec_present_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sec_present_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("common_ok",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("leader_ok",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("ok_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  a.eval_code ," + 
     "          a.eval_degree ," + 
     "          a.self_evaluator ," + 
     "          a.self_comp_code ," + 
     "          a.self_dept_code ," + 
     "          a.self_grade_code ," + 
     "          a.self_present_yn ," + 
     "          to_char(a.self_present_date,'yyyy.mm.dd') self_present_date," +
     "			 m.emp_name self_evaluator_name , " + 
     "			 b.long_name self_dept_name , " + 
     "			 c.grade_name self_grade_name , " +
     "          a.fir_evaluator ," + 
     "          a.fir_comp_code ," + 
     "          a.fir_dept_code ," + 
     "          a.fir_grade_code ," + 
     "          a.fir_interview_yn ," + 
     "          a.fir_interview_time ," + 
     "          a.fir_interview_place ," + 
     "          a.fir_suggest_grade ," + 
     "          a.fir_present_yn ," + 
     "          to_char(a.fir_present_date,'yyyy.mm.dd') fir_present_date," + 
     "			 f_m.emp_name fir_evaluator_name , " + 
     "			 f_b.long_name fir_dept_name , " + 
     "			 f_c.grade_name fir_grade_name , " +
     "          a.sec_evaluator ," + 
     "          a.sec_comp_code ," + 
     "          a.sec_dept_code ," + 
     "          a.sec_grade_code ," + 
     "          a.sec_eval_grade ," + 
     "          a.sec_present_yn ," + 
     "          to_char(a.sec_present_date,'yyyy.mm.dd') sec_present_date, " +
     "			 decode(fir_present_yn, 'Y', 'T', 'F') common_ok, " +
     "			 leader.leader_ok,  " +
     "			 'F' ok_tag " +
     "	  FROM p_eval_world_list  a,   " +
     "	       z_code_dept      b,   " +
     "	       p_code_grade     c,   " +
     "	       (select distinct resident_no, emp_name from p_pers_master)    m,   " +
     "	       z_code_dept      f_b,   " +
     "	       p_code_grade     f_c,   " +
     "	       (select distinct resident_no, emp_name from p_pers_master)    f_m,   " +
     "			 ( select b.self_evaluator,	" +
     "						 decode(b.fir_present_yn, 'Y', 'T', 'F') leader_ok 	" +
     "				  FROM p_eval_world_list  a,  " +
     "				  		 p_eval_leadership  b  		 " +
     "				 where a.eval_degree = b.eval_degree	" +
     "				   and a.self_evaluator = b.self_evaluator " +
     "				   and b.eval_code      = '03'  " +
     "				   and b.eval_degree    = '" + arg_eval_degree + "' " +
     "				   and a.sec_evaluator  = '" + arg_sec_evaluator + "' )	leader " +
     "	 where a.self_dept_code  = b.dept_code  (+) " +
     "	   and a.self_grade_code = c.grade_code (+) " +
     "	   and a.self_evaluator  = m.resident_no(+) " +
     "      and a.fir_dept_code  = f_b.dept_code (+) " +
     "	   and a.fir_grade_code = f_c.grade_code(+) " +
     "	   and a.fir_evaluator  = f_m.resident_no(+) " + 
     "	   and a.self_evaluator  = leader.self_evaluator (+) " +
     "      and a.eval_code      = '" + arg_eval_code + "' " +
     "      and a.eval_degree    = '" + arg_eval_degree + "' " +
     "      and a.sec_evaluator  = '" + arg_sec_evaluator + "' " ;
     
      if(arg_grade.equals("1"))    		 	 // 과장이상
		   query += " and a.self_grade_code <= '31' ";
		else if(arg_grade.equals("2"))		 // 과장미만
		   query += " and a.self_grade_code > '31' ";
		
		if(arg_title.equals("1"))    		 	 // 임원(특위이상)
		   query += " and a.self_grade_code <= '10' ";
		else if(arg_title.equals("2"))		 // 팀장(부장이하)
		   query += " and a.self_grade_code > '10' ";
		
     query += " order by a.self_dept_code ," ;
     query += "          a.self_grade_code ," ;
     query += "			 m.emp_name " ; 
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>