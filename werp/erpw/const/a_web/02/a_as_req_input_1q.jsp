<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_search = req.getParameter("arg_search");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("req_useq",GauceDataColumn.TB_DECIMAL,25,0));
     dSet.addDataColumn(new GauceDataColumn("proc_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("loc_useq",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("dong",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("ho",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("floor",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("donghofloor",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("prog_st",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("req_date",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("req_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("req_phone",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("req_desc",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("code_pos",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("code_pos_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("code_wbs",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("code_wbs_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("code_cat",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("code_cat_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("code_cau",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("code_cau_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("proc_status",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("plan_visit_date",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("plan_visit_date1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("plan_visit_date_time",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("plan_proc_cat",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("plan_proc_date",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("plan_proc_method",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sbcr_useq",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_useq_as",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_chrg_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sbcr_chrg_phone",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("res_comp_date",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("res_insu_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("res_desc",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("res_cost",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("res_cost_vat",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("insert_date",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("update_date",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("insert_user",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("update_user",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("attrib1",GauceDataColumn.TB_STRING,50));    
     dSet.addDataColumn(new GauceDataColumn("attrib2",GauceDataColumn.TB_STRING,50));   
    String query = "select a.req_useq, " +
          "                a.proc_code, " +
			 "                a.dept_code, " +
			 "                a.loc_useq, " +
			 "						a.dong, " +
			 "						a.ho, " +
			 "						a.floor, " +
			 "                a.dong || '-' || a.ho donghofloor, " +
			 "                a.prog_st, " +
			 "						to_char(a.req_date, 'yyyymmdd') req_date, " +
			 "						a.req_name, " +
			 "						a.req_phone, " +
			 "						a.req_desc, " +
			 "						a.code_pos, " +
			 "                (select name from a_as_comm_code where code=a.code_pos and class='1') code_pos_name, " +
			 "						a.code_wbs, " +
			 "                (select name from a_as_comm_code where code=a.code_wbs and class='2') code_wbs_name, " +
			 "						a.code_cat, " +
			 "                (select name from a_as_comm_code where code=a.code_cat and class='3') code_cat_name, " +
			 "						a.code_cau, " +
			 "                (select name from a_as_comm_code where code=a.code_cau and class='4') code_cau_name, " +
			 "						a.proc_status, " +
			 "						to_char(a.plan_visit_date, 'yyyymmddhh24mi') plan_visit_date, " +
			 "                to_char(a.plan_visit_date, 'yyyymmdd') plan_visit_date1, " +
			 "						to_char(a.plan_visit_date, 'hh24') plan_visit_date_time, " +
			 "						a.plan_proc_cat, " +
			 "						to_char(a.plan_proc_date, 'yyyymmdd') plan_proc_date, " +
			 "						a.plan_proc_method, " +
			 "						a.sbcr_useq, " +
			 "						a.sbcr_useq_as, " +
			 "						a.sbcr_chrg_name, " +
			 "						a.sbcr_chrg_phone, " +
			 "						to_char(a.res_comp_date, 'yyyymmdd') res_comp_date, " +
			 "						a.res_insu_yn, " +
			 "						a.res_desc, " +
			 "						a.res_cost, " +
			 "						a.res_cost_vat, " +
			 "						a.insert_date, " +
			 "						a.update_date, " +
			 "						a.insert_user, " +
			 "						a.update_user, " +
			 "						a.attrib1, " +
			 "						a.attrib2 " +
  			 "           from a_as_req_master a " +
	       "          where " + arg_search +
	       "          order by a.req_useq desc ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>