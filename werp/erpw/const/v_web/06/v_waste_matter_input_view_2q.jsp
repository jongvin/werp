<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r

     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	  dSet.addDataColumn(new GauceDataColumn("waste_matter_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("waste_matter_name",GauceDataColumn.TB_STRING,50));

    String query = " SELECT distinct a.dept_code,		" +																	
						"	    b.waste_matter_code ,			" +
						"		b.waste_matter_name				" +	
						" FROM v_waste_matter a , v_waste_matter_code b  " +   	
						" WHERE a.dept_code='"+arg_dept_code+"' and  " +
						"	   a.waste_matter_code = b.waste_matter_code " +
						" GROUP BY a.dept_code,									" +	 									
						"	    b.waste_matter_code ,                    " +
						"		b.waste_matter_name  							" +	 									
						" ORDER BY b.waste_matter_name  ASC	            " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>