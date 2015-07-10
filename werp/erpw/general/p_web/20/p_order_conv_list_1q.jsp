<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_name = req.getParameter("arg_emp_name");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("apply_order_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("order_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("real_order_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("cost_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cost_dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("work_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("work_dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("level_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("paystep",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("jobkind_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("jobgroup_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("title_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("duty",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("special_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("old_comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("old_comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("old_cost_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("old_cost_dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("old_work_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("old_work_dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("old_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("old_dept_name",GauceDataColumn.TB_STRING,40));     
     dSet.addDataColumn(new GauceDataColumn("old_grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("old_grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("old_level_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("old_level_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("old_paystep",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("old_jobkind_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("old_jobkind_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("old_jobgroup_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("old_jobgroup_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("old_title_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("old_title_name",GauceDataColumn.TB_STRING,40));     
     dSet.addDataColumn(new GauceDataColumn("old_duty",GauceDataColumn.TB_STRING,50));     
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("confirm_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_id",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("input_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("order_title",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,10));       
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,8));       
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));     
     dSet.addDataColumn(new GauceDataColumn("old_degree",GauceDataColumn.TB_DECIMAL,18,0));     
     dSet.addDataColumn(new GauceDataColumn("ok_tag",GauceDataColumn.TB_STRING,1)); 
     dSet.addDataColumn(new GauceDataColumn("old_service_div",GauceDataColumn.TB_STRING,1)); 
     dSet.addDataColumn(new GauceDataColumn("mov_group_join_date",GauceDataColumn.TB_STRING,18)); 
     dSet.addDataColumn(new GauceDataColumn("dept_short_name",GauceDataColumn.TB_STRING,50)); 
    String query = "SELECT a.emp_no,   " + 
     "     			a.spec_no_seq,  " + 
     "              to_char(a.apply_order_date,'yyyy.mm.dd')  apply_order_date,  " + 
     "              a.order_code,   " + 
	  "              ord.order_name,   " + 
     "              a.seq,   " + 
     "              a.order_no,   " + 
     "              to_char(a.real_order_date,'yyyy.mm.dd') real_order_date,  " + 
     "              a.comp_code,   " + 
     "              a.dept_code,   " + 
     "              dept.long_name dept_name,   " + 
     "              a.cost_dept_code,   " + 
     "              cost.long_name cost_dept_name,   " + 
     "              a.work_dept_code,   " + 
     "              work.long_name work_dept_name,   " + 
     "              a.grade_code,   " + 
     "              a.level_code,   " + 
     "              a.paystep,   " + 
     "              a.jobkind_code,   " + 
     "              a.jobgroup_code,   " + 
     "              a.title_code,   " + 
     "              a.duty,   " + 
     "				  a.special_tag, " +
     "              a.old_comp_code,   " + 
     "              o_comp.comp_name old_comp_name,   " + 
     "              a.old_cost_dept_code,   " + 
     "              o_cost.long_name old_cost_dept_name,   " + 
     "              a.old_work_dept_code,   " + 
     "              o_work.long_name old_work_dept_name,   " + 
     "              a.old_dept_code,   " + 
     "              o_dept.long_name old_dept_name,   " + 
     "              a.old_grade_code,   " + 
     "              o_grade.grade_name old_grade_name,   " + 
     "              a.old_level_code,   " + 
     "              o_level.level_name old_level_name,   " + 
     "              a.old_paystep,   " + 
     "              a.old_jobkind_code,   " + 
     "              o_jobk.jobkind_name old_jobkind_name,   " + 
     "              a.old_jobgroup_code,   " + 
     "              o_jobgroup.jobgroup_name old_jobgroup_name,   " + 
     "              a.old_title_code,   " + 
     "              o_title.title_name old_title_name,   " + 
     "              a.old_duty,   " + 
     "              a.remark,   " + 
     "              a.confirm_tag,   " + 
     "              a.input_id,   " + 
     "              to_char(a.input_date,'yyyy.mm.dd') input_date,   " + 
     "     			  b.order_title," + 
     "     			  c.emp_name," +      
     "     			  substr(c.resident_no,1,6) resident_no," +      
     "     			  a.degree," +      
     "     			  a.old_degree," +      
     "     			  '' ok_tag," +
     "				  a.old_service_div, " +
     "				  to_char(a.mov_group_join_date,'yyyy.mm.dd') mov_group_join_date, " +
     "				  a.dept_short_name " +
     "         FROM p_order_master   a," + 
     "     			p_order_paperno  b," + 
     "     			p_pers_master    c," + 
     "     			z_code_dept      dept," + 
     "     			z_code_dept 	  cost," + 
     "     			z_code_dept      work,     " + 
     "     			z_code_comp   o_comp," + 
     "     			z_code_dept      o_dept," + 
     "     			z_code_dept 	  o_cost," + 
     "     			z_code_dept      o_work," + 
     "     			p_code_grade     o_grade," + 
     "     			p_code_level     o_level," + 
     "     			p_code_jobgroup  o_jobgroup," + 
     "     			p_code_jobkind   o_jobk," + 
     "     			p_code_title     o_title,    " + 
     "     			p_code_order     ord    " + 
     "        WHERE a.order_no = b.order_no" + 
     "          and a.emp_no   = c.emp_no" + 
     "          and a.dept_code      = dept.dept_code(+)" + 
     "          and a.cost_dept_code = cost.dept_code(+)" + 
     "          and a.work_dept_code = work.dept_code(+)     " + 
     "          and a.old_comp_code 	= o_comp.comp_code(+)" + 
     "          and a.old_dept_code 	= o_dept.dept_code(+)" + 
     "          and a.old_cost_dept_code = o_cost.dept_code(+)" + 
     "          and a.old_work_dept_code = o_work.dept_code(+)" + 
     "          and a.old_grade_code 	= o_grade.grade_code(+)" + 
     "          and a.old_level_code 	= o_level.level_code(+)" + 
     "          and a.old_jobgroup_code 	= o_jobgroup.jobgroup_code(+)" + 
     "          and a.old_jobkind_code= o_jobk.jobkind_code(+)" + 
     "          and a.old_title_code 	= o_title.title_code(+)" +
	  "          and a.order_code 	= ord.order_code(+)" +
     "          and c.emp_name = '" + arg_emp_name + "' " + 
     " order by a.emp_no, a.apply_order_date ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>