<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_year = req.getParameter("arg_work_year");
     String arg_attend_code = req.getParameter("arg_attend_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("group_join_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("join_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("attend_day",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  a.resident_no ," + 
     "          b.emp_name ," + 
     "          b.comp_code ," + 
     "          b.dept_code ," + 
     "          c.short_name dept_name , " + 
     "          b.grade_code , " + 
     "          d.grade_name , " + 
     "          to_char(b.group_join_date, 'YYYY.MM.DD') group_join_date ," + 
     "          to_char(b.join_date, 'YYYY.MM.DD') join_date ," + 
     "          a.attend_day " + 
     "     FROM (select a.resident_no, a.emp_no, sum(a.attend_day) attend_day  " + 
     "             from p_attend_input a " + 
     "             where trunc(a.start_date,'yyyy') = trunc(to_date('" + arg_work_year + "'),'yyyy')  " ;
     			
     					if (! arg_attend_code.equals(""))		// 전체
     						query += " and a.attend_code =  '" + arg_attend_code + "' " ;
     
     query += "             group by a.resident_no, a.emp_no ) a, " ;
     query += " 			p_pers_master b, z_code_dept c, p_code_grade d " ;               
     query += "   where a.emp_no = b.emp_no " ;
     query += "     and b.dept_code   = c.dept_code (+)" ;
     query += "     and b.grade_code  = d.grade_code (+) " ;
     query += " order by b.emp_name, b.dept_code, b.grade_code " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>