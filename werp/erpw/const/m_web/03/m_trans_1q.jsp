<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
	String arg_date = req.getParameter("arg_date");
	String arg_date_1 = req.getParameter("arg_date_1");
	String arg_gubun = req.getParameter("arg_gubun");
 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
	dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("outputtitle",GauceDataColumn.TB_STRING,255));
	dSet.addDataColumn(new GauceDataColumn("inouttypecode",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("gubunName",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("relative_proj_code",GauceDataColumn.TB_STRING,6));
	dSet.addDataColumn(new GauceDataColumn("input_yymmdd",GauceDataColumn.TB_STRING,18));
	dSet.addDataColumn(new GauceDataColumn("relative_seq",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("total_amt",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("sale_amt",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("trans_tag",GauceDataColumn.TB_STRING,1));
	dSet.addDataColumn(new GauceDataColumn("memo",GauceDataColumn.TB_STRING,200));
	dSet.addDataColumn(new GauceDataColumn("output_proj",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("input_proj",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));

	String query = "";
if (arg_gubun.equals("1")) {
	query = " " +
				" SELECT" +
				"	a.DEPT_CODE," +
				" 	to_char(a.YYMMDD,'YYYY.MM.DD') YYMMDD," +
				" 	a.SEQ," +
				" 	a.OUTPUTTITLE," +
				"  a.inouttypecode, " +
				"	(CASE WHEN a.inouttypecode = '4' THEN '전출' WHEN a.inouttypecode = '5' THEN '폐기' ELSE '매각' END) gubunName," +
				" 	a.RELATIVE_PROJ_CODE," +
				" 	to_char(a.INPUT_YYMMDD,'YYYY.MM.DD') INPUT_YYMMDD," +
				" 	a.RELATIVE_SEQ," +
				" 	a.TOTAL_AMT," +
				"   0 sale_amt," +
				" 	a.TRANS_TAG," +
				" 	a.MEMO," +
				" 	b.long_name  output_proj," +
				" 	c.long_name  input_proj," +
				"	d.INVOICE_NUM" +
				" FROM" +
				" 	m_output  a," +
				" 	Z_CODE_DEPT b," +
				" 	Z_CODE_DEPT c," +
				" 	m_input d" +
				" WHERE" +
				" 	a.dept_code = b.dept_code" +
				" AND a.RELATIVE_PROJ_CODE = c.dept_code (+)" +
				" AND a.DEPT_CODE = d.RELATIVE_PROJ_CODE(+)" +
				" AND a.SEQ = d.RELATIVE_SEQ(+)" +
				" AND a.YYMMDD = d.YYMMDD(+)" +
				" AND a.YYMMDD >=  '" + arg_date + "'" +
				" AND a.YYMMDD <=  '" + arg_date_1 + "'";
	query = query + " AND a.inouttypecode = '4'";
	query = query + " ORDER BY" +
				" 	a.DEPT_CODE ASC,a.YYMMDD DESC,a.SEQ DESC";
} else {
	query = " " +
				" SELECT" +
				"	a.DEPT_CODE," +
				" 	to_char(a.YYMMDD,'YYYY.MM.DD') YYMMDD," +
				" 	a.SEQ," +
				" 	a.OUTPUTTITLE," +
				"	(CASE WHEN a.inouttypecode = '4' THEN '전출' WHEN a.inouttypecode = '5' THEN '매각' ELSE '폐기' END) gubunName," +
				" 	a.RELATIVE_PROJ_CODE," +
				" 	to_char(a.INPUT_YYMMDD,'YYYY.MM.DD') INPUT_YYMMDD," +
				" 	a.RELATIVE_SEQ," +
				" 	a.TOTAL_AMT," +
				"   nvl(e.sale_amt,0) sale_amt, " +
				" 	a.TRANS_TAG," +
				" 	a.MEMO," +
				" 	b.long_name  output_proj," +
				" 	c.long_name  input_proj," +
				"	e.INVOICE_NUM," +
				" 	decode(e.INVOICE_NUM,null,null,f_slip_no(e.INVOICE_NUM)) t_slip_no," +
				" 	decode(e.INVOICE_NUM,null,null,f_slip_status(e.INVOICE_NUM)) t_slip_chk" +
				" FROM" +
				" 	m_output  a," +
				" 	Z_CODE_DEPT b," +
				" 	Z_CODE_DEPT c," +
				" 	m_input d," +
				"   m_output_sale e " +
				" WHERE" +
				" 	a.dept_code = b.dept_code" +
				" AND a.RELATIVE_PROJ_CODE = c.dept_code (+)" +
				" AND a.DEPT_CODE = d.RELATIVE_PROJ_CODE(+)" +
				" AND a.SEQ = d.RELATIVE_SEQ(+)" +
				" AND a.YYMMDD = d.YYMMDD(+)" +
				" AND a.dept_code = e.dept_code(+) and a.yymmdd = e.yymmdd(+) and a.seq = e.seq(+) " +
				" AND a.YYMMDD >=  '" + arg_date + "'" +
				" AND a.YYMMDD <=  '" + arg_date_1 + "'";
	query = query + " AND a.inouttypecode IN ('5','6')";
	query = query + " ORDER BY" +
				" 	a.DEPT_CODE ASC,a.YYMMDD DESC,a.SEQ DESC";
}

%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>