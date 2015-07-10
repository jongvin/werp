<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp = req.getParameter("arg_comp");
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date");
     String arg_last_month = req.getParameter("arg_last_month");
     String arg_month = req.getParameter("arg_month");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("buy_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("years",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rentrate",GauceDataColumn.TB_DECIMAL,5,2));
     dSet.addDataColumn(new GauceDataColumn("amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt4",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt5",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt6",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt7",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt8",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt9",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT                                                                  									" +
		"		C.LONG_NAME, B.NAME NAME,B.SSIZE SSIZE,B.UNITCODE UNITCODE,to_char(B.BUY_DT,'yyyy.mm.dd') BUY_DT,           " +
		"		B.YEARS YEARS,B.RENTRATE RENTRATE,                                                                          " +
		"		SUM(CASE WHEN A.tag = '-2' THEN A.AMT ELSE 0 END) amt1,                                                     " +
		"		SUM(CASE WHEN A.tag = '0' THEN A.AMT ELSE 0 END) amt2,                                                      " +
		"		SUM(CASE WHEN A.tag = '1' THEN A.AMT ELSE 0 END) amt3,                                                      " +
		"		SUM(CASE WHEN A.tag = '3' THEN A.AMT ELSE 0 END) amt4,                                                      " +
		"		SUM(CASE WHEN A.tag = '4' THEN A.AMT ELSE 0 END) amt5,                                                      " +
		"		SUM(CASE WHEN A.tag = '5' THEN A.AMT ELSE 0 END) amt6,                                                      " +
		"		SUM(CASE WHEN A.tag = '-1' THEN A.AMT ELSE 0 END) amt8,                                                     " +
		"	                                                                                                               " +
		"		SUM(CASE WHEN A.tag = '0' THEN A.AMT ELSE 0 END) +                                                          " +
		"		SUM(CASE WHEN A.tag = '1' THEN A.AMT ELSE 0 END) +                                                          " +
		"		SUM(CASE WHEN A.tag = '3' THEN A.AMT ELSE 0 END) -                                                          " +
		"		SUM(CASE WHEN A.tag = '4' THEN A.AMT ELSE 0 END) -                                                          " +
		"		SUM(CASE WHEN A.tag = '5' THEN A.AMT ELSE 0 END) amt7,                                                      " +
		"	                                                                                                               " +
		"		SUM(CASE WHEN A.tag = '0' THEN A.AMT ELSE 0 END) +                                                          " +
		"		SUM(CASE WHEN A.tag = '1' THEN A.AMT ELSE 0 END) +                                                          " +
		"		SUM(CASE WHEN A.tag = '3' THEN A.AMT ELSE 0 END) -                                                          " +
		"		SUM(CASE WHEN A.tag = '4' THEN A.AMT ELSE 0 END) -                                                          " +
		"		SUM(CASE WHEN A.tag = '5' THEN A.AMT ELSE 0 END) -                                                          " +
		"		SUM(CASE WHEN A.tag = '-1' THEN A.AMT ELSE 0 END) amt9                                                      " +
		"	FROM                                                                                                           " +
		"	(                                                                                                              " +
		"	                                                                                                               " +
		"	SELECT                                                                                                         " +
		"		'0' tag,A.DEPT_CODE,B.TMAT_UNQ_NUM,A.QTY, A.QTY * D.REMAIND_AMT AMT                                         " +
		"	FROM                                                                                                           " +
		"		M_TMAT_PROJ_RENT A,                                                                                         " +
		"		M_TMAT_STOCK B,                                                                                             " +
		"		M_TMAT_RENT D,                                                                                              " +
		"		M_TMAT_MASTER E                                                                                             " +
		"	WHERE                                                                                                          " +
		"		A.DEPT_CODE = B.DEPT_CODE AND A.YYMMDD = B.YYMMDD AND A.SEQ = B.SEQ AND A.INPUT_UNQ_NUM = B.INPUT_UNQ_NUM   " +
		"	AND	B.TMAT_UNQ_NUM = D.TMAT_UNQ_NUM AND D.MONTH = '" + arg_last_month + "'                                   " +
		"	AND	B.TMAT_UNQ_NUM = E.TMAT_UNQ_NUM                                                                          " +
		"	AND	A.MONTH = '" + arg_last_month + "'                                                                       " +
		"	AND	D.REMAIND_AMT <> 0                                                                                       " +
		"	                                                                                                               " +
		"	UNION ALL                                                                                                      " +
		"	                                                                                                               " +
		"	                                                                                                               " +
		"	SELECT                                                                                                         " +
		"		'-1' tag,A.DEPT_CODE,B.TMAT_UNQ_NUM,A.QTY, A.AMT                                                            " +
		"	FROM                                                                                                           " +
		"		M_TMAT_PROJ_RENT A,                                                                                         " +
		"		M_TMAT_STOCK B                                                                                              " +
		"	WHERE                                                                                                          " +
		"		A.DEPT_CODE = B.DEPT_CODE AND A.YYMMDD = B.YYMMDD AND A.SEQ = B.SEQ AND A.INPUT_UNQ_NUM = B.INPUT_UNQ_NUM   " +
		"	AND	A.MONTH BETWEEN '" + arg_month + "' AND '" + arg_date + "'                                               " +
		"	AND	A.AMT <> 0                                                                                               " +
		"	                                                                                                               " +
		"	UNION ALL                                                                                                      " +
		"	                                                                                                               " +
		"	SELECT                                                                                                         " +
		"		'-2' tag,A.DEPT_CODE,B.TMAT_UNQ_NUM,A.QTY, A.AMT                                                            " +
		"	FROM                                                                                                           " +
		"		M_TMAT_PROJ_RENT A,                                                                                         " +
		"		M_TMAT_STOCK B                                                                                              " +
		"	WHERE                                                                                                          " +
		"		A.DEPT_CODE = B.DEPT_CODE AND A.YYMMDD = B.YYMMDD AND A.SEQ = B.SEQ AND A.INPUT_UNQ_NUM = B.INPUT_UNQ_NUM   " +
		"	AND	A.MONTH = '" + arg_date + "'                                                                             " +
		"	AND	A.AMT <> 0                                                                                               " +
		"	                                                                                                               " +
		"	UNION ALL                                                                                                      " +
		"	                                                                                                               " +
		"	SELECT                                                                                                         " +
		"		'1' tag,A.DEPT_CODE,A.TMAT_UNQ_NUM,A.QTY,nvl(A.AMT,0) + decode(a.vattag,'3',nvl(A.VATAMT,0),0)             " +
		"	FROM                                                                                                           " +
		"		M_INPUT_DETAIL A,                                                                                           " +
		"		M_TMAT_MASTER B                                                                                             " +
		"	WHERE                                                                                                          " +
		"		A.TMAT_UNQ_NUM = B.TMAT_UNQ_NUM                                                                             " +
		"	AND	A.YYMMDD BETWEEN '" + arg_month + "' AND last_day(to_date('" + arg_date + "'))                           " +
		"	AND	A.INOUTTYPECODE IN ('1','8')                                                                             " +
		"	AND	A.AMT <> 0                                                                                               " +
		"	                                                                                                               " +
		"	UNION ALL                                                                                                      " +
		"	                                                                                                               " +
		"	                                                                                                               " +
		"	SELECT                                                                                                         " +
		"		'3' tag,A.DEPT_CODE,A.TMAT_UNQ_NUM,B.QTY,B.QTY * B.UNITPRICE                                         " +
		"	FROM                                                                                                           " +
		"		M_TMAT_STOCK A,                                                                                             " +
		"		M_INPUT_DETAIL B,                                                                                           " +
		"		M_TMAT_RENT C                                                                                               " +
		"	WHERE                                                                                                          " +
		"		A.DEPT_CODE = B.DEPT_CODE AND A.YYMMDD = B.YYMMDD AND A.SEQ = B.SEQ AND A.INPUT_UNQ_NUM = B.INPUT_UNQ_NUM   " +
		"	AND	A.TMAT_UNQ_NUM = C.TMAT_UNQ_NUM AND trunc(A.YYMMDD,'mm') = C.MONTH                                       " +
		"	AND	B.YYMMDD BETWEEN '" + arg_month + "' AND last_day(to_date('" + arg_date + "'))                           " +
		"	AND	B.INOUTTYPECODE = '3'                                                                                    " +
		"	AND	C.PRE_REMAIND_AMT <> 0                                                                                   " +
		"	                                                                                                               " +
		"	UNION ALL                                                                                                      " +
		"	                                                                                                               " +
		"	                                                                                                               " +
		"	SELECT                                                                                                         " +
		"		'4' tag,D.RELATIVE_PROJ_CODE,A.TMAT_UNQ_NUM,B.QTY,B.QTY * B.UNITPRICE                               " +
		"	FROM                                                                                                           " +
		"		M_TMAT_STOCK A,                                                                                             " +
		"		M_INPUT_DETAIL B,                                                                                           " +
		"		M_TMAT_RENT C,                                                                                              " +
		"		M_INPUT D                                                                                                   " +
		"	WHERE                                                                                                          " +
		"		A.DEPT_CODE = B.DEPT_CODE AND A.YYMMDD = B.YYMMDD AND A.SEQ = B.SEQ AND A.INPUT_UNQ_NUM = B.INPUT_UNQ_NUM   " +
		"	AND	B.DEPT_CODE = D.DEPT_CODE AND B.YYMMDD = D.YYMMDD AND B.SEQ = D.SEQ                                      " +
		"	AND	A.TMAT_UNQ_NUM = C.TMAT_UNQ_NUM AND trunc(A.YYMMDD,'mm') = C.MONTH                                       " +
		"	AND	B.YYMMDD BETWEEN '" + arg_month + "' AND last_day(to_date('" + arg_date + "'))                           " +
		"	AND	B.INOUTTYPECODE = '3'                                                                                    " +
		"	AND	C.PRE_REMAIND_AMT <> 0                                                                                   " +
		"	                                                                                                               " +
		"	UNION ALL                                                                                                      " +
		"	                                                                                                               " +
		"	SELECT                                                                                                         " +
		"		'5' tag,A.DEPT_CODE,A.TMAT_UNQ_NUM,B.QTY,A.AMT                                                              " +
		"	FROM                                                                                                           " +
		"		M_OUTPUT_DETAIL A,                                                                                          " +
		"		M_TMAT_MASTER B                                                                                             " +
		"	WHERE                                                                                                          " +
		"		A.TMAT_UNQ_NUM = B.TMAT_UNQ_NUM                                                                             " +
		"	AND	A.YYMMDD BETWEEN '" + arg_month + "' AND last_day(to_date('" + arg_date + "'))                           " +
		"	AND	A.INOUTTYPECODE IN ('5','6')                                                                             " +
		"	) A,                                                                                                           " +
		"	M_TMAT_MASTER B,                                                                                               " +
		"	Z_CODE_DEPT C,                                                                                                 " +
		"	Z_CODE_COMP E                                                                                                  " +
		"	WHERE                                                                                                          " +
		"		A.TMAT_UNQ_NUM = B.TMAT_UNQ_NUM                                                                             " +
		"	AND	A.DEPT_CODE = C.DEPT_CODE                                                                                " +
		"	AND   C.COMP_CODE = E.COMP_CODE                                                                                " +
		"	AND	A.DEPT_CODE LIKE '" + arg_dept + "' || '%'     " +
		"	AND C.COMP_CODE = '" + arg_comp + "'                                                                           " +
		"	GROUP BY                                                                                                       " +
		"		A.DEPT_CODE,C.LONG_NAME,C.COMP_CODE,E.COMP_NAME,A.TMAT_UNQ_NUM,B.NAME,B.SSIZE,B.UNITCODE,B.BUY_DT,B.YEARS,B.RENTRATE "+
		"	ORDER BY																																			" +
		"		C.LONG_NAME,B.NAME                                                                                          " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>