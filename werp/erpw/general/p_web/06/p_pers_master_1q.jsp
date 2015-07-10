<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_date = req.getParameter("arg_work_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("group_join_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("join_date",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT  p_pers_master.resident_no ," + 
     "          p_pers_master.emp_no,     " + 
     "          p_pers_master.emp_name,     " + 
     "          p_pers_master.dept_code,     " + 
     "          p_pers_master.grade_code,     " + 
     "          to_char(p_pers_master.group_join_date, 'YYYY.MM.DD') group_join_date ," + 
     "          to_char(p_pers_master.join_date, 'YYYY.MM.DD') join_date " + 
     "       FROM p_pers_master        " +
     "   where p_pers_master.service_div_code = '2' " +
     "     and p_pers_master.group_join_date <= '" + arg_work_date + "' ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>