<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_eval_code = req.getParameter("arg_eval_code");
     String arg_self_comp = req.getParameter("arg_self_comp"); 
     String arg_eval_degree = req.getParameter("arg_eval_degree");         
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("eval_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("eval_degree",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("self_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("self_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("self_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("self_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("self_evaluator_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("self_comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("self_dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("self_grade_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("file_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fir_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("fir_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("fir_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("fir_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("sec_evaluator",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("sec_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("sec_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sec_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("write_date",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("url",GauceDataColumn.TB_STRING,250));     
    String query = "  SELECT  a.eval_code ," + 
     "          a.eval_degree ," + 
     "          a.self_evaluator ," + 
     "          a.self_comp_code ," + 
     "          a.self_dept_code ," + 
     "          a.self_grade_code ," + 
     "          self.emp_name self_evaluator_name," + 
     "          self_c.comp_name self_comp_name ," + 
     "          self_d.short_name self_dept_name ," + 
     "          self_g.grade_name self_grade_name ," + 
     "          a.file_code," + 
     "          a.fir_evaluator ," + 
     "          a.fir_comp_code ," + 
     "          a.fir_dept_code ," + 
     "          a.fir_grade_code ," + 
     "          a.sec_evaluator ," + 
     "          a.sec_comp_code ," + 
     "          a.sec_dept_code ," + 
     "          a.sec_grade_code ," + 
     "          to_char(write_date,'yyyy.mm.dd hh24:mi:ss') write_date," + 
     "          a.url  " +
     "	   FROM p_eval_file_upload    a, " +
     "			  (select distinct resident_no, emp_name from p_pers_master)			self, " +
     "			  z_code_comp				self_c, " +
     "			  z_code_dept				self_d, " +
     "			  p_code_grade				self_g " +
     "	  where a.self_evaluator = self.resident_no " +
     "		 and a.self_comp_code = self_c.comp_code(+) " +
     "		 and a.self_dept_code = self_d.dept_code(+) " +
     "		 and a.self_grade_code = self_g.grade_code(+) " +
     "		 and a.eval_code  = '" + arg_eval_code + "' " +
     "	    and a.eval_degree  = '" + arg_eval_degree + "'  ";
      
      if(! arg_self_comp.equals(" ")) {   //검색조건으로 찾기 
		   query += " and a.self_comp_code = '" + arg_self_comp + "' ";
		}
		
	  query += " order by a.self_comp_code ,"; 
     query += "          a.self_dept_code ,"; 
     query += "          a.self_grade_code ,";
     query += "			 self.emp_name  		" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>