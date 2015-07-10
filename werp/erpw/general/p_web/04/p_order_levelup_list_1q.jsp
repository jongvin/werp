<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp_code = req.getParameter("arg_comp_code");
     String arg_work_year = req.getParameter("arg_work_year");     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("paystep",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("group_join_date",GauceDataColumn.TB_STRING,18));     
     dSet.addDataColumn(new GauceDataColumn("levelup_date",GauceDataColumn.TB_STRING,18));     
	  dSet.addDataColumn(new GauceDataColumn("up_paystep",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ok_tag",GauceDataColumn.TB_STRING,1));     
    String query = "  SELECT a.emp_no,   " + 
     "         a.emp_name,   " + 
     "         a.comp_code,   " + 
     "         a.dept_code,   " + 
     "         de.long_name dept_name,   " + 
     "         a.grade_code,   " + 
     "			gr.grade_name,	 " + 
     "         a.paystep,   " + 
     "			decode(sign(add_months(to_date('" + arg_work_year + "'),-12) - a.group_join_date), " +
     "								 -1, 1, 2) up_paystep, " +
     "         to_char(a.group_join_date,'yyyy.mm.dd') group_join_date,   " + 
     "         to_char(a.levelup_date,'yyyy.mm.dd') levelup_date,   " + 
     "			'F' ok_tag " +
     "    FROM p_pers_master   a," + 
	  "			p_code_grade	 gr," +
     "			z_code_dept 	 de" +
     "	where a.grade_code  = gr.grade_code " +
     "	  and a.dept_code   = de.dept_code " +
     "	  and gr.levelup_obj_yn = 'T' " +
     "	  and a.service_div_code = '2' " +
     "	  and a.comp_code = '" + arg_comp_code + "'" + 
     "     and a.group_join_date < add_months(to_date('" + arg_work_year + "'), -6) " +
	  "     and a.levelup_date    < add_months(to_date('" + arg_work_year + "'), -6) " +
	  "     and not exists(select b.emp_no from p_order_obj_list b " +
	  "  		 	  					  where a.emp_no = b.emp_no " +
	  "									 and b.comp_code = '" + arg_comp_code + "' " +
	  "									 and b.work_year = '" + arg_work_year + "' ) " +
     " order by a.grade_code, a.paystep, a.emp_name ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>