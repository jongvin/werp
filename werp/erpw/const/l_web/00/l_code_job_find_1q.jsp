<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_job_name = req.getParameter("arg_job_name");
//---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("job_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("job_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("unitcost",GauceDataColumn.TB_DECIMAL,14,3));
    String query = "select job_code, job_name, unitcost " +
						"from l_code_job " +
						"where job_name like " + "'%" + arg_job_name + "%' " +
						"order by job_name asc ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>