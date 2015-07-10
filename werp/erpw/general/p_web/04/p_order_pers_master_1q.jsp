<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_order_no = req.getParameter("arg_order_no");    
     String arg_confirm_tag = req.getParameter("arg_confirm_tag");    
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("apply_order_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cost_dept_code",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("work_dept_code",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("level_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("paystep",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("jobgroup_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("jobkind_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("title_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("duty",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("service_div_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("group_join_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("join_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("retire_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("gradeup_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("levelup_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("dept_join_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cost_dept_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("layoff_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("jobgroup_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("order_comp_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("order_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("order_cost_dept_code",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("order_work_dept_code",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("order_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("order_level_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("order_paystep",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("order_jobgroup_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("order_jobkind_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("order_title_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("order_duty",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("order_service_div",GauceDataColumn.TB_STRING,10));     
     dSet.addDataColumn(new GauceDataColumn("gjoin_date_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("join_date_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("rest_date_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("reinst_date_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("retire_date_yn",GauceDataColumn.TB_STRING,1));     
     dSet.addDataColumn(new GauceDataColumn("dept_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cost_dept_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("add_dept_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("grade_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("level_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("paystep_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("jobgroup_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("jobkind_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("title_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));     
     dSet.addDataColumn(new GauceDataColumn("order_degree",GauceDataColumn.TB_DECIMAL,18,0)); 
     dSet.addDataColumn(new GauceDataColumn("order_code",GauceDataColumn.TB_STRING,3)); 
     dSet.addDataColumn(new GauceDataColumn("mov_group_join_date",GauceDataColumn.TB_STRING,18));      
    String query = "  SELECT a.emp_no,   " + 
     "         to_char(b.apply_order_date,'yyyy.mm.dd') apply_order_date,  " +
     "         a.comp_code, " +
     "         a.dept_code,  " + 
     "         a.cost_dept_code, " + 
     "         a.work_dept_code, " + 
     "         a.grade_code,  " + 
     "         a.level_code,   " + 
     "         a.paystep,   " + 
     "         a.jobgroup_code,   " + 
     "         a.jobkind_code,    " + 
     "         a.title_code,    " + 
     "         a.duty,    " + 
     "         a.service_div_code, " +
     "         to_char(a.group_join_date,'yyyy.mm.dd') group_join_date ," + 
     "         to_char(a.join_date,'yyyy.mm.dd') join_date,   " + 
     "         to_char(a.retire_date,'yyyy.mm.dd') retire_date," + 
     "         to_char(a.gradeup_date,'yyyy.mm.dd') gradeup_date," + 
     "         to_char(a.levelup_date,'yyyy.mm.dd') levelup_date," + 
     "         to_char(a.dept_join_date,'yyyy.mm.dd') dept_join_date," + 
     "         to_char(a.cost_dept_date,'yyyy.mm.dd') cost_dept_date," + 
     "         to_char(a.layoff_date,'yyyy.mm.dd') layoff_date ," + 
     "         to_char(a.jobgroup_date,'yyyy.mm.dd') jobgroup_date," + 
     "         b.comp_code 		order_comp_code, " +
     "         b.dept_code  		order_dept_code, " + 
     "         b.cost_dept_code	order_cost_dept_code, " + 
     "         b.work_dept_code	order_work_dept_code, " + 
     "         b.grade_code	  	order_grade_code, " + 
     "         b.level_code   	order_level_code, " + 
     "         b.paystep   		order_paystep, " + 
     "         b.jobgroup_code	   	order_jobgroup_code, " + 
     "         b.jobkind_code	   order_jobkind_code, " + 
     "         b.title_code    	order_title_code, " + 
     "         b.duty    			order_duty, " + 
     "     		c.service_div 		order_service_div," +      
     "     		c.gjoin_date_yn," + 
     "     		c.join_date_yn," + 
     "     		c.rest_date_yn," + 
     "     		c.reinst_date_yn," + 
     "     		c.retire_date_yn," +     
     "     		c.dept_yn," +     
     "     		c.cost_dept_yn," +     
     "     		c.add_dept_yn," +     
     "     		c.grade_yn," +     
     "     		c.level_yn," +     
     "     		c.paystep_yn," +     
     "     		c.jobgroup_yn," +     
     "     		c.jobkind_yn," +     
     "     		c.title_yn," + 
     "     		a.degree," + 
     "     		b.degree  order_degree," + 
     "			b.order_code, " +
     "			to_char(b.mov_group_join_date,'yyyy.mm.dd') mov_group_join_date " +
     "    FROM p_pers_master  a, " +
     "     		p_order_master b, " + 
     "     		p_code_order   c " + 
     "   where a.emp_no = b.emp_no	" +
     "	  and b.order_code = c.order_code " +
     "	  and b.order_no = '" + arg_order_no + "' " +
     "	  and b.confirm_tag = '" + arg_confirm_tag + "' " +
     "  order by a.emp_no ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>