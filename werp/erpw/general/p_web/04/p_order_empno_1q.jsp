<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("cost_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cost_dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("work_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("work_dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("level_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("level_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("paystep",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("jobgroup_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("jobgroup_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jobkind_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("jobkind_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("title_code",GauceDataColumn.TB_STRING,3));     
     dSet.addDataColumn(new GauceDataColumn("title_name",GauceDataColumn.TB_STRING,40));     
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));          
     dSet.addDataColumn(new GauceDataColumn("service_div_code",GauceDataColumn.TB_STRING,1));               
     dSet.addDataColumn(new GauceDataColumn("duty",GauceDataColumn.TB_STRING,50));               
     dSet.addDataColumn(new GauceDataColumn("group_join_date",GauceDataColumn.TB_STRING,18));               
    String query = "  SELECT a.emp_no,   " + 
     "         a.emp_name,   " + 
     "         a.comp_code,   " + 
     "         comp.comp_name,   " + 
     "         a.dept_code,   " + 
     "         dept.long_name dept_name,   " + 
     "         a.cost_dept_code,   " + 
     "         cost.long_name cost_dept_name,   " + 
     "         a.work_dept_code,   " + 
     "         work.long_name work_dept_name,   " + 
     "         a.grade_code,   " + 
     "         gr.grade_name,   " + 
     "         a.level_code,   " + 
     "         le.level_name,   " + 
     "         a.paystep,   " + 
     "         a.jobgroup_code,   " + 
     "         jg.jobgroup_name,   " + 
     "         a.jobkind_code,   " + 
     "         jo.jobkind_name,   " + 
     "         a.title_code, " + 
     "         ti.title_name, " + 
     "         a.degree, " + 
     "         a.service_div_code, " + 
     "         a.duty, " + 
     "			to_char(a.group_join_date,'yyyy.mm.dd') group_join_date " +
     "    FROM p_pers_master   a," + 
     "         z_code_dept		 dept," + 
     "         z_code_dept		 cost," + 
     "         z_code_dept		 work, " + 
     "         z_code_comp	 comp, " + 
     "         p_code_grade	 gr, " + 
     "         p_code_level	 le, " + 
     "         p_code_jobgroup		 jg, " + 
     "         p_code_jobkind	 jo, " + 
     "         p_code_title	 ti " + 
     "	where a.dept_code			= dept.dept_code(+)	" +
     "	  and a.cost_dept_code	= cost.dept_code(+)	" +
     "	  and a.work_dept_code	= work.dept_code(+)	" +
     "	  and a.comp_code			= comp.comp_code(+)	" +     
     "	  and a.grade_code	= gr.grade_code(+)	" +
     "	  and a.level_code	= le.level_code(+)	" +
     "	  and a.jobgroup_code		= jg.jobgroup_code(+)	" +
     "	  and a.jobkind_code	= jo.jobkind_code(+)	" +
     "	  and a.title_code	= ti.title_code(+)	" +
     "	  and a.emp_no = '" + arg_emp_no  + "'    " ;     
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>