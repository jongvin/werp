<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
	String arg_dept_code = req.getParameter("arg_dept_code");
	String arg_sdate     = req.getParameter("arg_sdate");
	String arg_class     = req.getParameter("arg_class");
 //---------------------------------------------------------- 
	dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
	dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("output_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("input_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,1));
	dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
	dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,3));
	dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("vat_price",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("vattag",GauceDataColumn.TB_STRING,1));
	dSet.addDataColumn(new GauceDataColumn("vat_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("comp_chk",GauceDataColumn.TB_STRING,1));
    String query = "select a.dept_code," + 
 					    "       to_char(a.yymmdd,'YYYY.MM.DD') yymmdd," + 
 					    "       a.seq," + 
 					    "       a.output_unq_num," + 
 					    "       a.input_unq_num," + 
 					    "       a.name," + 
 					    "       a.ssize," + 
 					    "       a.unitcode," + 
 					    "       a.ditag," + 
 					    "       a.qty," + 
 					    "       a.unitprice," + 
 					    "       a.amt," + 
 					    "       a.vat_amt," + 
 					    "       b.vat_price, " +
 					    "       b.vattag, " +
 					    "       a.vat_unq_num," + 
					    "       ''      comp_chk " +
 					    "  from m_output_detail a, " + 
 					    "       ( select a.dept_code,a.input_unq_num ,trunc(a.unitprice * 0.1,0) vat_price,a.vattag" +
 					    "           from m_input_detail a, " +
 					    "                m_vat b " +
 					    "          where a.dept_code = b.dept_code " +
 					    "            and a.vat_unq_num = b.vat_unq_num " +
 					    "            and a.dept_code = '" + arg_dept_code + "'" +
 					    "            and b.invoice_num is not null ) b " +
 					    " where a.dept_code = b.dept_code " +
 					    "   and a.input_unq_num = b.input_unq_num " +
 					    "   and a.dept_code = '" + arg_dept_code + "'" + 
 					    "   and a.vat_unq_num = 0" +
 					    "   and a.inouttypecode = '" + arg_class + "'" +
						"   and to_char(a.yymmdd,'YYYY.MM') || '.01' = '" + arg_sdate + "'" +
 					    " order by a.yymmdd,a.seq,a.detailseq ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>