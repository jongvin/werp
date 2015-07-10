<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_year = req.getParameter("arg_work_year");
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
     dSet.addDataColumn(new GauceDataColumn("annual_day",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("annual_use_day",GauceDataColumn.TB_DECIMAL,3,1));
     dSet.addDataColumn(new GauceDataColumn("attend_day",GauceDataColumn.TB_DECIMAL,3,1));
    String query = "  SELECT  b.resident_no ," + 
     " 					         e.emp_name,     " + 
     " 					         b.comp_code , " + 
     " 					         b.dept_code , " + 
     " 					         f.short_name dept_name , " + 
     " 					         b.grade_code , " + 
     " 					         g.grade_name , " + 
     " 					         to_char(b.group_join_date, 'YYYY.MM.DD') group_join_date ," + 
     " 					         to_char(b.join_date, 'YYYY.MM.DD') join_date ," + 
     " 					         b.annual_day, " + 	// '2002','2003','2004' 근태내역없음
     " 					         decode(to_char(b.work_year,'yyyy'),'2002',b.annual_use_day, " +
     "																			  '2003',b.annual_use_day, " +
     "																			  '2004',b.annual_use_day, " +
     "																			  a.annual_use_day) annual_use_day, " + 
     "								nvl(b.annual_day,0) - nvl(decode(to_char(b.work_year,'yyyy'), " +
     "																			  '2002',b.annual_use_day, " +
     "																			  '2003',b.annual_use_day, " +
     "																			  '2004',b.annual_use_day, " +
     "																			  a.annual_use_day),0) attend_day " +
     " 						FROM  p_attend_annual b, (select distinct resident_no, emp_name from p_pers_master) e,        " +
     " 					         z_code_dept f, p_code_grade g, " +
     " 					         (select a.resident_no, sum(a.attend_day) annual_use_day  " + 
     " 					            from p_attend_input a " + 
     " 					            where trunc(a.start_date,'yyyy') = trunc(to_date('" + arg_work_year + "'),'yyyy')  " +
     " 					              and a.attend_code = '01' " + 
     " 					            group by a.resident_no ) a " + 
     " 					  where b.resident_no = a.resident_no (+) " +
     " 					    and b.resident_no = e.resident_no " +
     " 					    and b.dept_code = f.dept_code (+) " +
     " 					    and b.grade_code = g.grade_code(+) " +
     " 					    and b.work_year = '" + arg_work_year + "' " +
     " 					order by e.emp_name, b.dept_code, b.grade_code " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>