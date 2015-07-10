<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("select_1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("select_2",GauceDataColumn.TB_STRING,50));

	 String query = " SELECT																			" +
	 				"   a.order_number select_1,														" + 
					"	a.order_name  select_2															" +
					" FROM																				" +
					" 	s_cn_list a,																	" +
					"	s_sbcr b,																		" +
					"	s_order_list c																	" +
					" WHERE																				" +		
					"	a.sbcr_code = b.sbcr_code and													" +
					"	c.dept_code = a.DEPT_CODE and													" +
					"	c.order_number = a.order_number and												" +
					"	a.dept_code = '" + arg_dept_code + "' and a.sbcr_code = '" + arg_sbcr_code + "'	" ;
				 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>