<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
	String arg_date = req.getParameter("arg_date");
	String query = "";
 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("LONG_NAME",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));

	query = "SELECT " +
			"	DISTINCT B.LONG_NAME, B.DEPT_CODE " +
			"FROM " +
			"	M_TMAT_PROJ_RENT A, " +
			"	Z_CODE_DEPT B " +
			"WHERE " +
			"	A.DEPT_CODE = B.DEPT_CODE " +
			"AND decode(A.INVOICE_NUM,null,'0',f_slip_status(A.INVOICE_NUM)) <> '9' " +
			"AND A.MONTH > '2005-06-01' " + 
			"AND A.MONTH <= '" + arg_date + "' " ;

%><%@ include file="../../../comm_function/conn_q_end.jsp"%>