<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
	String arg_date = req.getParameter("arg_date");
	String query = "";
 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("LONG_NAME",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("DEPT_CODE",GauceDataColumn.TB_STRING,7));
	query = " select " +
			"	trunc(a.yymmdd,'mm') yymmdd, c.long_name, a.dept_code " +
			"from " +
			"	m_output_detail a, " +
			"	m_output_slip b, " +
			"	z_code_dept c " +
			"where " +
			"	a.ditag = '1' " +
			"and a.yymmdd > '2005-06-30' " +
			"and a.yymmdd <= add_months('" + arg_date + "',1) - 1 " +
			"and a.dept_code = b.dept_code(+) and a.vat_unq_num = b.vat_unq_num(+) " +
			"and a.dept_code = c.dept_code(+) " +
			"and (decode(b.INVOICE_NUM,null,'1',f_slip_status(b.INVOICE_NUM)) <> '9' or b.dept_code is null) " +
			"group by " +
			"	trunc(a.yymmdd,'mm'), c.long_name , a.dept_code  " +
			"ORDER BY " +
			"	trunc(a.yymmdd,'mm'), c.long_name " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>