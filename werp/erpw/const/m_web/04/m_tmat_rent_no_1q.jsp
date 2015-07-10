<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
	String arg_date = req.getParameter("arg_date");
	String query = "";
 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("LONG_NAME",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
	query = "SELECT " +
			"	DISTINCT D.LONG_NAME, D.DEPT_CODE " +
			"FROM " +
			"	M_TMAT_STOCK A, " +
			"	M_TMAT_RENT B, " +
			"	(SELECT * FROM M_TMAT_PROJ_RENT WHERE DEGREE = '1' AND MONTH = '" + arg_date + "') C, " +
			"	Z_CODE_DEPT D " +
			"WHERE " +
			"	A.TMAT_UNQ_NUM = B.TMAT_UNQ_NUM " +
			"AND B.MONTH = '" + arg_date + "' " +
			"AND A.DEPT_CODE = C.DEPT_CODE(+) AND A.YYMMDD = C.YYMMDD(+) AND A.SEQ = C.SEQ(+) AND A.INPUT_UNQ_NUM = C.INPUT_UNQ_NUM(+) " +
			"AND A.DEPT_CODE = D.DEPT_CODE " +
			"AND A.YYMMDD < add_months(to_date('" + arg_date + "'),1) " +
			"AND A.QTY <> 0 " +
			"AND A.PROC_YN = 'Y' " +
			"AND C.DEPT_CODE Is Null " +
			"ORDER BY D.LONG_NAME " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>