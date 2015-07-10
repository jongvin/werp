<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_degree = req.getParameter("arg_degree");
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_seq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("Level1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("title_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("level_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));     
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));     
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));     
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));     
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));     
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,30));     
     dSet.addDataColumn(new GauceDataColumn("url",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,1));     
    String query = "select  a.degree , " + 
     "         a.dept_seq_key , " + 
     "         a.no_seq, " + 
     "         a.Level1, " + 
     "         a.title_name , " + 
     "         a.level_code , " + 
     "         a.comp_code," + 
     "			a.dept_code," + 
     "			a.emp_no," + 
     "			b.resident_no," + 
     "			b.emp_name, " + 
     "			c.grade_name, " + 
     "			d.url, " + 
     "			a.tag " + 
     "  from" + 
     "  		(  SELECT  a.degree , " + 
     "	               a.dept_seq_key , " + 
     "	               a.no_seq * 100000  no_seq, " + 
     "	               to_number(a.level1) Level1, " + 
     "	               a.title_name , " + 
     "	               a.level_code , " + 
     "	               a.comp_code," + 
     "						'' dept_code," + 
     "						a.emp_no," + 
     "						'1' tag " + 
     "	        FROM z_code_chg_dept_title a " + 
     "	         WHERE ( a.degree =  " + arg_degree + "  )" + 
     "	           and ( a.emp_no =  '" + arg_emp_no + "') " +      
     "	union all " + 
     "			SELECT  a.degree , " + 
     "	               a.dept_seq_key , " + 
     "	               a.no_seq  * 100000 + b.no_seq no_seq, " + 
     "	               to_number(a.level1) + 1 Level1, " + 
     "	               c.long_name , " + 
     "	               a.level_code || '01' , " + 
     "	               a.comp_code," + 
     "						b.dept_code," + 
     "						b.emp_no," + 
     "						'2' tag " + 
     "	        FROM z_code_chg_dept_title a," + 
     "			  		 z_code_chg_dept_content b," + 
     "					 z_code_dept				 c  " + 
     "	         WHERE ( a.degree =  " + arg_degree + " )" + 
     "  			   and (a.emp_no = '" + arg_emp_no + "' or b.emp_no like '%' " +
     "					   and b.emp_no = '" + arg_emp_no + "'  or b.charge_emp_no = '" + arg_emp_no + "' ) " +
     "				and a.degree = b.degree" + 
     "				and a.dept_seq_key = b.dept_seq_key" + 
     "				and b.dept_code    = c.dept_code" + 
     "				and b.dept_limit_tag  = 'Y' " + 
     "				and c.process_code    <> '03' " +
     "	   ) a , p_pers_master b, p_code_grade c, p_pers_picture d " + 
     " where a.emp_no = b.emp_no (+) " + 
     "   and b.grade_code  = c.grade_code (+) " + 
     "   and b.resident_no  = d.resident_no (+) " + 
     " order by a.no_seq	        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>