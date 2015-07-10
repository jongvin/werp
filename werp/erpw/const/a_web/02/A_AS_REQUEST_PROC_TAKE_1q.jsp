<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r

 //---------------------------------------------------------- 
	  dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("num",GauceDataColumn.TB_DECIMAL,13,0));
	  dSet.addDataColumn(new GauceDataColumn("code_wbs_name",GauceDataColumn.TB_STRING,50));

    String query =" select																	" +
					"	dept_code ,																" +
					"	(select long_name from z_code_dept where dept_code = a.dept_code ) dept_name , " +
					"	(select name from a_as_comm_code where code=a.code_wbs and class='2') code_wbs_name, " +
					"	count(dept_code) num	 " +
					"from		 " +
					"  a_as_req_master a " +
					"where prog_st < 2 " +
					"group by dept_code , code_wbs , prog_st  " +
					"order by (select long_name from z_code_dept where dept_code = a.dept_code ) ," +
					"(select name from a_as_comm_code where code=a.code_wbs and class='2') " ;
					

	
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>