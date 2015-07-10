<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String arg_class = req.getParameter("arg_class");

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("select_1",GauceDataColumn.TB_STRING,3));
	  dSet.addDataColumn(new GauceDataColumn("select_2",GauceDataColumn.TB_STRING,50));
 
    String query =" select '0' select_1 , null select_2 from dual							 " +
						" union																					 " +
						"select code select_1,name select_2 from a_as_comm_code where class = "+arg_class+ 
						" order by select_1	asc															 " ;

	
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>