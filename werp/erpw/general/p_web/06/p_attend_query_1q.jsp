<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_yymm = req.getParameter("arg_work_yymm");
     String arg_attend_code = req.getParameter("arg_attend_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("attend_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("holiday",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("attend_day",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("attend_reason",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("confirm_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  a.resident_no ," + 
     "          b.emp_name ," + 
     "          a.attend_code ," + 
     "          to_char(a.start_date , 'YYYY.MM.DD') start_date," + 
     "          to_char(a.end_date, 'YYYY.MM.DD') end_date," + 
     "          a.spec_no_seq ," + 
     "          to_char(a.holiday, 'YYYY.MM.DD') holiday," + 
     "          a.comp_code ," + 
     "          a.dept_code ," + 
     "          c.short_name dept_name , " + 
     "          a.grade_code ," + 
     "          d.grade_name , " + 
     "          a.attend_day ," + 
     "          a.attend_reason ," + 
     "          a.confirm_tag ," + 
     "          to_char(a.input_date, 'YYYY.MM.DD hh24:mi:ss') input_date " +
     "     FROM p_attend_input a, p_pers_master b, z_code_dept c, p_code_grade d        " +
     "   where a.emp_no = b.emp_no " +
     "     and b.dept_code   = c.dept_code " +
     "     and b.grade_code  = d.grade_code " +
     "     and trunc(a.start_date,'mm') = trunc(to_date('" + arg_work_yymm + "'),'mm') " ;
     
     if (! arg_attend_code.equals(""))		// 전체
     		query += " and a.attend_code =  '" + arg_attend_code + "' " ;
     
     query += " order by b.emp_name, b.dept_code, b.grade_code " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>