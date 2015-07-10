<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_year = req.getParameter("arg_work_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("work_year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("group_join_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("join_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("annual_day",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("create_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("confirm_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("ret_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  to_char(a.work_year, 'YYYY.MM.DD') work_year ," + 
     "          	      a.resident_no ," + 
     "          	      a.emp_no ," + 
     "          	      b.emp_name ," + 
     "          	      to_char(a.group_join_date, 'YYYY.MM.DD') group_join_date ," + 
     "          	      to_char(a.join_date, 'YYYY.MM.DD') join_date ," + 
     "          	      a.annual_day ," + 
     "          	      to_char(a.create_date, 'YYYY.MM.DD') create_date ," + 
     "          	      a.confirm_tag ," + 
     "          	      a.comp_code ," + 
     "          	      a.dept_code ," + 
     "          	      a.grade_code,     " +
     "          	      'Y' ret_tag     " +
     "     FROM p_attend_annual a, (select distinct resident_no, emp_name from p_pers_master) b     " +
     " where a.resident_no = b.resident_no " +
     "   and a.work_year = '" + arg_work_year + "' " +
     " order by b.emp_name, a.dept_code, a.grade_code " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>