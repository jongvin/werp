<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_from = req.getParameter("arg_from");
     String arg_to = req.getParameter("arg_to");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("civil_register_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("labor_name",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("job_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("dailywork",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("unitcost",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("text",GauceDataColumn.TB_STRING,50));
    String query = "select a.dept_code," + 
     "               		a.civil_register_number," + 
     "               		to_char(a.work_date,'YYYY.MM.DD') work_date," + 
     "               		b.labor_name," + 
     "               		c.job_name," + 
     "               		a.dailywork," + 
     "               		a.unitcost," + 
     "               		a.pay_amt," + 
     "               		e.long_name, " + 
     "                     ' ' text " +
     "                from l_labor_dailywork a," + 
     "                 	   l_labor_basic b," + 
     "                     l_code_job c," + 
     "                     ( SELECT max(CIVIL_REGISTER_NUMBER) civil_register_number,   " + 
     "               	            max(WORK_DATE) work_date" + 
     "               		    FROM L_LABOR_DAILYWORK  " + 
     "               		   where work_date >= " + "'" + arg_from + "'" + 
     "               		     and work_date <= " + "'" + arg_to + "'" + 
     "               		GROUP BY WORK_DATE,   " + 
     "                              CIVIL_REGISTER_NUMBER  " + 
     "               		  HAVING ( count(*) > 1 )  ) d," + 
     "               		z_code_dept e" + 
     "               where a.dept_code = e.dept_code" + 
     "                 and a.dept_code = b.dept_code" + 
     "                 and a.civil_register_number = b.civil_register_number" + 
     "                 and b.job_code  = c.job_code (+)" + 
     "                 and a.civil_register_number = d.civil_register_number" + 
     "                 and a.work_date = d.work_date" + 
     "            order by a.work_date asc,a.civil_register_number asc" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>