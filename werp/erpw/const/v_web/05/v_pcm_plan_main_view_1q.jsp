<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
	  
    String query = "SELECT   b.long_name name,									   " +
     "							  a.dept_code code   									" + 
     "              FROM v_pcm_plan a , z_code_dept b								" +
     "				  WHERE a.dept_code = b.dept_code								" +
	  "              group by a.dept_code, b.long_name                      " +
	  "              ORDER BY b.long_name ASC											" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>