<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
     String arg_where1 = req.getParameter("arg_where");
     String arg_where  = arg_where1.replace('^','%') ;  // ^를 %로 바꿈. url에서는 %를 값으로 넘겨줄수 없으으로  
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("temp_url",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("paystep",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("jobgroup_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("jobgroup_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jobkind_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("jobkind_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("title_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("title_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("join_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("service_div_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("service_div_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("empname_chi",GauceDataColumn.TB_STRING,20));   
	 dSet.addDataColumn(new GauceDataColumn("empname_eng",GauceDataColumn.TB_STRING,30));    
	 dSet.addDataColumn(new GauceDataColumn("work_dept_code",GauceDataColumn.TB_STRING,40));  
	 dSet.addDataColumn(new GauceDataColumn("work_dept_name",GauceDataColumn.TB_STRING,40));    
	 dSet.addDataColumn(new GauceDataColumn("cost_dept_code",GauceDataColumn.TB_STRING,40));    
	 dSet.addDataColumn(new GauceDataColumn("cost_dept_name",GauceDataColumn.TB_STRING,40));    
	 dSet.addDataColumn(new GauceDataColumn("school_car_code",GauceDataColumn.TB_STRING,13));  
	 dSet.addDataColumn(new GauceDataColumn("school_car_name",GauceDataColumn.TB_STRING,13));   
	 dSet.addDataColumn(new GauceDataColumn("last_school_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("employ_code",GauceDataColumn.TB_STRING,2));   
	 dSet.addDataColumn(new GauceDataColumn("group_join_date",GauceDataColumn.TB_STRING,18));   
	 dSet.addDataColumn(new GauceDataColumn("retire_date",GauceDataColumn.TB_STRING,18));    
	 dSet.addDataColumn(new GauceDataColumn("newface_div",GauceDataColumn.TB_STRING,1));    
	 dSet.addDataColumn(new GauceDataColumn("gradeup_date",GauceDataColumn.TB_STRING,18));  
	 dSet.addDataColumn(new GauceDataColumn("levelup_date",GauceDataColumn.TB_STRING,18));   
	 dSet.addDataColumn(new GauceDataColumn("reinst_date",GauceDataColumn.TB_STRING,18));    
	 dSet.addDataColumn(new GauceDataColumn("employ_div_code",GauceDataColumn.TB_STRING,2)); 
	 dSet.addDataColumn(new GauceDataColumn("dept_join_date",GauceDataColumn.TB_STRING,18));  
	 dSet.addDataColumn(new GauceDataColumn("layoff_date",GauceDataColumn.TB_STRING,18));    
	 dSet.addDataColumn(new GauceDataColumn("jobgroup_date",GauceDataColumn.TB_STRING,18));  
	 dSet.addDataColumn(new GauceDataColumn("recom_er_name",GauceDataColumn.TB_STRING,20));   
	 dSet.addDataColumn(new GauceDataColumn("recom_er_relation",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("recom_er_job",GauceDataColumn.TB_STRING,40));
	 dSet.addDataColumn(new GauceDataColumn("recom_er_title",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("contract_sdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("contract_edate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("url",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("v_dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("contract_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("mid_settle_date",GauceDataColumn.TB_STRING,18));     
     dSet.addDataColumn(new GauceDataColumn("duty",GauceDataColumn.TB_STRING,50));     
    String query = "  SELECT a.emp_no,   " + 
     "         a.emp_name," + 
     "         a.resident_no, " + 
     "         a.comp_code, " +
     "			b.comp_name,   " + 
     "         a.dept_code,  " + 
     "         c.long_name dept_name,  " + 
     "         a.grade_code,  " + 
     "         d.grade_name,  " + 
     "         a.paystep,   " + 
     "         a.jobgroup_code,   " + 
     "         f.jobgroup_name,   " + 
     "         a.jobkind_code,    " + 
     "         g.jobkind_name,    " + 
     "         a.title_code,    " + 
     "         t.title_name,    " + 
     "         to_char(a.join_date,'yyyy.mm.dd') join_date,   " + 
     "         a.service_div_code,  " +
     "         j.service_div_name,  " +
     "         a.empname_chi ," + 
	 "         a.empname_eng ," + 
	 "         a.work_dept_code, " + 
	 "         work.long_name work_dept_name, " + 
	 "         a.cost_dept_code, " + 
	 "         cost.long_name cost_dept_name, " + 
	 "         a.school_car_code ," + 
	 "         h.school_car_name ," + 
     "			a.last_school_name , " +
     "         a.employ_code ," + 
	 "         to_char(a.group_join_date,'yyyy.mm.dd') group_join_date ," + 
	 "         to_char(a.retire_date,'yyyy.mm.dd') retire_date," + 
	 "         a.newface_div ," + 
	 "         to_char(a.gradeup_date,'yyyy.mm.dd') gradeup_date," + 
	 "         to_char(a.levelup_date,'yyyy.mm.dd') levelup_date," + 
	 "         to_char(a.reinst_date,'yyyy.mm.dd') reinst_date," + 
	 "         a.employ_div_code ," + 
	 "         to_char(a.dept_join_date,'yyyy.mm.dd') dept_join_date," + 
	 "         to_char(a.layoff_date,'yyyy.mm.dd') layoff_date," + 
	 "         to_char(a.jobgroup_date,'yyyy.mm.dd') jobgroup_date," + 
	 "         a.recom_er_name ," + 
	 "         a.recom_er_relation ," + 
	 "         a.recom_er_job ," + 
	 "         a.recom_er_title,     " + 
     "         to_char(a.contract_sdate,'yyyy.mm.dd') contract_sdate," + 
     "         to_char(a.contract_edate,'yyyy.mm.dd') contract_edate," + 
     "         '                                                                                                         '  temp_url, " + 
     "			i.url,					" +
     "			v_t.title_name v_dept_name, " +
     "			a.contract_div, " +
     "			to_char(a.mid_settle_date,'yyyy.mm.dd') mid_settle_date, " +
     "			a.duty " +
     "    FROM p_pers_master  a, " +
     "         z_code_comp b, " + 
     "         z_code_dept c, " + 
     "         p_code_grade d, " + 
     "         p_code_jobgroup f, " + 
     "         p_code_jobkind g, " + 
     "         p_code_title t, " + 
     "			z_code_dept work, " +
     "			z_code_dept cost, " +
     "	      p_code_school_car  h,   " +
     "			p_pers_picture i,        " +
     "			p_code_service_div j,        " +
     "         view_dept_code 		v_d,		  " +
     "         view_dept_code_title v_t		  " +
     "   where a.comp_code  = b.comp_code (+) " +
     "     and a.dept_code  = c.dept_code (+) " +
     "     and a.grade_code = d.grade_code (+) " +
     "     and a.jobgroup_code  = f.jobgroup_code (+) " +
     "     and a.jobkind_code = g.jobkind_code (+) " +
     "     and a.title_code = t.title_code (+) " +
     "	  and a.work_dept_code = work.dept_code(+) " +
     "	  and a.cost_dept_code = cost.dept_code(+) " +
     "     and a.school_car_code = h.school_car_code(+) " +
     "     and a.resident_no = i.resident_no(+) " +
     "     and a.service_div_code = j.service_div_code (+) " +
	  "     and a.dept_code    = v_d.dept_code(+) " +
     "     and v_d.level_code = v_t.level_code(+) " +
     " " +  arg_where + " " +
     "  order by a.emp_name ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>