<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_from = req.getParameter("arg_from");
     String arg_to = req.getParameter("arg_to"); 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("civil_register_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("labor_name",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("job_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("unitcost",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dailywork",GauceDataColumn.TB_DECIMAL,18,1));
     dSet.addDataColumn(new GauceDataColumn("pay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("text",GauceDataColumn.TB_STRING,50));
    String query = "select a.dept_code," + 
     "               		a.civil_register_number," + 
     "               		b.labor_name," + 
     "               		c.job_name," + 
     "               		a.unitcost," + 
     "               		z.long_name, " + 
     "               		sum(a.dailywork) dailywork," + 
     "               		sum(a.pay_amt) pay_amt," + 
     "                     ' ' text " +
     "                from l_labor_dailywork a," + 
     "                 	   l_labor_basic b," + 
     "                     l_code_job c," + 
     "               		z_code_dept z, " + 
     "                     ( SELECT a.civil_register_number   " + 
     "               		    FROM (SELECT distinct dept_code, civil_register_number " + 
	  "           				    		   from l_labor_dailywork " + 
	  "           				    		   where work_date >= " + "'" + arg_from + "'" + 
	  "               					     and work_date <= " + "'" + arg_to + "'" + 
	  "               					 ) a " + 
     "               		GROUP BY CIVIL_REGISTER_NUMBER  " + 
     "               		  HAVING ( count(*) > 1 )  ) d  " + 
     "               where a.dept_code = z.dept_code" + 
     "                 and a.dept_code = b.dept_code" + 
     "                 and b.job_code  = c.job_code" + 
     "                 and a.civil_register_number = b.civil_register_number" + 
     "                 and a.civil_register_number = d.civil_register_number" + 
     "                 and a.work_date >= " + "'" + arg_from + "'"   + 
     "                 and a.work_date <= " + "'" + arg_to + "'"     + 
     "            group by a.dept_code, a.civil_register_number, " + 
     "                     b.labor_name, c.job_name, a.unitcost, z.long_name " + 
     "            order by a.civil_register_number asc" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>