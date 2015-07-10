<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp_code = req.getParameter("arg_comp_code");
     String arg_work_year = req.getParameter("arg_work_year");     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("work_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("cur_level",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("cur_paystep",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("up_level",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("up_paystep",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("up_paystep_temp",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("jobkind_code",GauceDataColumn.TB_STRING,5));
     dSet.addDataColumn(new GauceDataColumn("dept_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("jobgroup_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("last_levelup_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("last_paystep_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("school_career_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("last_school",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("year_level",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3,0));
     dSet.addDataColumn(new GauceDataColumn("group_join_date",GauceDataColumn.TB_STRING,18,0));
    String query = "  SELECT to_char(a.work_year,'yyyy.mm.dd') work_year,   " + 
     "         a.emp_no,   " + 
     "         b.emp_name,   " + 
     "         a.comp_code,   " + 
     "         a.dept_code,   " +
     "         a.cur_level,   " + 
     "         a.cur_paystep,   " + 
     "         a.up_level,   " + 
     "         a.up_paystep,   " + 
     "         a.up_paystep up_paystep_temp,   " + 
     "         a.jobkind_code,   " + 
     "         to_char(a.dept_date,'yyyy.mm.dd') dept_date,   " + 
     "         to_char(a.jobgroup_date,'yyyy.mm.dd') jobgroup_date,  " + 
     "         to_char(a.last_levelup_date,'yyyy.mm.dd') last_levelup_date,   " + 
     "         to_char(a.last_paystep_date,'yyyy.mm.dd') last_paystep_date,   " + 
     "         a.school_career_code,   " + 
     "         a.last_school,   " + 
     "         a.year_level,  " + 
     "         b.grade_code,  " + 
     "         to_char(b.group_join_date,'yyyy.mm.dd') group_join_date  " +      
     "    FROM p_order_obj_list   a," + 
     "         p_pers_master		 b" + 
     "	where a.emp_no = b.emp_no " +
     "	  and b.service_div_code = '2' " +
     "	  and a.comp_code = '" + arg_comp_code + "'" + 
     "     and a.work_year = '" + arg_work_year + "' " + 
     " order by b.grade_code, a.cur_paystep, b.emp_name ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>