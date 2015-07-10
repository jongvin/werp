<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
	String arg_dept_code = req.getParameter("arg_dept_code");
	String arg_date = req.getParameter("arg_date");
	String arg_comp_code = req.getParameter("arg_comp_code");
	String arg_view_chk = req.getParameter("arg_view_chk");

 //----------------------------------------------------------
	String query = " ";

 if (arg_view_chk.equals("2")) {
	dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("inputdate",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,30));
	dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
	dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("vatamt",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("outqty",GauceDataColumn.TB_DECIMAL,18,3));
	dSet.addDataColumn(new GauceDataColumn("outamt",GauceDataColumn.TB_DECIMAL,18,0));
	dSet.addDataColumn(new GauceDataColumn("outvat",GauceDataColumn.TB_DECIMAL,18,0));

	query = query + " Select";
	query = query + " 	a.dept_code,";
	query = query + " 	e.long_name,";
	query = query + " 	to_char(a.yymmdd,'yyyy.mm.dd') inputdate,";
	query = query + " 	a.name,";
	query = query + " 	a.ssize,";
	query = query + " 	a.unitcode,";
	query = query + " 	a.qty,";
	query = query + " 	a.amt,";
	query = query + " 	decode(a.vattag,'3',a.vatamt,0) vatamt,";
	query = query + " 	nvl(d.outqty,0) outqty,";
	query = query + " 	nvl(d.outamt,0) outamt,";
	query = query + " 	decode(a.vattag,'3',nvl(d.outvat,0),0) outvat";
	query = query + " from";
	query = query + " 	m_input_detail a,";
	query = query + " 	(";
	query = query + " 	SELECT";
	query = query + " 		b.dept_code,b.input_unq_num,sum(b.qty) outqty,sum(b.amt) outamt,sum(b.vat_amt) outvat";
	query = query + " 	FROM";
	query = query + " 		M_OUTPUT_DETAIL b,";
	query = query + " 		M_OUTPUT_SLIP c";
	query = query + " 	WHERE";
	query = query + " 		b.dept_code = c.dept_code and b.vat_unq_num = c.vat_unq_num";
	query = query + "	and decode(c.INVOICE_NUM,null,'1',f_slip_status(c.INVOICE_NUM)) = '9'";
	query = query + "	and b.yymmdd <= (add_months('" + arg_date + "',1) - 1)";
	query = query + " 	GROUP By";
	query = query + " 		b.dept_code,b.input_unq_num";
	query = query + " 	) d,";
	query = query + " 	z_code_dept e";
	query = query + " Where";
	query = query + " 	a.dept_code = d.dept_code(+) and a.input_unq_num = d.input_unq_num(+)";
	query = query + " and a.dept_code = e.dept_code";
	query = query + " and a.yymmdd > '2005-06-30' And a.ditag = '1'";
	query = query + " and (a.qty <> nvl(d.outqty,0) or a.amt <> nvl(d.outamt,0) or (a.vatamt <> nvl(d.outvat,0) and a.vattag = '3'))";
	query = query + " and a.yymmdd <= (add_months('" + arg_date + "',1) - 1)";
	if (!arg_dept_code.equals("T")) {
		query = query + " and a.dept_code = '" + arg_dept_code  + "'";
	}
	if (!arg_comp_code.equals("T")) {
		query = query + " and e.comp_code = '" + arg_comp_code  + "'";
	}
	query = query + " Order by";
	query = query + " 	e.long_name, a.yymmdd";
}



if (arg_view_chk.equals("1")) {
	dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("inputdate",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
	dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,30));
	dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
	dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
	dSet.addDataColumn(new GauceDataColumn("outqty",GauceDataColumn.TB_DECIMAL,18,3));

	query = query + " Select";
	query = query + " 	a.dept_code,";
	query = query + " 	e.long_name,";
	query = query + " 	to_char(a.yymmdd,'yyyy.mm.dd') inputdate,";
	query = query + " 	a.name,";
	query = query + " 	a.ssize,";
	query = query + " 	a.unitcode,";
	query = query + " 	a.qty,";
	query = query + " 	nvl(d.outqty,0) outqty";
	query = query + " from";
	query = query + " 	m_input_detail a,";
	query = query + " 	(";
	query = query + " 	SELECT";
	query = query + " 		b.dept_code,b.input_unq_num,sum(b.qty) outqty,sum(b.amt) outamt,sum(b.vat_amt) outvat";
	query = query + " 	FROM";
	query = query + " 		M_OUTPUT_DETAIL b";
	query = query + " 	WHERE";
	query = query + "		b.yymmdd <= (add_months('" + arg_date + "',1) - 1)";
	query = query + " 	GROUP By";
	query = query + " 		b.dept_code,b.input_unq_num";
	query = query + " 	) d,";
	query = query + " 	z_code_dept e";
	query = query + " Where";
	query = query + " 	a.dept_code = d.dept_code(+) and a.input_unq_num = d.input_unq_num(+)";
	query = query + " and a.dept_code = e.dept_code";
	query = query + " and a.yymmdd > '2005-06-30' And a.ditag = '1'";
	query = query + " and (a.qty <> nvl(d.outqty,0))";
	query = query + " and a.yymmdd <= (add_months('" + arg_date + "',1) - 1)";
	if (!arg_dept_code.equals("T")) {
		query = query + " and a.dept_code = '" + arg_dept_code  + "'";
	}
	if (!arg_comp_code.equals("T")) {
		query = query + " and e.comp_code = '" + arg_comp_code  + "'";
	}
	query = query + " Order by";
	query = query + " 	e.long_name, a.yymmdd";
}

%><%@ include file="../../../comm_function/conn_q_end.jsp"%>